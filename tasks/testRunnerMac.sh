#!/bin/bash
set -e
echo "INFO: installing pre-requirements for OS: $OSTYPE ..."

# 1. detect and print python version
if [[ "$(which brew)" == "" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo "INFO: Home Brew version: $(brew --version)"

if [[ "$(which python3)" != *"python"* || "$(python3 --version)" != *"Python 3.8."* ]]; then
    curl https://www.python.org/ftp/python/3.8.7/python-3.8.7-macosx10.9.pkg -o python-3.8.pkg
    echo "Please enter a password for user \"$(whoami)\": "
    sudo installer -pkg python-3.8.pkg -target /
fi
echo "INFO: Python version: $(python3 --version)"

# 2. accepts set of testrunner arguments
RUNCOMMAND='python3 runAllWebRTCTests.py'

for i in "$@"
do
case $i in
    --remoteServerType=*)
    REMOTESERVERTYPE="${i#*=}"
    shift
    if [ -n "$REMOTESERVERTYPE" ];then
      RUNCOMMAND+=" --remoteServerType ${REMOTESERVERTYPE}"
    fi
    ;;
    --joinAs=*)
    JOINAS="${i#*=}"
    shift
    if [ -n "$JOINAS" ];then
      RUNCOMMAND+=" --joinAs ${JOINAS}"
    fi
    ;;
    --rerunFailedTest)
    RERUNFAILEDTEST=true
    if [ -z "$RERUNFAILEDTEST" ];then
      RUNCOMMAND+=" --rerunFailedTest"
    fi
    ;;
    --runType=*)
    RUNTYPE="${i#*=}"
    shift
    if [ -n "$RUNTYPE" ];then
      RUNCOMMAND+=" --runType ${RUNTYPE}"
    fi
    ;;
    --projectId=*)
    PROJECTID="${i#*=}"
    shift
    if [ -n "$PROJECTID" ];then
      RUNCOMMAND+=" --projectId ${PROJECTID}"
    fi
    ;;
    --suiteId=*)
    SUITEID="${i#*=}"
    shift
    if [ -n "$SUITEID" ];then
      RUNCOMMAND+=" --suiteId ${SUITEID}"
    fi
    ;;
    --milestoneId=*)
    MILESTONEID="${i#*=}"
    shift
    if [ -n "$MILESTONEID" ];then
      RUNCOMMAND+=" --milestoneId ${MILESTONEID}"
    fi
    ;;
    --continue)
    CONTINUE=true
    if [ -z "$CONTINUE" ];then
      RUNCOMMAND+=" --continue"
    fi
    ;;
    --testCaseId=*)
    TESTCASEID="${i#*=}"
    shift
    if [ -n "$TESTCASEID" ];then
      RUNCOMMAND+=" --testCaseId ${TESTCASEID}"
    fi
    ;;
    --iterations)
    ITERATIONS="${i#*=}"
    shift
    if [ -n "$ITERATIONS" ];then
      RUNCOMMAND+=" --iterations ${ITERATIONS}"
    fi
    ;;
    --noRetest)
    NORETEST=true
    if [ -z "$NORETEST" ];then
      RUNCOMMAND+=" --noRetest"
    fi
    ;;
    --retest)
    RETEST=true
    if [ -z "$RETEST" ];then
      RUNCOMMAND+=" --retest"
    fi
    ;;
    --)
    break
    ;;
    *)
    break
    ;;
esac
done

# 3. creates python3 virtual environment
python3 -m pip install virtualenv
python3 -m virtualenv env
source env/bin/activate

./env/bin/python3 -m pip install --upgrade pip

# 4. installs all necessary python3 libraries
pip3 install -r requirements.txt

# 5. starts test run
chmod +x runAllWebRTCTests.py
eval  $RUNCOMMAND

# 6. archives screenshots and json logs
NOW=$(date +"%m-%d-%Y")
tar -czf screenshots_$NOW.tar.gz ./common/screenshots

# 7. deactivate virtual environment
deactivate
