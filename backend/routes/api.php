<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ParkirController;
use App\Http\Controllers\Api\kendaraanController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Route untuk ParkirController
Route::get('/parkir', [ParkirController::class, 'index']);
Route::post('/parkir', [ParkirController::class, 'store']);

// ✅ Route untuk kendaraanController (otomatis CRUD)
Route::apiResource('kendaraan', kendaraanController::class);
