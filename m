From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE36F3FB@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf


> Conclusions about different dumps:
> 
> I assume that the driver is working correctly and in your last email
> you were using the driver WITHOUT a lot of debugging messages. Maybe the
> delay while logging the messages caused troubles.

I did NOT enable the DEBUG message in the previous mails.


> Conclusions about Unknown type versus Known type:
> 
> Please are you sure you were using same version or lm_sensors?
> I think you told us that you just swapped the drives. Maybe something
> is still wrong about error signaling in the ali driver.

Yes, I'm using the same version of bus/chip drivers. The i2c-ali1563 driver
I'm using is the one modified by you. I also tried the original i2c-ali1563
in linux-2.6.10 before your modification. It does NOT work either.


> Steps to make us sure about bus readings:
> 1) take some OTHER  memory DDR (different manufacturer if possible)
> 2) put into ABIT, remove any other ddr memory modules
> 3) do i2cdump 0x50 asume 0x50 is correct addr of the chip

I'd like to try such DDR memory here:
PC1600R-20330		0446
HYMD264G726 B4M-H
512MB DDR 200MHZ ECC REG

Btw, the memory I used in previous several mails to you is
128MB REG ECC PC2100 CL2.5 Apacer * 2

Btw, the ABit motherboard User Guild says that it supports 144-bit wide
Dual channel DDR 400/333 memory, but neither of the above two kind memory
is DDR 400/333. Although the above two kind of memory can work on this
Abit motherboard, Does it have something to do with our problem?
We have no other ECC DDR memory here but the above two kind.

The dump result is(I dump is for three times, the result are same):
Here I have a question:
I'm using the address 50 to do the dump operation. How to judge the address
50 is correct? I do not have a motherboard spec here.
[root@ /usr/src/linux]# sensors
eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (255).

[root@ /usr/src/linux]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@ /usr/src/linux]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@ /usr/src/linux]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................



> 4) try this several times, also plz load your chip driver
>    and run sensors command from time to time. Check if you get
>    same two first bytes of the dump third should be 0x7 for DDR.

I loaded the chip modules w83792d, and do the operations you suggested,
I find the "Unknown EEPROM type (255)" will become " Unknown EEPROM type
 (172)" And the dump result also changed in the last line, Please refer
to the message below.

[root@ /usr/src/linux]# sensors
eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (255).

[root@ /usr/src/linux]# modprobe w83792d
[root@ /usr/src/linux]# sensors
w83792d-i2c-0-2f
Adapter: SMBus ALi 1563 Adapter @ 5000
VCoreA:    +1.52 V  (min =  +0.00 V, max =  +1.78 V)
VCoreB:    +0.54 V  (min =  +0.00 V, max =  +1.78 V)
VIN0:      +3.31 V  (min =  +0.00 V, max =  +4.08 V)
VIN1:      +3.15 V  (min =  +0.00 V, max =  +4.08 V)
VIN2:      +2.52 V  (min =  +0.00 V, max =  +4.08 V)
VIN3:      +1.26 V  (min =  +0.00 V, max =  +4.08 V)
5VCC:      +5.06 V  (min =  +0.00 V, max =  +6.12 V)
5VSB:      +4.99 V  (min =  +0.00 V, max =  +6.12 V)
VBAT:      +3.25 V  (min =  +0.00 V, max =  +4.08 V)
Fan1:     1638 RPM  (min =  703 RPM, div = 8)
Fan2:        0 RPM  (min =  703 RPM, div = 8)
Fan3:        0 RPM  (min =  703 RPM, div = 8)
Fan4:        0 RPM  (min =  703 RPM, div = 8)
Fan5:        0 RPM  (min =  703 RPM, div = 8)
Fan6:        0 RPM  (min =  703 RPM, div = 8)
Fan7:       -1 RPM  (min =    0 RPM, div = 2)              ALARM
Temp1:     +38.0??C  (high = +80.0??C, hyst = +75.0??C)   ALARM
Temp2:      -8.0??C  (high = +80.0??C, hyst = +75.0??C)   ALARM
Temp3:     +43.0??C  (high = +80.0??C, hyst = +75.0??C)   ALARM
chassis:  Chassis is normal.

eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (255).

[root@ /usr/src/linux]# sensors
w83792d-i2c-0-2f
Adapter: SMBus ALi 1563 Adapter @ 5000
VCoreA:    +1.52 V  (min =  +0.00 V, max =  +1.78 V)
VCoreB:    +0.54 V  (min =  +0.00 V, max =  +1.78 V)
VIN0:      +3.31 V  (min =  +0.00 V, max =  +4.08 V)
VIN1:      +3.15 V  (min =  +0.00 V, max =  +4.08 V)
VIN2:      +2.52 V  (min =  +0.00 V, max =  +4.08 V)
VIN3:      +1.26 V  (min =  +0.00 V, max =  +4.08 V)
5VCC:      +5.06 V  (min =  +0.00 V, max =  +6.12 V)
5VSB:      +4.99 V  (min =  +0.00 V, max =  +6.12 V)
VBAT:      +3.25 V  (min =  +0.00 V, max =  +4.08 V)
Fan1:     1638 RPM  (min =  703 RPM, div = 8)
Fan2:        0 RPM  (min =  703 RPM, div = 8)
Fan3:        0 RPM  (min =  703 RPM, div = 8)
Fan4:        0 RPM  (min =  703 RPM, div = 8)
Fan5:        0 RPM  (min =  703 RPM, div = 8)
Fan6:        0 RPM  (min =  703 RPM, div = 8)
Fan7:       -1 RPM  (min =    0 RPM, div = 2)              ALARM
Temp1:     +38.0??C  (high = +80.0??C, hyst = +75.0??C)   ALARM
Temp2:      -8.0??C  (high = +80.0??C, hyst = +75.0??C)   ALARM
Temp3:     +43.0??C  (high = +80.0??C, hyst = +75.0??C)   ALARM
chassis:  Chassis is normal.

eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (172)

[root@ /usr/src/linux]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................


> 5) take the same memory module to the intel board
> 6) check again if the dumps are same (plz remove any other ram modules)

I'm sorry that the memory
PC1600R-20330		0446
HYMD264G726 B4M-H
512MB DDR 200MHZ ECC REG
can NOT be used on the intel motherboard, because this motherboard must use
dual channel DDR memory. So I can NOT finish the test 5) and 6)
RIOWORKS PDPLA0250000005
Intel Corp.82801CA/CAM SMBus Controller
Intel(R) XEON(TM) CPU 2.00GHz


Thanks
Best Regards
Chunhao


==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repea!
 t the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.
