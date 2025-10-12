<?php

use App\Http\Controllers\IClockController;
use Illuminate\Support\Facades\Route;

Route::view('login','admin.auth.admin_login')->name('login');
Route::middleware('auth')->group(function () {
    //
});

Route::controller(IClockController::class)->group(function() {
    Route::get('/test', 'testView')->name('attendance.test.view');
    Route::post('/test', 'testAttendance')->name('attendance.test');
});


