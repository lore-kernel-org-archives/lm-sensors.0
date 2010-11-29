From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 10:23:25 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101129112325.1f3a693e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Mon, 29 Nov 2010 00:20:44 -0600 (CST), Jeff Rickman wrote:
> Providing some feedback now that SCH5127 support is "mainline" in
> LM_Sensors; no "force_id" option required.
> (...)
> [root@anas-01 ~]# service lm_sensors status
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +21.0=B0C  (crit =3D +90.0=B0C)
>=20
> sch5127-isa-0870
> Adapter: ISA adapter
> V+1.5:       +1.42 V  (min =3D  +1.35 V, max =3D  +1.65 V)
> 5VTR:        +4.78 V  (min =3D  +4.50 V, max =3D  +5.48 V)
> VBAT:        +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V+5:         +5.09 V  (min =3D  +0.00 V, max =3D  +6.72 V)
> Vccp:        +1.48 V  (min =3D  +1.35 V, max =3D  +1.49 V)
> VCC:         +3.33 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> VTR:         +3.24 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Side Fan:   2250 RPM  (min =3D 600 RPM)
> MCH Fan:    5137 RPM  (min =3D 4500 RPM)
> CPU Temp:    +47.6=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
> SYS Temp:    +35.1=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
>=20
> Here is my "/etc/sensors.d/local.conf" file:
>=20
> [root@anas-01 ~]# cat /etc/sensors.d/local.conf
> # libsensors configuration file
> # -----------------------------
>=20
> chip "sch5127-isa-0870"
>=20
>     label in0 "V+1.5"
>     label in1 "5VTR"
>     label in2 "VBAT"
>     label in3 "V+5"
>     label in4 "Vccp"
>     label in5 "VCC"
>     label in6 "VTR"
>=20
> # All inputs are listed here in order as displayed in BIOS.

This is often the case, but not always. So this should only be used as
a last resort decision factor.

> # Values seen by "sensors" closely match values seen in BIOS.
>=20
>     label fan1 "Side Fan"
>     label fan2 "MCH Fan"
>     ignore fan3
>=20
>     label temp1 "CPU Temp"
>     ignore temp2
> #    label temp2 "SIO Temp"

This is an internal sensor, it should always be present and correct, so
why would you ignore it?

>     label temp3 "SYS Temp"
>=20
>     compute in0 (@ * 0.8), (@ / 0.8)

This is extremely unlikely. While it is frequent to scale down voltage
inputs so that the results fits in the ADC range, there is no point in
scaling a voltage up. Especially not by a factor so close to 1: the
error incurred by the operation would far outweigh the resolution
improvement at the ADC level. Not to mention that scaling up needs an
amplifier so it's not a cheap operation - no PC vendor would do this.

So, I seriously doubt that in0 is +1.5V.

In fact, the SCH5127 already has internal scaling resistors on most
voltage inputs, so if the voltage lines are wired correctly, only
voltages over +3.3V should need external scaling. These voltages (+5V
and 5VTR in your case) should be wired to in3 and in4 per chip design,
to limit the number of inputs which require scaling. VBAT, VCC and VTR
should be on in2, in5 and in6, which matches your findings. Which means
that +1.5V and Vccp should be on in0 and in1 (or vice-versa.)

Now it is of course possible that Acer did things differently, either
for pin proximity reasons, or just because they are bad ;)

Assuming that your CPU does frequency and voltage scaling based on
load, you should try to put some load on the CPU and check which
voltage input raises. This would be Vcore (Vccp) and should require no
scaling. If you can figure that one out, it might help sort out the
rest.

>     compute in1 (@ * 4), (@ / 4)
>     compute in3 (@ * 4.5), (@ / 4.5)
>=20
>     set in0_min 1.5 * 0.90
>     set in0_max 1.5 * 1.10
>     set in1_min 5.0 * 0.90
>     set in1_max 5.0 * 1.10
>     set in4_min 1.50 * 0.90
>     set in4_max 1.50 * 1.10
>=20
>     set fan1_min 600 <- per fan vendor

You're missing a # before your comment.

>     set fan2_min 4500
>     set temp1_min 20
>     set temp1_max 60
>     set temp2_min 20
>     set temp3_min 20
>     set temp3_max 60

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
