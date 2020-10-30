#!/bin/bash

# Updates local dashboard configurations by retrieving
# the new version from a Grafana instance.
#
# The script assumes that basic authentication is configured
# (change the login credentials with `LOGIN`).
#
# DASHBOARD_DIRECTORY represents the path to the directory
# where the JSON files corresponding to the dashboards exist.
# The default location is relative to the execution of the
# script.
#
# URL specifies the URL of the Grafana instance.
#

set -o errexit

readonly URL=${URL:-"http://15.185.82.128/graf"}
readonly LOGIN=${LOGIN:-"admin:password"}
readonly DASHBOARDS_DIRECTORY=${DASHBOARDS_DIRECTORY:-"./dashboards"}


main() {
  local dashboards=$(list_dashboards)
  local dashboard_json

  show_config

  for dashboard in $dashboards; do
    dashboard_json=$(get_dashboard "$dashboard")

    if [[ -z "$dashboard_json" ]]; then
      echo "ERROR:
  Couldn't retrieve dashboard $dashboard.
      "
      exit 1
    fi

    echo "$dashboard_json" >$DASHBOARDS_DIRECTORY/$dashboard.json
  done
}
export -f main
./script.sh

# Shows the global environment variables that have been configured
# for this run.
show_config() {
  echo "INFO:
  Starting dashboard extraction.
  
  URL:                  $URL
  LOGIN:                $LOGIN
  DASHBOARDS_DIRECTORY: $DASHBOARDS_DIRECTORY
  "  
}
export -f show_config
./script.sh

# Retrieves a dashboard ($1) from the database of dashboards.
#
# As we're getting it right from the database, it'll contain an `id`.
#
# Given that the ID is potentially different when we import it
# later, to make this dashboard importable we make the `id`
# field NULL.
get_dashboard() {
  local dashboard=$1

  if [[ -z "$dashboard" ]]; then
    echo "ERROR:
  A dashboard must be specified.
  "
    exit 1
  fi

  curl \
    --silent \
    --user "$LOGIN" \
    $URL/api/dashboards/db/$dashboard |
    jq '.dashboard | .id = null'
}
export -f get_dashboard
./script.sh

# lists all the dashboards available.
#
# `/api/search` lists all the dashboards and folders
# that exist in our organization.
#
# Here we filter the response (that also contain folders)
# to gather only the name of the dashboards.
list_dashboards() {
  curl \
    --silent \
    --user "$LOGIN" \
    $URL/api/search |
    jq -r '.[] | select(.type == "dash-db") | .uri' |
    cut -d '/' -f2
}

main "$@"

