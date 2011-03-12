From: "Anders Kullenberg" <akullen@swipnet.se>
Date: Sat, 12 Mar 2011 21:39:42 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <000001cbe0fd$fff316e0$ffd944a0$@se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Thanks for the quick reply.

I checked the BIOS readings. They are normal, even below 800rpm. I have the
asus q-fan enabled in the bios that should control fan speeds. I tried to
disable it, didn't change anything.
It is possible to select ACPI 1.0, 2.0 or 3.0 in the bios, any
recommendations on that?

The fans are not any special stuff as far as I'm aware. They are connected
to the motherboard directly, no potentiometers used in the installation.

I found no chip "atk0110-*" section in /etc/sensors3.conf, what config is
used then, where should I put the compute statements?

BR
Anders

-----Ursprungligt meddelande-----
Fr=E5n: Jean Delvare [mailto:khali@linux-fr.org]=20
Skickat: den 12 mars 2011 21:28
Till: Anders Kullenberg
Kopia: lm-sensors@lm-sensors.org
=C4mne: Re: [lm-sensors] extreme fan rpms with atk0110

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
