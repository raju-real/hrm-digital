<?php

namespace App\Http\Controllers\Employee;

use App\Http\Controllers\Controller;
use App\Models\AttendanceLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class EmployeeActivityController extends Controller
{
    public function attendanceSummery()
    {
        $attendance_summery = AttendanceLog::select(
            DB::raw('MIN(id) as id'), // id of the earliest punch of the day
            DB::raw('DATE(punch_time) as attendance_date'),
            DB::raw('MIN(punch_time) as check_in'),
            DB::raw('MAX(punch_time) as check_out'),
            DB::raw('attendance_by')
        )
            ->where('user_id', Auth::id())
            ->groupBy(DB::raw('DATE(punch_time)'))
            ->orderBy('attendance_date', 'desc')
            ->paginate(50);
        return view('employee.attendance_summery', compact('attendance_summery'));
    }

    public function punchManual(Request $request)
    {
        $this->validate($request, [
            'latitude' => 'required',
            'longitude' => 'required'
        ]);

        $user = auth()->user();
        $latitude = $request->latitude;
        $longitude = $request->longitude;

        $attendance = new AttendanceLog();
        $attendance->employee_id = $user->employee_id;
        $attendance->device_id = null;
        $attendance->user_id = $user->id;
        $attendance->punch_time = now();
        $attendance->attendance_by = 'manual';
        $attendance->latitude = $latitude;
        $attendance->longitude = $longitude;
        $attendance->created_by = Auth::id();
        $attendance->save();

        // Optional: reverse geocode to get location_text (async job recommended)
        //dispatch(new ReverseGeocodeJob($a->id, $lat, $lng));

        return response()->json([
            'status' => 'success',
            'message' => 'Attendance recorded successfully!'
        ]);
    }

    public function attendanceLocation($attendance_id)
    {
        $attendance = AttendanceLog::where('id', encrypt_decrypt($attendance_id, 'decrypt'))->first();
        return view('employee.attendance_location', compact('attendance'));
    }
}
