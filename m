From: marc@corky.net (Just Marc)
Date: Tue, 04 Apr 2006 11:12:24 +0000
Subject: [lm-sensors] lmsensors in 2.6.16 on a Tyan 2882-D motherboard,
Message-Id: <44325498.8060805@corky.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everyone,

It's my first time setting lm-sensors up, the process was pretty 
painless after skimming the docs and FAQ.

The chips detected for my board are lm85 and w83627hf,  I tried using 
the debian package supplied sensors.conf and the Tyan supplied at 
ftp://ftp.tyan.com/software/lms/lms_s2882.tgz .  Tyan say that this file
is for version 2.8.0 though I'm using the one which comes with the 
2.6.16 kernel.

I would like to monitor all of the data provided by the sensors, though 
it appears that I'm not getting a good reading on some of the voltages,  
temperatures and all the rest seem right, though.

After a few further hours of reading various docs I still was not able 
to find a way to get it just right.  As this is the first time I'm using 
this package I don't even know how much of a skew is acceptable for 
these particular readings but some of the readings seem way out of the 
suggested min/max ranges.

Any pointers would be greatly appreciated.

Marc

# sensors -v
sensors version 2.10.0 with libsensors version 2.10.0

Before trying each config file, sensors -s was run

Output of sensors with the Tyan supplied config file:

# sensors
adm1027-i2c-0-2e
Adapter: SMBus AMD8111 adapter at 10e0

DDR 2.5V:  +2.607 V  (min =  +2.37 V, max =  +2.63 V)   ALARM
DDR VTT:   +1.304 V  (min =  +1.14 V, max =  +1.27 V)   ALARM
3VSB:      +3.347 V  (min =  +3.13 V, max =  +3.47 V)  
+5 V:     +5.039 V  (min =  +4.74 V, max =  +5.26 V)  
+12V:     +12.109 V  (min = +11.38 V, max = +12.62 V)  
fan2:      4895 RPM  (min = 4000 RPM)                    
fan1:      5089 RPM  (min =    0 RPM)                    
fan3:         0 RPM  (min =    0 RPM)                    
fan4:         0 RPM  (min =    0 RPM)                    
CPU2 Temp:+67.25?C  (low  =   +10?C, high =   +50?C)     ALARM 
sys Temp: +50.25?C  (low  =   +10?C, high =   +35?C)     ALARM
CPU1 Temp:+67.75?C  (low  =   +10?C, high =   +35?C)     ALARM 
vid:      +1.400 V  (VRM Version 2.4)

w83627hf-isa-0290
Adapter: ISA adapter
CPU2 Volt: +1.42 V  (min =  +1.33 V, max =  +1.47 V)             
CPU1 Volt: +1.44 V  (min =  +1.33 V, max =  +1.47 V)             
3.3V:      +3.30 V  (min =  +3.14 V, max =  +3.47 V)             
DDR VTT:   +1.30 V  (min =  +2.85 V, max =  +3.47 V)       ALARM 
DDR 2.5V:  +2.58 V  (min =  +0.34 V, max =  +0.80 V)       ALARM 
CPU2 Fan: 5487 RPM  (min = 5625 RPM, div = 2)              ALARM 
CPU1 Fan: 5625 RPM  (min = 2657 RPM, div = 2)                    
Fan5:        0 RPM  (min = 2657 RPM, div = 2)              ALARM 
vid:      +1.400 V  (VRM Version 2.4)
alarms:  
beep_enable:
          Sound alarm disabled


Output of sensors with the debian-supplied config file:

# sensors
adm1027-i2c-0-2e
Adapter: SMBus AMD8111 adapter at 10e0

V1.5:      +2.607 V  (min =  +1.42 V, max =  +1.58 V)   ALARM
VCore:     +1.307 V  (min =  +1.32 V, max =  +1.47 V)   ALARM
V3.3:      +3.339 V  (min =  +3.13 V, max =  +3.47 V)  
V5:       +5.039 V  (min =  +4.74 V, max =  +5.26 V)  
V12:      +12.109 V  (min = +11.38 V, max = +12.62 V)  
CPU_Fan:   4882 RPM  (min = 4000 RPM)                    
fan2:      5099 RPM  (min =    0 RPM)                    
fan3:         0 RPM  (min =    0 RPM)                    
fan4:         0 RPM  (min =    0 RPM)                    
CPU:      +67.25?C  (low  =   +10?C, high =   +50?C)     ALARM 
Board:    +50.25?C  (low  =   +10?C, high =   +35?C)     ALARM
Remote:   +67.75?C  (low  =   +10?C, high =   +35?C)     ALARM 
CPU_PWM:   255
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +1.400 V  (VRM Version 2.4)

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.44 V  (min =  +1.33 V, max =  +1.47 V)             
VCore 2:   +1.44 V  (min =  +1.33 V, max =  +1.47 V)             
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)             
+5V:       +5.00 V  (min =  +4.76 V, max =  +5.24 V)             
+12V:      +4.92 V  (min = +10.82 V, max = +13.19 V)       ALARM 
-12V:      -1.59 V  (min = -13.18 V, max = -10.80 V)       ALARM 
-5V:       -3.59 V  (min =  -5.25 V, max =  -4.75 V)       ALARM 
V5SB:      +5.59 V  (min =  +4.76 V, max =  +5.24 V)       ALARM 
VBat:      +0.21 V  (min =  +2.40 V, max =  +3.60 V)       ALARM 
fan1:     5487 RPM  (min = 5625 RPM, div = 2)              ALARM 
fan2:     5625 RPM  (min = 2657 RPM, div = 2)                    
fan3:        0 RPM  (min = 2657 RPM, div = 2)              ALARM 
temp1:       +37?C  (high =  +109?C, hyst =   +75?C)   sensor = 
thermistor          
temp2:     +37.5?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor          
temp3:     +43.5?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor          
vid:      +1.400 V  (VRM Version 2.4)
alarms:  
beep_enable:
          Sound alarm disabled



