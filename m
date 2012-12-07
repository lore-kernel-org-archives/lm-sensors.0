From: wind <Black.S52@yandex.com>
Date: Fri, 07 Dec 2012 16:44:52 +0000
Subject: [lm-sensors] decode-dimms can't detect DIMM in all slots
Message-Id: <50C21D04.8040003@yandex.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I use motherboard with 2 CPU and 6 DIMM (3 DIMM on each CPU).  I run 
decode-dimms and it detect 3 DIMM modules in the 3 slots but another 3 
DIMM decode-dimms can't detect.

lm-sensors 3.3.3
decode-dimms in the i2c-tools 3.1.0-3 and even I tried rev.6068
kernel 2.6.32.20 and even I tried 3.4.2
motherboard - Supermicro X8DTG

modprobe i2c-i801
modprobe i2c-dev
modprobe i2c-core
modprobe eeprom
'i2cdetect 3' give table something like this

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- UU -- UU -- UU -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 -- 52 -- 54 -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

ls /sys/bus/i2c/drivers/eeprom/
3-0050
3-0052
3-0054
i2c-dev...
i2c-dev...
i2c-dev...


decode-dimms give out something like this

$ decode-dimms
# decode-dimms version 6068 (2012-11-.. )

Memory Serial Presence Detect Decoder
By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
Jean Delvare, Trent Piepho and others


Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/3-0050
Guessing DIMM is in                             bank 1

---== SPD EEPROM Information ==---
EEPROM CRC of bytes 0-116                       OK (0xF02A)
# of bytes written to SDRAM EEPROM              176
Total number of bytes in EEPROM                 256
Fundamental Memory type                         DDR3 SDRAM
...

Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/3-0052
Guessing DIMM is in                             bank 3

---== SPD EEPROM Information ==---
EEPROM CRC of bytes 0-116                       OK (0x7134)
# of bytes written to SDRAM EEPROM              176
Total number of bytes in EEPROM                 256
Fundamental Memory type                         DDR3 SDRAM
...

Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/3-0052
Guessing DIMM is in                             bank 5

---== SPD EEPROM Information ==---
EEPROM CRC of bytes 0-116                       OK (0x...)
# of bytes written to SDRAM EEPROM              176
Total number of bytes in EEPROM                 256
Fundamental Memory type                         DDR3 SDRAM

...


Number of SDRAM DIMMs detected and decoded: 3




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
