#!/bin/bash -eu

# Copyright 2018 ConsenSys AG.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

NO_LOCK_REQUIRED=false

. ./.env
. ./.common.sh

HOST=${DOCKER_PORT_2375_TCP_ADDR:-"localhost"}

# Displays links to exposed services
echo "${bold}*************************************"
echo "Sample Network for Besu at ${version}"
echo "*************************************${normal}"
echo "List endpoints and services"
echo "----------------------------------"

# Displays services list with port mapping
composeFile=$(head -n 1 $LOCK_FILE)
docker-compose $composeFile ps

echo "****************************************************************"
if [ ${#dots} -gt ${maxRetryCount} ]; then
  echo "ERROR: Web block explorer is not started at http://${HOST}:${explorerPort} !"
  echo "****************************************************************"
else
  echo "JSON-RPC HTTP service endpoint      : http://${HOST}:8545"
  echo "JSON-RPC WebSocket service endpoint : ws://${HOST}:8546"
  echo "GraphQL HTTP service endpoint       : http://${HOST}:8547"
  echo "Web block explorer address          : http://${HOST}:25000/"
  echo "Prometheus address                  : http://${HOST}:9090/graph"
  echo "Grafana address                     : http://${HOST}:3000/d/XE4V0WGZz/besu-overview?orgId=1&refresh=10s&from=now-30m&to=now&var-system=All"
  echo "****************************************************************"
fi

