FROM openjdk:17-alpine

WORKDIR /appy

ENV MANAGEMENT_METRICS_BINDERS_PROCESSOR_ENABLED=false

COPY devops-proj.jar .

EXPOSE 8080

CMD [ "java" , "-jar", "devops-proj.jar"]
