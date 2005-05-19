From: peterg@infotel.bg (Peter Georgiev)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: Feedback
Message-Id: <20030422100715.21805087.peterg@ops.airport.pdv>
List-Id: <lm-sensors.vger.kernel.org>
References: <200203231220.g2NCKQD01021@shire.frodo.local>
In-Reply-To: <200203231220.g2NCKQD01021@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hiya guys,

Just dropping you a couple of lines to let you know
lm_sensors work fine with my motherboard.

Detail as follows:
Motherboard: 	MSI (Micro-Star International) 
		MS-6580 (v2.1) 845PE Max ATX
		G52-M6580X4
Chipset:	Intel 845PE
LM_Sensors:	v2.6.5

Detected busses:i2c-i801 / i2c-isa
Detected chips: w83781d / lm80 (emulated??)

SMBus gives buggy output (lame lm80 emulation??):

lm80-i2c-0-2f
Adapter: SMBus I801 adapter at 0c00
Algorithm: Non-I2C SMBus adapter
+5V:       +6.71 V  (min =  +6.71 V, max =  +6.71 V)   ALARM
VTT:       +2.55 V  (min =  +2.55 V, max =  +2.55 V)   ALARM
+3.3V:     +4.43 V  (min =  +4.43 V, max =  +4.43 V)   ALARM
+Vcore:    +3.76 V  (min =  +3.76 V, max =  +3.76 V)   ALARM
+12V:     +16.10 V  (min = +16.10 V, max = +16.10 V)   ALARM
-12V:     -16.11 V  (min = -16.11 V, max = -16.11 V)   ALARM
-5V:       -6.70 V  (min =  -6.70 V, max =  -6.70 V)   ALARM
fan1:        0 RPM  (min =    0 RPM, div = 8)          ALARM
fan2:        0 RPM  (min =    0 RPM, div = 8)          ALARM
temp:     -1.00 ?C (hot:limit =  -1?C,  hysteresis =  -1?C) ALARM
         (os: limit =  -1?C,  hysteresis =  -1?C) ALARM
alarms:   Board temperature input (LM75)               ALARM


ISA adapter data is just fine:

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.76 V  (min =  +1.80 V, max =  +1.98 V)              
VCore 2:   +1.80 V  (min =  +1.80 V, max =  +1.98 V)       ALARM  
+3.3V:     +3.18 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.99 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:     +11.86 V  (min = +10.79 V, max = +13.19 V)              
-12V:     -11.62 V  (min = -13.21 V, max = -10.90 V)              
-5V:       -5.01 V  (min =  -5.26 V, max =  -4.76 V)              
V5SB:      +5.43 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.15 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     2812 RPM  (min = 3000 RPM, div = 2)                     
fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
temp1:       +27?C  (limit =  +60?C)                       sensor thermistor           temp2:     +38.0?C  (limit =  +60?C, hysteresis = 
+50?C) sensor = PII/Celeron diode           temp3:     +58.0?C  (limit  +60?C, hysteresis =  +50?C) sensor = thermistor           vid:     
+1.900 V alarms:   Chassis intrusion detection                     
ALARM beep_enable:
          Sound alarm disabled


	  
Well, hope this is of use
keep up the good work and stay cool

Peter
