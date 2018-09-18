#!/bin/bash

echo "\$ModLoad imtcp">>/home/ubuntu/output.txt
echo "\$InputTCPServerRun 514">>/home/ubuntu/output.txt
echo "*.*         @@tri-strongswan-sumologic-collector.awsinternal.tri.global:514">>/home/ubuntu/output.txt
