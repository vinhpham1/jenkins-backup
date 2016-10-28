#!/bin/bash -xe

##################################################################################
function usage(){
  echo "usage: $(basename $0) /path/to/jenkins_home archive.tar.gz"
}
##################################################################################

readonly JENKINS_HOME=$1
readonly DEST_FILE=$2
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
readonly TMP_DIR="$CUR_DIR/tmp"
readonly ARC_NAME="jenkins-backup"
readonly ARC_DIR="$TMP_DIR/$ARC_NAME"
readonly TMP_TAR_NAME="$TMP_DIR/archive.tar.gz"

if [ -z "$JENKINS_HOME" -o -z "$DEST_FILE" ] ; then
  usage >&2
  exit 1
fi

rm -rf "$ARC_DIR" "$TMP_TAR_NAME"
for i in plugins jobs users secrets nodes;do
  mkdir -p "$ARC_DIR"/$i
done

cp -r "$JENKINS_HOME/"* "$ARC_DIR"

cd "$TMP_DIR"
tar -czvf "$TMP_TAR_NAME" "$ARC_NAME/"*
cd -
mv -f "$TMP_TAR_NAME" "$DEST_FILE"
rm -rf "$ARC_DIR"

exit 0
