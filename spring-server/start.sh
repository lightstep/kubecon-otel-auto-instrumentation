#!/bin/sh
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

DEFAULT_JAEGER_ENDPOINT=localhost:14250
DEFAULT_REDIS_HOST=localhost

if [ "$JAEGER_ENDPOINT" == "" ]; then
	JAEGER_ENDPOINT=$DEFAULT_JAEGER_ENDPOINT
fi

if [ "$REDIS_HOST" == "" ]; then
	REDIS_HOST=$DEFAULT_REDIS_HOST
fi

echo "starting server"
java -javaagent:/app/opentelemetry-javaagent-all.jar \
	-Dotel.exporter=jaeger \
	-Dotel.jaeger.service.name=spring-server \
	-Dotel.jaeger.endpoint=$JAEGER_ENDPOINT \
	-Dredis.host=$REDIS_HOST \
	-jar /app/opentelemetry-instrumentation-demo-0.0.1-SNAPSHOT.jar
