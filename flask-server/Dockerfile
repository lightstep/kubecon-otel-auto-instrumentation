FROM python:3.8.1

ADD requirements.txt .
RUN pip install -r requirements.txt

ENV OPENTELEMETRY_PYTHON_tracer_provider=sdk_tracer_provider
ENV PYTHONUNBUFFERED=1

ADD server.py /app/server.py
CMD ["opentelemetry-instrument", "/app/server.py"]