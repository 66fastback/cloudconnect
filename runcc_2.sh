#!/bin/bash

ccstore=$store
blocksize=2048
progressdir=/home/andrew/progressdir$ccstore
workdir=/mnt/localssd/workspace
sourcedisk=/mnt/localssd
threads=256
options="-"

rm -rf /elastifile/log/elcc/elcc-*

for i in {2..20}; do
  size="$i-MB"
  echo -e "$size\n"
  elcc version scan $ccstore /mnt/localssd/$size
  versiondir=$workdir/`ls -lht $workdir | grep $ccstore | head -1 | cut -d " " -f 9`
  echo $versiondir
  elcc version commit $ccstore $versiondir /mnt/localssd/$size/ --version_desc=/mnt/localssd/$size --config=/home/andrew/elcc.conf --threads=$threads --progressdir=$progressdir/$size
done

tar czvf $ccstore.tar.gz /elastifile/log $progressdir
