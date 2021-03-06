#!/bin/sh

set -e
set -x

pushd dataprep
./makeDocker.sh  # This builds, among other things, the dataprep jar that the Dockerfile.server depends on.
popd

VERSION=$(cat version.txt)

docker build -t spv2/server:$VERSION -f Dockerfile.server .
docker build -t spv2/db_worker:$VERSION -f Dockerfile.db_worker .
docker build -t spv2/cron:$VERSION -f Dockerfile.cron .

docker tag spv2/server:$VERSION 896129387501.dkr.ecr.us-west-2.amazonaws.com/spv2/server:$VERSION
docker tag spv2/db_worker:$VERSION 896129387501.dkr.ecr.us-west-2.amazonaws.com/spv2/db_worker:$VERSION
docker tag spv2/cron:$VERSION 896129387501.dkr.ecr.us-west-2.amazonaws.com/spv2/cron:$VERSION

docker push 896129387501.dkr.ecr.us-west-2.amazonaws.com/spv2/server:$VERSION
docker push 896129387501.dkr.ecr.us-west-2.amazonaws.com/spv2/db_worker:$VERSION
docker push 896129387501.dkr.ecr.us-west-2.amazonaws.com/spv2/cron:$VERSION
