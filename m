From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 17:20:20 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <20081216182020.43411649@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 16 Dec 2008 09:08:12 -0800, Chuan-kai Lin wrote:
> On Tue, Dec 16, 2008 at 02:26:08PM +0100, Jean Delvare wrote:
> > Please provide a dump of your F8000 chip:
>=20
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff 03 40 00 ff ff ff ff ff ff c1 00 55 4c 00 ff=20
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> 20: d2 d2 ca ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> 50: ff ff ff ff ff ff ff ff ff ff 05 08 10 19 34 ff=20
> 60: 00 00 00 ff ff ff 00 01 65 ff ff ff ff ff ff 00=20
> 70: 22 ff 08 ff 2b ff ff ff ff ff ff ff ff ff ff ff=20
> 80: 46 3c 64 55 64 55 ff ff ff ff ff ff ff ff 2a ff=20
> 90: 00 04 04 00 2a ff 15 ff aa 04 ff 2a 55 05 ff 0a=20
> a0: 03 bd 00 66 03 b3 48 48 48 1c ff ff ff a7 66 3d=20
> b0: 03 7b 00 5a 03 15 48 48 48 1c ff ff ff a0 5a 3d=20
> c0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 a6 80 66 0c=20
> d0: 0f ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00
      ^^^^^
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> f0: 00 00 00 00 00 00 3b 3b 03 39 ff 00 ff ff ff ff=20
>=20
> f8000-isa-0a00
> Adapter: ISA adapter
> in0:         +1.68 V
> in1:         +1.68 V
> in2:         +1.62 V
> fan1:       1567 RPM
> fan2:       1683 RPM
> fan3:          0 RPM  ALARM
> fan4:       100000 RPM
> temp1:       +34.0=B0C  (high =3D +70.0=B0C, hyst =3D +60.0=B0C) =20
> temp2:        +8.0=B0C  (high =3D +100.0=B0C, hyst =3D +85.0=B0C)  sensor=
 =3D Intel PECI
> temp3:       +43.0=B0C  (high =3D +100.0=B0C, hyst =3D +85.0=B0C) =20

Just as I suspected. Hans, as you can see, fan4's speed is 0 in the
chip. So it's not a hardware issue, but a bug in your driver. Which I
presume the following patch would fix?

Fix fan4 for the F8000.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/f71882fg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.28-rc8.orig/drivers/hwmon/f71882fg.c	2008-12-16 17:42:05.0000=
00000 +0100
+++ linux-2.6.28-rc8/drivers/hwmon/f71882fg.c	2008-12-16 18:14:52.000000000=
 +0100
@@ -982,7 +982,7 @@ static struct f71882fg_data *f71882fg_up
=20
 		/* The f8000 can monitor 1 more fan, but has no pwm for it */
 		if (data->type =3D f8000)
-			data->fan[3] =3D f71882fg_read8(data,
+			data->fan[3] =3D f71882fg_read16(data,
 						F71882FG_REG_FAN(3));
 		if (data->type =3D f71882fg)
 			data->in_status =3D f71882fg_read8(data,

Something to fold into hwmon/hwmon-f71882fg-13-add-f8000-support.patch
I presume.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
