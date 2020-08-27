#!/bin/bash -e

KEEP_RUNNING=
USE_EXISTING_CONTAINERS=

while [ ! -z "$*" ] ; do
  case $1 in
    "--keep-running" )
      KEEP_RUNNING=yes
      ;;
    "--use-existing-containers" )
      USE_EXISTING_CONTAINERS=yes
      ;;
    "--help" )
      echo ./test.sh --keep-running --use-existing-containers
      exit 0
      ;;
    *)
      echo ./test.sh --keep-running --use-existing-containers
      exit 0
      ;;
  esac
  shift
done

./gradlew testClasses

if [ -z "$USE_EXISTING_CONTAINERS" ] ; then
  ./gradlew mysqlComposeDown
fi

./gradlew mysqlComposeUp

./gradlew  build



if [ -z "$KEEP_RUNNING" ] ; then
  ./gradlew mysqlComposeDown
fi


