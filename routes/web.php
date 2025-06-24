<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\NewsletterController;

Route::post('/subscribe', [NewsletterController::class, 'subscribe'])->name('subscribe');


Route::get('/', function () {
    return view('home');
});
