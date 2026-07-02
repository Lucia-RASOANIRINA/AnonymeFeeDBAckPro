import type { Config } from 'tailwindcss';

const config: Config = {
  content: ['./src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        brand: {
          DEFAULT: '#1B7A43',
          dark: '#0E5C30',
          light: '#E7F3EC',
        },
      },
    },
  },
  plugins: [],
};

export default config;
