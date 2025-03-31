`2041 autotest grip utils.py`

# Subset 0
## `git-init`
- [x] grip-init should create a directory named .grip, which it will use to store the repository.
- [x] It should produce an error message if this directory already exists, or cannot be created.

## `git-add`
### Error
- [x] invalid filenames
- [x] add with no previous init
- [x] add with non-existent file
- [x] "usage: grip-add <filenames>"
- [x] test add with non-existent files (all don't exist)
- [x] test add with non-existent files (all don't exist)
- [x] test add with some exist and some don't exist
- [ ] no grip

## `git-commit`
- [x] no commit message
- [x] double commit
- [x] commit without adding any files
- [x] Test subset1_14 (add + commit -a) 

## `grip-show`
### Error
- [x] grip-show: error: unknown commit '0'
- [ ] no .grip folder
- [ ] No args: `usage: grip-show <commit>:<filename>`
- [x] grip-show: error: 'c' not found in index
- [x] print(f"grip-show: error: '{file}' not found in commit {commitNum}", file=sys.stderr)
- [ ] `grip-show: error: unknown commit '2'`
- [ ] usage
- [ ] 
### Success
- [x] add and show index 2_1
- [ ] no commit num --> show index
- [ ] index behaviour after committing

## `grip-rm`
### success
- [x] autotest subset0_15
- [ ] usage
- [ ] 
