`2041 autotest grip utils.py`

# Subset 0
## `git-init`
- [ ] grip-init should create a directory named .grip, which it will use to store the repository.
- [ ] It should produce an error message if this directory already exists, or cannot be created.

## `git-add`
### Error
- [ ] invalid filenames
- [x] add with no previous init
- [ ] add with non-existent file
- [ ] "usage: grip-add <filenames>"
- [ ] test add with non-existent files (all don't exist)
- [ ] test add with non-existent files (all don't exist)
- [ ] test add with some exist and some don't exist

## `git-commit`
- [ ] no commit message
- [ ] commit without adding any files

## `grip-show`
### Error
- [ ] grip-show: error: unknown commit '0'
- [ ] no .grip folder
- [ ] No args: `usage: grip-show <commit>:<filename>`
### Success
- [x] add and show index 2_1
- [ ] no commit num --> show index
- [ ] index behaviour after committing
