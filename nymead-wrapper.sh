#!/bin/sh

if [ ! -e $SNAP_DATA/nymead.conf ]; then
    cp $SNAP/template-nymead.conf $SNAP_DATA/nymead.conf
fi

# Load custom guhd call
if [ -e $SNAP_DATA/runner.conf ]; then
    CUSTOMLAUNCH=`cat $SNAP_DATA/runner.conf`
    if ! [ -z "$CUSTOMLAUNCH" ]; then
        echo "Start nymead using the custom runner ${SNAP_DATA}/runner.conf"
        echo "Running command \"${CUSTOMLAUNCH}\""
        qt5-launch nymead $CUSTOMLAUNCH
        exit 0
    fi
else
    echo "Creating default runner script $SNAP_DATA/runner.conf"
    echo "-n -p -d NoWebSocketServerTraffic -d NoTcpServerTraffic -d NoRuleEngineDebug -d NoJsonRpcTraffic -d NoJanusTraffic -d NoAWSTraffic" > ${SNAP_DATA}/runner.conf
fi

# important: keep this in order to propagate return values
set -e
qt5-launch nymead -n -p -d NoWebSocketServerTraffic -d NoTcpServerTraffic -d NoRuleEngineDebug -d NoJsonRpcTraffic -d NoJanusTraffic -d NoAWSTraffic
