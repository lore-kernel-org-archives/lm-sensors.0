From: rod@morison.biz (Rod Morison)
Date: Wed, 24 May 2006 08:32:25 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <44741A19.4090108@morison.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hello,
>
> As for the 2.4 version I cannot see that you have loaded the w83792d 
> kernel module.
>
> Please try the modprobe w83792d
> and then sensors
You're right. Now I'm fairly sure I have all the sensor bus/chip drivers 
loaded under 2.4 that are loaded in the 2.6 kernel, but still I'm 
missing the w83792d-i2c-0-2f information. Is it possible that I need to 
load the w83792d driver with some option settings?

Am I missing something else?

2.4.19: lsmod
Module                  Size  Used by    Tainted: P 
i2c-dev                 3776   0  (unused)
w83627hf               14104   0  (unused)
smbus-arp               4816   0  (unused)
w83792d                11988   0  (unused)
i2c-isa                  804   0  (unused)
i2c-i801                4828   0  (unused)
vrdvx                  51460   4
vrdsp                1234848   2
vrsfd                  74096  14  [vrdvx vrdsp]
vrmem                   9760   2
eeprom                  3500   0  (unused)
w83781d                19196   0  (unused)
i2c-proc                5988   0  [w83627hf smbus-arp w83792d eeprom 
w83781d]
i2c-core               14276   0  [i2c-dev w83627hf smbus-arp w83792d 
i2c-isa i2c-i801 eeprom w83781d i2c-proc]
e1000                  98896   1
2.4.19:  sensors
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1100
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 1100
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       512

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.00 V  (min =  +3.33 V, max =  +3.66 V)             
VCore 2:   +0.00 V  (min =  +3.33 V, max =  +3.66 V)             
+3.3V:     +0.00 V  (min =  +3.14 V, max =  +3.46 V)             
+5V:       +5.19 V  (min =  +4.74 V, max =  +5.24 V)             
+12V:      +0.00 V  (min = +10.83 V, max = +13.19 V)             
-12V:     -14.91 V  (min = -13.16 V, max = -10.90 V)             
-5V:       -7.71 V  (min =  -5.26 V, max =  -4.76 V)             
V5SB:      +5.56 V  (min =  +4.74 V, max =  +5.24 V)             
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)             
fan1:        0 RPM  (min = 2848 RPM, div = 2)                    
fan2:        0 RPM  (min = 2848 RPM, div = 2)                    
fan3:        0 RPM  (min =    0 RPM, div = 8)                    
temp1:      +127 C  (high =    -1 C, hyst =    -1 C)   sensor = 
thermistor          
temp2:    +127.0 C  (high =   +80 C, hyst =   +75 C)   sensor = 
thermistor   ALARM  
temp3:    +127.0 C  (high =   +80 C, hyst =   +75 C)   sensor = 
thermistor   ALARM  
vid:      +3.500 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

arp-i2c-0-61
Adapter: SMBus I801 adapter at 1100

2.4.19:

>
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060524/0671b176/attachment.html
