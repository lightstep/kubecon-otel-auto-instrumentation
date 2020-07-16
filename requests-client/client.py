#!/usr/bin/env python3
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

import os
import time

import backoff
from opentelemetry import trace
from opentelemetry.ext.jaeger import JaegerSpanExporter
from opentelemetry.sdk.trace.export import BatchExportSpanProcessor
import requests


trace.get_tracer_provider().add_span_processor(
    BatchExportSpanProcessor(
        JaegerSpanExporter(
            "requests-client",
            agent_host_name=os.getenv("OTEL_EXPORTER_JAEGER_AGENT_HOST", "jaeger"),
        ),
    )
)


def send_requests(destination):
    url = f"{destination}/help-from-the-internet"
    try:
        res = requests.get(url)
        print(f"Working from home advice: {res.text}")
    except Exception as e:
        print(f"Request to {url} failed {e}")


@backoff.on_exception(
    backoff.expo, (requests.exceptions.Timeout, requests.exceptions.ConnectionError)
)
def populate(destination):
    url = f"{destination}/populate"
    requests.get(url)


if __name__ == "__main__":
    destination = os.getenv("DESTINATION", "http://localhost:8080")

    populate(destination)

    while True:
        send_requests(destination)
        time.sleep(5)
