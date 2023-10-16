import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/home.css', 'resources/css/ch.css','resources/js/ch.js' ],
            refresh: true,
        }),
    ],
});
