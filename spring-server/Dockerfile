FROM openjdk:8-jre-alpine

ADD target/opentelemetry-instrumentation-demo-0.0.1-SNAPSHOT.jar /app/
ADD opentelemetry-javaagent-all.jar /app/
ADD start.sh /app/

CMD ["/app/start.sh"]
