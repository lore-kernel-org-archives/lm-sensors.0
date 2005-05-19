From: nombrandue@hotmail.com (Nombrandue Nightstalker)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Sensor issues
Message-Id: <BAY1-F23023F526DAAA27542A181C8C20@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

My hardware on the system in question is
abit KT7RAID
AMD 1.0 Ghz processor.

Software

Fedora core 2 with SElinux enabled.


     I am sure this is a simple to solve issue, but I haven't been able to 
find the answers in all the documentation.

What I am trying to do is get RRD to graph my sensor output. I read, and 
installed rrd-tools, and lm-sensors as per instructions. I successfully was 
able to get santafu to pull the output from lm-sensors, and the sensors 
command kicks back information.

the issue I am having is there is lots of stuff pointing to kernel 2.4's 
procfs output, not 2.6's sysfs output. Since I have never worked with 
hardware health programs on linux, I have not real idea if the area's I am 
looking at are correct. The directory I found information ( I found two 
actually) is:

/sys/bus/i2c/drivers/via686a/0-6000
and
/sys/devices/platform/i2c-0/0-6000/


I am not sure what ones to point to in the rrd makefile. What I have is:
# Edit the following for your setup
#
USER=apache
#CRONTAB=/var/spool/cron/tabs/$(USER)
RRDPATH=/usr/local/rrdtool/bin
BINPATH=/usr/local/bin
RRDDIR=/var/lib/sensors-rrd
APACHE=/var/www/html
APACHDIR=$(APACHE)/senspix
SENSDEV=via686a
MACH=`uname -n`
#
# Everything below here should be fine
#
RRDB=$(RRDDIR)/sensors.rrd
SENSDIR=/sys/bus/i2c/drivers/$(SENSDEV)


This is as far as I have edited the file.


the RRD cgi script only shows:

#!/usr/local/rrdtool/bin/rrdcgi
ONE DAY VIEW
See also:
One Week View
One Week Summary View
TEMPERATURES

' -a PNG -h 200 -w 800 --lazy -s -1days -v "Temperature (degrees C)" -t 
"Motherboard temperature" -x HOUR:1:HOUR:3:HOUR:3:0:'%b %d %H:00' -y 1:5 
DEF:temp=/var/lib/sensors-rrd/sensors.rrd:temp1:AVERAGE LINE2:temp#FF00FF>



From the looks of it, the rrdcgi script isn't creating the image file, and 
it isn't showing up in my logs as to why/where this fails.

Any help would be appriciated


Seann

