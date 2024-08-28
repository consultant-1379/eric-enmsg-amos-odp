#!/bin/bash
APPS_PATH=/ericsson/tor/data/apps
HTML_PATH=/var/www/html
_RSYNC=/usr/bin/rsync
apps=(advancedmoscripting shell)

for app in "${apps[@]}"
do
  if [ ${app} == "advancedmoscripting" ]
      then
        $_RSYNC -avz --perms --chmod=D775,F664 --no-times --no-perms --no-group  "/var/www/html/${app}/metadata/*" "/ericsson/tor/data/apps/"
        fi

    mkdir -m 775 -p $APPS_PATH/${app}/locales/en-us/
    $_RSYNC -avz --perms --chmod=D775,F664 --no-times --no-perms --no-group "/var/www/html/advancedmoscripting/metadata/${app}/locales/en-us/app.json" "${APPS_PATH}/${app}/locales/en-us/"

    if [ ${app} == "advancedmoscripting" ]
        then
          $_RSYNC -avz --perms --chmod=D775,F664 --no-times --no-perms --no-group "/var/www/html/advancedmoscripting/metadata/${app}/locales/en-us/app_actions.json" "${APPS_PATH}/${app}/locales/en-us/"
          fi

    if [ $? -ne 0 ]
    then
        logger  -t "CLOUD INIT" -p local0.err "($prg) [${app} deploy] failed to copy en-us localization files."
        exit 1
    fi
done