<?php

namespace App\Services;

use App\Models\Device;
use Jmrashed\Zkteco\Lib\ZKTeco;

class ZkTecoService
{
    public function connect(Device $device): ?ZKTeco
    {
        $zk = new ZKTeco($device->ip_address, $device->device_port);
        return $zk->connect() ? $zk : null;
    }

    public function disconnect(ZKTeco $zk): void
    {
        $zk->disconnect();
    }

    public function getUsers(ZKTeco $zk): array
    {
        return $zk->getUser() ?? [];
    }

    public function pushUser(ZKTeco $zk, string $employeeId, string $name): void
    {
        $zk->setUser($employeeId, $employeeId, $name, '', 0);
    }

    public function softDeleteUser(ZKTeco $zk, string $employeeId): void
    {
        $zk->setUser($employeeId, $employeeId, 'DELETED', '', 0);
    }

    public function getAttendance(ZKTeco $zk): array
    {
        return $zk->getAttendance() ?? [];
    }

    public function clearAttendance(ZKTeco $zk): void
    {
        $zk->clearAttendance();
    }
}
