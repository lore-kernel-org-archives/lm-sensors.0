From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1833
Message-Id: <Pine.LNX.4.58.0412061330430.10292@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> We could probably take a guess if you would provide dumps for all three
> chips:
> isadump 0x295 0x296 (assuming that the Super-I/O chip is at 0x290)
> i2cdump 0 0x2c
> i2cdump 0 0x2f
The i2c address 0x2c is an alias for the super IO sensor that
is found at ISA 0x0290 and is detected on the scan of the ISA 
bus as well as the scan for super IO/sensors.  Those numbers 
track exactly as I make the machine hotter and colder.
It's the one at 0x2f which is the mystery chip.

Another examination of the file AllSuperD.ini which
comes from Supermicro shows me that this chip is indeed a 
W83792D chip.  Their .ini file says that, and also 
gives me the offsets of which signal is where.

How do I correlate that to what the w83781d driver thinks is 
on a w83781d chip... i.e., how do I translate in0-in6 to their
appropriate offsets?

In particular, the two fans I am interested in show up 
as fan2 and fan3 at offset 29 and 2a respectively.  I have the information
for what every offset of this chip means.  Does that do me any good?

Steve Timm


[root@fnpt126 etc]# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and 
worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 5e d4 d5 c0 cc 26 a4 20 ff ff ff 00 00 00 00 d8
30: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00
40: 01 04 10 00 00 00 00 5f 2c 03 01 44 40 95 00 a3
50: ff ff 00 ff ff ff 00 00 21 70 ff ff 11 00 ff 05
60: 5e d4 d5 c0 cc 26 a4 20 ff ff ff 00 00 00 00 d8
70: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 5e d4 d5 c0 cc 26 a4 20 ff ff ff 00 00 00 00 d8
b0: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00
c0: 01 00 00 00 00 00 00 5f 2c 03 01 44 40 95 00 a3
d0: ff ff 00 ff ff ff 00 00 21 70 ff ff 11 00 ff 05
e0: 5e d4 d5 c0 cc 26 a4 20 ff ff ff 00 00 00 00 d8
f0: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00
[root@fnpt126 etc]# i2cdump 0 0x2c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2c, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 5c d3 d6 c1 cd 25 a3 20 ff ff ff 00 00 00 00 d8    \????%? .......?
30: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00    ?????1?;1P.?z?..
40: 01 00 10 00 00 00 00 5f 2c 03 01 44 40 95 00 a3    ?.?...._,??D@?.?
50: ff ff 00 ff ff ff 00 00 21 70 ff ff 11 00 ff 05    ........!p..?..?
60: 5e d4 d6 c1 cb 24 a5 20 ff ff ff 00 00 00 00 d8    ^????$? .......?
70: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00    ?????1?;1P.?z?..
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 5c d4 d6 c1 ce 26 a4 20 ff ff ff 00 00 00 00 d8    \????&? .......?
b0: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00    ?????1?;1P.?z?..
c0: 01 00 10 00 00 00 00 5f 2c 03 01 44 40 95 00 a3    ?.?...._,??D@?.?
d0: ff ff 00 ff ff ff 00 00 21 70 ff ff 11 00 ff 05    ........!p..?..?
e0: 5e d3 d7 c1 cd 25 a3 20 ff ff ff 00 00 00 00 d8    ^????%? .......?
f0: c4 c3 b0 d9 b2 31 15 3b 31 50 00 c7 7a 11 00 00    ?????1?;1P.?z?..

[root@fnpt126 etc]# i2cdump 0 0x2f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2f, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 93 00 00 53 00 ff 00 00 05 00 00 b3    ..dd?..S....?..?
20: a6 a6 51 4e 4a 9e d4 2f ff 7b 7f c6 94 c6 94 d8    ??QNJ??/.{??????
30: c4 c3 b0 cf bb e2 cc da c5 7f 00 ed ed ed a4 a8    ??????????.?????
40: 01 00 00 00 00 ff ff 11 2f 13 73 c4 4d ff 80 5c    ?......?/?s?M.?\
50: ff ff ff ff ff ff ff ff 7a 60 ff 11 bb 00 05 7f    ........z`.??.??
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 8f 01 8f 00 00 00 00 11 11 ff ff 3c 3c 0a 0a    ????....??..<<??
90: 00 00 00 01 8f ff 00 00 11 ff 3c e0 00 01 01 ff    ...??...?.<?.??.
a0: 01 01 01 8f 8f 8f 8f ff 48 20 0f e0 ff ff 00 00    ???????.H ??....
b0: d2 00 ff ff ff 00 ff 00 ff ff ff ed ed ed ff ff    ?..........???..
c0: 2a 00 00 44 00 4e 00 ff 31 00 00 44 00 4e 00 ff    *..D.N..1..D.N..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
f0: ff ff 00 ff 00 01 00 20 ff 02 ff 00 00 00 00 ff    .....?. .?......





> 
> One of the I2C chips is obviously an "alias" of the Super-I/O chip, this
> should help find out which actually is.
> 
> The W83792D sounds much more credible to me. Again without a datasheet
> we cannot confirm. However, Winbond themselves are working on a driver,
> and said they would release a datasheet soon. Let's just wait until they
> are done.
> 
> Stay tuned! :)
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/
> 
