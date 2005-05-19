From: m.strong@tnsa.com.au (Mark Strong)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: fan speeds and temps no reading
Message-Id: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guys,
	having a little trouble getting good readings

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +0.97 V  (min =  +0.96 V, max =  +0.96 V)              
+12V:      +6.63 V  (min = +10.82 V, max = +13.19 V)              
+3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.47 V)              
+5V:       +4.96 V  (min =  +4.75 V, max =  +5.25 V)              
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)              
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)              
VBat:      +1.70 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:        0 RPM  (min = 8881 RPM, div = 2)                     
fan2:        0 RPM  (min = 5273 RPM, div = 2)                     
fan3:        0 RPM  (min = 10546 RPM, div = 2)                     
temp1:       -48?C  (high =    +9?C, hyst =    +0?C)   sensor thermistor           
temp2:    +127.5?C  (high =   +80?C, hyst =   +75?C)   sensor transistor   ALARM   
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor thermistor           
vid:      +0.000 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

[root@bambi etc]# sensors -v
sensors version 2.9.0 with libsensors version 2.9.0

Its a 2.6.9 (Redhat FC3 x86_64) kernel.

I just installed the RPMs from http://atrpms.net/name/lm_sensors/ for
FC3 x86_64, the kernel modules are from the redhat kernel source (I
recompiled it).

The motherboard definitely has a w83627thf soldered on it (which
sensors-detect detected), its an ASUS NCL-DS (its a dual Xeon, fairly
new).

The fans I've tried different "fan1_div" settings (tried 4 and 8) no
good, for the temps I've tried set sensor1,2 or 3435 (I can only get
-48C or +127C)

What can I try next (also where are the /proc values, or is it sysfs
these days?)


Regards
Mark Strong


