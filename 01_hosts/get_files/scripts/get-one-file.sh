#!/bin/bash

function echo_message() {
  echo "--------------------------------------------------------"
  echo "=> $1"
  echo "--------------------------------------------------------"
  echo ""
}

# ---------------- DOWNLOAD FILE TO LOCAL MACHINE, TO DEFAULT LOCATION -------------------
# The intention is to download to a default location, make a cache, to avoid repetitive downloads

FILE=$1
REPO=$2
IS_REPO_REMOTE=$3
DOWNLOAD_TO_DIR=$4
LOCAL_FILE_NAME=$5

#REPO="~/Downloads/Jboss/"  # In case of manual Download, IS_REPO_REMOTE=false
REPO_FILE=$REPO/$FILE


if [ ! -d $DOWNLOAD_TO_DIR ]; then
  mkdir -p $DOWNLOAD_TO_DIR
fi

#-z test if variable is empty, keep file name
if [ -z "$LOCAL_FILE_NAME" ]; then
  DOWNLOAD_TO_FILE=$DOWNLOAD_TO_DIR/$FILE
else
#or #Download to especific name LOCAL_FILE_NAME
  DOWNLOAD_TO_FILE=$DOWNLOAD_TO_DIR/$LOCAL_FILE_NAME
fi

if [ -f $DOWNLOAD_TO_FILE ]; then
  echo_message "File $DOWNLOAD_TO_FILE already downloaded"
else
  if [ "$IS_REPO_REMOTE" == true ]; then
    echo_message "Downloading to $DOWNLOAD_TO_FILE"
    echo wget  --no-check-certificate -O $DOWNLOAD_TO_FILE $REPO_FILE 
    #wget --no-check-certificate -O $DOWNLOAD_TO_FILE $REPO_FILE
    A=$$; ( wget --no-check-certificate -O $A.d $REPO_FILE && mv $A.d $DOWNLOAD_TO_FILE ) || (rm $A.d; echo "Removing temp file") 
  else 
    echo_message "Copying $FILE to $DOWNLOAD_TO_FILE"
    echo cp $REPO_FILE $DOWNLOAD_TO_FILE
    cp $REPO_FILE $DOWNLOAD_TO_FILE
  fi

  if [ ! -f $DOWNLOAD_TO_FILE ]; then
    echo_message "ERROR, failed to download $DOWNLOAD_TO_FILE"
    exit 1
  else
    echo_message "Download finished"
    exit 0
  fi
  
fi
