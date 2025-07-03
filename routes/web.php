<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('home');
});


use Illuminate\Support\Facades\File;

Route::get('/log', function () {
    $logFile = storage_path('logs/laravel.log');

    if (!File::exists($logFile)) {
        return 'Log file not found.';
    }

    $logs = File::get($logFile);
    $lines = explode("\n", $logs);
    $lastLines = array_slice($lines, -50); // últimas 50 líneas

    return '<pre>' . e(implode("\n", $lastLines)) . '</pre>';
});
