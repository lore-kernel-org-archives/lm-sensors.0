From: Christian Sickau <christian.sickau@gmx.de>
Date: Mon, 25 May 2009 15:29:22 +0000
Subject: [lm-sensors] shutdown-script using lm-sensors
Message-Id: <4A1AB952.9020706@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi there,

I wanted to monitor the temperature of a server and shut it down 
automatically when it reaches certain threshold. At the same time it 
should keep me informed about the status via email.

I found that 
http://cahbojonegoro.wordpress.com/2008/12/15/cpu-temperature-monitor-script/
script and changed it a little:

#!/bin/sh

### Temperature Monitor
### Auto Shutdown if CPU Temperature is over threshold

## Define threshold for CPU Temperature
thresholdu

## Get CPU Temperatur using lm-sensor
t1=`/usr/bin/sensors | nawk ‘/temp2/ {print substr($2,2,2)}’`

if test $t1 -gt $threshold
then
mail -s "safety-shutdown" name@domain.de < /home/chris/heat.txt
echo “CPU Temperature is exceeding threshold – Shutting down in 10 sec …….”
sleep 10
shutdown -h now
else
mail -s "test" name@domain.de < /home/chris/textdatei.txt
echo “Temperature still on the safe range “
echo “CPU: $t1°C”
fi


Cronjob is runnig the script periodically. lm-sensors itself as well as 
the email-thing work well, but it seems that the script doesn't get the 
needed info from lm-sensors. My error-message is:

nawk: 1: unexpected character 0xe2
test: 23: 75: unexpected operator
â€œTemperature still on the safe range â€œ
â€œCPU: Â°Câ€

Since I don't have much experience with scripts, I don't really 
understand what the problem could be. Any suggestions what do do?

I am using Ubuntu Linux 8.04.2 kernel 2.6.24-24, the mainboard is an 
Asus Pundit-R AB-P 2800 using an it8712-isa-0260 chip.**
****
**
**Thanks a lot in advance and greets from Bavaria!
**
**Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
