From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Jan 2010 14:37:47 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <20100113153747.1dab14c5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 13 Jan 2010 15:20:57 +0100, Manuel Lamotte-Schubert wrote:
> Hi all,
>=20
> I have an ZOTAC ION ITX-B mainboard.
> (http://pden.zotac.com/index.php?page=3Dshop.product_details&flypage=3Dfl=
ypage_images.tpl&product_id=168&category_id=15&option=3Dcom_virtuemart&Item=
id=3D1)
>=20
> I'm running Debian Lenny stable, having lm-sensors installed, Version:=20
> 1:3.0.2-1+b2.
> The kernel version is 2.6.32, self-compiled
>=20
> Here's some output I get:
> # lspci
> ...
> 00:03.2 SMBus: nVidia Corporation Device 0aa2 (rev b1)
> ...
>=20
> # sensors-detect
> ...
> Found unknown SMBus adapter 10de:0aa2 at 0000:00:03.2.
> ...

A more recent version of sensors-detect (lm-sensors 3.1.0 or later)
would not show this message. Anyway, as long as the kernel itself knows
about the device (and this is your case) it doesn't really matter.

> # lspci -vv -s 00:03.2
> 00:03.2 SMBus: nVidia Corporation Device 0aa2 (rev b1)
>         Subsystem: Device 19da:a108
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=20
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 4900 [sized]
>         Region 4: I/O ports at 4d00 [sized]
>         Region 5: I/O ports at 4e00 [sized]
>         Capabilities: [44] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>         Kernel driver in use: nForce2_smbus
>         Kernel modules: i2c-nforce2

The i2c-nforce2 is used for the device, so it's OK.

>=20
> # i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
> 50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>=20
> Any help would be appreciated, maybe I can help supporting it!

You did not tell us which I2C/SMBus adapter i2c-0 was. But seeing the
chips at 0x50-0x57, I would guess this is your graphics adapter, rather
than the SMBus (unless you have 8 memory modules, but I wouldn't expect
that on any Zotac product.) The chip at 0x4c could be a temperature
monitoring chip, we'd need a dump to tell. But first just try a more
recent version of sensors-detect:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

And report the full output.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
