#!/bin/bash

cd ~/rclone-v1.49.1-linux-amd64/

./rclone copy /u/scratch/n/nikodm/bioRxiv/ team:biorxivBackup_09172019

cd
