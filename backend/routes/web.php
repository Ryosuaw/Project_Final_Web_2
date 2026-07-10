<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\SkillController;
use App\Http\Controllers\SkillExchangeController;
use App\Http\Controllers\OpportunityController;
use App\Http\Controllers\StudyClubController;
use App\Http\Controllers\MessageController;

// Halaman Register
Route::get('/register', [AuthController::class, 'showRegisterForm']);
Route::post('/register', [AuthController::class, 'register']);

// Halaman Login
Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('/login', [AuthController::class, 'login']);

// Logout
Route::post('/logout', [AuthController::class, 'logout']);

// Dashboard — hanya bisa diakses kalau sudah login
Route::get('/dashboard', [DashboardController::class, 'index'])->middleware('auth');

// Tambah Skill — hanya bisa diakses kalau sudah login
Route::get('/skills/create', [SkillController::class, 'create'])->middleware('auth');
Route::post('/skills', [SkillController::class, 'store'])->middleware('auth');

// Skill Exchange
Route::get('/skill-exchange', [SkillExchangeController::class, 'index'])
    ->middleware('auth')
    ->name('skill-exchange.index');

Route::post('/skill-exchange/{userId}/request', [SkillExchangeController::class, 'sendRequest'])
    ->middleware('auth')
    ->name('skill-exchange.send-request');

Route::post('/skill-exchange/requests/{requestId}/accept', [SkillExchangeController::class, 'acceptRequest'])
    ->middleware('auth')
    ->name('skill-exchange.accept-request');

Route::post('/skill-exchange/requests/{requestId}/reject', [SkillExchangeController::class, 'rejectRequest'])
    ->middleware('auth')
    ->name('skill-exchange.reject-request');
// Peluang (Beasiswa, Kompetisi, Seminar & Webinar)
Route::get('/peluang/{type}', [OpportunityController::class, 'index'])
    ->middleware('auth')
    ->name('opportunities.index');

Route::post('/peluang/{opportunityId}/save', [OpportunityController::class, 'toggleSave'])
    ->middleware('auth')
    ->name('opportunities.toggle-save');  

// Study Club
Route::get('/study-club', [StudyClubController::class, 'index'])
    ->middleware('auth')
    ->name('study-club.index');

Route::post('/study-club', [StudyClubController::class, 'store'])
    ->middleware('auth')
    ->name('study-club.store');

Route::post('/study-club/{studyClubId}/join', [StudyClubController::class, 'join'])
    ->middleware('auth')
    ->name('study-club.join');

Route::post('/study-club/{studyClubId}/leave', [StudyClubController::class, 'leave'])
    ->middleware('auth')
    ->name('study-club.leave');
 

// Pesan / Chat
Route::get('/messages', [MessageController::class, 'index'])
    ->middleware('auth')
    ->name('messages.index');

Route::get('/messages/{userId}', [MessageController::class, 'show'])
    ->middleware('auth')
    ->name('messages.show');

Route::post('/messages/{userId}', [MessageController::class, 'store'])
    ->middleware('auth')
    ->name('messages.store');

// Halaman lain (template statis) tetap seperti sebelumnya
Route::get('/{any}', function () {
    return view('noera');
})->where('any', '.*');