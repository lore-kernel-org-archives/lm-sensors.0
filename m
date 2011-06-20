From: Vincent Pelletier <plr.vincent@gmail.com>
Date: Mon, 20 Jun 2011 11:20:49 +0000
Subject: Re: [lm-sensors] IT8721F on Asus M5A88-V EVO
Message-Id: <201106201320.49924.plr.vincent@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201106192314.40074.plr.vincent@gmail.com>
In-Reply-To: <201106192314.40074.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Again, with atk0110 loaded (after I noticed the warning in dmesg about using 
acpi_enforce_resources kernel parameter preventing atk module from loading).
All values provided again for comparison.

$ sensors
k10temp-pci-00c3                                                                                                                                                                                                                                                                               
Adapter: PCI adapter                                                                                                                                                                                                                                                                           
temp1:        +28.5°C  (high = +70.0°C)                                                                                                                                                                                                                                                        
                       (crit = +70.0°C, hyst = +65.0°C)                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                               
atk0110-acpi-0                                                                                                                                                                                                                                                                                 
Adapter: ACPI interface                                                                                                                                                                                                                                                                        
Vcore Voltage:      +1.27 V  (min =  +0.85 V, max =  +1.60 V)                                                                                                                                                                                                                                  
 +3.3 Voltage:      +3.28 V  (min =  +2.97 V, max =  +3.63 V)                                                                                                                                                                                                                                  
 +5 Voltage:        +5.06 V  (min =  +4.50 V, max =  +5.50 V)                                                                                                                                                                                                                                  
 +12 Voltage:      +12.13 V  (min = +10.20 V, max = +13.80 V)                                                                                                                                                                                                                                  
CPU FAN Speed:     2616 RPM  (min =  600 RPM)                                                                                                                                                                                                                                                  
CHASSIS FAN Speed: 1562 RPM  (min =  600 RPM)                                                                                                                                                                                                                                                  
POWER FAN Speed:   1683 RPM  (min =  600 RPM)                                                                                                                                                                                                                                                  
CPU Temperature:    +37.0°C  (high = +60.0°C, crit = +95.0°C)                                                                                                                                                                                                                                  
MB Temperature:     +35.0°C  (high = +45.0°C, crit = +75.0°C)                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                               
it8721-isa-0290                                                                                                                                                                                                                                                                                
Adapter: ISA adapter                                                                                                                                                                                                                                                                           
VCore:        +2.92 V  (min =  +1.82 V, max =  +0.17 V)  ALARM                                                                                                                                                                                                                                 
VDDR:         +2.89 V  (min =  +2.34 V, max =  +2.06 V)  ALARM                                                                                                                                                                                                                                 
+3.3V:        +1.27 V  (min =  +2.10 V, max =  +2.68 V)  ALARM                                                                                                                                                                                                                                 
+5V:          +3.29 V  (min =  +2.38 V, max =  +2.90 V)  ALARM                                                                                                                                                                                                                                 
+12V:         +1.70 V  (min =  +2.82 V, max =  +1.31 V)  ALARM                                                                                                                                                                                                                                 
in5:          +2.63 V  (min =  +2.10 V, max =  +1.40 V)  ALARM                                                                                                                                                                                                                                 
in6:          +1.01 V  (min =  +1.99 V, max =  +1.25 V)  ALARM                                                                                                                                                                                                                                 
VSB:          +4.27 V  (min =  +1.30 V, max =  +2.76 V)  ALARM                                                                                                                                                                                                                                 
VBat:         +3.34 V                                                                                                                                                                                                                                                                          
CPU fan:     2606 RPM  (min =   14 RPM)                                                                                                                                                                                                                                                        
CHA fan:     1566 RPM  (min =   24 RPM)                                                                                                                                                                                                                                                        
PSU fan:     1683 RPM  (min =   21 RPM)                                                                                                                                                                                                                                                        
CPU Temp:     +37.0°C  (low  =  +0.0°C, high = +70.0°C)  sensor = thermistor                                                                                                                                                                                                                   
MB Temp:      +35.0°C  (low  =  +0.0°C, high = +70.0°C)  sensor = thermistor                                                                                                                                                                                                                   

atk driver provides values very close to bios, with following exceptions:
- cpu temp is lower (46° in bios), in my understanding cpu is at full
  speed during bios so it can explain
- chassis fan lower (1717 RPM in bios), most probably related to higher cpu
  temperature, as its speed under OS follows CPU temperature
- power fan min RPM cannot be set in the bios, others are consistent with my
  settings
- MB temperature shutdown level in bios is 95°. Not sure if it contradicts
  "crit" level reported above (maybe unrelated).

For some reason, when changing fan settings in bios, linux fails booting after 
detecting all hard disks, undoing the config doesn't always cure startup. I 
could originally boot in "auto" mode, now I can bot in "manual" mode (bios 
controls fans, but I get to set the levels - for no audible difference 
anyway). I suspect bios has a good share of bugs (it seems this motherboard is 
more recent than I thought... dmidecode says "Release Date: 04/18/2011" in 
"BIOS Information" section).

-- 
Vincent Pelletier

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
