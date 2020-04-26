// https://www.educative.io/blog/sass-tutorial-unit-testing-with-sass-true

const path = require('path')
const sassTrue = require('sass-true')
const glob = require('glob')

describe('Sass-Pal', () => {
  const testPath = path.resolve(process.cwd(), 'tests/sass-pal.spec.scss');
  const files = glob.sync(testPath);
  for (const file of files) {
    sassTrue.runSass({ file }, { describe, it });
  }
});
