From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0504071934580.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hello,

I think I have a solution (after some hours of work).

First how "continous reads works"- READ_BYTE. It is good for eeprom
reading, first you write to command register offset from which you want to
start reading and next you read and read and read data. (in READ_BYTE_DATA
mode you must write offset, get data, write offset+1, get data etc)

problem: it seems that for BYTE mode readings do not start at correct
	 location

The shift  by one byte we observed can be explained that we start reading
at offset FF instead of from 00 as requested.

Why after modprobe decoding of memory type works?

I concluded from docs I was wrong, the problem does not depend on "older
value of CMD".

It seems it depends on value of some other register.

it can be spotted right here:

size is I2C_SMBUS_BYTE!
size is HST_CNTL2_BYTE!
rw =3D I2C_SMBUS_WRITE!
Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A, DAT1=
=00
Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A, DAT1=00

This requests to read in I2C_SMBUS_BYTE from offset 0x40, offset 0x40 is
filled to CMD REG (even before transaction because it is done in access
routine)

Now what we got when reading first byte:

Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=1A, DAT1=
=00
Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=00, DAT1=00

Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=00, DAT1=
=00
Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0P, DAT1=00

Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0P, DAT1=00
Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0<, DAT1=00

In DAT0 are results so we get 00 50 3C...
But expected content is 80 00 00 00 ...

BUT if you take a look to the dump you can find this sequence at address
0x1A.  00 50 3c 50 30 20

And guess what were was the value 0x1A present?

Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A, DAT1=
=00

Yes it was in DAT0 register. So this ALI thing is putting the command not
to the CMD reg but it takes it from DAT0 register!!!!!!!!
(intel and others are putting command to cmd register)

So what we need now:

1) test the driver with following change:
           case HST_CNTL2_BYTE:
               dev_err(&a->dev, "size is HST_CNTL2_BYTE!\n");
                if (rw=3D I2C_SMBUS_WRITE)
                        outb_p(cmd, SMB_HST_CMD);

   and replace please last line with  outb_p(cmd, SMB_HST_DAT0);


   now you can run
   i2cdump 0 0x50
   i2cdump 0 0x50 c
   modprobe eeprom
   sensors
   modprobe w...
   sensors

   all should work now (please test also with your chip driver loaded as
   you reported in your previous email)

2) ask ALI if this is a bug or feature.
3) test the rest modes, WORD mode, please
   can you test (I dont know how the result should look like)

   i2cdump 0 0x50 w
   i2cdump 0 0x50 c

Regards

Rudolf

> [root@ ~]# i2cdump 0 0x51
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x51, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
> 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
> 20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
> 40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
