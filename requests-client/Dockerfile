FROM python:3.8.1

ADD requirements.txt .
RUN pip install -r requirements.txt
RUN pip install -U pip

ENV OPENTELEMETRY_PYTHON_tracer_provider=sdk_tracer_provider
ENV PYTHONUNBUFFERED=1

ADD client.py /app/client.py
ADD start.sh /app/

CMD ["/app/start.sh"]