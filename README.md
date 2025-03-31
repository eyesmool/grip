# Grip - A Simplified Git Implementation in Python

## Overview

Grip (Git Reimplemented In Python) is a simplified version control system that mimics core Git functionality. This project implements a subset of Git commands entirely in Python, providing basic version control capabilities including repository initialization, file tracking, committing changes, branching, and merging.

## Features Implemented

### Subset 0: Basic Version Control
- **grip-init**: Initializes a new empty Grip repository
- **grip-add**: Adds files to the staging index
- **grip-commit**: Commits staged changes to the repository
- **grip-log**: Displays commit history
- **grip-show**: Shows file contents at different stages

### Subset 1: Enhanced Workflow
- **grip-commit -a**: Commits with automatic staging of tracked files
- **grip-rm**: Removes files from tracking with safety checks
- **grip-status**: Shows comprehensive status of working directory vs index vs repository

### Subset 2: Branching and Merging
- **grip-branch**: Creates, lists, and deletes branches
- **grip-checkout**: Switches between branches
- **grip-merge**: Merges changes from one branch to another

## Implementation Details

- **Pure Python**: All functionality implemented using only Python standard libraries
- **Custom Repository Structure**: Designed an efficient storage system within `.grip` directory
- **Error Handling**: Comprehensive error messages matching reference implementation
- **File Management**: Careful handling of file operations with proper error checking
- **State Tracking**: Maintains repository state including branches, commits, and file versions

## Testing

Included test scripts (`test0.sh` to `test9.sh`) demonstrate:

1. Basic repository initialization and file operations
2. Commit history and file version inspection
3. Branch creation and switching
4. Merge conflict scenarios
5. Edge cases and error conditions

## Usage Examples

```bash
# Initialize a new repository
./grip-init

# Add and commit files
echo "Hello World" > file.txt
./grip-add file.txt
./grip-commit -m "Initial commit"

# Check status and history
./grip-status
./grip-log

# Branching and merging
./grip-branch new-feature
./grip-checkout new-feature
# ... make changes ...
./grip-commit -a -m "Feature implementation"
./grip-checkout trunk
./grip-merge new-feature -m "Merge feature branch"
```

## Challenges Overcome

1. **Repository Structure**: Designed an efficient way to store multiple versions of files
2. **Branch Management**: Implemented branch switching with proper working directory updates
3. **Merge Conflicts**: Detected and handled file conflicts during merging
4. **State Tracking**: Maintained accurate status across all repository operations
5. **Error Handling**: Provided comprehensive error messages for all edge cases

## Compliance

- Matches behavior of reference implementation exactly
- Follows all specified assumptions and constraints
- Implements all required functionality for all three subsets
- Includes comprehensive test suite

## How to Run

1. Make scripts executable: `chmod +x grip-*`
2. Run individual commands as shown in examples
3. Execute test scripts to verify functionality: `./test0.sh`, etc.
