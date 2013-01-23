From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Jan 2013 08:31:35 +0000
Subject: Re: [lm-sensors] Issue on ASUS Sabertooth 990FX
Message-Id: <20130123093135.36b84b43@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50FF51C2.4000507@sbcglobal.net>
In-Reply-To: <50FF51C2.4000507@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Carl,

On Tue, 22 Jan 2013 21:58:10 -0500, Carl Seutter wrote:
> Hi all,
> I have an ASUS Sabertooth 990FX motherboard with bios version 1604.
>=20
> I'm running OpenSuSe 12.1 with the 3.1.10 kernel, sensors 3.3, and I=20
> downloaded the standalone driver from=20
> http://khali.linux-fr.org/devel/misc/it87/ as it indicated it supported=20
> 5 fans.

Up to 5 fans. The actual count depends on the chip configuration, which
itself depends on how the chip is wired on the board.

> I'm seeing some incorrect results when running sensors for the number of =

> fans and temperatures:
>=20
> # ./sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:         +8.5=B0C  (high =3D +70.0=B0C)
>                         (crit =3D +90.0=B0C, hyst =3D +87.0=B0C)
>=20
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:       32.24 W  (crit =3D 124.77 W)
>=20
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +2.82 V  (min =3D  +2.32 V, max =3D  +1.51 V)  ALARM
> in1:          +2.80 V  (min =3D  +1.68 V, max =3D  +0.24 V)  ALARM
> in2:          +0.88 V  (min =3D  +0.42 V, max =3D  +1.85 V)
> +3.3V:        +3.31 V  (min =3D  +2.38 V, max =3D  +1.82 V)  ALARM
> in4:          +1.16 V  (min =3D  +0.89 V, max =3D  +0.36 V)  ALARM
> in5:          +2.51 V  (min =3D  +1.72 V, max =3D  +2.08 V)  ALARM
> in6:          +1.73 V  (min =3D  +1.64 V, max =3D  +0.44 V)  ALARM
> 3VSB:         +0.29 V  (min =3D  +2.02 V, max =3D  +4.90 V)  ALARM
> Vbat:         +3.34 V
> fan1:        2156 RPM  (min =3D   17 RPM)
> fan2:           0 RPM  (min =3D  327 RPM)  ALARM
> fan3:         722 RPM  (min =3D   13 RPM)
> temp1:        +31.0=B0C  (low  =3D +43.0=B0C, high =3D +44.0=B0C)  sensor=
 =3D thermistor
> temp2:        +29.0=B0C  (low  =3D +10.0=B0C, high =3D -66.0=B0C)  sensor=
 =3D thermistor
> temp3:       -128.0=B0C  (low  =3D -117.0=B0C, high =3D +71.0=B0C)  senso=
r =3D disabled
> intrusion0:  OK
>=20
>=20
> My motherboard has a total of 6 fan connections, 4 of which actually=20
> have fans attached.  The BIOS shows all 6 connections but as you can=20
> see, only 3 are being reported.

The IT8721F chip can only monitor up to 5 fans simultaneously. So
either there is another monitoring chip on the board, or there is some
pin multiplexing taking place.

> Additionally, my motherboard is=20
> supposed to have 10 sensors for monitoring temperatures.  I know the=20
> it87 driver only measures 3, and temp3 doesn't look right.  Maybe it's=20
> showing -128 because it's disabled?

Yes, -128 is because it is disabled. The missing 8 temperature values
again suggest an extra monitoring chip is present.

> While trying to figure out why I was only seeing 3 fans I discovered this:
>=20
> #rmmod it87
> # ./isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss and wor=
se!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 02 fb 00 00 00 00 00 00 80 58 0f 07 44 ff a3
> 10: 0b 0a 61 77 c7 80 00 00 01 ff 03 99 08 c0 c0 c0
> 20: eb e9 60 8a 61 d1 90 0c 8b 1f 1e 80 80 30 3d 3d
> 30: 7e c1 14 8c 9a 23 4c 63 1e 4a ad 8f 25 89 cc 54
> 40: 2c 2b be 0a 47 8b 5f 40 ad 6a d4 00 ff ff ff ff
> 50: 2f 18 7f 7f 7f 40 00 00 90 00 37 12 60 00 00 00
> 60: 80 14 46 0c a0 41 00 ff 7f 7f 7f 80 00 00 00 ff
> 70: 80 00 7f ff 00 41 00 ff ff ff ff ff ff ff ff ff
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 0d 02 51
> 90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff
> a0: 11 87 87 87 87 87 87 ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>=20
> In looking at 80-87 are all showing 00, maybe that explains why sensors=20
> is only showing fans1-3.

The 00s here are the result of fan4 and fan5 being disabled in
configuration register 0Ch: bits 4 and 5 are 0.

If you want, you can try the following commands to forcibly enable fan4
and fan5:

# rmmod it87
# isaset 0x295 0x296 0x0c 0x37
# insmod it87.ko

But honestly I doubt it will help. You can return to the original
configuration with:

# rmmod it87
# isaset 0x295 0x296 0x0c 0x07
# insmod it87.ko

> When I insert module it87:
>=20
> # modprobe it87
> it87: Found IT8721F chip at 0x290, revision 1
>=20
> Maybe the revision makes a difference?

I don't have a datasheet for this exact revision, only for revision 3.
But I doubt it is relevant here.

> Here is the output from sensors-detect:
> # ./sensors-detect
> # sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
> # Board: ASUSTeK COMPUTER INC. SABERTOOTH 990FX
> (...)
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc=20
> SB600/SB700/SB800 SMBus
> Module i2c-dev loaded successfully.

What you actually have is an SB950 chip. We do not have explicit SMBus
support for that south bridge. Unfortunately the datasheet isn't
available for download from AMD's site. Our code will assume 100%
compatibility with the SB800, which may or may not be correct.

Recent AMD south bridges have extra SMBus channels. We started adding
support for these in kernel 3.6 but this is still work in progress for
the SB800 and later. Please check the revision of PCI device
0000:00:14.0 for confirmation, I suppose it is >=3D 40.

So you may need the multiplexing code discussed here:
http://marc.info/?t=3D132225900800002&r=3D1&w=3D2
which unfortunately never made it upstream.

A completely different approach would be to use the asus_atk0110
driver instead of the it87 driver, if your board's BIOS implements the
ACPI interface used by the asus_atk0110 driver.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
