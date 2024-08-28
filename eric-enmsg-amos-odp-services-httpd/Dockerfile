ARG ERIC_ENM_SLES_APACHE2_IMAGE_NAME=eric-enm-sles-apache2
ARG ERIC_ENM_SLES_APACHE2_IMAGE_REPO=armdocker.rnd.ericsson.se/proj-enm
ARG ERIC_ENM_SLES_APACHE2_IMAGE_TAG=1.57.0-44

FROM ${ERIC_ENM_SLES_APACHE2_IMAGE_REPO}/${ERIC_ENM_SLES_APACHE2_IMAGE_NAME}:${ERIC_ENM_SLES_APACHE2_IMAGE_TAG}

ARG BUILD_DATE=unspecified
ARG IMAGE_BUILD_VERSION=unspecified
ARG GIT_COMMIT=unspecified
ARG ISO_VERSION=unspecified
ARG RSTATE=unspecified
ARG SGUSER=273570

LABEL \
com.ericsson.product-number="CXC Placeholder" \
com.ericsson.product-revision=$RSTATE \
enm_iso_version=$ISO_VERSION \
org.label-schema.name="ENM Amos UI SideCar" \
org.label-schema.build-date=$BUILD_DATE \
org.label-schema.vcs-ref=$GIT_COMMIT \
org.label-schema.vendor="Ericsson" \
org.label-schema.version=$IMAGE_BUILD_VERSION \
org.label-schema.schema-version="1.0.0-rc1"

RUN zypper install -y ERICamosui_CXP9032045 && \
    zypper clean -a

ENV CREDM_CONTROLLER_MNG="TRUE"
ENV PROXY_PASS_RULES="amos-service,terminal-websocket"

COPY addAppsToLauncher.sh /var/tmp/
RUN sed -i "9 a bash /var/tmp/addAppsToLauncher.sh" entry-point.sh

RUN echo "$SGUSER:x:$SGUSER:$SGUSER:An Identity for amos-odp-services-httpd:/nonexistent:/bin/false" >>/etc/passwd && \
    echo "$SGUSER:!::0:::::" >>/etc/shadow

EXPOSE 8084 8444

USER $SGUSER
