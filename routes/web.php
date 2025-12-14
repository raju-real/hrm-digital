<?php

use App\Http\Controllers\ZkTAttendanceController;
use Illuminate\Support\Facades\Route;

Route::view('login', 'admin.auth.admin_login')->name('login');
Route::middleware('auth')->group(function () {
    //
});

Route::prefix('package')->controller(ZkTAttendanceController::class)->group(function () {
    Route::get('test/{serial}','test')->name('test');
    Route::get('test-connection/{serial}','testConnection')->name('test-connection');
    Route::get('get-users/{serial}','getUsers')->name('get-users');
    Route::get('get-attendances/{serial}','getAttendances')->name('get-attendances');
});


