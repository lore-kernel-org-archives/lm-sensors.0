From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Apr 2008 20:20:43 +0000
Subject: Re: [lm-sensors] [PATCH] Use the current locale in sensors program
Message-Id: <20080407222043.379d8797@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406210232.GB31929@volta.aurel32.net>
In-Reply-To: <20080406210232.GB31929@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 6 Apr 2008 23:02:32 +0200, Aurelien Jarno wrote:
> The previous patch fixed libsensors behaviour wrt locales, so I guess it
> is now safe to use the current locale for all categories in the sensors=20
> program. This includes LC_NUMERIC, so the values are printed using the
> correct decimal separator wrt to the locale settings.
>=20
>=20
> Index: prog/sensors/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- prog/sensors/main.c	(r=E9vision 5168)
> +++ prog/sensors/main.c	(copie de travail)
> @@ -257,7 +257,7 @@
>  		{ 0, 0, 0, 0 }
>  	};
> =20
> -	setlocale(LC_CTYPE, "");
> +	setlocale(LC_ALL, "");
> =20
>  	do_raw =3D 0;
>  	do_sets =3D 0;
>=20

I'm a bit reluctant to apply this. For one thing, it assumes that the
libsensors locale fix is applied, while it should be possible to use
sensors 3.0.1 with libsensors 3.0.2. This is unlikely to happen, but
still.

For another, this will change the output of "sensors" and "sensors -u",
which we know some people are parsing. While there is a workaround
(have the caller change LC_ALL) this is still likely to break scripts
out there.

Last but not least, sensors isn't internationalized, and I think it's a
bit confusing to have sensors use English words (adapter, sensor,
thermistor, alarm etc.) but write numbers using the French syntax.

I welcome other opinions on this patch though. If a clear majority
think that this patch should be applied, my opinion on the matter isn't
that strong.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
