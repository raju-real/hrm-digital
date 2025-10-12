<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Designation;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class StaffController extends Controller
{
    public function index()
    {
        $data = User::query();
        $data->employee();
        $data->when(request()->get('search'),function($query) {
           $search = request()->get('search');
           $query->where('name',"LIKE","%{$search}%");
           $query->orWhere('mobile',request('search'));
        });
        $data->when(request()->get('status'),function($query) {
           $query->where('status',request()->get('status'));
        });
        $staffs = $data->oldest('employee_id')->paginate(20);
        return view('admin.staff.staff_list', compact('staffs'));
    }

    public function create()
    {
        $route = route('admin.staffs.store');
        return view('admin.staff.staff_add_edit', compact('route'));
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'department' => 'required|exists:departments,id',
            'designation' => 'required|exists:designations,id',
            'name' => 'required|string|max:50',
            'email' => [
                'required',
                'string',
                'max:30',
                Rule::unique('users', 'email')->whereNull('deleted_at')
            ],
            'mobile' => [
                'required',
                'string',
                'max:11',
                Rule::unique('users', 'mobile')->whereNull('deleted_at')
            ],
            'password' => 'required|max:12|min:6',
            'status' => 'required|in:active,inactive'
        ]);
        $staff = new User();
        $staff->role = 'employee';
        $staff->employee_id = User::getEmployeeId();
        $staff->department_id = $request->department;
        $staff->designation_id = $request->designation;
        $staff->name = $request->name;
        $staff->email = $request->email;
        $staff->mobile = $request->mobile;
        $staff->password = Hash::make($request->password);
        $staff->password_plain = $request->password;
        $staff->status = $request->status;
        $staff->created_by = Auth::id();
        $staff->save();
        return redirect()->route('admin.staffs.index')->with(successMessage());
    }


    public function edit($id)
    {
        $staff = User::findOrFail($id);
        $route = route('admin.staffs.update', $staff->id);
        return view('admin.staff.staff_add_edit', compact('staff', 'route'));
    }


    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'department' => 'required|exists:departments,id',
            'designation' => 'required|exists:designations,id',
            'name' => 'required|string|max:50',
            'email' => [
                'required',
                'string',
                'max:30',
                Rule::unique('users', 'email')->whereNull('deleted_at')->ignore($id)
            ],
            'mobile' => [
                'required',
                'string',
                'max:11',
                Rule::unique('users', 'mobile')->whereNull('deleted_at')->ignore($id)
            ],
            'status' => 'required|in:active,inactive'
        ]);
        $staff = User::findOrFail($id);
        $staff->department_id = $request->department;
        $staff->designation_id = $request->designation;
        $staff->name = $request->name;
        $staff->email = $request->email;
        $staff->mobile = $request->mobile;
        if($request->password) {
            $staff->password = Hash::make($request->password);
            $staff->password_plain = $request->password;
        }
        $staff->status = $request->status;
        $staff->created_by = Auth::id();
        $staff->save();
        return redirect()->route('admin.staffs.index')->with(infoMessage());
    }

    public function updateStaffStatus($id): \Illuminate\Http\JsonResponse
    {
        $staff = User::findOrFail($id);
        $staff->status = $staff->status === 'active' ? 'inactive' : 'active';
        if ($staff->save()) {
            return response()->json([
                'status' => 'success',
                'message' => 'Staff status updated successfully.',
            ]);
        }
        // Optional: Handle failure case if needed
        return response()->json([
            'status' => 'error',
            'message' => 'Failed to update Staff status.',
        ], 500);
    }


//    public function destroy($id)
//    {
//        $staff = User::findOrFail($id);
//        $staff->update(['deleted_by' => Auth::id()]);
//        $staff->delete();
//        return redirect()->route('admin.staffs.index')->with(deleteMessage());
//    }
}
