FROM alpine:3.6

EXPOSE 9191

VOLUME [ "/ara" ]

ENV ARA_DATABASE=sqlite:////ara/ara-db.sqlite

ARG ARA_VERSION=0.14.5

LABEL ARA_VERSION=$ARA_VERSION \
      ALPINE_VERSION=3.6

RUN apk add --update --no-cache \
        python \
        py-pip \
        libffi \
        openssl-dev \
        ca-certificates \
        py2-psycopg2 \
    && apk add --update --no-cache --virtual build-deps \
        python-dev \
        build-base \
        libffi-dev \
        linux-headers \
    && pip install --no-cache-dir --upgrade \
        pip \
        ara==${ARA_VERSION} \
        pymysql \
    && apk del build-deps

ENTRYPOINT [ "ara-manage", "runserver", "-h", "0.0.0.0", "-R" ]
