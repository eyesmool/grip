
import os
import sys
import shutil
import subprocess
import filecmp

indexDir = '.grip/.index'
commitDir = '.grip/.commits'

def checkDotGripExist():
    directory = os.path.join(os.getcwd(), '.grip')

    if not os.path.exists(directory):
        print("grip-add: error: grip repository directory .grip not found", file=sys.stderr)
        sys.exit(1)

def isDirectoryEmpty(directory):
    return not os.listdir(directory)

def copyIndexToCommit(commitNum):
    commitNumDir = os.path.join(commitDir, str(commitNum))
    for item in os.listdir(indexDir):
        srcPath = os.path.join(indexDir, item)
        shutil.copy(srcPath, commitNumDir)

def getCurrCommitNum():
    with open('.grip/.commits/commitTracker', 'r') as file:
        return int(file.read())

def getCurrCommitDir():
    return os.path.join(commitDir, str(getCurrCommitNum()))

def cat(filePath):
    cat = subprocess.run(['cat', filePath], capture_output=True, text=True, check=True)
    print(cat.stdout, end="")

def copyPreviousCommit(currCommitNum):
    prevCommitNum = currCommitNum - 1
    previousCommitDir = os.path.join(commitDir, str(prevCommitNum))
    currCommitDir = os.path.join(commitDir, str(currCommitNum))
    for item in os.listdir(previousCommitDir):
        srcPath = os.path.join(previousCommitDir, item)
        if os.path.exists(os.path.join(indexDir, item)):
            # if exists in index then copy over
            shutil.copy(srcPath, currCommitDir)

def updateCommitTracker(currCommit):
    with open('.grip/.commits/commitTracker', 'w') as file:
        file.write(str(currCommit))

def createLog(message):
    with open('.grip/log', 'w') as file:
        log = str(0) + ' ' + message
        file.write(log)

def updateLog(commitNum, message):
    with open('.grip/log', 'r') as file:
        existingContent = file.read()
    with open('.grip/log', 'w') as file:
        log = str(commitNum) + ' ' + message + '\n'
        file.write(log)
        file.write(existingContent + "\n")

def compareDirectories(dir1, dir2):
    def doCompareDir(dcmp):
        # Check if the lists of files and subdirectories are the same
        if (dcmp.left_only or dcmp.right_only or
            dcmp.diff_files or dcmp.funny_files):
            return False

        # Recursively check all subdirectories
        for sub_dir in dcmp.common_dirs:
            sub_dcmp = filecmp.dircmp(
                os.path.join(dcmp.left, sub_dir),
                os.path.join(dcmp.right, sub_dir)
            )
            if not doCompareDir(sub_dcmp):
                return False

        return True

    # Initial comparison
    initial_dcmp = filecmp.dircmp(dir1, dir2)
    return doCompareDir(initial_dcmp)

def checkNothingToCommit():
    # if index is same as current commit throw error
    currComitDir = os.path.join(commitDir, str(getCurrCommitNum()))
    if compareDirectories(indexDir, currComitDir):
        # then directories are the same
        print("nothing to commit", file=sys.stderr)
        sys.exit(1)

    # if index is different to current commit return do nothing

def addFileToIndex(file):
    directory = '.grip'
    indexDir = os.path.join(directory, '.index')
    try:
        shutil.copy(file, indexDir)
    except Exception as e:
        print(f"An error occurred: {e}")

def removeFileFromIndex(file):
    filePath = os.path.join(indexDir, str(file))
    if not os.path.exists(filePath):
       print(f"grip-rm: error: '{file}' is not in the grip repository",file=sys.stderr)
       sys.exit(1)
    try:
        os.remove(filePath)
    except FileNotFoundError:
        print(f"File {filePath} does not exist.")
    except PermissionError:
        print(f"Permission denied to delete {filePath}.")
    except Exception as e:
        print(f"An error occurred: {e}")

def removeFileFromCWD(file):
    filePath = os.path.join(os.getcwd(), str(file))
    try:
        os.remove(filePath)
    except FileNotFoundError:
        print(f"File {filePath} does not exist.")
    except PermissionError:
        print(f"Permission denied to delete {filePath}.")
    except Exception as e:
        print(f"An error occurred: {e}")


def rmChecks(file):
    committedFilePath = os.path.join(getCurrCommitDir(), file)
    filePathCWD = os.path.join(os.getcwd(), file)
    fileIndexPath = os.path.join(indexDir, file)
    if not os.path.exists(os.path.join(indexDir, str(file))):
        # then file doesn't exist in index
       print(f"grip-rm: error: '{file}' is not in the grip repository",file=sys.stderr)
       sys.exit(1)
    if not filecmp.cmp(fileIndexPath, filePathCWD, shallow=False) and not filecmp.cmp(fileIndexPath, committedFilePath, shallow=False):
        # then file in index is different to both the working file and the repository
        print(f"grip-rm: error: '{file}' in index is different to both the working file and the repository",file=sys.stderr)
        sys.exit(1)
    if not os.path.exists(committedFilePath):
        # then file has staged changes in the index
        print(f"grip-rm: error: '{file}' has staged changes in the index",file=sys.stderr)
        sys.exit(1)
    if not filecmp.cmp(fileIndexPath, committedFilePath, shallow=False):
        # then file has staged changes in the index
        print(f"grip-rm: error: '{file}' has staged changes in the index",file=sys.stderr)
        sys.exit(1)
    if not filecmp.cmp(committedFilePath, filePathCWD, shallow=False):
        # then file in the repository is different to the working file
        print(f"grip-rm: error: '{file}' in the repository is different to the working file",file=sys.stderr)
        sys.exit(1)

def rmChecksCache(file):
    committedFilePath = os.path.join(getCurrCommitDir(), file)
    filePathCWD = os.path.join(os.getcwd(), file)
    fileIndexPath = os.path.join(indexDir, file)
    if not os.path.exists(os.path.join(indexDir, str(file))):
        # then file doesn't exist in index
       print(f"grip-rm: error: '{file}' is not in the grip repository",file=sys.stderr)
       sys.exit(1)
    if not filecmp.cmp(fileIndexPath, filePathCWD, shallow=False) and not filecmp.cmp(fileIndexPath, committedFilePath, shallow=False):
        # then file in index is different to both the working file and the repository
        print(f"grip-rm: error: '{file}' in index is different to both the working file and the repository",file=sys.stderr)
        sys.exit(1)