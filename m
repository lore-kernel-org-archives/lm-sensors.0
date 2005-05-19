From: elof@image.dk (Kristian Soerensen)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Tyan Tiger S2466MPX
Message-Id: <Pine.LNX.4.44.0210072110001.2270-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello


Below are the result of running lm_sensors on a Tyan Tiger S2466N MPX
motherboard with a chip marked Winbond W83627HF-AW. 

The cpu temperatures are way out of line, and the -5V reading looks
suspicious. There are two cpus installed but the kernel is not SMP, and
one cpu heatsink is significantly cooler to the touch than the other.

lm_sensors is compiled from source code obtained by anonymous cvs on the 
7. of October 2002. The CVS ID of kernel/chips/w83781d.c is 1.95

I am more than happy to test any patches that you will want to have tested
on this particular motherboard.


w83627hf-i2c-0-2c
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.71 V  (min =  +4.08 V, max =  +4.08 V)              
VCore 2:   +1.72 V  (min =  +4.08 V, max =  +4.08 V)              
+3.3V:     +3.26 V  (min =  +2.97 V, max =  +3.63 V)              
+5V:       +5.02 V  (min =  +4.50 V, max =  +5.48 V)              
+12V:      +9.46 V  (min = +10.79 V, max = +13.11 V)              
-12V:     -12.03 V  (min = -13.21 V, max = -10.90 V)              
-5V:       +0.27 V  (min =  -5.51 V, max =  -4.51 V)              
V5SB:      +5.44 V  (min =  +4.50 V, max =  +5.48 V)              
VBat:      +3.24 V  (min =  +2.70 V, max =  +3.29 V)              
fan1:     2109 RPM  (min =   93 RPM, div = 64)                     
fan2:     2343 RPM  (min =   93 RPM, div = 64)                     
fan3:        0 RPM  (min =   93 RPM, div = 64)                     
temp1:       +77?C  (limit =  +60?C)                       sensor = 
thermistor   ALARM   
temp2:     +76.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
thermistor   ALARM   
temp3:     +74.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
thermistor   ALARM   
vid:      +18.500 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled




-- 
-----------------------   http://www.elof.dk   ----------------------
Kristian Elof Soerensen      elof@elof.dk           (+45) 45 93 92 02 
