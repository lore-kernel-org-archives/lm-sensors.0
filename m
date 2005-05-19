From: Helpdesk@twilightinc.nl (TwiLight INC)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Asus PCH-DR
Message-Id: <425ED987.9040306@twilightinc.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <425E7468.8020500@twilightinc.nl>
In-Reply-To: <425E7468.8020500@twilightinc.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I did that but i get really strange readings back...

[root@naruto ~]# sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.94 V  (min =  +1.93 V, max =  +1.93 V)
+12V:     +12.89 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.39 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.04 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.61 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 18750 RPM, div = 2)
CPU Fan:     0 RPM  (min = 4963 RPM, div = 2)
fan3:        0 RPM  (min = 4927 RPM, div = 2)
M/B Temp:    -35?C  (high =   +18?C, hyst =    +0?C)   sensor = 
thermistor     
CPU Temp:  -35.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor     
temp3:     -35.0?C  (high =   +80?C, hyst =   +75?C)   sensor = 
thermistor     
vid:      +0.000 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

[root@naruto ~]#


Rudolf Marek wrote:

>Hello,
>
>Please install lm_sensors package on your system. You can have it from our website.
>(Follow different instructions for 2.6 and 2.4 kernels)
>
>When installed please run sensors-detect
>It will tell you what chip it found and what modules to load.
>
>Load them and issue sensors command. You can fine tune your configuration by editing /etc/sensors.conf
>
>I hope this helps
>
>Regards
>
>Rudolf
>
>
>  
>

