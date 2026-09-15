const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: { sans: ['Manrope', ...defaultTheme.fontFamily.sans] },
      colors: {
        night:   '#050914', // page background
        deep:    '#0B1326', // surfaces
        panel:   '#111C36', // raised surfaces / inputs
        line:    '#1E2B4D', // borders
        ink:     '#F2F5FA', // primary text
        mute:    '#9AA8C7', // secondary text
        royal:   '#3B6FE8', // Encounter blue
        royalink:'#1B3A8A', // pressed / soft blue
        glow:    '#8FB3FF'  // highlight text on blue
      }
    }
  },
  plugins: []
}
