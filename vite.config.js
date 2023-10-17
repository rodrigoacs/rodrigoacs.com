import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/ch.css','resources/js/ch.js', 'resources/css/style.css', 'resources/js/script.js' ],
            refresh: true,
        }),
    ],
});
