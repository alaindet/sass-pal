git checkout gh-pages
git merge master
npm run doc
rm -rf ./assets ./index.html
mv ./doc/assets/ ./assets/
mv ./doc/index.html ./index.html
git add .
git commit -m "Update documentation"
git push origin gh-pages
git checkout master
