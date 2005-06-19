From: chris@ripptech.com (Chris Ripp)
Date: Sun, 19 Jun 2005 23:06:40 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <42B5DE4F.4020606@ripptech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>>able ~ # i2cdump 0 0x48
>>    
>>
>
>Have you also Kryten ?
>
>  
>
>>I will have to recompile for this, and can't do it right now, when I get
>>there I'll reply about this section...
>>    
>>
>
>Hmm it seems like lm75 compatible chip
>Please prepare lm75 driver too.
>
>To have all data do our puzzle, I would like to ask you also for:
>
>i2cdump 0 0x2f
>
>  
>

able ~ # i2cdump 0 0x2f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x2f, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 8a 00 00 01 00 00 ff    .........?..?...
10: 00 00 7f 00 00 10 00 00 00 00 00 00 00 00 00 fc    ..?..?.........?
20: 1d 09 1a bc 09 09 09 7c ff ff ff 7e 68 00 00 ed    ???????|...~h..?
30: b0 00 08 10 10 20 10 58 b5 00 20 00 00 20 ff ff    ?.??? ?X?. .. ..
40: 01 ff 2f 00 00 00 00 50 2f 10 01 44 01 95 80 5c    ?./....P/??D???\
50: ff ff ff ff ff ff 00 80 72 70 ff 00 00 00 05 ff    .......?rp....?.
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a    ?.?.....????<<??
90: 00 00 00 01 ff 00 00 00 01 01 3c 18 00 00 01 01    ...?....??<?..??
a0: ff ff ff 00 00 00 00 00 1a ff 2f 18 00 ff ff ff    ........?./?....
b0: bb 04 09 ff 40 00 00 40 20 00 ff ff 1b 01 ff ff    ???.@..@ ...??..
c0: 7c 00 00 4b 00 50 00 ff 7c 00 00 4b 00 50 00 ff    |..K.P..|..K.P..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff 00 ff 00 01 00 ff ff 02 ff 00 00 07 ff 1d    .....?...?...?.?
able ~ #

sensors-detect has claimed to have found an lm75 before, but I never
could get anything out of that, I just figured it was a false positive....

I will let you know what happens when I can get around to recompiling


