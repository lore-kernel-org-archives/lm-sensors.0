From: tc@crawfords.de (Tony Crawford)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: It works: idiosyncratic lm78 on Intergraph TD-425
Message-Id: <E1A9CB9-0000a6-97@luggage.dmz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gang!

Beautiful flow-chart on your troubleshooting page. 

I was working on a support request, around Item 93, but then I says 
to myself, after all this modprobe rmmod modprobe rmmod, maybe I 
could reboot, just to see. So now this is a feel-good positive 
feedback success story.

I was getting all the pretty modules loaded for a number of 
"chips", incl. lm75, lm80 and others, but lots of sensors output 
with all zero values, and with never a line about the lm78 itself.

Machine is an old graphics workstation, an Intergraph TD-425 (dual 
pII) that I made it into an intranet server. It's a mid-90s model. 
The BIOS manual said it's got a "hardware monitor" on (default) I/O 
port 0x110, and I should see the on-line Help of the Win NT monitor 
app for details. I got the thing with no software whatsoever, so 
that's no Help. 

I had stuffed the box full of IBM SCSI disks, including a drive 
cage over the ram banks that wasn't there before, and I was a bit 
surprised to see in the first place that those PIIs have just big 
passive heat sinks, so I thought, if there's a thermometer in 
there, it wouldn't be a bad idea to read it.

It's running Debian testing/unstable and Linux 2.4.22, and I got 
the Debianized sources of i2c and lm_sensors-- that's 2.8.0. 
Making, installing and even modprobing went fine with Debian's make-
kpkg (after a make-kpkg clean modules_clean).

Oh: To get sensors-detect to find anything, I had to change 0x290 
to 0x110 (based on the Intergraph manual, which is still available 
as a PDF on their website). (That was easier than changing the 
LM78's I/O addresss in the BIOS, because the box is in a closet 
with no monitor or keyboard on it. One question I was about to ask 
you guys was whether I was likely to have better luck if I did 
change that in the BIOS to 0x290.) Since 0x110 made sensors-detect 
happy, I went ahead and patched lm78.c to say

static unsigned int normal_isa[] = { 0x110, SENSORS_ISA_END };

too. 

An isadump of 0x295 0x296 was all FFs, but 0x115 0x116 was a 
kaleidoscope.

Anyway, since the reboot I have:

luggage:~# lsmod
Module                  Size  Used by    Not tainted
lm78                    7320   0  (unused)
smbus-arp               4948   0  (unused)
ltc1710                 2344   0  (unused)
eeprom                  3636   0  (unused)
lm75                    2908   0  (unused)
lm80                    5504   0  (unused)
adm1021                 5976   0  (unused)
i2c-proc                6868   0  [lm78 smbus-arp ltc1710 eeprom 
lm75 lm80 adm1021]
i2c-isa                  756   0  (unused)
i2c-core               15780   0  [lm78 smbus-arp ltc1710 eeprom 
lm75 lm80 adm1021 i2c-proc i2c-isa]
af_packet              15016   0  (unused)
unix                   17356  12  (autoclean)

luggage:~# sensors
lm78-isa-0110
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.83 V  (min =  +2.52 V, max =  +3.08 V)
VCore 2:   +2.89 V  (min =  +2.52 V, max =  +3.08 V)
+3.3V:     +3.36 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.12 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +11.48 V  (min = +10.79 V, max = +13.11 V)
-12V:     -10.67 V  (min = -13.18 V, max = -10.78 V)   ALARM
-5V:       -3.73 V  (min =  -5.48 V, max =  -4.50 V)   ALARM
fan1:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
temp:      +25.0?C  (limit =  +60?C, hysteresis =  +50?C)
vid:       +2.80 V
alarms:   Chassis intrusion detection                  ALARM

and the voltages fluctuate, and the temperature goes up to 26? if I 
block the air vents for a couple of minutes. (Did I mention that 
the airflow in this box bears witness to an ample engineering 
budget?)

So thanks very much! It's very cool, literally. Now I'm going to 
fill in my "ignore" statements and go hunt up a funky front-end for 
this info.

Oh, and maybe look into those alarms :-(. That would be the 
"excess" disk drives pulling down the voltage, I imagine.

Tony

-- 
-- Tony Crawford
-- +49-3341-309999
-- 


