From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Sep 2009 09:25:56 +0000
Subject: Re: [lm-sensors] Intel DQ45CB motherboard - zero stats
Message-Id: <20090912112556.4fc4b4f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5a2e2c6e0909112349n7ec3a8f5m4c22af9dff02cd33@mail.gmail.com>
In-Reply-To: <5a2e2c6e0909112349n7ec3a8f5m4c22af9dff02cd33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 12 Sep 2009 12:15:33 +0300, Stefan Catruna wrote:
> Here are 2 consecutise "sensors" run:
>=20
> # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +73.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)  ALARM
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +68.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +69.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)  ALARM
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +71.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)  ALARM
>=20
> # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +72.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)  ALARM
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +67.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +67.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)  ALARM
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +70.0=B0C  (high =3D +74.0=B0C, crit =3D +100.0=B0C)  ALARM

This is odd. Rudolf, do you know why alarm flags are set while
temperatures are below the high limits?

> PS: lm-sensors was installed from repository
> # sensors -v
> sensors version 3.0.2 with libsensors version 3.0.2

Kernel version is useful as well.

> PPS: I'm having some problems with the temperature, it reached even 100

Not good. Maybe your fans aren't spinning fast enough? If you are doing
fan speed control, try without it for a moment.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
