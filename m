From: hiro_yuki_mori@yahoo.co.jp (Mori Hiroyuki)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Sensor results of P4P800
Message-Id: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm using P4P800/ASUS mother board. Also I know that
Winbond w83627thf is assembled on it.
Currently I downloaded i2c and lm_sensors source code from
CVS dated on 12/6/'03 and installed them on
TruboLinux(2.4.18). Then I can get following result.

[root@test root]# sensors -s; sensors
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

w83627thf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.99 V  (min =  +0.00 V, max =  +0.00 V)      
       
VCore 2:   +3.20 V  (min =  +4.08 V, max =  +4.08 V)      
       
+3.3V:     +3.38 V  (min =  +3.14 V, max =  +3.46 V)      
       
+5V:       +5.14 V  (min =  +4.74 V, max =  +5.24 V)      
       
in4:       +0.00 V  (min =  +0.30 V, max =  +5.55 V)      
       
V5SB:      +5.02 V  (min =  +4.74 V, max =  +5.24 V)      
       
VBat:      +3.22 V  (min =  +2.40 V, max =  +3.60 V)      
       
fan1:        0 RPM  (min =  351 RPM, div = 32)            
        
fan2:     2884 RPM  (min = 5273 RPM, div = 2)             
       
fan3:        0 RPM  (min =   87 RPM, div = 128)           
         
M/B Temp:    +31  (high =   +40, hyst =   +37)   sensor thermistor           
CPU Temp:  +29.0  (high =   +52, hyst =   +47)   sensor PII/Celeron diode           
temp3:    +127.5  (high =   +80, hyst =   +75)   sensor 3904 transistor   ALARM   
vid:      +0.000 V
alarms:   
beep_enable:
          Sound alarm disabled

My question is the results of Vcore1, Vcore2, in4 and CPU
Temp.
Vcore1: BIOS shows 1.55V as Vcore voltage. Should I
calculate to make correction with 'compute'? Is there any
formula?
Vcore2: Can I ignore?
in4: I believe in4 shows +12V. Is this a bug?
CPU Temp: I tried to set 1,2,3435 in /etc/sensors.conf.
Result shows as below.

CPU Temp:  +29.0  (high =   +52, hyst =   +47)   sensor PII/Celeron diode
CPU Temp:  +30.0  (high =   +52, hyst =   +47)   sensor 3904 transistor
CPU Temp:  +86.0  (high =   +52, hyst =   +47)   sensor thermistor   ALARM

BIOS shows 40'C(approx M/B+9'C) as CPU temp value. What
should I do?

Also I report the status of temp3 with above condition for
reference.
temp3:    +127.5  (high =   +80, hyst =   +75)   sensor PII/Celeron diode   ALARM
temp3:    +127.5  (high =   +80, hyst =   +75)   sensor 3904 transistor   ALARM
temp3:    +208.0  (high =   +80, hyst =   +75)   sensor thermistor




__________________________________________________
Do You Yahoo!?
Yahoo! BB is Broadband by Yahoo!
http://bb.yahoo.co.jp/
