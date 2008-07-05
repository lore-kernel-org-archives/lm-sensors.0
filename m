From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jul 2008 13:32:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080705153219.73bb19f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bruno,

On Sat, 5 Jul 2008 14:40:03 +0200, Bruno Pr=E9mont wrote:
> On Tue, 24 June 2008 "Andrew Paprocki" <andrew@ishiboo.com> wrote:
> > I've reworked the code to just add a revision field as you noted and
> > to only contain the 16-bit tach change. Please review and let me know
> > what you think re: force enabling the fans via a module parameter
> > bitmask or something similar.
>=20
> I've run if for about 20 minutes on my system (Kino 690S1, IT8712F-S)
> and FAN speed readings look fine (around 3200 RPM (with PWM control) for
> CPU fan and 1500 for Artic Cooling self-regulated FAN)
> The divisor files don't show up in sysfs anymore (as expected).
>=20
> Andrew, do you have the links to docs for pre-8 revisions at
> hand? The link on ITE homepage for datasheet revision 0.8.2 returns a
> 404 error...

I think I have all the old IT8712 datasheets, I'll send revision 0.8.2
to you (in private) if that's what you need.

> I would like to check if there is any change regarding voltage
> inputs as for change to FAN tacho register width. The voltage readings
> reported by the driver look pretty improbable!
>=20
> it8712-isa-0e80
> Adapter: ISA adapter
> VCore 1:     +1.17 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:     +0.82 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:       +3.01 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:         +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> +12V:        +4.99 V  (min =3D  +0.00 V, max =3D +16.32 V)
> -12V:       -13.86 V  (min =3D -27.36 V, max =3D  +3.93 V)
> -5V:         -3.11 V  (min =3D -13.64 V, max =3D  +4.03 V)
> Stdby:       +4.95 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> VBat:        +3.26 V
> fan1:       3183 RPM  (min =3D    0 RPM, div =3D 8)
> fan2:       1520 RPM  (min =3D    0 RPM, div =3D 8)
> CPU Temp:    +20.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermal diode
> M/B Temp:    +48.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermal diode
> cpu0_vid:   +1.550 V

I don't remember any change in the voltage computations. More likely
you simply need to tweak your configuration file to match your
motherboard wiring, as is the case with all motherboards. This includes
changing the labels and adjusting the compute statements as well. We
can help you a bit with this if you tell us all the voltage labels and
values displayed by your BIOS, and the voltages values reported by
"sensors -c /dev/null".

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
