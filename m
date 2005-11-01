From: nivv@cs.bgu.ac.il (niv)
Date: Tue, 01 Nov 2005 17:48:37 +0000
Subject: [lm-sensors] Good news , bad news
Message-Id: <43679C33.5010605@cs.bgu.ac.il>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am glad to report lm_sensors works on my IDEQ 210V . This pc has the 
via KM400 and VT8378. sensors-detect found the it87 and it looks good.

I also have a TV card on this pc , and it uses I2C.


Question: How to omit the other chips that show up in the sensors command?

I mean the eeprom-i2c-1-51,Philips -i2c-0-61,tveeprom

I cant find a section in the sensors.conf that lists the chips used. 
looks like sensors shows all the I2C devices.



it87-isa-0290
Adapter: ISA adapter
+5V:       +5.00 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +11.65 V  (min = +11.39 V, max = +12.61 V)
Stdby:     +4.84 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.25 V
fan1:        0 RPM  (min =    0 RPM, div = 8)
fan2:     1654 RPM  (min =  664 RPM, div = 8)          ALARM
M/B Temp:    +29 C  (low  =   +15 C, high =   +40 C)   sensor = thermistor
CPU Temp:    +42 C  (low  =   +15 C, high =   +45 C)   sensor = thermistor
Temp3:       +43 C  (low  =   +15 C, high =   +45 C)   sensor = thermistor

eeprom-i2c-1-51
Adapter: SMBus Via Pro adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

Philips -i2c-0-61
Adapter: bt878 #0 [sw]

tveeprom-i2c-0-50
Adapter: bt878 #0 [sw]




Thanks,

Niv

-- 
"??? ???"
