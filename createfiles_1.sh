#!/bin/bash

mkdir /mnt/localssd/1MB
mkdir /mnt/localssd/10MB
mkdir /mnt/localssd/100MB
mkdir /mnt/localssd/1GB
mkdir /mnt/localssd/25GB

for f in {1..25000}; do dd if=/dev/urandom of=/mnt/localssd/1MB/1MBfile$f bs=1M count=1 1>/dev/null 2>&1; done
for f in {1..2500}; do dd if=/dev/urandom of=/mnt/localssd/10MB/10MBfile$f bs=1M count=10 1>/dev/null 2>&1; done
for f in {1..250}; do dd if=/dev/urandom of=/mnt/localssd/100MB/100MBfile$f bs=1M count=100 1>/dev/null 2>&1; done
for f in {1..25}; do dd if=/dev/urandom of=/mnt/localssd/1GB/1GBfile$f bs=1M count=1000 1>/dev/null 2>&1; done
for f in {1..1}; do dd if=/dev/urandom of=/mnt/localssd/25GB/25GBfile$f bs=1M count=25000 1>/dev/null 2>&1; done
