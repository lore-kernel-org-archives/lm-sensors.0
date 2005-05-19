From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040912104609.6ab694af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Got it working with "modprobe w83781d force_w83781d=9191,0x290".  I
> guess the "force" alone tried something different.  Not sure if this
> problem is solvable.  If it is, great.  If not, the workaround as
> explained in the docs could be further elaborated.

"force" skips detection (basically checking if there is a chip at 0x290
or not) while force_w83781d additionally skips identification (basically
checking if the chip is a Winbond W83781D or not). Both steps are
failing for you, probably for the same reason (BIOS messing with the
registers).

> It's mentioned in the docs (
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d )
> that the chip gets misidentified.  However my chip was detected, is
> that the same as identified?  Also, the docs says:
>=20
>     (modprobe w83781d force_CHIP=3DBUS,0x2d where CHIP is the chip name
>     and BUS is your i2c bus number -
>     cat /proc/bus/i2c to see a list of bus numbers)
>=20
> But I have no /proc/bus/i2c (file or directory).

This is for 2.4 kernels.

> I can't find the
> corresponding data in /sys , either because I don't know where to
> look, or it's just not there.

There is no file in /sys. Instead you can use "i2cdetect -l" (which
happens to also work for 2.4 kernels).

> I suggest an update to add a note
> explaining how to get the right bus number in kernel 2.4 and 2.6.=20

Most (if not all) of the docs in the lm_sensors2 CVS repository are
targeted at 2.4 kernels. The reason is both historical (obviously) and
technical (2.6 drivers are not part of the package).

But I agree that updating the docs as time permits would be great.
Another approach would be to add chip documentation to the 2.6 kernel.

> Additionally make a clearer distinction between ISA bus/address and
> I2C bus/address and list typical numbers for this device: ISA bus 9191
> / address 0x290 and I2C bus 0 or 1 / address 0x2d.  Also helpful would
> be both the modprobe syntax (as shown) and the modules.conf syntax.
>=20
> # Mail client won't let me enter tabs.
>=20
> <DOC_begin>
>=20
> W8378* PROBLEMS
> -----------------
> Known problems:
>         - Some chips are misidentified even if successfully detected.
>           This is caused by the chip having the wrong WCHIPID register
>           value, so there is no fix. The workaround is to use the
>           force_CHIP parameter.
>=20
>     modprobe format:
>=20
>         modprobe w83781d force_CHIP=3DBUS,ADDR
>=20
>     modules.conf format:
>=20
>         options w83781d force_CHIP=3DBUS,ADDR
>=20
>     Example values, comma separated, use only one, use only ISA or
>     I2C:
>=20
>         CHIP    : w83781d
>         I2C BUS : 0, 1

This can be about any value, depending on the other devices in the
system. On my system, the hardware monitoring bus is 4 (0 to 3 are
occupied by my Radeon graphics adapter).

>         I2C ADDR: 0x2d
>         ISA BUS : 9191
>         ISA ADDR: 0x290
>=20
>     Find your specific bus:
>=20
>         kernel 2.4 I2C: cat /proc/bus/i2c
>         kernel 2.4 ISA: ???
>         kernel 2.6 I2C: ???
>         kernel 2.6 ISA: ???

Irrelevant for ISA, bus is always 9191.

For 2.6 I2C, "i2cdetect -l" (which also works for 2.4).

>     Find your specific address:
>=20
>         kernel 2.4 I2C: ???
>         kernel 2.4 ISA: ???
>         kernel 2.6 I2C: ???
>         kernel 2.6 ISA: ???

Always 0x290 for ISA, there is no way to detect it if a different value
is.

For I2C, "i2cdetect <BUS NUMBER>" should help, although I never saw a
W83781D at a non-0x2d address.

>=20
>     See "Addresses scanned" sections under "Supported chips" above.
>=20
> </DOC_end>

Care to provide this documentation update as a patch we could apply to
the CVS repository? Thanks.

(BTW, I cannot possibly connect to the CVS repository for now, so
someone else will have to apply the patch.)

As for me, I will propose my extra-debug patch (slightly cleaned up) for
inclusion into the 2.6 kernel. It helped us once, so it could prove to
be valuable in the future as well.

Thanks again.

--=20
Jean "Khali" Delvare
http://khali.linux-fr.org/
