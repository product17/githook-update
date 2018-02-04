#!/bin/bash

echo `git remote -v`

# Wipe the files
> .git/hooks/pre-push
cat > .git/hooks/pre-push <<'endmsg'
remote="$1"
echo $remote
endmsg

chmod +x .git/hooks/pre-push