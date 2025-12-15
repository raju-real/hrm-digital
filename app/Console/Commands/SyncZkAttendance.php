<?php

namespace App\Console\Commands;

use App\Models\AttendanceLog;
use Illuminate\Console\Command;
use App\Models\Device;
use App\Models\User;
use Jmrashed\Zkteco\Lib\ZKTeco;
use Carbon\Carbon;

class SyncZkAttendance extends Command
{
    /**
     * php artisan zk:sync-attendance
     * php artisan zk:sync-attendance --date=2025-01-15
     * php artisan zk:sync-attendance --from=2025-01-01 --to=2025-01-31
     * php artisan zk:sync-attendance --device=ZK-123456
     * php artisan zk:sync-attendance --device=ZK-123456 --date=2025-01-15
     */
    protected $signature = 'zk:sync-attendance
                            {--date= : YYYY-MM-DD}
                            {--from= : YYYY-MM-DD}
                            {--to= : YYYY-MM-DD}
                            {--device= : Device serial number}';

    protected $description = 'Sync attendance from ZKTeco devices';

    public function handle()
    {
        $this->info('🔄 Starting ZKTeco attendance sync...');

        $date = $this->option('date');
        $from = $this->option('from');
        $to = $this->option('to');
        $serial = $this->option('device');

        // Default = today
        if (!$date && !$from && !$to) {
            $from = $to = Carbon::today()->toDateString();
        }

        if ($date) {
            $from = $to = $date;
        }

        $devices = Device::query()
            ->when($serial, fn($q) => $q->where('serial_no', $serial))
            ->active()
            ->get();

        if ($devices->isEmpty()) {
            $this->error('❌ No devices found');
            return Command::FAILURE;
        }

        foreach ($devices as $device) {
            $this->syncDevice($device, $from, $to);
        }

        $this->info('✅ Attendance sync completed.');
        return Command::SUCCESS;
    }

    protected function syncDevice(Device $device, string $from, string $to)
    {
        $this->line("📡 Connecting device: {$device->serial_no}");

        try {
            $zk = new ZKTeco($device->ip_address, $device->device_port);

            if (!$zk->connect()) {
                $this->error("❌ Failed to connect {$device->serial_no}");
                return;
            }

            $logs = $zk->getAttendance();
            $zk->disconnect();

            if (!$logs) {
                $this->warn("⚠ No logs from {$device->serial_no}");
                return;
            }

            foreach ($logs as $log) {
                $punchTime = Carbon::parse($log['timestamp']);

                if ($punchTime->toDateString() < $from || $punchTime->toDateString() > $to) {
                    continue;
                }

                $employeeId = $log['id'];
                $user = User::where('employee_id', $employeeId)->first();

                if (!$user) {
                    continue; // skip unknown users
                }

                AttendanceLog::firstOrCreate(
                    [
                        'employee_id' => $employeeId,
                        'device_id' => $device->id,
                        'punch_time' => $punchTime,
                    ],
                    [
                        'device_serial' => $device->serial_no,
                        'user_id' => $user->id,
                        'client_ip' => $device->ip_address ?? '',
                        'attendance_by' => 'fingerprint',
                        'punch_type' => $this->mapPunchType($log['type'] ?? null),
                    ]
                );

            }

            $this->info("✔ Synced device {$device->serial_no}");

        } catch (\Throwable $e) {
            $this->error("❌ {$device->serial_no}: {$e->getMessage()}");
        }
    }

    protected function mapPunchType($type): string
    {
        return match ((int)$type) {
            0 => 'IN',
            1 => 'OUT',
            default => 'UNKNOWN',
        };
    }
}
