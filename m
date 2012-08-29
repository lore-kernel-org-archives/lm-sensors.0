From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Aug 2012 16:47:38 +0000
Subject: Re: [lm-sensors] Patching help
Message-Id: <20120829184738.59888825@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
In-Reply-To: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Simon,

On Wed, 29 Aug 2012 13:53:05 +0100, Simon Tims wrote:
> I've spent many hours reading up on patching lm-sensors but I'm either
> looking in the wrong place, mis-understanding the patch command, or a
> combination!

lm-sensors should rarely need any patching of any kind these days.
Hardware support is in the kernel, so if anything you likely need to
patch your kernel, or a modified standalone driver (easier.)

> uname -a reports:
> 3.2.0-29-generic-pae #46-Ubuntu SMP Fri Jul 27 17:25:43 UTC 2012 i686
> athlon i386 GNU/Linux
>=20
> This is an HP Proliant Microserver N40L.  There are a few threads about
> this hardware and I see people have got sensors working properly on this
> machine, but I can't find how to patch the software correctly.

Presumably you refer to:
http://marc.info/?l=3Dlinux-i2c&m=3D133033220527043&w=3D2
(At least I think this is the latest version of the patch... Not sure.)

> Here's my sensors-detect:
>=20
> # sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
> # System: HP ProLiant MicroServer
> (...)
> Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x18
> Handled by driver `jc42' (already loaded), chip type `jc42'
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No

I suppose this is without the patch, otherwise you'd have more SMBus
channels listed.

> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `jc42':
>   * Bus `SMBus PIIX4 adapter at 0b00'
>     Busdriver `i2c_piix4', I2C address 0x18
>     Chip `jc42' (confidence: 6)

This is the thermal sensor chip on your DDR3 SDRAM memory module.

>=20
> Driver `to-be-written':
>   * ISA bus
>     Chip `IPMI BMC KCS' (confidence: 8)

Means you may be able to get monitoring information with ipmitool
instead of sensors. If your system has a BMC, that is.

> (...)
> Here's the output of sensors:
>=20
> jc42-i2c-0-18
> Adapter: SMBus PIIX4 adapter at 0b00
> temp1:        +30.5=B0C  (low  =3D  +0.0=B0C)                  ALARM (HIG=
H, CRIT)
>                        (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +31.5=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +100.0=B0C, hyst =3D +95.0=B0C)
>=20
>=20
> With help from Eddi De Pieri I got to this post:
>=20
> http://www.spinics.net/lists/linux-i2c/msg07284.html
>=20
> but I can't establish the exact process.  I was able to download the new
> sensors-detect binary, set it executable and run it.  I get these results:

You shouldn't need any modification to sensors-detect, the ProLiant
MicroServer issue is related to SMBus multiplexing, this is handled in
the kernel. Plus this version of sensors-detect includes Gentoo-specific
changes, so it's no surprise you get errors on Ubuntu.

> The threads I've read seem to mention patching an i2c driver, which I can=
't
> find on my system.

The driver is i2c-piix4. On your system it should be at:
/lib/modules/3.2.0-29-generic-pae/kernel/drivers/i2c/busses/i2c-piix4.ko

If not, it means that the driver is built into a kernel rather than as
a module. You can check with:
$ zgrep I2C_PIIX4 /proc/config.gz
"=3Dm" means module, "=3Dy" means built-in.

> Can anyone tell me exactly what process I need to follow?  Or where I
> should ask if this list is the wrong place?

If i2c-piix4 is built into your kernel as you seem to imply, then you
can't replace it with a standalone driver, meaning the easy path isn't
possible. You need to patch the kernel tree and rebuild the kernel,
which isn't an easy process for the non-initiate.

I hope to find some time to finally review the patch in question so
that it can get upstream and things just work for users out of the box.
But I am just back from vacation with a lot of stuff in my mailbox so
it will take some time before I get there.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
