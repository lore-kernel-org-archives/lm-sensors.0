From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 Mar 2013 17:24:22 +0000
Subject: Re: [lm-sensors] ITE8518 (Gigabyte U2442 Line)
Message-Id: <20130330172422.GB28035@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <51570D84.8020204@gmail.com>
In-Reply-To: <51570D84.8020204@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Mar 30, 2013 at 08:06:28PM +0400, dev.local wrote:
> Hi everyone.
>=20
Hi dev.local,

> Recent Gigabyte U2442V "ultrabook" is equipped with ITE8518, which
> is not listed under http://www.lm-sensors.org/wiki/Devices , so I
> suppose it's not supported and will not be supported in the near
> future.
>
Correct.

> After quick googling I was unable to find datasheets or any other
> information for ITE8518.
>=20
Unfortunately, ITE is very secretive about their chips, so it is difficult =
if
not impossible to get access to datasheets, and thus it is equally difficult
or impossible to write drivers.

> I am quite motivated to help with testing at least, because U2442V
> is too hot under linux without proper fan controls.
>=20
You are not the only one with this problem. However, I find that not even
speedfan supports this chip [1], meaning it looks like ITE is _really_
secretive about it. So I think you may be simply out of luck.

It might help if enough people create noise about this and similar problems,
but so far that has not happened. PC vendors still integrate ITE chips
into their systems, and people still buy those systems.

> Here's what 'sensors' usually show:
>=20
> # sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +50.1=B0C  (crit =3D +103.0=B0C)
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +51.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
> Core 0:         +47.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
> Core 1:         +49.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
>=20
> If someone would give me a reference point (e.g., similar supported
> chipset) I can also try to help with development.
>=20
For my part I have no idea if the chip even supports fan control or
hardware monitoring in the first place.

Guenter

[1] http://www.bugtrack.almico.com/view.php?id=3D2027

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
