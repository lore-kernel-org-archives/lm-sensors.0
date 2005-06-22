From: fabien.pourias@thales-is.com (fabien.pourias)
Date: Wed, 22 Jun 2005 12:07:17 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <42AAB7E3@mailmlk.tisfr.thales>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>=== Original Message From lm-sensors@lm-sensors.org ==>Hi all
>
>Please can you modprobe the bus driver
>
>modprobe i2c-i801
>modprobe i2c-dev
>i2cdetect 0
>
>And send us output of i2cdetect command?

see attach output_i2cdetect.txt file.

>Somewhere in region 0x20 - 0x2f should be one number. Use it in next command
>
>i2cdump 0 0x2f
>

see attach output_i2cdump.txt file.

>0x2f is an example. Most likely it will be 0x2f or 0x2d or 0x2e
>
>Are you sure you ran  /usr/local/sbin/sensors-detect
>
>and not /usr/sbin/sensors-detect
>

Yes i am sure because there is no binary sensors-detect in /usr/sbin.

Thank,
Fabien POURIAS.

>Thanks,
>regards
>
>Rudolf.

-------------- next part --------------
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2f, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 93 00 00 78 00 ff 00 00 04 00 e0 b3    ..dd?..x....?.??
20: a8 ff d2 bf 1f c4 d4 28 32 ff ff c6 94 b5 83 e2    ?.?????(2..?????
30: b9 ce a8 2f 13 d9 b1 cc a7 4b 46 ed ed ed 1f 01    ???/?????KF?????
40: 03 00 00 df 7f ff ff 33 2f 13 73 87 43 ff 80 5c    ?..??..3/?s?C.?\
50: ff ff ff ff ff ff ff ff 7a 10 ff 33 33 01 05 7f    ........z?.33???
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 8f 01 8f 15 00 00 00 11 11 ff ff 3c 3c 06 06    ?????...??..<<??
90: 00 00 00 01 80 ff 00 00 11 ff 3c 03 df 01 01 ff    ...??...?.<????.
a0: 01 01 01 e0 8f 8f 8f ff 3a c2 10 c3 ff ff 00 00    ???????.:???....
b0: cb c8 ff ff cc a7 cc a7 33 ff ff ed ed ed ff ff    ??..????3..???..
c0: 25 80 00 4b 00 50 00 ff cf 80 00 4b 00 50 00 ff    %?.K.P..??.K.P..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
f0: ff ff 00 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    .....?...?......
-------------- next part --------------
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2f 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX 44 XX XX XX XX XX XX 4b XX XX XX 4f 
50: 50 XX XX XX 54 XX XX XX XX XX XX XX XX XX XX XX 
60: 60 61 XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX                         
