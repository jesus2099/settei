Import files (as patch)
------------

Move files with commit history from one repo to the other https://stackoverflow.com/a/11426261/2236179

    git log --pretty=email --patch-with-stat --reverse -- path/to/file_or_folder | (cd /path/to/new_repository && git am --committer-date-is-author-date)


Password leak protection (2)
------------------------

.gitignore does not ignore file changes
used « git update-index --assume-unchanged <file> » instead (can be cancelled by « git update-index --no-assume-unchanged <file> »)
