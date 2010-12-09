From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Dec 2010 12:57:38 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101209135738.07f236f8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 9 Dec 2010 12:31:28 +0100, Juerg Haefliger wrote:
> Hi Jean and Jeff,
>=20
>=20
> > On Mon, 29 Nov 2010 00:20:44 -0600 (CST), Jeff Rickman wrote:
> >> Providing some feedback now that SCH5127 support is "mainline" in
> >> LM_Sensors; no "force_id" option required.
> >> (...)
> >> [root@anas-01 ~]# service lm_sensors status
> >> coretemp-isa-0000
> >> Adapter: ISA adapter
> >> Core 0: =A0 =A0 =A0+21.0=B0C =A0(crit =3D +90.0=B0C)
> >>
> >> sch5127-isa-0870
> >> Adapter: ISA adapter
> >> V+1.5: =A0 =A0 =A0 +1.42 V =A0(min =3D =A0+1.35 V, max =3D =A0+1.65 V)
> >> 5VTR: =A0 =A0 =A0 =A0+4.78 V =A0(min =3D =A0+4.50 V, max =3D =A0+5.48 =
V)
> >> VBAT: =A0 =A0 =A0 =A0+3.32 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.38 =
V)
> >> V+5: =A0 =A0 =A0 =A0 +5.09 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.72 =
V)
> >> Vccp: =A0 =A0 =A0 =A0+1.48 V =A0(min =3D =A0+1.35 V, max =3D =A0+1.49 =
V)
> >> VCC: =A0 =A0 =A0 =A0 +3.33 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.38 =
V)
> >> VTR: =A0 =A0 =A0 =A0 +3.24 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.38 =
V)
> >> Side Fan: =A0 2250 RPM =A0(min =3D 600 RPM)
> >> MCH Fan: =A0 =A05137 RPM =A0(min =3D 4500 RPM)
> >> CPU Temp: =A0 =A0+47.6=B0C =A0(low =A0=3D +20.0=B0C, high =3D +60.0=B0=
C)
> >> SYS Temp: =A0 =A0+35.1=B0C =A0(low =A0=3D +20.0=B0C, high =3D +60.0=B0=
C)
> >>
> >> Here is my "/etc/sensors.d/local.conf" file:
> >>
> >> [root@anas-01 ~]# cat /etc/sensors.d/local.conf
> >> # libsensors configuration file
> >> # -----------------------------
> >>
> >> chip "sch5127-isa-0870"
> >>
> >> =A0 =A0 label in0 "V+1.5"
> >> =A0 =A0 label in1 "5VTR"
> >> =A0 =A0 label in2 "VBAT"
> >> =A0 =A0 label in3 "V+5"
> >> =A0 =A0 label in4 "Vccp"
> >> =A0 =A0 label in5 "VCC"
> >> =A0 =A0 label in6 "VTR"
>=20
> According to the datasheet (and I just double-checked the scaling
> factors in the driver and they are correct), the voltages are as
> follows:
>=20
> in0: 2.5V   (2.5V nominal, 3.320V max)
> in1: Vccp   (2.25V nominal, 2.988V max)
> in2: VCC   (3.3V nominal, 4.383V max)
> in3: V2_IN   (1.125V nominal, 1.5V max, should be wired to scaled down 5V)
> in4: V1_IN   (1.125V nominal, 1.5V max, should be wired to scaled down 12=
V)
> in5: VTR   (3.3V nominal, 4.383V max)
> in6: VBat   (3.0V nominal, 4.383V max)
>=20
> If the chip is hooked up according to the datasheet then the only
> voltages that require scaling are in3 & 4.

OK, thanks for checking. Your conclusion matches mine.

Do you happen to know if any of these are internal (so that the
mapping/label doesn't depend on the system)? This would help. in2 and
in6 would be candidates, maybe in5 as well. Do you have any clue what
"VTR" stands for?

For internal voltages we can put the labels in the default
sensors3.conf file, to help the users.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
