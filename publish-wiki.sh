#!/bin/bash

#TODO:  syntax hight fails
#emacs24 --batch -l ./src/publish_config.el -f publish-org

git add .
if [ $# -eq 1 ]; then
    git commit -am "$1"
else
    git commit -am "update"
fi
git push

