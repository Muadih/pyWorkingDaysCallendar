#!/bin/sh
# Build our Flask app and all the dependencies into a container image
# Note: OOTB on RHEL 7.6 this needs to be run as root.

MYIMAGE=gs/workingdayscallendar
FLASK_APP=WorkingDaysCallendar
FLASK_ENV=development
USERID=1000

IMAGEID=$(buildah from ubi8/python-36)
buildah run $IMAGEID pip3 install --upgrade pip
buildah run $IMAGEID pip3 install flask flask-restful
buildah config --env FLASK_APP=$FLASK_APP --env FLASK_ENV=$FLASK_ENV $IMAGEID

# any build steps above this line run as root inside the container
# any steps after run as $USERID
buildah config --user $USERID:$USERID $IMAGEID

buildah copy $IMAGEID . /opt/app-root/src
buildah config --cmd '/bin/sh run-app.sh' $IMAGEID

buildah commit $IMAGEID $MYIMAGE
