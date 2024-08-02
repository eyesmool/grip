
import os
import sys
import shutil
import subprocess

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

def cat(filePath):
    cat = subprocess.run(['cat', filePath], capture_output=True, text=True, check=True)
    print(cat.stdout, end="")

def copyPreviousCommit(currCommitNum):
    prevCommitNum = currCommitNum - 1
    previousCommitDir = os.path.join(commitDir, str(prevCommitNum))
    currCommitDir = os.path.join(commitDir, str(currCommitNum))
    for item in os.listdir(previousCommitDir):
        srcPath = os.path.join(previousCommitDir, item)
        shutil.copy(srcPath, currCommitDir)

def updateCommitTracker(currCommit):
    with open('.grip/.commits/commitTracker', 'w') as file:
        file.write(str(currCommit))