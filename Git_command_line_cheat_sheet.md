# Git Command Line Cheat Sheet

## Stashes

| Command | Description |
|--|--|
| git stash push -m "my stash message" | create a git stash with a specific message |
| git stash list | show all stashes in stack |
| git stash clear | delete ALL STASHES IN REPO (CAREFUL) |
| git stash show -p stash@{x} | show contents of stash without applying |
| git stash drop stash@{n} | delete a stash |
| git stash apply stash@{n} | apply a specific stash, WITHOUT removing from stack |
| git stash pop stash@{n} | apply a specific stash, and remove from stack |

## Remotes

| Command | Description |
|--|--|
| git remote -v | show all remotes associated with this repo |
| git branch -r | show all branches within remotes (includes deleted branches) |
| git ls-remote --heads \<remote> | show all branches within remotes (excludes deleted branches) |
| git checkout -b LocalName origin/RemoteName | Check out a certain (new) branch from remote (may need to do 'git fetch' first) |
| git pull origin \<branch> | pull existing remote \<branch> into CURRENT local branch |
| git push origin branch | push existing local branch to existing remote branch |
| git push -u origin branch | push a NEW local branch to a NEW remote branch with same name |
| git push -u origin localBranch:remoteBranchToBeCreated | push a NEW local branch to a NEW remote branch with DIFFERENT name |
| git push origin \<branch> --force | force push to remote (CAREFUL) |
| git push origin --delete \<branch> | delete a remote branch (CAREFUL) |
| git remote add \<remote-name> <ssh or <https://github.com/xxxxx.git>> | add new remote |
| git remote rename \<old-name> \<new-name> | rename existing remote |
| git remote remove \<remote-name> | remove an existing remote |
| git remote set-url \<remote-name> \<ssh or https address> | change existing \<remote>'s repository URL |
| git branch --set-upstream \<local-branch> origin/\<remote-branch> | set local branch up to track specific remote branch |
| git remote show \<remoteName> | show all branches in remote, even those not tracked or fetched |

## Multiple Remotes

```text
# Set the two separated remotes
git remote add <Name Remote-1> [Remote-1 URL]
git remote add <Name Remote-2> [Remote-2 URL]

# Set a main common remote called origin
git remote add origin [Remote-1 URL]
# Set push to main remote
git remote set-url --add --push origin [Remote-1 URL]
# Set push to Second remote
git remote set-url --add --push origin [Remote-2 URL]

# To push on both remotes at the same time
git push origin

# To pull from a especific remote

git pull <Name Remote-1>

# It is not possible to git pull from multiple repos. 
# However, you can git fetch from multiple repos with
# the following command:

git fetch --all

# This will fetch information from all remote repos. 
# You can switch to the latest version of a branch 
# on a particular remote with the command:

# Checkout the branch you want to work with.
git checkout BRANCH

# Reset the branch to match the state as on a specific remote.
git reset --hard REMOTE-ID/BRANCH

```

## Branches

