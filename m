From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Mon, 07 Jan 2013 21:42:43 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <201301072142.r07LgiPe020771@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> sensors.org] On Behalf Of Leslie Rhorer
> Sent: Monday, January 07, 2013 3:01 PM
> To: 'Jean Delvare'
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
>=20
> RAID-Server:/tmp# sensors
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +2.81 V  (min =3D  +1.04 V, max =3D  +1.99 V)  ALARM
> in1:          +2.81 V  (min =3D  +1.08 V, max =3D  +2.48 V)  ALARM
> in2:          +0.90 V  (min =3D  +2.34 V, max =3D  +0.72 V)  ALARM
> +3.3V:        +3.29 V  (min =3D  +2.33 V, max =3D  +1.87 V)  ALARM
> in4:          +1.54 V  (min =3D  +0.06 V, max =3D  +1.70 V)
> in5:          +2.51 V  (min =3D  +2.40 V, max =3D  +2.92 V)
> in6:          +1.54 V  (min =3D  +0.12 V, max =3D  +0.58 V)  ALARM
> 3VSB:         +3.46 V  (min =3D  +5.06 V, max =3D  +1.34 V)  ALARM
> Vbat:         +3.38 V
> fan1:           0 RPM  (min =3D   14 RPM)  ALARM
> fan2:        2213 RPM  (min =3D   32 RPM)
> fan3:        2191 RPM  (min =3D   11 RPM)
> temp1:        +32.0=B0C  (low  =3D +36.0=B0C, high =3D +11.0=B0C)  ALARM =
 sensor =3D
> thermistor
> temp2:        +31.0=B0C  (low  =3D  +0.0=B0C, high =3D +49.0=B0C)  sensor=
 =3D
> thermistor
> temp3:       -128.0=B0C  (low  =3D +116.0=B0C, high =3D +93.0=B0C)  senso=
r =3D
> disabled
> intrusion0:  OK
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +10.2=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +90.0=B0C, hyst =3D +87.0=B0C)

	Hmm.  I just put the following into /etc/sensors.conf

chip "it8721-isa-0290"

   label fan2 "CPU Fan"

	And then ran `sensors -s` followed by `sensors`, but the output from
`sensors` did not change.  I also tried "*-isa-*.  Is there something else I
should be doing?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
