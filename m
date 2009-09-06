From: Karl Schmidt <karl@xtronics.com>
Date: Sun, 06 Sep 2009 18:28:04 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <4AA3FF34.10709@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Karl,
>=20
> On Sat, 05 Sep 2009 17:03:40 -0500, Karl Schmidt wrote:
>> No size specified (using byte-data access)
>> WARNING! This program can confuse your I2C bus, cause data loss and wors=
e!
>> I will probe file /dev/i2c-1, address 0x2e, mode byte
>> Continue? [Y/n] y
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff    ................
>> 20: 64 79 c3 c3 c1 24 1a 17 b2 02 95 02 aa 02 ab 02    dy???$??????????
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 5c 89    ..............\?
>> 40: 05 00 00 00 00 4d 00 ff 00 ff 00 ff 00 ff 81 7f    ?....M........??
>> 50: 81 7f 81 7f a3 02 58 02 ff ff ff ff 02 02 02 a7    ??????X?....????
>> 60: a7 a7 e0 00 00 00 00 2d 2d 2d 64 64 64 44 40 00    ???....---dddD@.
>> 70: 00 00 00 09 09 09 09 09 09 00 30 00 40 00 00 1c    ...??????.0.@..?
>> 80: 00 a4 00 00 44 2a 86 c3 0d 00 4d 4d 0b 0b 0c 00    .?..D*???.MM???.
>> 90: cc cc cc cc 0c 0c 0c 5a f1 c0 ae 00 ff 00 ff 00    ???????Z???.....
>> a0: 00 00 0c 00 00 00 00 0b 0b fe ff fe ff ff ff ff    ..?....???.?....
>> b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>=20
> I have just checked the DME1737 datasheet. This chip doesn't have
> real-time status registers but interrupt status registers. In these
> registers, each bit can be enabled or disabled individually. If
> interrupts are globally enabled, this lets the vendor decide which
> events should trigger an interrupt.
>=20
> The interrupt enable registers are at 0x7E, 0x80 and 0x82. As you can
> see, you have only zeroes in these registers, meaning that all
> interrupts are disabled. This is why you don't see any alarm flag.
> According to the datasheet, this isn't the default value. So this
> suggests your mainboard vendor willingly disabled all the individual
> interrupt bits.
>=20
> The global interrupt enable flag is also disabled (register 0x7c bit
> 2), which is the default. This makes me wonder why the vendor disabled
> the individual bits, given that they wouldn't trigger any interrupt
> anyway.

Strange - I dug up a new BIOS I can put in the unit - I need to be physical=
ly there to do it.. may=20
be a few days.

>=20
> Then we may also discuss whether it is desirable to enable individual
> interrupt bits when the rest of the configuration is such that physical
> interrupts will never trigger anyway. If both the global interrupt bit
> and the group enable bits are clear, this should be safe as far as I
> can see. This would let users see the alarm flags even when the BIOS
> disabled them without a good reason. What do you think?
>=20
> Karl, I suggest that you go check the BIOS options of your system.
> Maybe there are ways to enable or disable an action (such as beeping or
> thermal throttling) on some hardware monitoring events? This might
> explain what we're seeing. If there are such options, please toggle
> them, check whether this gives your alarms in "sensors", and provide a
> new i2c dump for each relevant combination.
>=20
> If you can't find any such option, and want your alarm flags to raise,
> here is how you can do that on your system:
>=20
> # modprobe i2c-dev
> # rmmod dme1737
> # i2cset -y 0 0x2e 0x7e 0xec
> # i2cset -y 0 0x2e 0x80 0x7e
> # i2cset -y 0 0x2e 0x82 0x0e
> # modprobe dme1737
>=20
> This will restore the interrupt bits to what the datasheet lists as
> the default. I expect this to let you see alarm flags on out-of-limits
> conditions again.
>=20

OK - this is what I did in the mean time - just to test:
---------------------------------
# modprobe i2c-dev
root@kiwi:~# rmmod dme1737
root@kiwi:~# i2cset -y 0 0x2e 0x7e 0xec
No size specified (using byte-data access)
Value 0xec written, readback matched
root@kiwi:~# i2cset -y 0 0x2e 0x80 0x7e
No size specified (using byte-data access)
Value 0x7e written, readback matched
root@kiwi:~# i2cset -y 0 0x2e 0x82 0x0e
No size specified (using byte-data access)
Value 0x0e written, readback matched
root@kiwi:~# modprobe dme1737 ignore=3D1,0x2e

# sensors
k8temp-pci-00c3
Adapter: PCI adapter
temp1:       +20.0=B0C

dme1737-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
in0:         +2.61 V  (min =3D  +0.00 V, max =3D  +2.00 V)   ALARM
in1:         +1.43 V  (min =3D  +0.00 V, max =3D  +2.99 V)
in2:         +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)
in3:         +5.10 V  (min =3D  +0.00 V, max =3D  +6.64 V)
in4:        +12.09 V  (min =3D  +0.00 V, max =3D +15.94 V)
in5:         +3.30 V  (min =3D  +0.00 V, max =3D  +4.38 V)
in6:         +3.00 V  (min =3D  +0.00 V, max =3D  +4.38 V)
fan1:       7826 RPM  (min =3D 8000 RPM)
fan2:       8157 RPM  (min =3D 9000 RPM)
fan3:       7929 RPM  (min =3D    0 RPM)
fan4:       7894 RPM  (min =3D    0 RPM)
temp1:       +36.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
temp2:       +26.3=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
temp3:       +22.9=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
cpu0_vid:   +1.550 V
----------------------------------------

I did get the voltage alarm that is set! But sadly still no fan alarms, but=
 you are obviously on the=20
correct track.

I will the latest BIOS in and retest - In the BIOS change-logs.. I have ver=
sion 3.00

There are these changes:
* Adjusted CPU temperature readings
* Changed the routing for the SMDC card to IRQ4
* Updated AMD PowerNOW! functionality

http://www.tyan.com/support_download_bios.aspx?model=3DS.S2865

I bet this will fix things -- will let you know and supply a config with BI=
OS comments etc..
I will also check that PNPOS is set to off - see if there are any sensor se=
ttings etc.. Anyother=20
BIOS settings to look for ?


Thanks again..




---------------------------------------------------------------------------=
-----
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

42.7% of all statistics are made up on the spot.

---------------------------------------------------------------------------=
-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
