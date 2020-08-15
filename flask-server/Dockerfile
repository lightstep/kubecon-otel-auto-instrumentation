FROM python:3.8.1

RUN pip install -U pip
ADD requirements.txt .
RUN pip install -r requirements.txt

ENV OTEL_PYTHON_TRACER_PROVIDER=sdk_tracer_provider
ENV PYTHONUNBUFFERED=1

ADD server.py /app/server.py
ADD start.sh /app/

CMD ["/app/start.sh"]