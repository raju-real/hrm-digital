<?php

namespace App\Http\Controllers\Admin;

use App\Models\Device;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class DeviceController extends Controller
{
    public function index()
    {
        $devices = Device::latest()->paginate(20);
        return view('admin.configuration.device_list', compact('devices'));
    }

    public function create()
    {
        $route = route('admin.devices.store');
        return view('admin.configuration.device_add_edit', compact('route'));
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => [
                'required',
                'string',
                'max:50',
                Rule::unique('devices')
                    ->where('branch_id', $request->branch)
                    ->whereNull('deleted_at'),
            ],
            'serial_no' => [
                'required',
                'string',
                'max:255',
                Rule::unique('devices')->whereNull('deleted_at'),
            ],
            'ip_address' => [
                'required',
                'string',
                'max:100',
                Rule::unique('devices')
                    ->where('branch_id', $request->branch)
                    ->whereNull('deleted_at'),
            ],
            'device_port' => 'required|numeric|between:1,65535',
            'comm_key' => 'required|numeric|between:0,65535',
            'branch' => 'required|exists:branches,id',
            'status' => 'required|in:active,inactive',
        ]);

        $device = new Device();
        $device->name = $request->name;
        $device->slug = Str::slug($request->name);
        $device->serial_no = $request->serial_no;
        $device->ip_address = $request->ip_address;
        $device->device_port = $request->device_port;
        $device->comm_key = $request->comm_key;
        $device->branch_id = $request->branch;
        $device->status = $request->status;
        $device->created_by = Auth::id();
        $device->save();

        return redirect()
            ->route('admin.devices.index')
            ->with(successMessage());
    }

    public function edit($slug)
    {
        $device = Device::whereSlug($slug)->first();
        $route = route('admin.devices.update', $device->id);
        return view('admin.configuration.device_add_edit', compact('device', 'route'));
    }


    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'name' => [
                'required',
                'string',
                'max:50',
                Rule::unique('devices')
                    ->where('branch_id', $request->branch)
                    ->whereNull('deleted_at')
                    ->ignore($id),
            ],
            'serial_no' => [
                'required',
                'string',
                'max:255',
                Rule::unique('devices')
                    ->whereNull('deleted_at')
                    ->ignore($id),
            ],
            'ip_address' => [
                'required',
                'string',
                'max:100',
                Rule::unique('devices')
                    ->where('branch_id', $request->branch)
                    ->whereNull('deleted_at')
                    ->ignore($id),
            ],
            'device_port' => 'required|numeric|between:1,65535',
            'comm_key' => 'required|numeric|between:0,65535',
            'branch' => 'required|exists:branches,id',
            'status' => 'required|in:active,inactive',
        ]);

        $device = Device::findOrFail($id);

        $device->name = $request->name;
        $device->slug = Str::slug($request->name);
        $device->serial_no = $request->serial_no;
        $device->ip_address = $request->ip_address;
        $device->device_port = $request->device_port;
        $device->comm_key = $request->comm_key;
        $device->branch_id = $request->branch;
        $device->status = $request->status;
        $device->updated_by = Auth::id();

        $device->save();

        return redirect()
            ->route('admin.devices.index')
            ->with(infoMessage());
    }

    public function updateDeviceStatus($id): \Illuminate\Http\JsonResponse
    {
        $device = Device::findOrFail($id);
        $device->status = $device->status === 'active' ? 'inactive' : 'active';
        $device->updated_by = Auth::id();
        if ($device->save()) {
            return response()->json([
                'status' => 'success',
                'message' => 'Device status updated successfully.',
            ]);
        }
        // Optional: Handle failure case if needed
        return response()->json([
            'status' => 'error',
            'message' => 'Failed to update Device status.',
        ], 500);
    }


    public function destroy($id)
    {
        $device = Device::findOrFail($id);
        $device->update(['deleted_by' => Auth::id()]);
        $device->delete();
        return redirect()->route('admin.devices.index')->with(deleteMessage());
    }
}
