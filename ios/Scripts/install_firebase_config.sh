#!/bin/sh

SCHEME_NAME="default"

# Extract the scheme name from the Build Configuration name.
#
# Our scheme names are "dev" and "prod", so we named our Build Configurations as
# "Debug-dev", "Debug-prod", etc., which is the naming convention required by
# Flutter flavors.
#
# The $CONFIGURATION variable in the XCode build environment contains the
# configuration name, so from it we can extract the scheme name. E.g., if
# CONFIGURATION="Debug-prod", then the environment will be set to "prod".
if [[ $CONFIGURATION =~ -([^-]*)$ ]]; then
SCHEME_NAME=${BASH_REMATCH[1]}
fi

echo "note: Current scheme (flavor) is $SCHEME_NAME"

# Using the scheme name, set the name and path of the resource we're installing.
GOOGLESERVICE_INFO_PLIST=GoogleService-Info.plist
GOOGLESERVICE_INFO_FILE=${PROJECT_DIR}/Config/${SCHEME_NAME}/${GOOGLESERVICE_INFO_PLIST}

# Make sure the resource exists at the path.
echo "note: Looking for ${GOOGLESERVICE_INFO_FILE}"
if [ ! -f $GOOGLESERVICE_INFO_FILE ]
then
echo "error: No GoogleService-Info.plist found"
exit 1
fi

# Set the destination location for the resource. This is the default location
# where the Firebase init code expects to find GoogleServices-Info.plist.
PLIST_DESTINATION=${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app

# Copy the current scheme's GoogleService-Info.plist to the destination.
echo "Copying ${GOOGLESERVICE_INFO_PLIST} to ${PLIST_DESTINATION}"
cp "${GOOGLESERVICE_INFO_FILE}" "${PLIST_DESTINATION}"
