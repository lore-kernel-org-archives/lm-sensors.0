From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Jan 2009 12:13:30 +0000
Subject: Re: [lm-sensors] Help with it8712-isa-0290
Message-Id: <20090108131330.7b9587ad@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200812291955.10560.apetar@gmail.com>
In-Reply-To: <200812291955.10560.apetar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Petar,

On Mon, 29 Dec 2008 19:55:10 +0100, Petar wrote:
> Hi list,=20
>=20
> [root@fearless mrtg]# sensors
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:     +1.33 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:     +2.61 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:       +3.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:         +5.13 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> +12V:       +11.90 V  (min =3D  +0.00 V, max =3D +16.32 V)
> -12V:        -9.07 V  (min =3D -27.36 V, max =3D  +3.93 V)
> -5V:         -8.44 V  (min =3D -13.64 V, max =3D  +4.03 V)
> Stdby:       +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
> VBat:        +3.10 V
> fan1:       1231 RPM  (min =3D    0 RPM, div =3D 8)
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
> M/B Temp:    -55.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D transistor
> CPU Temp:     -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D transistor
> Temp3:       +33.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D thermal diode
> cpu0_vid:   +1.388 V
>=20
>=20
> I guess temp1 is  "CPU Temp" and temp3 is "M/B Temp".

Definitely not. -55 degrees C suggests a broken or unconnected thermal
sensor.

> I cant tell what is temp2 doing but i think it is safe to ignore?

-2 degrees C indeed doesn't look very reasonable.

My guess would be that only temp3 is relevant on your system and that
would be the CPU temperature. This would result in the following lines
in sensors3.conf:

   ignore temp1
   ignore temp2
   label  temp3  "CPU Temp"

How many temperatures are displayed by your BIOS?

> After editing sensors3.conf i got :
>=20
> paleksic@fearless html 0 $ sensors
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:     +1.22 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:     +2.61 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:       +3.17 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:         +5.05 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> +12V:       +12.10 V  (min =3D  +0.00 V, max =3D +16.32 V)
> -12V:       -14.97 V  (min =3D -27.36 V, max =3D  +3.93 V)
> -5V:        -11.01 V  (min =3D -13.64 V, max =3D  +4.03 V)
> Stdby:       +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
> VBat:        +3.10 V
> fan1:       1147 RPM  (min =3D    0 RPM, div =3D 8)
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
> CPU Temp:    -55.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D transistor
> M/B Temp:    +31.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D thermal diode
> cpu0_vid:   +1.388 V
>=20
> Still no good :> Why is CPU Temp inverted and how can i fix it?

It's not inverted, it's just wrong, most probably because there's no
sensor connected to the input.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
