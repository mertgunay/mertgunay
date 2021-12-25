const colors = require('tailwindcss/colors')

module.exports = {
    mode: 'jit',
    purge: [
        './core/templates/**/*.{html,js}',
    ],
    darkMode: 'class',
    content: [],
    theme: {
        extend: {
            colors: {
                white: '#ffffff',
                black: '#121212',
                primary: '#ff1744',
                secondary: '#1e1e1e',
                gray: colors.gray,
            }
        }
    },
    plugins: [],
}
