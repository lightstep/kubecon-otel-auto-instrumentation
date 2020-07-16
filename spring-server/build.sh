#!/bin/bash
#
# Copyright Lightstep Authors
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

AGENT_URL=https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent-all.jar
AGENT_JAR=opentelemetry-javaagent-all.jar

echo "detecing the java instrumentation jar..."
if [ ! -f "$AGENT_JAR" ]; then
	echo "downloading the java instrumentation jar..."
	wget $AGENT_URL
fi

echo "building the server"
./mvnw package
