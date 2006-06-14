From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Wed, 14 Jun 2006 04:33:27 +0000
Subject: [lm-sensors] Using lm_sensors for accessing SMSC EMC6W201
Message-Id: <448F9197.1020100@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613191611.80065.qmail@web81614.mail.mud.yahoo.com>
In-Reply-To: <20060613191611.80065.qmail@web81614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ric Johnson wrote:

>There is no URL as GBT sent the Datasheet to me. It is PDF. I can send it but
>do not have a web server at this time so cannot post it.
>  
>
It would *really* help if we could see the datasheet.  How big is it?

>The DS says the "default slave adddress is 0101110b" and GBT told me they
>"followed SMSC recommendations" ... 
>There is a table showing 
> "SMBUS Address[7:1] " as 0101 110b which is suppose is the same as 101110
>binary or 2E hex.  
>  
>
Yes, that's the default address.

>i2cdetect -l  returns nothing.  I am not sure why since lsmod has quite a few
>"i2c*" items in it while sensors is running.
>  
>
Perhaps that's a bug with i2cdetect...  We can follow up on that problem 
later.

>#> i2cdetect 0
>WARNING! This program can confuse your I2C bus, cause data loss and worse!
>I will probe file /dev/i2c-0.
>I will probe address range 0x03-0x77.
>Continue? [Y/n]
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
>10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>50: XX XX UU UU XX XX UU UU XX XX XX XX XX XX XX XX
>60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>70: XX XX XX XX XX XX XX XX
>
>  
>
No, that's probably just your memory DIMM's (at 52, 53, 56, 67) (do you 
have 4 DIMM's installed?)  Not sure what might be at address 0x08...

>I have run i2cdump 0 0x2e but the results are only "XX". Perhaps that is that
>wrong command parameter/address ...
>  
>
That's because there is no device at address 0x2e on bus 0.  Note the XX 
in square 20 x e in the output above.

>Since it *looks* like i2c-1 is where all the easter eggs are hidden, I did a
>dump and got all kinds of stuff:
>  
>
Perfect, the output from 'i2cdetect -l' would have listed what busses 
you have and we would have gotten around to asking you to 'i2cdetect 1' 
and so on, but you've figured that out for yourself.  Excellent...

>#> i2cdump 1 0x2e
>No size specified (using byte-data access)
>WARNING! This program can confuse your I2C bus, cause data loss and worse!
>I will probe file /dev/i2c-1, address 0x2e, mode byte
>Continue? [Y/n]
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>20: c8 b0 bb 64 c0 b3 2d 17 31 1b 16 22 c4 0c 37 0e    ???d??-?1??"??7?
>30: 52 0e 40 0d 1a 07 80 80 80 00 00 00 00 00 5c b1    R?@??????.....\?
>40: 05 00 00 00 00 00 00 00 3e 00 00 ff 00 ff 00 ff    ?.......>.......
>50: 00 ff 00 ff 00 ff 81 7f 81 7f 81 7f 81 7f 81 7f    ......??????????
>60: 81 7f ff ff ff ff ff ff ff ff ff ff 00 00 00 ff    ??..............
>70: 00 ff 00 ff 00 ff 00 ff 00 ff fc 3e 7e 00 00 00    ..........?>~...
>80: e2 e2 e2 99 90 cc cc cc 00 00 80 80 80 00 00 00    ????????..???...
>90: 23 23 23 23 23 23 64 64 64 64 64 64 44 44 44 94    ######ddddddDDD?
>a0: 00 40 80 00 04 04 04 04 2c 2c 2c 00 0a 00 2d 2d    .@?.????,,,.?.--
>b0: 2d 2d 2d 2d 00 00 00 00 a0 00 05 25 12 ff ff 00    ----....?.?%?...
>c0: 00 00 00 00 7f 7f 7f 7f 7f 7f c0 00 00 00 00 00    ....???????.....
>d0: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
>e0: 00 00 c0 8a 68 00 20 00 1c 00 00 00 00 00 00 00    ..??h. .?.......
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>It's 22:24:24 CDT (UTC-0500) on Tue Jun 13, week 24 in 2006.
>
>OF course, that might be an eeprom or something.
>
No, that's probably your chip.  Go ahead and try i2cdump on one of your 
eeproms 'i2cdump 0 0x52' and you'll see that the output is very different.

>Any ideas?
>
>  
>
Yes, but without the data sheet it's just speculation...

I would say that you appear to have 6 voltage sensors (0x20-25), and 6 
temperature sensors (as you said previously, 0x26-2b).  I'm going to 
guess that you have five (5) 16-bit fan speed sensors (0x2c-35).

The device ID signature registers are probably 0x3e (value 0x5c) and 
0x3f (value 0xb1)

The min/max limits for the voltages probably start at 0x4a through 
0x55.  Then the limits for the temperatures (0x56-0x61) and fan speeds 
(0x62-0x6b).

I would guess that the rest of the registers are perhaps fan speed 
control or some other features on the chip.  Hopefully they are 
described in the datasheet.

If that's correct, then we just need to know what the scaling values are 
for the voltages and the fan speed equation.  And your temperatures are:

2d  =  45 degC
17  =  23 degC
31  =  49 degC
1b  =  27 degC
16  =  22 degC
22  =  34 degC

If that's right, the temperatures appear to be rather low.  Do you have this machine in a cooled computer room?


Thanks,
:v)

