From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Jul 2011 09:12:30 +0000
Subject: Re: [lm-sensors] IT8772E info and reports
Message-Id: <20110706111230.5d612b2b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
In-Reply-To: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 5 Jul 2011 13:52:13 +0100, Kazuya wrote:
> It works however there is still some troubles :
>=20
> it8721-isa-0a30
> Adapter: ISA adapter
> in0:         +1.01 V  (min =3D  +0.82 V, max =3D  +0.58 V)   ALARM
> in1:         +1.60 V  (min =3D  +0.94 V, max =3D  +1.56 V)   ALARM
> in2:         +1.07 V  (min =3D  +2.56 V, max =3D  +1.20 V)   ALARM
> in3:         +1.04 V  (min =3D  +2.40 V, max =3D  +2.44 V)   ALARM
> in4:         +0.49 V  (min =3D  +1.93 V, max =3D  +1.73 V)   ALARM
> in5:         +2.22 V  (min =3D  +0.12 V, max =3D  +2.59 V)
> in6:         +2.22 V  (min =3D  +1.02 V, max =3D  +1.93 V)   ALARM
> 3VSB:        +3.31 V  (min =3D  +5.57 V, max =3D  +0.05 V)   ALARM
> Vbat:        +3.26 V
> fan1:          0 RPM  (min =3D   57 RPM)  ALARM
> fan2:       1397 RPM  (min =3D   19 RPM)
> fan3:          0 RPM  (min =3D   79 RPM)  ALARM
> temp1:       +42.0=B0C  (low  =3D -35.0=B0C, high =3D +17.0=B0C)  ALARM  =
sensor =3D thermistor
> temp2:       +54.0=B0C  (low  =3D +64.0=B0C, high =3D +76.0=B0C)  ALARM  =
sensor =3D thermal diode
> temp3:      -128.0=B0C  (low  =3D +57.0=B0C, high =3D +54.0=B0C)  sensor =
=3D disabled

Where do you see "some trouble"? If you refer to the ALARM flags, these
are nothing to worry about, it only means that the min and max limits
haven't been configured yet.

> How can I write down every monitored value in my bios ?

With a pencil and a sheet of paper? :)

Enter the BIOS setup by pressing the Del key at boot ("Suppr" on French
keyboard), and look for the hardware monitoring panel. Almost every
PC BIOS has this for the last 10 years or so. According to screenshots
found on the web, on your board it should be under Advanced > H/W
Monitor.

Write on a paper every label and monitored value. If some values
oscillate, write all the numbers, this is very useful to find the
scaling factors. Then e-mail everything to us and we can compare with
the output above and start writing a configuration file.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
