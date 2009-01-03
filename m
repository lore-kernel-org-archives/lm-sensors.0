From: Vincent Danjean <vdanjean.ml@free.fr>
Date: Sat, 03 Jan 2009 21:17:41 +0000
Subject: [lm-sensors] VRM 11.0 needed for it8718 chip
Message-Id: <495FD5F5.70103@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

  Hi,

  I'm trying to use lm-sensors with a Gigabyte EG45M-DS2H motherboard
and a Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz (from /proc/cpuinfo)
  sensor-detect asks me to load it87 and coretemp modules

  I'm using Debian lenny versions of lm-sensors: 1:3.0.2-1+b2
(ie 3.0.2 upstream)

  My chips is a it8718F. When loading my modules, I get:
[   15.646427] it87: Found IT8718F chip at 0x290, revision 5
[   15.646427] it87: in3 is VCC (+5V)
[   15.654427] coretemp coretemp.0: Using relative temperature scale!
[   15.654427] coretemp coretemp.1: Using relative temperature scale!
[   15.654427] coretemp coretemp.2: Using relative temperature scale!
[   15.654427] coretemp coretemp.3: Using relative temperature scale!

  The default configuration file did have have anything for a it8718.
I wrote a section based on the one found here:
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/G33-DS3R
I had to change low/over to min/max and to comment out "set sensor3 0"

I also add a problem with in0_(min|max): vid was not valid and cpu0_vid
was always 0. At first, I put a explicit value here. Then, I read
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/vid
(pointed by your FAQ)
It tells:
109     The following chip drivers support only VRM 8.2 and cannot be changed:
110 	
111 	        adm1024, it87, mtp008, adm9240, gl520sm, lm78
112 	
113 	If you have a board with one of these chips which needs advanced
114 	VRM support please email us.

So, I'm emailing you. Indeed, my /sys/class/hwmon/hwmon0/device/vrm had
by default a value of 110. The intel website has a document for VRM 11.0.
If I put the value 100 in /sys/class/hwmon/hwmon0/device/vrm, then
I got a non zero value for cpu0_vid (the value seems non absurd, ie
sensors reports 1.063V for cpu_vid0)

Note that "set vrm 100" in my it8718 section is refused by "sensors -s":
# sensors -s
Error: Line 1429: Unknown feature name
it8718-isa-0290: No such subfeature known


  If you need more information, please, ask me (but I'm not subscribed to
this ML, so CC me)


  Last remark: lm-sensors seems to work with my config but I'm not sure
that the CPU temp is correctly computed. I've:
NBr Temp:    +37.0°C  (low  = +10.0°C, high = +50.0°C)  sensor = transistor
CPU Temp:    +21.0°C  (low  = +10.0°C, high = +60.0°C)  sensor = thermal diode
and then
Core 0:      +31.0°C  (high = +82.0°C, crit = +100.0°C)
Core 1:      +32.0°C  (high = +82.0°C, crit = +100.0°C)
Core 2:      +28.0°C  (high = +82.0°C, crit = +100.0°C)
Core 3:      +31.0°C  (high = +82.0°C, crit = +100.0°C)

  Regards,
    Vincent

-- 
Vincent Danjean       GPG key ID 0x9D025E87         vdanjean@debian.org
GPG key fingerprint: FC95 08A6 854D DB48 4B9A  8A94 0BF7 7867 9D02 5E87
Unofficial pacakges: http://www-id.imag.fr/~danjean/deb.html#package
APT repo:  deb http://perso.debian.org/~vdanjean/debian unstable main


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
