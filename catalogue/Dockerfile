FROM golang:1.7 as builder

COPY . /go/src/github.com/Ra-tnt/level3-project
WORKDIR /go/src/github.com/Ra-tnt/level3-project/catalogue

RUN go get -u github.com/FiloSottile/gvt
RUN gvt restore && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app github.com/Ra-tnt/level3-project/catalogue/cmd/cataloguesvc

FROM alpine:3.4

ENV	SERVICE_USER=myuser \
	SERVICE_UID=10001 \
	SERVICE_GROUP=mygroup \
	SERVICE_GID=10001

RUN	addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} && \
	adduser -g "${SERVICE_NAME} user" -D -H -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER} && \
	apk add --update libcap

WORKDIR /
COPY --from=builder /app /app
COPY images/ /images/

RUN	chmod +x /app && \
	chown -R ${SERVICE_USER}:${SERVICE_GROUP} /app /images && \
	setcap 'cap_net_bind_service=+ep' /app

USER ${SERVICE_USER}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG COMMIT

LABEL org.label-schema.vendor="Weaveworks" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.version="${BUILD_VERSION}" \
  org.label-schema.name="Socks Shop: Catalogue" \
  org.label-schema.description="REST API for Catalogue service" \
  org.label-schema.url="https://github.com/Ra-tnt/level3-project/catalogue" \
  org.label-schema.vcs-url="github.com:Ra-tnt/level3-project.git" \
  org.label-schema.vcs-ref="${COMMIT}" \
  org.label-schema.schema-version="1.0"

CMD ["/app", "-port=80"]
EXPOSE 80
