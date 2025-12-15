<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('attendance_logs', function (Blueprint $table) {
            $table->id();
            $table->string('employee_id', 191)->nullable();
            $table->integer('device_id')->nullable();
            $table->string('device_serial',255)->nullable();
            $table->string('user_id')->nullable(); // device user id / PIN
            $table->timestamp('punch_time')->nullable();
            $table->enum('attendance_by', ['fingerprint', 'card', 'face', 'pin', 'manual'])->default('fingerprint');
            //$table->enum('direction', ['in', 'out'])->nullable(); // check-in / check-out
            $table->string('client_ip')->nullable();
            $table->decimal('latitude', 10, 7)->nullable();
            $table->decimal('longitude', 10, 7)->nullable();
            $table->string('location_text')->nullable(); // optional reverse geocoded address
            $table->json('raw_payload')->nullable();
            $table->string('verify_mode')->nullable(); // fingerprint, card, face, pin, password, etc.
            $table->string('work_code')->nullable(); // work code from device, if any
            $table->string('punch_type')->nullable(); // work code from device, if any
            $table->integer('created_by')->nullable();
            $table->timestamps();
            $table->integer('updated_by')->nullable();
            $table->softDeletes();
            $table->integer('deleted_by')->nullable();

            $table->unique(['employee_id', 'punch_time', 'device_serial'], 'uniq_attendance_triplet');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('attendance_logs');
    }
};
