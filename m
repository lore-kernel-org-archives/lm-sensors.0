From: jwa@fasytek.dk (J. W. Andersen)
Date: Wed, 14 Jun 2006 14:07:15 +0000
Subject: [lm-sensors] ASUS NCCH-DR confusing 83792 vs. 83627THF
Message-Id: <44901813.3080703@fasytek.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi list - I am as confused as I ever want to be, hope someone can help.

I have build a brand new server for SuSE 10, using ASUS NCCH-DR, and 
everything
works fine, apart from the HW monitoring.

The only "likely" chip I can see on the board is a Winbond W83627THF, 
but according
to ASUS support the HW monitoring chip should be W83792D (even if I 
can't find it).

The block diagram  (attached) in the users manual however shows both the 
mentioned chips.
W83792 is on the SMbus providing HW monitoring functions for fans, PSU 
and eeprom,
whereas the W83627THF is on the LPC bus, providing keyboard, FDD, serial 
and mouse ports.
Both busses are on an Intel 6300ESB ICH.

sensors-detect finds and setup drivers for i2c-i810, i2c-isa, i2c-dev, 
eeprom and w83627hf.
It does not find w83792d, and does not even test for it, according to 
output. When running
sensors, i get a number of rather weird values:

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.94 V  (min =  +1.94 V, max =  +1.94 V)             
+12V:      +7.60 V  (min = +10.82 V, max = +13.19 V)       ALARM 
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)             
+5V:       +4.96 V  (min =  +4.75 V, max =  +5.25 V)             
-12V:      +6.06 V  (min = -10.80 V, max = -13.18 V)       ALARM 
V5SB:      +5.00 V  (min =  +4.76 V, max =  +5.24 V)             
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)       ALARM 
fan1:        0 RPM  (min = 4891 RPM, div = 2)              ALARM 
CPU Fan:     0 RPM  (min = 37500 RPM, div = 2)              ALARM 
fan3:        0 RPM  (min = 28125 RPM, div = 2)              ALARM 
M/B Temp:    -48?C  (high =  +104?C, hyst =    +0?C)   sensor = 
thermistor          
CPU Temp:  -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor          
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor          
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

The other thing that puzzles me: In an X86_64 system, I would expect to find
the libsensor libraries in a the /lib64 directory, but they actually get 
nstalled
in /usr/local/lib. What must I do to get these libraries in the proper 
place ?

Regards, Joern.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: NCCH-DR.pdf
Type: application/pdf
Size: 15194 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060614/80d13307/attachment-0001.pdf 
