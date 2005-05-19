From: otheos@clara.net (Alexandros Kambas)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: ref ticket 749.
Message-Id: <E16BE4O-000568-00@oracle.clara.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for all your support.

the `modprobe w83781d init=0` works and the system no longer locks.

However, if I call:

modprobe i2c-dev
modprobe i2c-amd756
modprobe w83781d init=0

from /etc/rc.d/rc.local (RH7.2) while booting up, sound (SB Live Value) won't 
play. Not too important as if I leave them out and modprobe them after I boot 
sound is ok and it seems they still work so I only mentioning just for the 
cause.

Now, it seems that the readings are completely wrong/out of the blue.

Here's a typical:

[root@zeus spxak]# sensors
w83627hf-i2c-0-2c
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.87 V  (min =  +1.93 V, max =  +2.14 V)       ALARM  
VCore 2:   +1.84 V  (min =  +1.93 V, max =  +2.14 V)       ALARM  
+3.3V:     +3.29 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.70 V  (min =  +4.72 V, max =  +5.24 V)       ALARM  
+12V:      +9.84 V  (min = +10.79 V, max = +13.19 V)              
-12V:     -13.11 V  (min = -10.90 V, max = -13.21 V)              
-5V:       -0.24 V  (min =  -4.76 V, max =  -5.26 V)              
V5SB:      +5.51 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     3375 RPM  (min = 33750 RPM, div = 8)                     
fan2:     3125 RPM  (min = 84375 RPM, div = 8)                     
fan3:        0 RPM  (min = 4963 RPM, div = 8)                     
temp1:    +78.0?C   (limit = +81?C, hysteresis = +66?C) sensor = thermistor   
        
temp2:    +4.5?C   (limit = +80?C, hysteresis = +75?C) sensor = thermistor    
       
temp3:    +8.0?C   (limit = +80?C, hysteresis = +75?C) sensor = thermistor    
       
vid:      +2.05 V
alarms:   Chassis intrusion detection                             
beep_enable:
          Sound alarm enabled

They system should report ~55C for the CPU's.

I hope that even if my issue is not resolved, you can use the feedback.

Thank you again

A. Kambas.
