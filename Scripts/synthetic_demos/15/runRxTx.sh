#!/bin/bash

cp /home/grant/RADCOM3/RadCom_Project/Scripts/synthetic_demos/tmp.bin /home/grant/workarea/uhd/host/build/examples 

./txrx_loopback_to_file --tx-rate=5e6 --rx-rate=5e6 --tx-freq=2.45e9 --rx-freq=2.45e9 --tx-bw=8e6 --rx-bw=8e6  \
	--tx-channels="A:0" --rx-channel="A:0" --type="float"  --file-tx="tmp.bin"  \
	--settling=0 --repeat --tx-gain=20 --rx-gain=10 --tx-args="192.168.10.2" --rx-args="192.168.10.3" \
  	--tx-ant="TX/RX" --rx-ant="RX2" --spb=2048 #--delay=0.02


cp rx.01.dat /home/grant/RADCOM3/RadCom_Project/Scripts/synthetic_demos

cp tmp.bin /home/grant/RADCOM3/RadCom_Project/Scripts/synthetic_demos

cp rx.00.dat /home/grant/RADCOM3/RadCom_Project/Scripts/synthetic_demos

cp rx.dat /home/grant/RADCOM3/RadCom_Project/Scripts/synthetic_demos
