#!/bin/bash -ex

load_jenkins_vars() {
    if [ -e "jenkins-env" ]; then
        cat jenkins-env \
          | grep -E "(DEVSHIFT_TAG_LEN|DEVSHIFT_USERNAME|DEVSHIFT_PASSWORD|JENKINS_URL|GIT_BRANCH|GIT_COMMIT|BUILD_NUMBER|ghprbSourceBranch|ghprbActualCommit|BUILD_URL|ghprbPullId)=" \
          | sed 's/^/export /g' \
          > ~/.jenkins-env
        source ~/.jenkins-env
    fi
}

prep() {
    yum -y update
    yum -y install docker make git gcc-c++ bzip2 fontconfig
    curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
    yum -y install nodejs
    systemctl start docker
}

load_jenkins_vars
prep
