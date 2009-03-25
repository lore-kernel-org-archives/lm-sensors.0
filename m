From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Mar 2009 08:01:06 +0000
Subject: Re: [lm-sensors] help with lmsensors and intel atom
Message-Id: <20090325090106.4b7e8c3a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20090324T161504-153@post.gmane.org>
In-Reply-To: <loom.20090324T161504-153@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 25 Mar 2009 02:07:22 +0000 (UTC), Alan A wrote:
> smsc47m192-i2c-0-2d
> Adapter: SMBus I801 adapter at 2000
> +2.5V:       +2.55 V  (min =3D  +0.00 V, max =3D  +3.32 V)  =20
> VCore:       +1.20 V  (min =3D  +0.00 V, max =3D  +2.99 V)  =20
> +3.3V:       +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)  =20
> +5V:         +4.97 V  (min =3D  +0.00 V, max =3D  +6.64 V)  =20
> +12V:       +12.25 V  (min =3D  +0.00 V, max =3D +15.94 V)  =20
> VCC:         +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)  =20
> +1.5V:       +1.58 V  (min =3D  +0.00 V, max =3D  +1.99 V)  =20
> +1.8V:       +1.78 V  (min =3D  +0.00 V, max =3D  +2.39 V)  =20
> Chip Temp:   +31.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C) =20
> CPU Temp:    +50.0=B0C  (low  =3D +40.0=B0C, high =3D +70.0=B0C) =20
> Sys Temp:    +40.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C) =20
> cpu0_vid:   +2.050 V
>=20
> smsc47m1-isa-0680
> Adapter: ISA adapter
> fan1:       4818 RPM  (min =3D 1280 RPM, div =3D 4)
> fan2:       7021 RPM  (min =3D 1280 RPM, div =3D 4)
>=20
> And then checked the version:
>=20
> sensors version 3.0.2 with libsensors version 3.0.2
>=20
> You do know your stuff! Thank you much. Any ideas as to the code in the s=
nippet
> in the other message? I'm running LCD4Linux to access the LCD.

Try temp3_input instead of temp_input3 maybe. Another suspicious thing
is the lack of reference to a specific monitoring chip (you have 2
chips so how can LCD4Linux know which one you're talking about?), and
also the name "i2c_sensors" while we made the hardware monitoring
subsystem independent from i2c years ago. Could be that the LCD4Linux
code is old and doesn't properly interface with the current hwmon or
libsensors API.

But anyway, at this point there's not so much we can do for you. Your
sensors are OK, your problem is with LCD4Linux, so you should ask for
help people who know about LCD4Linux.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
