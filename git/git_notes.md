# Git Notes

## General

List tracked files:

    git ls-files

Remove file:

    git rm FILE

Move file:

    git mv SOURCE DESTINATION

## Diff

Unstaged changes:

    git diff

## Committing

Commit with message:

    git commit -m "Message here"

Automatically stage modified and deleted files and commit with message:

    git commit -am "Message here"

## Branches

List branches:

    git branch

Create a branch and switch to it:

    git checkout -b BRANCH_NAME

Switch to another branch:

    git checkout BRANCH_NAME

Merge BRANCH_NAME to current branch:

    git merge BRANCH_NAME

Rebase current branch to BRANCH_NAME:

    git rebase BRANCH_NAME

## Working with remote

Update references (to see what's changed on origin):

    git fetch origin

Merge changes on origin to master branch:

    git pull origin master

Rebase instead of merge:

    git pull --rebase origin master

## Stashing

Stash changes:

    git stash

Stash with message:

    git stash save "message"

Stash modified and untracked files:

    git stash -u

Bring latest stashed changes back from stash:

    git stash apply

Bring back specific stash:

    git stash apply stash@{STASH_INDEX}

Delete the latest stash:

    git stash drop

Delete stash with specific index:

    git stash drop stash@{STASH_INDEX}

Delete all stashes:

    git stash clear

Apply and drop (the latest stash):

    git stash pop

List stashes:

    git stash list

Show what's been stashed:

    git stash show stash@{STASH_INDEX}

Move from stash to new branch and drop the stash:

    git stash branch BRANCH_NAME

## Tags

Lightweight tag:

    git tag TAGNAME [COMMIT]

Annotated tag:

    git tag -a TAGNAME [-m "MESSAGE]

Comparing tags:

    git diff TAG1 TAG2

Update tag (`-f` is the trick):

    git tag -a -f OTHER_COMMIT -m MESSAGE

## Misc

Log of git commands:

    git reflog

Cherry picking (on branch where you want to add the commit):

    git cherry-pick COMMIT
