From: "everythingsfree@lineone.net" <everythingsfree@lineone.net>
Date: Thu, 16 Jun 2011 18:21:21 +0000
Subject: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

I'm running Ubuntu Server 10.4 LTS (64 bit) on a Gigabyte GA-D525 
board and have downloaded, built and installed the latest version of lm-
sensors (using 'sensors -v' it reports 'sensors version 3.3.0 with 
libsensors version 3.3.0'), as far as I can tell I've done this 
correctly.

I ran 'sensors-detect' and answered all of the questions 
and let it do its thing.

On checking what gets reported through 
'sensors' I get the following which appears to be failing to report the 
temperatures of the cores  (I also wonder why it's attempting to report 
four when it's only a dual core processor) although I do get some 
temperatures at the bottom:


coretemp-isa-0000
Adapter: ISA adapter

Core 0:           N/A  (crit = +100.0Â°C)

coretemp-isa-0001
Adapter: 
ISA adapter
Core 1:           N/A  (crit = +100.0Â°C)

coretemp-isa-
0002
Adapter: ISA adapter
Core 2:           N/A  (crit = +100.0Â°C)


coretemp-isa-0003
Adapter: ISA adapter
Core 3:           N/A  (crit = 
+100.0Â°C)

it8720-isa-0290
Adapter: ISA adapter
in0:          +1.10 V  
(min =  +0.00 V, max =  +4.08 V)
in1:          +1.52 V  (min =  +0.00 
V, max =  +4.08 V)
in2:          +3.31 V  (min =  +0.00 V, max =  +4.08 
V)
in3:          +2.98 V  (min =  +0.00 V, max =  +4.08 V)

in4:          +3.09 V  (min =  +0.00 V, max =  +4.08 V)
in5:          
+4.08 V  (min =  +0.00 V, max =  +4.08 V)  ALARM
in6:          +4.08 V  
(min =  +0.00 V, max =  +4.08 V)  ALARM
in7:          +2.18 V  (min =  
+0.00 V, max =  +4.08 V)
Vbat:         +3.06 V
fan1:        3857 RPM  
(min =    0 RPM)
fan2:           0 RPM  (min =    0 RPM)
temp1:        
-55.0Â°C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = thermistor

temp2:        +64.0Â°C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = 
thermistor
temp3:        +30.0Â°C  (low  = +127.0Â°C, high = +127.0Â°
C)  sensor = thermal diode
cpu0_vid:    +1.850 V

From what I 
understand 'coretemp' is reporting the core temperatures and the other 
stuff is from'it87' (these are also in '/etc/modules')

I also noticed 
that someone else has reported what appears to be a similar or the same 
problems with this board back in April (http://lists.lm-sensors.org/pipermail/lm-sensors/2011-April/032332.html
, oddly they only got two core temperature reading attempts.

Hopefully 
someone can respond and help me out, no one appears to have replied to 
the other posting unfortunately.  I'm willing to try out any code 
changes and run tests that may be required.

Thanks
Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
