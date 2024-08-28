#!/bin/bash

#Variables
_JAVA=/usr/bin/java
_LOGGER=/bin/logger

SCRIPT_NAME="${0}"
HEALTH_CHECK_JAR=/ericsson/ERICamosservice2_CXP9039087/pod_healthcheck/amos-lb-healthcheck.jar
MEMORY_CALCULATOR=com.ericsson.pod.healthcheck.GetMemory
LOG_TAG="LOAD_BALANCER"

############################################################################################
# Logger Function
############################################################################################

info()
{
  $_LOGGER -s -t "${LOG_TAG}" -p user.notice "INFO ( ${SCRIPT_NAME} ): $1"
}

error()
{
  $_LOGGER -s -t "${LOG_TAG}" -p user.notice "ERROR ( ${SCRIPT_NAME} ): $1"
}

############################################################################################
# Threshold will be 15% of Free memory in the pod.
############################################################################################

$_JAVA -Xms10m -Xmx10m -cp ${HEALTH_CHECK_JAR} ${MEMORY_CALCULATOR} "15"
if [[ $? == 0 ]]; then
   exit 0
else
   error "Memory usage reached beyond 85%"
   exit 1
fi
