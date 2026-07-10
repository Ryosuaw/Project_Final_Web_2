<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SkillExchangeController;
use App\Http\Controllers\DashboardController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/test-data', function () {
    return response()->json([
        'pesan' => 'Halo! Ini data uji coba dari backend Laravel',
        'status' => 'Sukses Terhubung'
    ]);
});

Route::get('/skill-exchange', [SkillExchangeController::class, 'index']);
Route::post('/skill-exchange/{userId}/request', [SkillExchangeController::class, 'sendRequest']);
Route::post('/skill-exchange/requests/{requestId}/accept', [SkillExchangeController::class, 'acceptRequest']);
Route::post('/skill-exchange/requests/{requestId}/reject', [SkillExchangeController::class, 'rejectRequest']);
Route::get('/dashboard', [DashboardController::class, 'index']);