### git overview through examples!

## Setting up a repository

# Clone the repository.
git clone http://www.scs.stanford.edu/11wi-cs140/pintos.git pintos

# Observe branch.
git status  # default branch name is "master", repository is clean

# cd to pintos and look at the commit log.
cd pintos
git log                 # pretty bare; no filenames
git log --name-status   # lists filenames and statuses

# Download the DESIGNDOC template into pintos/src/threads.
cd src/threads
wget http://www.scs.stanford.edu/11wi-cs140/pintos/threads.tmpl -O DESIGNDOC
less DESIGNDOC

# Note that git notices the new file.
git status  # DESIGNDOC is "untracked"

# Add DESIGNDOC file to repository.
git add DESIGNDOC
git commit -m "Adding DESIGNDOC template"
git log     # (optional) just to see the commit log

# Observe status again.
git status  # working directory is clean again!

# Make a change to DESIGNDOC.
emacs DESIGNDOC
git status  # git sees the pending change
git commit  # does not do anything! We must stage first! (or skip with -a)
    git commit -a -m "Changing names in DESIGNDOC"


## Branching
# git has fast and lightweight branching -- use this feature!

# Create a new branch for your project!
#   (This really should be done before you add your DESIGNDOC as above.)
    git checkout -b threads  # create new branch and switch to it
    git branch               # shows two branches, "master" and "threads"

# Do a related set of edits, commit, rinse, repeat.
# ...
# Now say you have almost every test case passing. You want to create a
# checkpoint that you can go back to easily.
    git branch threads-95percent  # doesn't switch to new branch!
    git branch                    # see the new branch

# Now you can continue editing on your threads branch. If you fix your bugs,
# great! If not, at least you have a nearly-perfect failsafe that you can jump
# back to if you run out of time.
    git checkout threads-95percent  # switches to threads-95percent branch

## Pushing to a remote repository
# Local changes aren't very useful if your group members can't access them. Git
# has many different possible workflows. I personally recommend that each
# developer have his or her own public read-only repository, but I will discuss
# the simpler subversion-like centralized repository.

# NOTE: If you use this approach, only one person in your group needs to do the
#   following three steps -- you only need one central repository for this.

# [local]
# Login to a corn machine.
    ssh corn25.stanford.edu

# [corn]
# Make a "bare" repository in ~/temp/pintos -- or wherever you like.
    mkdir -p ~/temp/pintos
    cd ~/temp/pintos
    git init --bare

# [corn]
# Set AFS permissions so all group members can push into it.
    fsr sa ~/temp/pintos <GROUPMEMBER1> all  # replace <...> with SUNet ID.
    fsr sa ~/temp/pintos <GROUPMEMBER2> all  # replace <...> with SUNet ID.

# [local]
# All group members should now set up a remote in their local repositories so
# they can push into the repository on AFS.
    git remote add central SUNETID@corn25.stanford.edu:~YOURID/temp/pintos
# where SUNETID changes by group member, and YOURID is the username of the
# repository hoster.

# [local]
# Push both branches to the central repository.
    git push central master
    git push central threads

# [local -- other group members]
# Now your group members can start tracking the branches on the remote central
# repository.
    git fetch central                        # get updates from central repository
    git checkout -b threads central/threads  # create a local 'threads' branch

# [local -- any group member]
# Make changes, commit, and push.
    emacs src/threads/DESIGNDOC
    git commit -a -m "Foo"
    git push central threads

# [local -- other group members]
# Pull in new changes.
    git pull central threads


# Admittedly, this is a (too) fast overview of a lot of detailed material.
# Like any rcs, git has a learning curve, but it is very worth the time
# investment to learn to use it effectively.

# Other useful commands:
#   (use "git help <command>" to see a manpage)

    git bisect  # Find when bugs were introduced using a binary search of commits
    git stash   # Temporarily set uncommitted changes aside


# If you decide to use git (you should!), there is a plethora of information
# on the web, including cheat sheets, comparisons to svn, workflows, etc.
# The online Pro Git book [http://progit.org/book] is a great place to learn
# more about all of the above and more.

    Final tip: Commit early and commit often!
