<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Device;
use App\Models\User;
use App\Models\AttendanceLog;
use App\Services\ZkTecoService;
use Illuminate\Http\Request;
use Carbon\Carbon;

class DeviceActivityController extends Controller
{
    public function __construct(
        protected ZkTecoService $zkService
    ) {}

    /**
     * Activities dashboard
     */
    public function index()
    {
        return view('admin.devices.activities', [
            'devices' => Device::where('status', 'active')->get(),
        ]);
    }

    /* ==========================================================
     | USERS SYNC
     |========================================================== */

    /**
     * Sync users
     * direction = device_to_db | db_to_device | both
     */
    public function syncUsers(Request $request)
    {
        $request->validate([
            'employee_id' => 'nullable|sometimes|exists:users,employee_id',
            'direction' => 'required|in:device_to_db,db_to_device,both',
            'from_date' => 'nullable|date',
            'to_date'   => 'nullable|date',
            'device'    => 'nullable|string',
        ]);

        $devices = $this->getDevices($request->device);

        foreach ($devices as $device) {

            $zk = $this->zkService->connect($device);
            if (!$zk) continue;

            if (in_array($request->direction, ['device_to_db', 'both'])) {
                $this->syncUsersFromDevice($zk);
            }

            if (in_array($request->direction, ['db_to_device', 'both'])) {
                $this->syncUsersToDevice($zk, $request);
            }

            $this->zkService->disconnect($zk);
        }

        return back()->with('user_sync', 'User sync completed successfully');
    }

    protected function syncUsersFromDevice($zk): void
    {
        foreach ($this->zkService->getUsers($zk) as $u) {
            User::firstOrCreate(
                ['employee_id' => $u['userid']],
                ['name' => $u['name']]
            );
        }
    }

    protected function syncUsersToDevice($zk, Request $request): void
    {
        $users = User::query()
            ->when($request->from_date, fn ($q) => $q->whereBetween('created_at', [$request->from_date, $request->to_date ?? now()]))
            ->when($request->employee_id, fn($q) => $q->where('employee_id', $request->employee_id))
            ->get();

        foreach ($users as $user) {
            $this->zkService->pushUser(
                $zk,
                $user->employee_id,
                $user->name
            );
        }
    }

    /* ==========================================================
     | ATTENDANCE SYNC
     |========================================================== */

    /**
     * Sync attendance
     * Default: today
     */
    public function syncAttendance(Request $request)
    {
        $request->validate([
            'date'   => 'nullable|date',
            'from'   => 'nullable|date',
            'to'     => 'nullable|date',
            'device' => 'nullable|string',
        ]);

        $from = $request->date ?? $request->from ?? Carbon::today()->toDateString();
        $to   = $request->date ?? $request->to   ?? Carbon::today()->toDateString();

        $devices = $this->getDevices($request->device);

        foreach ($devices as $device) {

            $zk = $this->zkService->connect($device);
            if (!$zk) continue;

            foreach ($this->zkService->getAttendance($zk) as $log) {

                $punchTime = Carbon::parse($log['timestamp']);

                if (
                    $punchTime->toDateString() < $from ||
                    $punchTime->toDateString() > $to
                ) {
                    continue;
                }

                AttendanceLog::firstOrCreate(
                    [
                        'employee_id' => $log['id'],
                        'device_id'   => $device->id,
                        'punch_time'  => $punchTime->format('Y-m-d H:i:s'),
                    ],
                    [
                        'device_serial' => $device->serial_no,
                        'type' => $this->mapPunchType($log['type'] ?? null),
                    ]
                );
            }

            $this->zkService->disconnect($zk);
        }

        return back()->with('success', 'Attendance synced successfully');
    }

    /* ==========================================================
     | DEVICE COMMANDS
     |========================================================== */

    /**
     * Clear all attendance logs from device
     */
    public function clearAttendance(Request $request)
    {
        $request->validate([
            'device' => 'required|string',
        ]);

        $device = Device::where('serial_no', $request->device)->firstOrFail();

        $zk = $this->zkService->connect($device);
        if (!$zk) {
            return back()->withErrors('Device not reachable');
        }

        $this->zkService->clearAttendance($zk);
        $this->zkService->disconnect($zk);

        return back()->with('warning', 'Device attendance cleared');
    }

    /**
     * Soft delete user from device (overwrite)
     */
    public function deleteUserFromDevice(Request $request)
    {
        $request->validate([
            'employee_id' => 'required|string',
            'device' => 'required|string',
        ]);

        $device = Device::where('serial_no', $request->device)->firstOrFail();

        $zk = $this->zkService->connect($device);
        if (!$zk) {
            return back()->withErrors('Device not reachable');
        }

        $this->zkService->softDeleteUser($zk, $request->employee_id);
        $this->zkService->disconnect($zk);

        return back()->with('info', 'User removed from device');
    }

    /* ==========================================================
     | HELPERS
     |========================================================== */

    protected function getDevices(?string $serial)
    {
        return Device::query()
            ->when($serial, fn ($q) => $q->where('serial_no', $serial))
            ->where('status', 'active')
            ->get();
    }

    protected function mapPunchType($type): string
    {
        return match ((int) $type) {
            0 => 'IN',
            1 => 'OUT',
            default => 'UNKNOWN',
        };
    }
}
