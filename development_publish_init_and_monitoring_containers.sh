

## tag and push monitoring image
VERSION=1.62.0-44

docker pull armdocker.rnd.ericsson.se/proj-enm/eric-enm-monitoring-eap7:${VERSION}
docker tag armdocker.rnd.ericsson.se/proj-enm/eric-enm-monitoring-eap7:${VERSION} armdocker.rnd.ericsson.se/proj_oss_releases/enm/eric-enm-monitoring-eap7:${VERSION}

docker push armdocker.rnd.ericsson.se/proj_oss_releases/enm/eric-enm-monitoring-eap7:${VERSION}

docker rmi -f armdocker.rnd.ericsson.se/proj_oss_releases/enm/eric-enm-monitoring-eap7:${VERSION}
docker rmi -f armdocker.rnd.ericsson.se/proj-enm/eric-enm-monitoring-eap7:${VERSION}

## tag and push init image
VERSION=1.62.0-44
docker pull armdocker.rnd.ericsson.se/proj-enm/eric-enm-init-container:${VERSION}
docker tag armdocker.rnd.ericsson.se/proj-enm/eric-enm-init-container:${VERSION} armdocker.rnd.ericsson.se/proj_oss_releases/enm/eric-enm-init-container:${VERSION}

docker push armdocker.rnd.ericsson.se/proj_oss_releases/enm/eric-enm-init-container:${VERSION}
docker rmi -f armdocker.rnd.ericsson.se/proj_oss_releases/enm/eric-enm-init-container:${VERSION}
docker rmi -f armdocker.rnd.ericsson.se/proj-enm/eric-enm-init-container:${VERSION}


## credm

## tag and push enm-wait-for-certificates-container
VERSION=1.50.0-45

docker pull armdocker.rnd.ericsson.se/proj-enm/"enm-wait-for-certificates-container:${VERSION}"
docker tag armdocker.rnd.ericsson.se/proj-enm/"enm-wait-for-certificates-container:${VERSION}" armdocker.rnd.ericsson.se/proj_oss_releases/enm/"enm-wait-for-certificates-container:${VERSION}"

docker push armdocker.rnd.ericsson.se/proj_oss_releases/enm/"enm-wait-for-certificates-container:${VERSION}"

docker rmi -f armdocker.rnd.ericsson.se/proj_oss_releases/enm/"enm-wait-for-certificates-container:${VERSION}"
docker rmi -f armdocker.rnd.ericsson.se/proj-enm/"enm-wait-for-certificates-container:${VERSION}"


## tag and push init image
docker pull armdocker.rnd.ericsson.se/proj-enm/"enm-certrequestjob-container:${VERSION}"
docker tag armdocker.rnd.ericsson.se/proj-enm/"enm-certrequestjob-container:${VERSION}" armdocker.rnd.ericsson.se/proj_oss_releases/enm/"enm-certrequestjob-container:${VERSION}"

docker push armdocker.rnd.ericsson.se/proj_oss_releases/enm/"enm-certrequestjob-container:${VERSION}"

docker rmi -f armdocker.rnd.ericsson.se/proj_oss_releases/enm/"enm-certrequestjob-container:${VERSION}"
docker rmi -f armdocker.rnd.ericsson.se/proj-enm/"enm-certrequestjob-container:${VERSION}"
