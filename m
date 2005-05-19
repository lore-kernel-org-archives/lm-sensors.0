From: M.Meyer@maxonline.at (Matthias Meyer)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: sensors stop working after some hours/days
Message-Id: <20020108220123.CAPS1238.viefep16-int.chello.at@there>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

I've a Motherboard Gigabyte GA-7IXE with
CHIPSET 
?AMD? 751 (Irongate) North Bridge
?AMD? 756 (Viper) South Bridge
?Winbond W83977 I/O set
?Winbond W83782 health chip
?
I use Mandrake 8.1 and so I have linux 2.4.8 with buildin sensors version 
2.6.1.
All works fine for a lot of hours.
But after some time sensors stops reporting possible values. Instead it 
reports 0 for the temperatures and -1 for the fan speed.

Anybody have a idea ?
-------------- next part --------------
w83782d-i2c-0-2d
Adapter: SMBus AMD7X6 adapter at 50e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
VCore 2:   +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
+5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)              
-12V:     -14.91 V  (min = -14.91 V, max = -14.91 V)              
-5V:       -7.71 V  (min =  -7.71 V, max =  -7.71 V)              
V5SB:      +0.13 V  (min =  +0.13 V, max =  +0.13 V)              
VBat:      +0.08 V  (min =  +0.08 V, max =  +0.08 V)              
fan1:       -1 RPM  (min =   -1 RPM, div = 1)                     
fan2:       -1 RPM  (min =   -1 RPM, div = 1)                     
fan3:       -1 RPM  (min =   -1 RPM, div = 1)                     
temp1:      +0.0?C  (limit =   +0?C, hysteresis =   +0?C) sensor = thermistor           
temp2:        +0?C  (limit =   +0?C, hysteresis =   +0?C) sensor = thermistor           
temp3:        +0?C  (limit =   +0?C, hysteresis =   +0?C) sensor = PII/Celeron diode           
vid:      +2.05 V
alarms:   Chassis intrusion detection                             
beep_enable:
          Sound alarm disabled
