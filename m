From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Dec 2010 21:05:57 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101212220557.16a4dd91@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 11 Dec 2010 04:16:07 -0600 (CST), Jeff Rickman wrote:
> Please look at the "min" and "max" values for "in7". They look reversed.
>=20
> [root@anas-01 ~]# sensors
> sch5127-isa-0870
> Adapter: ISA adapter
> in0:         +1.78 V  (min =3D  +0.00 V, max =3D  +3.32 V)
> Vccp:        +1.19 V  (min =3D  +1.08 V, max =3D  +1.32 V)
> VCC:         +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> in3:         +1.13 V  (min =3D  +0.00 V, max =3D  +1.49 V)
> in4:         +1.48 V  (min =3D  +0.00 V, max =3D  +1.49 V)
> VTR:         +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> VBAT:        +3.24 V  (min =3D  +2.70 V, max =3D  +3.30 V)
> in7:         +0.72 V  (min =3D  +1.99 V, max =3D  +1.75 V)
> Side Fan:   1863 RPM  (min =3D  700 RPM)
> MCH Fan:    5023 RPM  (min =3D 4500 RPM)
> CPU Temp:    +39.9=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
> SYS Temp:    +32.4=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)

The in7 limit values are probably simply not initialized by the BIOS.
At least the in7_max value differs from your previous post.

I admit the in7_min limit is surprising, as it didn't change and
corresponds to the max value (register value 0xff), which would make
sense for a max limit but not for a min limit. But even more surprising
is that the alarm flag doesn't show even though the reading is below
the min limit. There's something fishy here. You should check if you
can change the limits and if you are able to get the alarm flag to
trigger.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
