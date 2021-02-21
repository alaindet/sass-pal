// https://www.educative.io/blog/sass-tutorial-unit-testing-with-sass-true

const path = require('path');
const glob = require('glob');
const sassTrue = require('sass-true');

describe('Sass-Pal', () => {
  const srcDir = path.join(process.cwd(), 'src');
  const globPattern = `${srcDir}/**/*.spec.scss`;
  const files = glob.sync(globPattern);
  for (const file of files) {
    sassTrue.runSass({ file }, { describe, it });
  }
});
