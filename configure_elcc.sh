#!/bin/bash

ccstore=$store
blocksize=2048
progressdir=/home/andrew/progressdir$ccstore
workdir=/mnt/localssd/workspace
sourcedisk=/mnt/localssd

mkfs.ext4 -F /dev/sdb
mkdir -p /mnt/localssd
mount /dev/sdb/ /mnt/localssd/

curl -O https://storage.googleapis.com/elastifile-upgrade-files/offline.json
elcc-setup -M mixed offline.json
elcc service init /elastifile/elcc/default.json -M mixed -m /mnt/localssd -w $workdir

/elastifile/bin/elcc bucket create gcp $ccstore andrew-sa-elastifile-sa.json
/elastifile/bin/elcc bucket format gcp $ccstore -B $blocksize andrew-sa-elastifile-sa.json

mkdir $progressdir
