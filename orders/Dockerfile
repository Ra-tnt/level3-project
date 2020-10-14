FROM maven:3-jdk-11 as build
WORKDIR /tmp/

COPY src /tmp/src
COPY pom.xml /tmp/

RUN mvn -DskipTests package


FROM weaveworksdemos/msd-java:jre-latest

#WORKDIR /usr/src/app

COPY --from=build tmp/target/orders.jar ./app.jar
RUN chmod a+rx ./app.jar
RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

USER ${SERVICE_USER}

ENTRYPOINT ["/usr/local/bin/java.sh","-jar","./app.jar", "--port=80"]
