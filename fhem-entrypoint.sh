#!/bin/bash

CONFIGDIR=/data
FHEM_CFG=$CONFIGDIR/fhem.cfg

if [ ! -d $CONFIGDIR ]; then
  mkdir -p $CONFIGDIR/log
fi


if [ ! -e "$FHEM_CFG" ] ; then
    cp /opt/fhem/fhem.cfg.template $FHEM_CFG
fi

chown fhem:dialout -R $CONFIGDIR

perl fhem.pl $FHEM_CFG