| Command | Description |
|--|--|
| git branch | show all local branches |
| git branch -d \<local-branch> | safe delete a local branch (won't accept if unmerged or unpushed changes) |
| git branch -D \<local-branch> | unsafe delete - will delete no matter what |
| git branch -m \<oldname> \<newname> | rename local branch |
| git cherry-pick \<commit> | cherry pick \<commit> from some other branch into this one (ADDS COMMIT TO THIS HISTORY) |
| git cherry-pick \<commit> --no-commit | cherry pick \<commit> from some other branch into this working directory (does not add commit to history) |
| git merge \<otherbranch> | locally merge \<otherbranch> into current branch |
| git checkout -b \<newBranchName> | create a new local branch from current branch |
| git checkout --orphan \<newBranchName> | create a branch with NO HISTORY. Useful for essentially squashing all previous commits into one new one. |
| git checkout \<branchName> | check out an existing local branch |

## Log

| Command | Description |
|--|--|
| git log | show details about previous commits |
| git status | show status of local branch vs. tracked remote |
| git diff <commit_hash>~ <commit_hash> | see contents of a given commit |
| git diff \<master>..\<feature> | compare the HEADS of 2 branches (must include the 2 dots and no spaces) |
| git log \<branch> | see the log for a branch other than the current one |
| git log --oneline | show a list of previous commits (one line each) |

## Rebase

| Command | Description |
|--|--|
| git rebase -i \<commit>~X | interactive rebase, starting "X" commits behind <commit>. |

## Commits

| Command | Description |
|--|--|
| git commit -m "message" | create a commit with a message |
| git checkout <commit_hash> | checkout a previous commit |
| git checkout HEAD | To recover previous state if not committed (recover deleted files for example but not committed) (ONLY TESTED WHEN NOT PUSHED) |
| git checkout HEAD^ | To recover previous state but already committed (recover deleted files for example but committed) (ONLY TESTED WHEN NOT PUSHED) |
| git checkout HEAD~n | undo to 'n' previous commit (ONLY TESTED WHEN NOT PUSHED) |
| git reset HEAD~ | undo previous commit, reverts to prev working directory (ONLY TESTED WHEN NOT PUSHED) |
| git reflog | show changes as a result of 'git reset HEAD~' |
| git reset HEAD@{x} | Reset to the point (head@{x}) in the reflog |
| git reset --hard <commit_hash> | Reset to the previous commit (ONLY TESTED WHEN NOT PUSHED) |
| git add --force [thing] | stages items, even if they're included in .gitignore. Example "git add --force Utilities/**" |
| git rm --cached path/to/file | Remove previously-committed files from version control. ""--cached"" keeps local copies. |
| git blame -L \<line>,\<line> \<file> | Find when a particular line(s) was added. Example: "git blame -L 2,2 test.txt" |
| git commit --amend | add staged changes to PREVIOUS commit |

## Tags

| Command | Description |
|--|--|
| git tag | show list of all tags |
| git tag -a v123.456 -m "my tag message" | Add tag to current commit (doesn't have to start with v…. Can be anything without spaces) |
| git push \<remote> \<tagname> | push tag to remote (must do it explicitly - normal push does not push tags) |

## Diff and Merge Conflicts (console)

| Command | Description |
|--|--|
| git mergetool | opens vimdiff that steps you through each conflict. |
| git config merge.tool vimdiff     | set vimdiff as the default merge tool |
| git config merge.conflictstyle diff3 | set display as a 3-way diff |
| git config mergetool.prompt false   | disable the prompt to use the merge tool each time a merge conflict happens. |
|:diffg R| get changes from REMOTE |
|:diffg B| get changes from BASE |
|:diffg L| get changes from LOCAL |
|:wqa|  If you made changes in current split windowsave and exit from vimdiff |
|:wqa[ll]| If you made changes in more than one split window and want to save all of those changes. |
|:qa[ll]!|If you made changes in more than one split window but don't want to save any of those changes |
|:q!|If you made changes in current split window but do not want to save it. |
|ctrl + w + w| move between vimdiff's windows. |
|Ctrl + w + h| Move cursor to the split window on the left |
|Ctrl + w + l| Move cursor to the split window on the right |
|Ctrl + w + j| Move cursor to the split window on the bottom |
|Ctrl + w + k| Move cursor to the split window on the top |
|[ + c| Move to the previous change |
|] + c| Move to the next change |
|u[ndo]|Undo the most recent change |
|Ctrl + r|Redo the last undo |

### vimdiff display format

```text
  ╔═══════╦══════╦════════╗
  ║       ║      ║        ║
  ║ LOCAL ║ BASE ║ REMOTE ║
  ║       ║      ║        ║
  ╠═══════╩══════╩════════╣
  ║                       ║
  ║        MERGED         ║
  ║                       ║
  ╚═══════════════════════╝

LOCAL: this is the file from the current branch
BASE: the common ancestor, how this file looked before both changes
REMOTE: the file you are merging into your branch
MERGED: the merge result; this is what gets saved in the merge commit.
```

## Alias

| Command | Description |
|--|--|
| git config --global alias.[alias_n] "\<command>" | Generate an 'alias_n' for \<command>, Example: git config --global alias.ci "commit -v" |
|git config --global --unset alias.[alias_n] | Unset 'alias_n' |

## Alias to generate a nice branch tree

```text
git config --global alias.ctree "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n' --abbrev-commit --date=relative --branches"
 
git ctree
```