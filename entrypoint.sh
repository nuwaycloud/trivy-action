#!/bin/bash

set -e

###################################
##### function to exit script #####
###################################
function exitScript()
{
    local message=$1
    [ -z "$message" ] && message="Died"
    echo -e "${RED}[$FAILED] $message at ${BASH_SOURCE[1]}:${FUNCNAME[1]} line ${BASH_LINENO[0]}.${RESET}" >&2
    exit 1
}

#########################################
##### function to scan docker image #####
#########################################
function scan_image()
{
  if [ "${INPUT_SCAN_TYPE}" == "image" ]; then
     [ -z "${INPUT_IMAGE_NAME}" ] && exitScript "Please pass docker image name with image_name input, exiting..."
     trivy_input="${INPUT_IMAGE_NAME}"
     error_mmessage="trivy found vulnerabilities in docker image ${INPUT_IMAGE_NAME}, exiting..."
  else
     exitScript "Please pass supported scan type(image,repository), exiting..."
  fi

  [ "${INPUT_EXIT_CODE}" ] && trivy_arguments="${trivy_arguments} --exit-code ${INPUT_EXIT_CODE}"
  [ "${INPUT_SEVERITY}" ] && trivy_arguments="${trivy_arguments} --severity ${INPUT_SEVERITY}"
  [ "${INPUT_VULN_TYPE}" ] && trivy_arguments="${trivy_arguments} --vuln-type ${INPUT_VULN_TYPE}"
  [ "${INPUT_FORMAT}" ] && trivy_arguments="${trivy_arguments} --format ${INPUT_FORMAT}"

  trivy ${INPUT_SCAN_TYPE} ${trivy_arguments} ${trivy_input} || exitScript "${error_mmessage}"
  echo -e "${CYAN}[$SUCCESS] trivy scan completed"
  echo -e "${GREEN} Congratulations!!! Trivy found no vulnerability issues. ${RESET}"
}

RED='\033[0;31m'
RESET='\033[0m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
SUCCESS='\u2714'
FAILED='\u274c'

trivy_argumments=""

scan_image
