PREFIX="# Sass Pal #"

echo "${PREFIX} This script updates the online documentation"

if [ -z "$1" ]
  then
    echo "ERROR: You must provide a version (first argument)"
    echo "Ex.: $ doc.sh 1.2.3"
    exit
fi

echo "${PREFIX} Version passed: ${1}"

echo "${PREFIX} 01/08 # Checkout to gh-pages branch"
git checkout gh-pages

echo "${PREFIX} 02/08 # Merge with master branch"
git merge master

echo "${PREFIX} 03/08 # Generate documentation"
npm run doc

echo "${PREFIX} 04/08 # Cleanup old documentation"
rm -rf ./assets ./index.html

echo "${PREFIX} 05/08 # Move new documentation to root"
mv ./doc/assets/ ./assets/
mv ./doc/index.html ./index.html

echo "${PREFIX} 06/08 # Commit and push new documention"
git add .
git commit -m "${PREFIX} Update documentation version ${1}"
git push origin gh-pages

echo "${PREFIX} 07/08 # Switch back to master branch"
git checkout master

echo "${PREFIX} 08/08 # Finished"
