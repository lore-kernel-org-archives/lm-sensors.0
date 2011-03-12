From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Mar 2011 20:27:59 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <20110312212759.3c9e0e56@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Anders,

On Sat, 12 Mar 2011 20:25:16 +0100, Anders Kullenberg wrote:
> I have extremely high fan reading on my ubuntu 10.10 server installation
> (AMD64). Any clues to what could be the reason?
>=20
> Asus m2v motherboard
> Lm-sensors 3.1.2 kernel 2.6.35-22
>=20
> Sensors output:
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:      +1.14 V  (min =3D  +0.85 V, max =3D  +1.60 V)
>  +3.3 Voltage:      +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:        +5.00 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:      +11.31 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:     18000 RPM  (min =3D  800 RPM)
> CHASSIS FAN Speed: 14835 RPM  (min =3D  800 RPM)
> CHASSIS2 FAN Speed:   0 RPM  (min =3D  800 RPM)
> CPU Temperature:    +25.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:     +35.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)

Do you see the same crazy values in the BIOS? I guess so.

There can be two reasons:
* You are using special fans with more than 2 poles, so they emit more
  than 2 pulses per revolution. If this is the case, you have to
  correct the values using compute statements in your configuration
  file.
* You are using potentiometers or a so-called "fanbus" to control the
  speed of 3-wire fans. These tend to degrade the tachometer signal to
  a point where monitored values get completely wrong. In this case,
  you have to increase the speed to get valid readings again.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
