From: achim <achim@ag-web.biz>
Date: Wed, 07 May 2008 19:47:43 +0000
Subject: Re: [lm-sensors] Test on chip at SMBus address 0x2e
Message-Id: <1210189663.3333.16.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

>Will try 0x32 as a value after i submitted this mail. :)

You know what happend, the system froze and did not boot (stuck at C1).
It did boot after i removed one dimm. And on the board that dimm did no longer work.
I'm running this board with an other two dimm kit now, using the same slots as with the first kit.
I tried the defect dimm in the GBT780G board and it did not work. I tried the other dimm of 
that kit and it worked. Then i tried both and they work. 

So I went adventurous again. ;)

I know where to measure vdimm on the board.

>i2cget 0 0x2e 0x35 => 1,942V 
﻿>i2cget 0 0x2e 0x36 => 1,916V
﻿>i2cget 0 0x2e 0x37 => 1,892V

That is nice to know but seem to be no good for detection, every change changes the vdimm atleast at about 0.024V.

Also the sensor chip shows the difference, 

vddr = NB-HT ﻿voltage
in5 = SB voltage
in6 = vdimm
cpu0_vid seems to be the max cpu_vid.

---------------------------------------------------------------------------------------------
debian-9850:~/i2c-tools-r5242-20080506/tools# ./i2cget 0 0x2e 0x37
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will read from device file /dev/i2c-0, chip address 0x2e, data address
0x37, using read byte data.
Continue? [Y/n] 
0x37
debian-9850:~/i2c-tools-r5242-20080506/tools# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:   +9,0°C                                    
Core0 Temp:   +4,0°C                                    
Core1 Temp:   +4,0°C                                    
Core1 Temp:  -10,0°C                                    

it8716-isa-0228
Adapter: ISA adapter
VCore:       +1,10 V  (min =  +2,11 V, max =  +0,00 V)
VDDR:        +1,28 V  (min =  +0,06 V, max =  +0,51 V)
+3.3V:       +3,28 V  (min =  +0,00 V, max =  +2,66 V)
+5V:         +4,92 V  (min =  +0,43 V, max =  +0,11 V)
+12V:       +11,90 V  (min =  +0,00 V, max =  +8,19 V)
in5:         +1,20 V  (min =  +0,00 V, max =  +0,00 V)
in6:         +1,87 V  (min =  +1,02 V, max =  +0,00 V)
5VSB:        +4,84 V  (min =  +0,35 V, max =  +0,00 V)
VBat:        +3,34 V
fan1:       1323 RPM  (min = 3245 RPM)
fan2:       3534 RPM  (min = 3245 RPM)
fan3:          0 RPM  (min = 3245 RPM)
temp1:       +21,0°C  (low  = +127,0°C, high = +84,0°C)  sensor = thermal diode
temp2:       +34,0°C  (low  = +127,0°C, high = +84,0°C)  sensor = transistor
temp3:       +40,0°C  (low  = +127,0°C, high = +84,0°C)  sensor = transistor
cpu0_vid:   +1,550 V

debian-9850:~/i2c-tools-r5242-20080506/tools# ./i2cget 0 0x2e 0x35
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will read from device file /dev/i2c-0, chip address 0x2e, data address
0x35, using read byte data.
Continue? [Y/n] 
0x35
debian-9850:~/i2c-tools-r5242-20080506/tools# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:   +9,0°C                                    
Core0 Temp:   +3,0°C                                    
Core1 Temp:   +4,0°C                                    
Core1 Temp:  -10,0°C                                    

it8716-isa-0228
Adapter: ISA adapter
VCore:       +1,10 V  (min =  +2,11 V, max =  +0,00 V)
VDDR:        +1,28 V  (min =  +0,06 V, max =  +0,51 V)
+3.3V:       +3,28 V  (min =  +0,00 V, max =  +2,66 V)
+5V:         +4,92 V  (min =  +0,43 V, max =  +0,11 V)
+12V:       +11,90 V  (min =  +0,00 V, max =  +8,19 V)
in5:         +1,20 V  (min =  +0,00 V, max =  +0,00 V)
in6:         +1,92 V  (min =  +1,02 V, max =  +0,00 V)
5VSB:        +4,84 V  (min =  +0,35 V, max =  +0,00 V)
VBat:        +3,34 V
fan1:       1326 RPM  (min = 3245 RPM)
fan2:       3534 RPM  (min = 3245 RPM)
fan3:          0 RPM  (min = 3245 RPM)
temp1:       +22,0°C  (low  = +127,0°C, high = +84,0°C)  sensor = thermal diode
temp2:       +34,0°C  (low  = +127,0°C, high = +84,0°C)  sensor = transistor
temp3:       +40,0°C  (low  = +127,0°C, high = +84,0°C)  sensor = transistor
cpu0_vid:   +1,550 V







_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
