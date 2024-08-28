#!/bin/bash

_WALL=/usr/bin/wall

PROG="amos-preStop"
TEMP_COM_USERS_CLEANUP=/opt/ericsson/amos/scripts/temporary_com_users_cleanup.sh
SCRIPT_CHECK_USER=/ericsson/sg/check_user_session.sh

#############################################################
#
# Logger Functions
#
#############################################################
info() {
    logger -t "${PROG}" -p user.notice "INFO ( ${PROG} ): $1"
}

#######################################
# Action :
#  print_wall_message
#   Sends the wall message to all the users currently logged in.
# Globals :
#   _WALL
# Arguments:
#   None
# Returns:
#   None
#######################################
print_wall_message() {
  $_WALL "Please save your work, the system received restart command."
}

#######################################
# Action :
#  temporary_com_users_cleanup
#   Cleans up the temporary users.
# Globals :
#   TEMP_COM_USERS_CLEANUP
# Arguments:
#   None
# Returns:
#   None
#######################################
temporary_com_users_cleanup() {
    [ -f "${TEMP_COM_USERS_CLEANUP}" ] && ${TEMP_COM_USERS_CLEANUP} -a 0
}

#######################################
# Action :
#   stop
#   Sends the wall message to all the users currently logged in.
#   Cleans up the temporary users.
#   Execute the check_user_session.sh script.
# Globals:
#   SCRIPT_CHECK_USER
# Arguments:
#   None
# Returns:
#   0 Always
#######################################
preStop() {
  print_wall_message
  temporary_com_users_cleanup
  ${SCRIPT_CHECK_USER}
  return 0
}

#////////////////////////////////////////////
# service main starts here.
#////////////////////////////////////////////
preStop

info "The pre-stop activity has successfully finished."
exit 0