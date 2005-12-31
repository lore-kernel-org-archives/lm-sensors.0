From: tonu@jes.ee (Tonu Samuel)
Date: Sat, 31 Dec 2005 23:28:31 +0000
Subject: [lm-sensors] conflict - eeprom vs pcf8583
Message-Id: <200601010128.31423.tonu@jes.ee>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Seems like eeprom module does not make any checks or detection at all except 
Sony Vaio stuff. I had a problem with pcf8583 chip which can reside on 0x50 
or 0x51 only. This patch will read fast changing register twice to find out 
if this is and very static eeprom or dynamic clock.


test:/usr/src # diff -u linux/drivers/i2c/chips/eeprom.c 
se95/drivers/i2c/chips/eeprom.c
--- linux/drivers/i2c/chips/eeprom.c    2005-10-01 00:17:35.000000000 +0300
+++ se95/drivers/i2c/chips/eeprom.c     2006-01-01 01:11:07.000000000 +0200
@@ -185,6 +185,13 @@
        new_client->driver = &eeprom_driver;
        new_client->flags = 0;

+       /* if double read gives different values then it might be
+          PCF8583 real time clock, not eeprom */
+       if (i2c_smbus_read_byte_data(new_client, 0x01) != 
i2c_smbus_read_byte_data(new_client, 0x01)) {
+               printk(KERN_WARNING "eeprom: chip on smbus address (0x%02x) is 
not eeprom?!\n",address);
+               goto exit;
+       }
+
        /* Fill in the remaining client fields */
        strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
        data->valid = 0;
test:/usr/src #                          


I have looked around and in machines I seen, eeprom always starts  with magic 
bytes 80 08 in first registers. Maybe this is some check which can be done? 


test:/usr/src/se95 # rmmod eeprom
test:/usr/src/se95 # i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
test:/usr/src/se95 # insmod drivers/i2c/chips/eeprom.ko
test:/usr/src/se95 # i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: UU 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
test:/usr/src/se95 #                                    
test:/usr/src/se95 # i2cdump 0 0x50 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 04 0d 0a 01 40 00 01 75 54 00 82 08 00 01    ??????@.?uT.??.?
10: 8f 04 04 01 01 00 0e 00 00 00 00 14 0f 14 2d 40    ?????.?....???-@
20: 15 08 15 08 00 00 00 00 00 00 00 00 00 00 00 00    ????............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 d0    ..............??
40: 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00    ........?.......
50: 47 41 39 31 37 30 31 34 32 00 00 00 00 00 00 00    GA9170142.......
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 64 ad    ..............d?
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
test:/usr/src/se95 # i2cdump 0 0x51 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x51, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 29 23 57 00 01 01 00 00 ff ff ff ff ff ff ff    .)#W.??.........
10: 00 03 04 00 00 00 00 00 c2 00 00 04 20 0c 04 02    .??.....?..? ???
20: 06 00 00 00 00 40 90 80 20 00 80 00 c9 48 50 20    ?....@?? .?.?HP
30: 00 04 00 90 04 01 00 20 a0 40 29 00 86 00 00 01    .?.???. ?@).?..?
40: 00 00 02 40 00 42 a0 80 02 03 00 00 02 10 20 80    ..?@.B????..?? ?
50: 08 04 80 00 00 00 00 00 09 10 00 00 a0 00 00 00    ???.....??..?...
60: 30 20 00 00 00 00 28 00 10 00 48 00 00 00 a0 00    0 ....(.?.H...?.
70: 00 40 81 80 a2 08 10 08 a0 04 80 80 02 00 04 88    .@???????????.??
80: 20 00 60 03 45 01 00 06 81 22 a2 80 80 00 80 02     .`?E?.??"???.??
90: 01 00 00 02 0c 00 01 08 04 98 00 00 10 00 04 02    ?..??.????..?.??
a0: 02 40 88 60 08 00 b2 00 01 00 40 00 08 00 00 04    ?@?`?.?.?. at .?..?
b0: 00 00 10 04 48 54 28 00 8a 01 00 10 00 20 00 14    ..??HT(.??.?. .?
c0: 20 00 10 10 00 c0 68 80 80 00 00 00 02 00 11 00     .??.?h??...?.?.
d0: 04 00 20 00 18 00 00 44 10 40 90 04 02 00 2c 00    ?. .?..D?@???.,.
e0: 00 01 00 02 21 24 00 00 30 02 20 20 c8 00 a0 80    .?.?!$..0?  ?.??
f0: 12 00 30 00 00 02 00 0b 22 00 88 10 88 08 00 00    ?.0..?.?".????..
test:/usr/src/se95 # i2cdump 0 0x51 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x51, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 50 26 57 00 01 01 00 00 ff ff ff ff ff ff ff    ?P&W.??.........
10: 00 03 04 00 00 00 00 00 c2 00 00 04 20 0c 04 02    .??.....?..? ???
20: 06 00 00 00 00 40 90 80 20 00 80 00 c9 48 50 20    ?....@?? .?.?HP
30: 00 04 00 90 04 01 00 20 a0 40 29 00 86 00 00 01    .?.???. ?@).?..?
40: 00 00 02 40 00 42 a0 80 02 03 00 00 02 10 20 80    ..?@.B????..?? ?
50: 08 04 80 00 00 00 00 00 09 10 00 00 a0 00 00 00    ???.....??..?...
60: 30 20 00 00 00 00 28 00 10 00 48 00 00 00 a0 00    0 ....(.?.H...?.
70: 00 40 81 80 a2 08 10 08 a0 04 80 80 02 00 04 88    .@???????????.??
80: 20 00 60 03 45 01 00 06 81 22 a2 80 80 00 80 02     .`?E?.??"???.??
90: 01 00 00 02 0c 00 01 08 04 98 00 00 10 00 04 02    ?..??.????..?.??
a0: 02 40 88 60 08 00 b2 00 01 00 40 00 08 00 00 04    ?@?`?.?.?. at .?..?
b0: 00 00 10 04 48 54 28 00 8a 01 00 10 00 20 00 14    ..??HT(.??.?. .?
c0: 20 00 10 10 00 c0 68 80 80 00 00 00 02 00 11 00     .??.?h??...?.?.
d0: 04 00 20 00 18 00 00 44 10 40 90 04 02 00 2c 00    ?. .?..D?@???.,.
e0: 00 01 00 02 21 24 00 00 30 02 20 20 c8 00 a0 80    .?.?!$..0?  ?.??
f0: 12 00 30 00 00 02 00 0b 22 00 88 10 88 08 00 00    ?.0..?.?".????..
test:/usr/src/se95 #

