#!/bin/bash
cd /Users/dpope/github/exercise-super-wide
git checkout main
echo -e "\n" >> README.md
echo $(date) >> README.md
git add README.md
git commit -m "test"
git push