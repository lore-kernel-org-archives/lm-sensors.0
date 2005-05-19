From: cwingert@qualcomm.com (Christopher Wingert)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Soyo Dragon IT8705F
Message-Id: <200203251944.g2PJihZQ004922@logansrun.qualcomm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I have a Soyo Dragon MB.  I am running 2.6.3 and seeing some wierd numbers
from the temperature sensors.  The temperature seems to change +/-20 degrees C
from one run to another.

For example :
[root@wingert root]# sensors
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.87 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
VCore 2:   +2.51 V  (min =  +2.40 V, max =  +2.60 V)   
+3.3V:     +6.58 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
+5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)   
+12V:     +12.32 V  (min = +11.36 V, max = +12.60 V)   
-12V:     -19.69 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.31 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +4.99 V  (min =  +4.72 V, max =  +5.24 V)   
VBat:      +0.00 V
fan1:        0 RPM  (min =    0 RPM, div = 2)          
fan2:     4623 RPM  (min = 3000 RPM, div = 2)          
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +47?C  (min =  +20?C, max =  +40?C) 
Temp2/CPU:   -59?C  (min =  +25?C, max =  +45?C) 
Temp3:       +77?C  (min =  +25?C, max =  +45?C) 

[root@wingert root]# sensors
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.85 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
VCore 2:   +2.51 V  (min =  +2.40 V, max =  +2.60 V)   
+3.3V:     +6.62 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
+5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)   
+12V:     +12.32 V  (min = +11.36 V, max = +12.60 V)   
-12V:     -19.69 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.31 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +4.97 V  (min =  +4.72 V, max =  +5.24 V)   
VBat:      +0.00 V
fan1:        0 RPM  (min =    0 RPM, div = 2)          
fan2:     4623 RPM  (min = 3000 RPM, div = 2)          
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +47?C  (min =  +20?C, max =  +40?C) 
Temp2/CPU:   -58?C  (min =  +25?C, max =  +45?C) 
Temp3:       +52?C  (min =  +25?C, max =  +45?C) 

These were run approximately 1 second apart.
Approximately 75% of the time it does give the right answer though.

Any help would be appreciated.



                                    Regards,
                                        Christopher

