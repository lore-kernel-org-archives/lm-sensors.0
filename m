From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 31 Mar 2006 10:27:09 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <20060331122709.45c81c66.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Dieter,

> I am using several Tyan Tiger 2460 motherboards since quite a while. And =
I am=20
> observing a strange behaviour someone in the list (might) have a clue abo=
ut.
>=20
> I am reading the sensors data periodically every 10 seconds. After an=20
> undefined time (maybe one week, maybe one day, maybe three weeks) sensors=
=20
> "hangs" after start and cannot be killed any more. A manual call to senso=
rs=20
> ends in a hang as well (of sensors, the board is running on).
>=20
> What is my configuration:
> I am loading=20
> MODULE_0=3Di2c-amd756
> MODULE_1=3Di2c-isa
> MODULE_2=3Dw83781d
> MODULE_3=EEprom
> MODULE_4=3Dw83627hf
> (in this sequence).
>=20
> By recommendation from Tyan I use the line:
> options w83781d force_w83782d=3D0,0x2d force_subclients=3D0,0x2d,0x48,0x4=
9=20
> force_w83627hf=3D0,0x2c force_subclients=3D0,0x2c,0x4a,0x4b init=3D0
>=20
> in /etc/modprobe.conf.local

This doesn't make much sense. You ask the w83781d driver to take care
of the W83627HF chip, but also load the w83627hf driver. Both drivers
will attempt to handle the same chip, this might explain the deadlock.

I'd suggest that you try without loading the w83627hf driver. If the
w83781d driver is able to handle both chips (the W83782D and the
W83627HF) then the w83627hf driver is not needed at all.

--=20
Jean Delvare

