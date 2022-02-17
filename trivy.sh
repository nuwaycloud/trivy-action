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

#############################################
##### function to download trivy binary #####
#############################################
function download_trivy()
{
    [ -z "${INPUT_VERSION}" ] && exitScript "please pass trivy version with <version> input, exiting..."
    install_url="https://github.com/aquasecurity/trivy/releases/download/v${INPUT_VERSION}/trivy_${INPUT_VERSION}_Linux-64bit.deb"
    wget $install_url
    sudo dpkg -i trivy_${INPUT_VERSION}_Linux-64bit.deb || exitScript "Failed to install trivy version ${INPUT_VERSION}, exiting..."
    echo -e "${CYAN}[$SUCCESS] trivy installed ${RESET}"
}

#########################################
##### function to scan docker image #####
#########################################
function scan_image()
{
  [ -z "${INPUT_IMAGE_NAME}" ] && exitScript "please pass docker image to scan for vulnerabilities, exiting..."
  /usr/local/bin/trivy image ${INPUT_ADDITIONAL_OPTIONS} $INPUT_IMAGE_NAME || exitScript "trivy found vulnerabilities in docker image ${INPUT_IMAGE_NAME}, exiting..."
  echo -e "${CYAN}[$SUCCESS] trivy scan completed"
  echo -e "${GREEN} Congratulations!!! Trivy found no vulnerability issues. ${RESET}"
}

RED='\033[0;31m'
RESET='\033[0m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
SUCCESS='\u2714'
FAILED='\u274c'

download_trivy
scan_image
