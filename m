From: tristan-777@t-online.de (Dimitri Puzin)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Intel D845GEBV2 with lm85: config is locked
Message-Id: <000501c38918$5f227520$fe0aa8c0@freeman>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I've got an Intel mainboard D845GEBV2 as replacement for my Asus P4B-266SE
(that ASB100 mess). I've mounted it, gone through the configs and
sensors-detect said I should use the lm85 driver. With lm85 it seem to work
well, except I cannot change anything in the proc interface. The values
reported seem correct but all changes (e.g. echoing values to the pwm#
registers) are ignored... As far as I can see from the BIOS, that board has
settings for fan control and speed. I guess that the BIOS initializes the
sensors during POST but as far as I could see, there was no change to the
problem even I deactivate the settings from the BIOS. I've took a look at
the board and found following devices I could think of being attached to the
bus: LM 85 BIMQ, ICS 950227 AF, FW 82801 DB, PC 87382 IBU/VLA and the eeprom
from the RAM. Intel claims there is an SMSC LPC47M172 on board. Here is the
output of what I could get from my system.

Output of syslog
-----------------------
Oct  1 20:33:18 elexis kernel: i2c-core.o: i2c core module version 2.8.0
(20030714)
Oct  1 20:33:18 elexis kernel: i2c-proc.o version 2.8.0 (20030714)
Oct  1 20:33:26 elexis kernel: i2c-dev.o: i2c /dev entries driver module
version 2.8.0 (20030714)
Oct  1 20:33:38 elexis kernel: i2c-i801 version 2.8.0 (20030714)
Oct  1 20:33:38 elexis kernel: i2c-dev.o: Registered 'SMBus I801 adapter at
e000' as minor 0
Oct  1 20:34:24 elexis kernel: lm85: Version 2.8.0 (20030714)
Oct  1 20:34:24 elexis kernel: lm85: See
http://www.penguincomputing.com/lm_sensors for more info.
Oct  1 20:34:24 elexis kernel: lm85: Assigning ID 0 to National LM85-B at
0,0x2e
Oct  1 20:34:24 elexis kernel: lm85(0): Client (0,0x2e) config is locked.

Output from sensors-detect
---------------------------
elexis:~# sensors-detect
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4

Driver `lm85' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at e000' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `National Semiconductor LM85' (confidence: 7)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at e000' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 8)

elexis:~# i2cdetect 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2e XX
30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

elexis:~# i2cdump 0 0x2e
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 76 94 c0 c5 c2 1f 20 1f a7 06 ff ff 73 12 33 11    v????? ???..s?3?
30: ff ff 4d 00 00 00 00 00 00 00 00 00 00 00 01 62    ..M...........?b
40: 07 8b 01 04 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ????..........??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 42 c4    ????........bbB?
60: c4 c4 e0 00 80 80 4d 5a 5a 25 64 64 2f 44 40 00    ???.??MZZ%dd/D@.
70: 1f 20 1f 32 00 07 00 00 00 00 00 40 28 31 6c 57    ? ?2.?.....@(1lW
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
elexis:~# i2cdump 0 0x44
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 0f 04 00 00 00 00 00 00 00 00 00 00 00 00    ..??............
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
elexis:~# i2cdump 0 0x50
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 01 40 00 04 75 75 00 82 08 00 01    ??????@.?uu.??.?
10: 0e 04 0c 01 02 20 00 a0 75 00 00 50 3c 50 2d 40    ????? .?u..P<P-@
20: 90 90 50 50 00 00 00 00 00 00 00 00 00 00 00 00    ??PP............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bf    ...............?
40: ce 00 00 00 00 00 00 00 01 4d 33 20 36 38 4c 33    ?.......?M3 68L3
50: 32 32 33 44 54 4c 2d 43 42 30 20 4c 44 02 32 f2    223DTL-CB0 LD?2?
60: 03 f5 de 00 43 42 42 30 45 30 35 00 00 00 00 00    ???.CBB0E05.....
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
elexis:~# i2cdump 0 0x69
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
20: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
40: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
50: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
60: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
70: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
80: d9 87 7e c5 3f 00 ff 01 0f 0a 80 8d 9b fe 17 44    ??~??..????????D
90: 95 09 04 03 40 aa aa 20 00 00 00 00 00 d3 XX XX    ????@?? .....?XX

I had to do a cold reset after the use of i2cdetect/dump. I tried to exclude
all except 0x2e but without success.
Do you have an idea how to solve that problem?

Regards,
-Dimitri

PS: sorry if I sent it multiple - my posts didn't appear on the list.

