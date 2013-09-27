From: Olavo Luppi Silva <olavo.luppi@ig.com.br>
Date: Fri, 27 Sep 2013 15:57:07 +0000
Subject: [lm-sensors] Sudden shutdown and wrong temperature reading (driver jc42)
Message-Id: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi dear lm-sensors developers,

My name is Olavo, I am a newbie in this group and I am writing because I'm
facing some problems that I suspect it could be a lm-sensors bug. If it's a
bug I would be happy to help fixing it.


SHORT STORY:
The workstation suddenly shuts down, usually when performing intensive
computation. Workaround: comment line jc42 at /etc/modules apparently
solves the problem.



LONG STORY:
We have 3 Intel workstations with the specification described below,
running linux ubuntu and lm-sensors installed. In June, one of the machines
(raphson) started to shutdown suddenly during intensive computations, all
processor in use during several hours. The shutdown events where becoming
more and more frequent (a shutdown at each 5 minutes) and raphson were
taken to technical assistance. They detected a hardware problem and
replaced the motherboard which was in warranty period.

Raphson returned but the shutdown events were still present at each 12h to
24h, roughly. Then I created a script to save sensors temperatures, which
is pasted below, and monitored the workstation for many hours.  Ploting
temperature of sensors jc42-i2c-8-1a, jc42-i2c-8-1b, etc, I noticed some
spikes both down (0 Celsius degrees) and up (250 C).
Then I disabled sensor jc42 commenting line jc42 at /etc/modules and it
apparently solves the problem. Raphson is running without interruption
performing intensive computations for 3 weeks now.

I also performed the same temperature monitoring at the two other machines:
kalman and gauss. Kalman temperature plots are ok, but Gauss's aren't. It
presents the same spikes and sometimes produces the following error:
ERROR: Can't get value of subfeature temp1_input:
Kalman is running intensive computations without interruption for 2 weeks.
Gauss was running intensive computations since last week but yesterday
night and today morning it shutdown.
Now I'm suspecting jc42 sensor is causing this problem.


Olavo

===================
I'm not quite sure if the specifications of all workstations are exactly
the same. Here is raphson specs:

$ head -n 5 /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 44
model name    : Intel(R) Xeon(R) CPU           E5645  @ 2.40GHz

$ lspci | grep -i vga
GPU: NVIDIA Corporation GF104 [GeForce GTX 460] (rev a1)

$ sudo dmidecode -t baseboard | less
# dmidecode 2.11
SMBIOS 2.5 present.

Handle 0x0003, DMI type 2, 16 bytes
Base Board Information
        Manufacturer: Intel Corporation
        Product Name: S5520SC
        Version: E30682-358
        Serial Number: QSHV24600462


========================#!/bin/bash
# temperature_monitor.sh
# Create a log file with sensors temperature once per second


LogFileName=$1
rm $LogFileName
touch $LogFileName


while true
do
  # Probe temperature sensors
  sensors -u > temp.log
  # Record date
  data=$(date +"%Y%m%d%H%M%S")

  # Read individual temperatures
  core00=`sed -n '11p' temp.log | cut -f2 -d ':'`;
  core01=`sed -n '16p' temp.log | cut -f2 -d ':'`;
  core02=`sed -n '21p' temp.log | cut -f2 -d ':'`;
  core03=`sed -n '26p' temp.log | cut -f2 -d ':'`;
  core04=`sed -n '30p' temp.log | cut -f2 -d ':'`;
  core05=`sed -n '34p' temp.log | cut -f2 -d ':'`;
  core06=`sed -n '41p' temp.log | cut -f2 -d ':'`;
  core07=`sed -n '46p' temp.log | cut -f2 -d ':'`;
  core08=`sed -n '51p' temp.log | cut -f2 -d ':'`;
  core09=`sed -n '56p' temp.log | cut -f2 -d ':'`;
  core10=`sed -n '60p' temp.log | cut -f2 -d ':'`;
  core11=`sed -n '64p' temp.log | cut -f2 -d ':'`;

  SMBus1=`sed -n '71p' temp.log | cut -f2 -d ':'`;
  SMBus2=`sed -n '84p' temp.log | cut -f2 -d ':'`;
  SMBus3=`sed -n '97p' temp.log | cut -f2 -d ':'`;


  # Write temperature info to file
  echo "$data $core00 $core01 $core02 $core03 $core04 $core05 $core06
$core07 $core08 $core09 $core10 $core11 $SMBus1 $SMBus2 $SMBus3" >>
$LogFileName

  # Display temperature info at screen
#  echo "$core00 $core01 $core02 $core03 $core04 $core05 $core06 $core07
$core08 $core09 $core10 $core11 $SMBus1 $SMBus2 $SMBus3"

  sleep 1

done
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
