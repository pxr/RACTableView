#!/bin/bash

PRODUCT_NAME=RACTableView
API_TOKEN=
TEAM_TOKEN=
SIGNING_IDENTITY="iPhone Distribution: Paul Robinson"
PROVISIONING_PROFILE="${HOME}/Library/MobileDevice/Provisioning Profiles/5104F24D-A2C8-46C2-92D9-E3B11522D311.mobileprovision"
LOG="/tmp/testflight.log"
#GROWL="${HOME}/bin/growlnotify -a Xcode -w"

DATE=$( /bin/date +"%Y-%m-%d" )
ARCHIVE=$( /bin/ls -t "${HOME}/Library/Developer/Xcode/Archives/${DATE}" | /usr/bin/grep xcarchive | /usr/bin/sed -n 1p )
DSYM="${HOME}/Library/Developer/Xcode/Archives/${DATE}/${ARCHIVE}/dSYMs/${PRODUCT_NAME}.app.dSYM"
APP="${HOME}/Library/Developer/Xcode/Archives/${DATE}/${ARCHIVE}/Products/Applications/${PRODUCT_NAME}.app"

/usr/bin/open -a /Applications/Utilities/Console.app $LOG

echo -n "Creating .ipa for ${PRODUCT_NAME}... " > $LOG
echo "Creating .ipa for ${PRODUCT_NAME}" | ${GROWL}

/bin/rm "/tmp/${PRODUCT_NAME}.ipa"

echo "app ${APP}"
echo "productname: ${PRODUCT_NAME}"

/usr/bin/xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "/tmp/${PRODUCT_NAME}.ipa" --sign "${SIGNING_IDENTITY}" --embed "${PROVISIONING_PROFILE}"

echo "done." >> $LOG
echo "Created .ipa for ${PRODUCT_NAME}" | ${GROWL}

echo -n "Zipping .dSYM for ${PRODUCT_NAME}..." >> $LOG
echo "Zipping .dSYM for ${PRODUCT_NAME}" | ${GROWL}

/bin/rm "/tmp/${PRODUCT_NAME}.dSYM.zip"
/usr/bin/zip -r "/tmp/${PRODUCT_NAME}.dSYM.zip" "${DSYM}"

echo "done." >> $LOG
echo "Created .dSYM for ${PRODUCT_NAME}" | ${GROWL}

echo -n "Uploading to TestFlight... " >> $LOG
echo "Uploading to TestFlight" | ${GROWL}

/usr/bin/curl "http://testflightapp.com/api/builds.json" \
-F file=@"/tmp/${PRODUCT_NAME}.ipa" \
-F dsym=@"/tmp/${PRODUCT_NAME}.dSYM.zip" \
-F api_token="${API_TOKEN}" \
-F team_token="${TEAM_TOKEN}" \
-F notes="Build uploaded automatically from Xcode."

echo "done." >> $LOG
echo "Uploaded to TestFlight" | ${GROWL} -s && /usr/bin/open "https://testflightapp.com/dashboard/builds/"
