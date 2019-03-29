#!/bin/sh

# Default nymea configuration
if [ ! -e $SNAP_DATA/nymead.conf ]; then
    echo "Install template nymead.conf"
    cp $SNAP/template-nymead.conf $SNAP_DATA/nymead.conf
fi

# Load logging configuration
if [ -e $SNAP_DATA/logging.conf ]; then
    echo "Using custom logging configuration from ${SNAP_DATA}/logging.conf"
    export QT_LOGGING_CONF=${SNAP_DATA}/logging.conf
else
    echo "Using default logging configuration from ${SNAP}/default-logging.conf"
    export QT_LOGGING_CONF=${SNAP}/default-logging.conf
fi

# important: keep this in order to propagate return values
set -e
qt5-launch nymead -n
