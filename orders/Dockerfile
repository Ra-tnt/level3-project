FROM maven:3-jdk-11 as build
WORKDIR /orders

copy . /orders

run mvn clean package

from adoptopenjdk/openjdk11:alpine

COPY --from=build /orders/target/orders.jar /orders.jar

RUN chmod a+rx ./orders.jar

USER ${SERVICE_USER}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG COMMIT

LABEL org.label-schema.vendor="bryandollery" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.version="${BUILD_VERSION}" \
  org.label-schema.name="Socks Shop: Orders" \
  org.label-schema.description="REST API for Orders service" \
  org.label-schema.url="https://github.com/microservices-demo/orders" \
  org.label-schema.vcs-url="github.com:microservices-demo/orders.git" \
  org.label-schema.vcs-ref="${COMMIT}" \
  org.label-schema.schema-version="1.0"

ENTRYPOINT ["/opt/java/openjdk/bin/java","-jar","./orders.jar", "--port=80"]
#EXPOSE 80
