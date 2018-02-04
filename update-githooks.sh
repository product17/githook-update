#!/bin/bash

# Wipe the files
> .git/hooks/pre-commit
echo "echo water2" >> .git/hooks/pre-commit

chmod +x .git/hooks/pre-commit