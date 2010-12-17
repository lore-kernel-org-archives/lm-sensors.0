From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Dec 2010 19:46:12 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101217204612.45086f60@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 17 Dec 2010 13:04:53 -0600 (CST), Jeff Rickman wrote:
> Changes made. Recompile successful. Old module removed. Module installs
> without error. Output as follows:
>=20
> [root@anas-01 sensors]# sensors
> sch5127-isa-0870
> Adapter: ISA adapter
> in0:         +1.78 V  (min =3D  +0.00 V, max =3D  +3.32 V)
> Vccp:        +1.19 V  (min =3D  +1.08 V, max =3D  +1.32 V)
> VCC:         +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> in3:         +1.13 V  (min =3D  +0.00 V, max =3D  +1.49 V)
> in4:         +1.48 V  (min =3D  +0.00 V, max =3D  +1.49 V)
> VTR:         +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> VBAT:        +3.25 V  (min =3D  +2.70 V, max =3D  +3.30 V)
> in7:         +1.43 V  (min =3D  +1.35 V, max =3D  +1.65 V)
> Side Fan:   1905 RPM  (min =3D  700 RPM)
> MCH Fan:    5032 RPM  (min =3D 4500 RPM)
> CPU Temp:    +41.8=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
> SYS Temp:    +32.9=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
>=20
> 1.43 volts isn't 1.5 volts, but within +- 10 percent.

Indeed, much better! Thanks for testing and reporting! Now, I can merge
Juerg's patch.

I think we can conclude that in7 is +1.5V on your system, and in0 and
in3 would be +5V and 5VSB (or vice-versa) with unknown scaling factors.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
