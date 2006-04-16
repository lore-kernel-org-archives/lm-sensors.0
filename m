From: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sun, 16 Apr 2006 16:06:36 +0000
Subject: [lm-sensors] ridicolous sensors output?
Message-Id: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi all

running 'sensors' on this new 1U asus server, gives me quite  
interesting data. this is on a server that's been running three weeks  
or so without problems. attached is lspci -vvv output and  
sensors.conf (standard from debian sarge).

can someone please help me figure out what's happening here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.conf.gz
Type: application/x-gzip
Size: 18675 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060416/e36e63b5/sensors.conf-0001.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci-vvv.txt.gz
Type: application/x-gzip
Size: 1854 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060416/e36e63b5/lspci-vvv.txt-0001.gz
-------------- next part --------------

thanks

roy

# sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.94 V  (min =  +0.70 V, max =  +1.87 V)       ALARM
+12V:      +7.36 V  (min =  +0.30 V, max =  +7.78 V)
+3.3V:     +1.44 V  (min =  +0.21 V, max =  +0.77 V)       ALARM
+5V:       +5.01 V  (min =  +0.00 V, max =  +0.77 V)       ALARM
-12V:      +6.06 V  (min = -10.96 V, max = -12.28 V)       ALARM
V5SB:      +5.03 V  (min =  +1.51 V, max =  +0.38 V)       ALARM
VBat:      +0.11 V  (min =  +0.00 V, max =  +2.82 V)
fan1:        0 RPM  (min = 5232 RPM, div = 2)              ALARM
CPU Fan:     0 RPM  (min = 675000 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 9926 RPM, div = 2)              ALARM
M/B Temp:    -48 C  (high =    +4 C, hyst =    +0 C)   sensor =  
thermistor
CPU Temp:  -48.0 C  (high =   +80 C, hyst =   +75 C)   sensor =  
thermistor
temp3:     -48.0 C  (high =   +80 C, hyst =   +75 C)   sensor =  
thermistor
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
           Sound alarm enabled

--
Roy Sigurd Karlsbakk
roy at karlsbakk.net
---
In space, loud sounds, like explosions, are even louder because there  
is no air to get in the way.


