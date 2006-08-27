From: david_denny@verizon.net (David Denny)
Date: Sun, 27 Aug 2006 13:54:38 +0000
Subject: [lm-sensors] Newbie: Gigabyte K8NS calibration / scaling questions
Message-Id: <44F1A41E.7020300@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Gentlemen,

Thanks for the great work on lm_sensors (and also the i2c subsystem!)  
Of course its good to be able to monitor the temperature and take some 
action,  but I'm also inspired by the "hardware hacking" ideas.   I've 
wanted to fool with some of the stuff at 
"http://www.sparkfun.com/commerce/categories.php", but didn't quite know 
how to interface to a modern computer - now I know!

I hooked up lm_sensors and cpufreqd because I was having some strange 
problems with my CPU overheating under sustained high load, and then 
getting a very reproducible but mysterious kernel panic.  All is hooked 
up now, and everything works perfectly.  As the CPU temp climbs, under a 
heavy load, the frequency is scaled back to stabilize the temp and the 
kernel panic is avoided.

I have some "fine-tuning" issues that you may be able to provide advice 
regarding.

First, my configuration:

AMD Athlon 64 3400+ 2.4GHz
Gigabyte GA-K8NS (version 1.2 I believe, not 2.1.  Not Ultra, not Pro, 
just plain.),  Version 19 firmware.
Linux-2.6.17.11
lm_sensors-2.10.0
sysfsutils-2.1.0

This board has the ITE 8712F chip, which is detected correctly.  I can 
see values like:

it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.52 V  (min =  +1.42 V, max =  +1.57 V)
VCore 2:   +2.56 V  (min =  +2.40 V, max =  +2.61 V)
+3.3V:     +3.07 V  (min =  +3.14 V, max =  +3.47 V)   ALARM
+5V:       +5.81 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
+12V:     +11.65 V  (min = +11.39 V, max = +12.61 V)
-12V:     -10.42 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -4.84 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +4.27 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
VBat:      +2.93 V
CPU Fan:  5273 RPM  (min = 2481 RPM, div = 8)
M/B Temp:    +25 C  (low  =   +15 C, high =   +40 C)   sensor = thermistor
CPU Temp:    +41 C  (low  =   +15 C, high =   +65 C)   sensor = thermistor
Temp3:       +72 C  (low  =   +15 C, high =   +45 C)   sensor = thermistor
vid:       +1.55 V

but then, taken a few seconds later, I get...

it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.52 V  (min =  +1.42 V, max =  +1.57 V)
VCore 2:   +2.56 V  (min =  +2.40 V, max =  +2.61 V)
+3.3V:     +3.07 V  (min =  +3.14 V, max =  +3.47 V)   ALARM
+5V:       +3.84 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
+12V:     +11.58 V  (min = +11.39 V, max = +12.61 V)
-12V:      -4.66 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -2.35 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +4.97 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
VBat:      +2.93 V
CPU Fan:  5443 RPM  (min = 2481 RPM, div = 8)
M/B Temp:    +25 C  (low  =   +15 C, high =   +40 C)   sensor = thermistor
CPU Temp:    +41 C  (low  =   +15 C, high =   +65 C)   sensor = thermistor
Temp3:       +72 C  (low  =   +15 C, high =   +45 C)   sensor = thermistor
vid:       +1.55 V



 From my observations...

1.) Some signals, like VCore1, VCore2, +3.3, +12, standby, VBatt, CPU 
Fan, M/B temp, CPU Temp, vid seem to be connected.  In some cases they 
may have scaling issues however.

2.) Some signals, like +/- 5V and -12V are all over the place.  I bet 
they aren't supported on the M/B.

3.) CPU Fan Speed toggles somewhat, which is no problem, but also drifts 
hugely, like from 5400 RPM to 3500 RPM, which trips an alarm.   I 
noticed this at night, which system temperature was at a minimum with 
minimal load on the CPU.  The fan slowed way down and tripped an 
alarm.   Sorry I can't show it on my output capture!

4.) CPU temp may be scaled / reported incorrectly because I get a 
different value in BIOS, and also because it fails when it hits the 
"correct" temperature (over 70C) rather than the lm_sensor reported ~50C.  

My questions are:

1.) Do you know which lines are connected and which ones should be ignored?
2.) What is the best way to determine correct scaling and calibrate the 
connected lines?  I have plenty of gadgetry and have worked on 
electronic stuff for years.  But I'm not sure how to determine a 
calibration curve without having specs, being able to vary conditions, 
etc.  I'd like to hear ideas from experts!
3.) Any ideas why the fan speed is moving around (beyond just simple 
toggling and resolution limitations?)  I'd like to detect "dead/failing" 
fan syndrome and take corrective action.  Any ideas how this can be 
implemented since the RPM varies quite a bit?
4.) Any ideas how to correctly scale the CPU temp?  I'd like to read it 
absolutely, rather than a relative more/less hot...

Once again, thanks for the great work!

David
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060827/144f675d/attachment-0001.html 
