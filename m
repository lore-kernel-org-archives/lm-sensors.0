From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Jan 2009 16:20:38 +0000
Subject: Re: [lm-sensors] w83667hg support feedback: some things work,
Message-Id: <20090128172038.51ec9da6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <806dafc20901200009l2fd53e9bnea2e5402f17b5da2@mail.gmail.com>
In-Reply-To: <806dafc20901200009l2fd53e9bnea2e5402f17b5da2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Christopher,

On Tue, 20 Jan 2009 03:09:15 -0500, Christopher Montgomery wrote:
> Hello,
>=20
> I've tried the w83667hg patch that was posted here last December [1]
> and found that it basically works but does not correctly determine
> several aspects of the setup on my ASUS P6T WS Pro motherboard.
>=20
> Summary:  The motherboard has five fan ports, four fans plugged in.
> However, it mis-senses that the motherboard has only three fan ports.
> In the 'data->has_fan' initialization code, the patched w83627ehf.c
> driver reads:
>=20
> 	  data->has_fan =3D 0x07; /* fan1, fan2 and fan3 */
> 	  i =3D w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
> =09
> 	  if ((i & (1 << 2)) && (!fan4pin))
> 	    data->has_fan |=3D (1 << 3);
> 	  if (!(i & (1 << 1)) && (!fan5pin))
> 	    data->has_fan |=3D (1 << 4);
>=20
> On my board, i=3D0x35, fan4pin=3D0x40 and fan5pin=3D0x20.  If I comment o=
ut
> the code and simply force data->has_fan=3D0x1f, I am able to read
> correct speeds from all five fans.

Thanks for reporting. Apparently the pin usage bits have inverted logic
between the W83627EHG and the W83667HG. Can you please test the
following patch? It should fix your problem.

---
 drivers/hwmon/w83627ehf.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.29-rc2.orig/drivers/hwmon/w83627ehf.c	2009-01-28 16:27:13.000=
000000 +0100
+++ linux-2.6.29-rc2/drivers/hwmon/w83627ehf.c	2009-01-28 16:39:18.00000000=
0 +0100
@@ -1359,8 +1359,8 @@ static int __devinit w83627ehf_probe(str
 		fan5pin =3D superio_inb(sio_data->sioreg, 0x27) & 0x20;
 		fan4pin =3D superio_inb(sio_data->sioreg, 0x27) & 0x40;
 	} else {
-		fan5pin =3D superio_inb(sio_data->sioreg, 0x24) & 0x2;
-		fan4pin =3D superio_inb(sio_data->sioreg, 0x29) & 0x6;
+		fan5pin =3D !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
+		fan4pin =3D !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
 	}
 	superio_exit(sio_data->sioreg);
=20
@@ -1372,9 +1372,9 @@ static int __devinit w83627ehf_probe(str
=20
 	data->has_fan =3D 0x07; /* fan1, fan2 and fan3 */
 	i =3D w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
-	if ((i & (1 << 2)) && (!fan4pin))
+	if ((i & (1 << 2)) && fan4pin)
 		data->has_fan |=3D (1 << 3);
-	if (!(i & (1 << 1)) && (!fan5pin))
+	if (!(i & (1 << 1)) && fan5pin)
 		data->has_fan |=3D (1 << 4);
=20
 	/* Read fan clock dividers immediately */


> Next issue; nearly all of the Min/Max values are incorrect.  They are
> both nonsensical and attempts to set them to sane values fail. An
> example (without forcing the extra fans):
>=20
> w83667hg-isa-0290
> Adapter: ISA adapter
> in0:         +1.00 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:         +1.71 V  (min =3D  +0.24 V, max =3D  +1.54 V)   ALARM
> in2:         +3.28 V  (min =3D  +0.38 V, max =3D  +0.29 V)   ALARM
> in3:         +3.26 V  (min =3D  +3.09 V, max =3D  +2.40 V)   ALARM
> in4:         +1.69 V  (min =3D  +1.57 V, max =3D  +0.26 V)   ALARM
> in5:         +2.04 V  (min =3D  +0.56 V, max =3D  +0.00 V)   ALARM
> in6:         +1.02 V  (min =3D  +1.57 V, max =3D  +1.34 V)   ALARM
> in7:         +3.39 V  (min =3D  +0.77 V, max =3D  +2.22 V)   ALARM
> in8:         +3.30 V  (min =3D  +2.11 V, max =3D  +1.71 V)   ALARM
> fan1:        917 RPM  (min =3D  200 RPM, div =3D 64)
> fan2:       1222 RPM  (min =3D  502 RPM, div =3D 16)
> fan3:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> temp1:       +45.0=B0C  (high =3D +57.0=B0C, hyst =3D +10.0=B0C)  sensor =
=3D thermistor
> temp2:       +45.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> temp3:      +124.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor =3D thermistor
> cpu0_vid:   +2.050 V
>=20
>  FTR, fan3 really isn't connected, so the value of zero is correct.

That's more surprising. How exactly did you attempt to set sane values?
If you edited /etc/sensors3.conf, please remember that it takes a
"sensors -s" to write the new limits to the chip.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
