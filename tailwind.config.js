const colors = require('tailwindcss/colors')

module.exports = {
    darkMode: 'class',
    content: [
        './core/templates/core/**/*.{html,js}',
    ],
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
