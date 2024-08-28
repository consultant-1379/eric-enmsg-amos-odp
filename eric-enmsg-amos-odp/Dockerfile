ARG ERIC_ODP_BASE_IMAGE_NAME=eric-enm-sles-base-scripting-odp
ARG ERIC_ODP_BASE_IMAGE_REPO=armdocker.rnd.ericsson.se/proj_oss_releases/enm
ARG ERIC_ODP_BASE_IMAGE_TAG=1.0.0-21
ARG IMAGE_BUILD_VERSION

FROM ${ERIC_ODP_BASE_IMAGE_REPO}/${ERIC_ODP_BASE_IMAGE_NAME}:${ERIC_ODP_BASE_IMAGE_TAG}

ENV JBOSS_HOST amos-odp-services
RUN echo "JBOSS_HOST=amos-odp-services" >> /etc/environment

RUN zypper install -y EXTRjdk11_CXP9038676 && ln -s /usr/java/jdk11* /usr/java/openjdk_latest

ENV JAVA_HOME=/usr/java/openjdk_latest
ENV PATH=$JAVA_HOME/bin:$PATH

RUN zypper install -y ERICenmmoshell_CXP9032228 \
    net-tools-deprecated

RUN zypper --no-gpg-checks install -y https://arm1s11-eiffel004.eiffel.gic.ericsson.se:8443/nexus/content/repositories/snapshots/com/ericsson/oss/services/amos/ERICamosrestrequestbroker_CXP9031949/2.46.1-SNAPSHOT/ERICamosrestrequestbroker_CXP9031949-2.46.1-20240508.091927-8.rpm
