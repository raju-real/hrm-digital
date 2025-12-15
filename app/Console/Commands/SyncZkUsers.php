<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Device;
use App\Models\User;
use Jmrashed\Zkteco\Lib\ZKTeco;
use Illuminate\Support\Facades\Log;

class SyncZkUsers extends Command
{
    /**
     * php artisan zkteco:sync-users
     * php artisan zkteco:sync-users --direction=device
     * php artisan zkteco:sync-users --direction=db
     * Scheduler (Background Sync) app/Console/Kernel.php
     * $schedule->command('zkteco:sync-users')->everyTenMinutes()->withoutOverlapping()->runInBackground();
     * * * * * * php /path/to/artisan schedule:run >> /dev/null 2>&1 (on server)
     */
    protected $signature = 'zkteco:sync-users {--direction=both}';
    protected $description = 'Sync users between ZKTeco devices and database';

    public function handle()
    {
        $direction = $this->option('direction'); // db, device, both

        $devices = Device::active()->get();

        if ($devices->isEmpty()) {
            $this->warn('No active devices found');
            return;
        }

        foreach ($devices as $device) {
            $this->info("🔄 Processing Device: {$device->serial_no}");

            try {
                $zk = new ZKTeco($device->ip_address, $device->device_port);

                if (!$zk->connect()) {
                    throw new \Exception('Unable to connect device');
                }

                if (!$zk->connect()) {
                    $this->error("❌ Cannot connect to {$device->serial_no}");
                    continue;
                }

                if ($direction === 'device' || $direction === 'both') {
                    $this->syncFromDeviceToDb($zk);
                }

                if ($direction === 'db' || $direction === 'both') {
                    $this->syncFromDbToDevice($zk);
                }

                $zk->disconnect();

            } catch (\Exception $e) {
                Log::error('ZKTeco Sync Error', [
                    'device' => $device->serial_no,
                    'error' => $e->getMessage(),
                ]);

                $this->error("❌ Error on device {$device->serial_no}");
            }
        }

        $this->info('✅ ZKTeco user sync completed');
    }

    /**
     * Sync users FROM DEVICE → DATABASE
     */
    protected function syncFromDeviceToDb(ZKTeco $zk)
    {
        $deviceUsers = $zk->getUser();
        //dd($deviceUsers);
        foreach ($deviceUsers as $dUser) {
            if (empty($dUser['userid'])) {
                continue;
            }
            $userData =  [
                    'name' => $dUser['name'] ?? 'Unknown',
                    'email' => $dUser['userid'].'@mail.com',
                    'password_plain' => 'Pa$$w0rd!',
                    'password' => bcrypt('Pa$$w0rd!'),
                    'status' => 'active',
                    'created_by' => 0
                ];

            User::firstOrCreate(['employee_id' => $dUser['userid']],$userData);
        }

        $this->info('   ✔ Synced users FROM device to DB');
    }

    /**
     * Sync users FROM DATABASE → DEVICE
     */
    protected function syncFromDbToDevice(ZKTeco $zk)
    {
        $deviceUsers = collect($zk->getUser())->pluck('userid')->toArray();

        $users = User::whereNotNull('employee_id')->get();

        foreach ($users as $user) {

            if (in_array($user->employee_id, $deviceUsers)) {
                continue; // already exists
            }

            $zk->setUser(
                $user->employee_id,   // uid
                $user->employee_id,   // userid
                $user->name,
                '',                   // password
                0                     // normal user
            );
        }

        $this->info('   ✔ Synced users FROM DB to device');
    }
}
