From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 15 Aug 2007 17:22:03 +0000
Subject: Re: [lm-sensors] lm_sensors + max1668
Message-Id: <46C3363B.9070502@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAAD23.4060202@assembler.cz>
In-Reply-To: <46BAAD23.4060202@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi again,

Sorry for the delay, I'm quite busy with other stuff.

Hmm seems I forgot to CC him :/ Anyway here are both mails you send me in private:

> Hi Rudolf, thank's for your help;
> 
> I don't know how to CC as a reply to the same thread of the list..

Just reply to this mail, leaving all on CC.

> 
> sensors-detect now give me adresses 0x29 and 0x2a ;
> 
> Hurky:/# i2cdetect -l
> i2c-2	i2c	B2C2 FlexCop device
> i2c-1	smbus	SMBus nForce2 adapter at 5040
> i2c-0	smbus	SMBus nForce2 adapter at 5000
> 
> Hurky:/# i2cdump -y 0 0x29
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 1c 31 24 28 1e 80 00 00 7f c9 7f c9 7f c9 7f c9    ?1$(??..????????
> 10: 7f c9 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 20: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 30: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 40: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 50: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 60: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 70: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 80: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 90: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> a0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> b0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> c0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> d0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> e0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> f0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 4d 03    ??????????????M?
> 
> Hurky:/# i2cdump -y 0 0x2a
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 1b 36 7f 7f 2f 98 14 00 7f c9 7f c9 7f c9 7f c9    ?6??/??.????????
> 10: 7f c9 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 20: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 30: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 40: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 50: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 60: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 70: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 80: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> 90: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> a0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> b0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> c0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> d0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> e0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03    ????????????????
> f0: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 4d 03    ??????????????M?
> 
> Regards, Hurky.
> 

And the second one:

> Hi again, yesterday I think my SMBus get corrupted, I redetected the
> Maxims con 0x18 and 0x19 with the folowing dumps:
> 
> Thanks !
> 
> Hurky:/home/hurky# i2cdump -y 0 0x18
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 1d 33 25 29 1f 80 00 00 7f c9 7f c9 7f c9 7f c9    ?3%)??..????????
> 10: 7f c9 03 03 03 03 03 03 03 03 03 03 03 03 XX XX    ??????????????XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> Hurky:/home/hurky# i2cdump -y 0 0x19
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 1c 37 7f 7f 30 98 14 00 7f c9 7f c9 7f c9 7f c9    ?7??0??.????????
> 10: 7f c9 03 03 03 03 03 03 03 03 03 03 03 03 XX XX    ??????????????XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

So I dont know what could possibly do the address shift by one? Are you sure
that bus electrical condition is OK? Have you possibility to measure the bus
with oscilloscope to check the signal integrity?

It seems the bus will lock after a while and this is the reason why the driver
does not detect the chip. The chip ID should be at offset 0xff and 0xfe.

Have you any chance to use some parallel port adapter? Like one described in the
Documentation/i2c/busses/i2c-parport driver?

Maybe it would be worth to try out with the adapter first.

Rudolf


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwzY73J9wPJqZRNURAqlOAKDAyLAug9PyMKafN3E41hc4kPTuuACfXe2E
1+KR0O7IvBVdyggsbt1bdIk=PAPO
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
