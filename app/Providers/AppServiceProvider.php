<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        // Comentado porque no existe Vite::useManifestPath en tu versión
        // $vite->useManifestPath(Config::get('vite.manifest_path'));
    }
}
