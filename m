From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 10:21:22 +0000
Subject: Re: [lm-sensors] Help with it8712-isa-0290
Message-Id: <20090114112122.4446ebcc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200812291955.10560.apetar@gmail.com>
In-Reply-To: <200812291955.10560.apetar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Petar,

Please keep the mailing list Cc'd.

On Wed, 14 Jan 2009 02:04:50 +0100, Predrag Aleksic wrote:
> Jean sorry for delay with reply to your message. I changed sensor type fr=
om=20
> transistor to thermal diode and now i get normal readings.
>=20
> set temp1_type 3
> set temp2_type 3
> label temp1       "CPU Core1 Temp"
> label temp2       "CPU Core2 Temp"
> label temp3       "M/B Temp"
>=20
> paleksic@fearless ~ 127 $ sensors
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:     +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:     +2.58 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:       +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:         +5.08 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> +12V:       +12.03 V  (min =3D  +0.00 V, max =3D +16.32 V)
> -12V:       -10.55 V  (min =3D -27.36 V, max =3D  +3.93 V)
> -5V:        -11.08 V  (min =3D -13.64 V, max =3D  +4.03 V)
> Stdby:       +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
> VBat:        +3.07 V
> fan1:       2311 RPM  (min =3D    0 RPM, div =3D 8)
> CPU Core1 Temp:  +98.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  s=
ensor =3D thermal diode
> CPU Core2 Temp:  +94.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  s=
ensor =3D thermal diode
> M/B Temp:    +48.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D thermal diode
> cpu0_vid:   +1.388 V

+98 degrees C, "normal reading"? Hell, I sure hope your CPU isn't that
hot.

Your CPU temperature is most certainly temp3, as I said earlier. You
still did not tell us what temperature labels and values your BIOS was
displaying.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
