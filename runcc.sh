#!/bin/bash

ccstore=$store
blocksize=2048
progressdir=/home/andrew/progressdir$ccstore
workdir=/mnt/localssd/workspace
sourcedisk=/mnt/localssd
threads=256
options="-"

rm -rf /elastifile/log/elcc/elcc-*

#size=1MB ; elcc version scan $ccstore /mnt/localssd/$size; versiondir=$workdir/`ls -lht $workdir | grep $ccstore | head -1 | cut -d " " -f 9` ; echo $versiondir ; elcc version commit $ccstore $versiondir /mnt/localssd/$size/ --version_desc=/mnt/localssd/$size --config=/home/andrew/elcc.conf --threads=$threads --progressdir=$progressdir/$size

#size=10MB ; elcc version scan $ccstore /mnt/localssd/$size; versiondir=$workdir/`ls -lht $workdir | grep $ccstore | head -1 | cut -d " " -f 9` ; echo $versiondir ; elcc version commit $ccstore $versiondir /mnt/localssd/$size/ --version_desc=/mnt/localssd/$size --config=/home/andrew/elcc.conf --threads=$threads --progressdir=$progressdir/$size

#size=100MB ; elcc version scan $ccstore /mnt/localssd/$size; versiondir=$workdir/`ls -lht $workdir | grep $ccstore | head -1 | cut -d " " -f 9` ; echo $versiondir ; elcc version commit $ccstore $versiondir /mnt/localssd/$size/ --version_desc=/mnt/localssd/$size --config=/home/andrew/elcc.conf --threads=$threads --progressdir=$progressdir/$size

#size=1GB ; elcc version scan $ccstore /mnt/localssd/$size; versiondir=$workdir/`ls -lht $workdir | grep $ccstore | head -1 | cut -d " " -f 9` ; echo $versiondir ; elcc version commit $ccstore $versiondir /mnt/localssd/$size/ --version_desc=/mnt/localssd/$size --config=/home/andrew/elcc.conf --threads=$threads --progressdir=$progressdir/$size

#size=25GB ; elcc version scan $ccstore /mnt/localssd/$size; versiondir=$workdir/`ls -lht $workdir | grep $ccstore | head -1 | cut -d " " -f 9` ; echo $versiondir ; elcc version commit $ccstore $versiondir /mnt/localssd/$size/ --version_desc=/mnt/localssd/$size --config=/home/andrew/elcc.conf --threads=$threads --progressdir=$progressdir/$size

tar czvf $ccstore.tar.gz /elastifile/log $progressdir

for i in {2..20}; do
  size="$i-MB"
  echo -e "$size\n"
  elcc version scan $ccstore /mnt/localssd/$size
  versiondir=$workdir/`ls -lht $workdir | grep $ccstore | head -1 | cut -d " " -f 9`
  echo $versiondir
  elcc version commit $ccstore $versiondir /mnt/localssd/$size/ --version_desc=/mnt/localssd/$size --config=/home/andrew/elcc.conf --threads=$threads --progressdir=$progressdir/$size
done

#for i in `ls -lt progressdirandrew-2228-m-16/*B/summary.json | cut -d " " -f 9` ; do echo -e  "\n\n##############################\n\n$i\n" ; cat $i | grep -e elapsed -e data_bytes | cut -d ":" -f 2 | cut -d "," -f 1 ;done
