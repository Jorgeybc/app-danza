<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Subscriber;
use Illuminate\Validation\ValidationException;

class NewsletterController extends Controller
{
 public function subscribe(Request $request)
{
    try {
        $request->validate([
            'email' => 'required|email|unique:subscribers,email',
        ]);

        Subscriber::create([
            'email' => $request->email,
        ]);

        return back()->with('success', '¡Gracias por suscribirte!');
    } catch (\Illuminate\Validation\ValidationException $e) {
        return back()->withErrors($e->validator)->withInput()->with('error', 'Este correo ya está registrado.');
    }
}



}
