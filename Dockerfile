ARG ERIC_ENM_SLES_EAP7_IMAGE_NAME=eric-enm-sles-eap7
ARG ERIC_ENM_SLES_EAP7_IMAGE_REPO=armdocker.rnd.ericsson.se/proj-enm
ARG ERIC_ENM_SLES_EAP7_IMAGE_TAG=1.62.0-45

FROM ${ERIC_ENM_SLES_EAP7_IMAGE_REPO}/${ERIC_ENM_SLES_EAP7_IMAGE_NAME}:${ERIC_ENM_SLES_EAP7_IMAGE_TAG}

ARG BUILD_DATE=unspecified
ARG IMAGE_BUILD_VERSION=unspecified
ARG GIT_COMMIT=unspecified
ARG ISO_VERSION=unspecified
ARG RSTATE=unspecified
ARG SGUSER=273570

LABEL \
com.ericsson.product-number="CXC 174 2010" \
com.ericsson.product-revision=$RSTATE \
enm_iso_version=$ISO_VERSION \
org.label-schema.name="ENM AMOS Service Group" \
org.label-schema.build-date=$BUILD_DATE \
org.label-schema.vcs-ref=$GIT_COMMIT \
org.label-schema.vendor="Ericsson" \
org.label-schema.version=$IMAGE_BUILD_VERSION \
org.label-schema.schema-version="1.0.0-rc1"

RUN rpm -e --nodeps ERICcredentialmanagercli_CXP9031389 || echo "No ERICcredentialmanagercli_CXP9031389 installed"

RUN mkdir -p /ericsson/amos/ \
    /var/tmp/rpms \
    /ericsson/cert/data/certs

ENV ENM_JBOSS_SDK_CLUSTER_ID="amos" \
    ENM_JBOSS_BIND_ADDRESS="0.0.0.0" \
    JBOSS_CONF="/ericsson/3pp/jboss/app-server.conf"

## add extra logic for service group startup
COPY image_content/createCertificatesLinks.sh /ericsson/3pp/jboss/bin/pre-start/createCertificatesLinks.sh

COPY image_content/updateCertificatesLinks.sh /usr/lib/ocf/resource.d/updateCertificatesLinks.sh
RUN /bin/chmod 755 /usr/lib/ocf/resource.d/updateCertificatesLinks.sh

RUN /bin/chown jboss_user:jboss /ericsson/3pp/jboss/bin/pre-start/createCertificatesLinks.sh
RUN /bin/chmod 755 /ericsson/3pp/jboss/bin/pre-start/createCertificatesLinks.sh

RUN /bin/mkdir -p -m 775 /ericsson/credm/data/certs && \
    /bin/chown -R jboss_user:jboss /ericsson/credm/data/certs

RUN /bin/mkdir -p /home/shared/common

RUN zypper install -y less ERICserviceframework4_CXP9037454  \
    ERICserviceframeworkmodule4_CXP9037453  \
    ERICmodelserviceapi_CXP9030594  \
    ERICmodelservice_CXP9030595  \
    ERICpib2_CXP9037459  \
    ERICwebpushmodule_CXP9042711 && \
    zypper download ERICenmsgamos_CXP9031904 && \
    rpm -ivh /var/cache/zypp/packages/enm_iso_repo/ERICenmsgamos_CXP9031904*.rpm --allfiles --nodeps --noscripts

## this part and scripts and services will be removed

RUN chmod 755 /ericsson/3pp/jboss/bin/microhealthcheck.sh && \
    rm /usr/lib/ocf/resource.d/amos_vm_configured.sh && \
    rm /etc/init.d/amos-config

EXPOSE 22 3528 4447 5342 5343 8009 8080 9920 9921 9990 9999 12987 38467 46001 54200 55631 56164 58156 63167 33077 33078 33079 33080 33081 33082 33083 33084 33085 33086 33087

## apply compatiblity for scripts, that tried to run with default system python
RUN cp /usr/bin/python3 /usr/bin/python


RUN zypper --no-gpg-checks install -y \
      https://arm1s11-eiffel004.eiffel.gic.ericsson.se:8443/nexus/content/repositories/snapshots/com/ericsson/oss/presentation/server/terminal/ERICterminalwebsocket2_CXP9039065/2.22.1-SNAPSHOT/ERICterminalwebsocket2_CXP9039065-2.22.1-20240513.131901-21.rpm \
      https://arm1s11-eiffel004.eiffel.gic.ericsson.se:8443/nexus/content/repositories/snapshots/com/ericsson/oss/services/amos/ERICamosservice2_CXP9039087/2.46.1-SNAPSHOT/ERICamosservice2_CXP9039087-2.46.1-20240508.091918-8.rpm

RUN chmod 550 /ericsson/3pp/jboss/standalone/deployments/terminal-websocket-war*
RUN chmod 550 /ericsson/3pp/jboss/standalone/deployments/amos-service-ear*
RUN zypper clean --all



RUN rm -rf /ericsson/3pp/jboss/standalone/deployments/cleanup/* \
    /ericsson/3pp/jboss/standalone/deployments/cleanup \
    /ericsson/3pp/jboss/bin/pre-start/configure_nfs_mounts_moshell.sh \
    /ericsson/3pp/jboss/bin/pre-start/configure_SSHD_amos.sh \
    /ericsson/3pp/jboss/bin/pre-start/configure_selinux_for_vsftpd.sh \
    /ericsson/3pp/jboss/bin/pre-start/create_amos_log_dir.sh \
    /ericsson/3pp/jboss/bin/pre-start/swapEnable.sh \
    /ericsson/3pp/jboss/bin/post-start/configCronForFtpes.sh \
    /ericsson/3pp/jboss/bin/post-start/configure_share_permissions.sh \
    /ericsson/3pp/jboss/bin/post-start/configure_sshd.sh \
    /ericsson/3pp/jboss/bin/post-start/create_amos_watcher_cron.sh \
    /ericsson/3pp/jboss/bin/post-start/ftpes-config.sh \
    /ericsson/3pp/jboss/bin/post-start/vsftpd_configure_services.sh

ENV container eric-odp
RUN echo "container=eric-odp" >> /etc/environment
ENV POSTGRES_SERVICE_HOST postgres
RUN echo "POSTGRES_SERVICE_HOST=postgres" >> /etc/environment

## NON ROOT access
RUN /bin/mkdir -p -m 775 /ericsson/credm/data/xmlfiles && \
    /bin/chown -R jboss_user:jboss /ericsson/credm/data/xmlfiles && \
    rm -f /ericsson/3pp/jboss/bin/post-start/update_management_credential_permissions.sh /ericsson/3pp/jboss/bin/post-start/update_standalone_permissions.sh && \
    echo "$SGUSER:x:$SGUSER:$SGUSER:An Identity for amos-odp-services:/nonexistent:/bin/false" >>/etc/passwd && \
    echo "$SGUSER:!::0:::::" >>/etc/shadow

USER $SGUSER
