#!/bin/sh
echo "Starting startup.sh.."
echo "*       *       *       *       *       run-parts /etc/periodic/1min"  >> /etc/crontabs/root
echo "*/5     *       *       *       *       run-parts /etc/periodic/5min"  >> /etc/crontabs/root
echo "*/30    *       *       *       *       run-parts /etc/periodic/30min" >> /etc/crontabs/root
echo "0 	  */6 	  * 	  * 	  *       run-parts /etc/periodic/6hour" >> /etc/crontabs/root
crontab -l
