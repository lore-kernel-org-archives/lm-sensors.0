From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: bug with sensors-detect recommendation for modprobe (fwd)
Message-Id: <20030216142544.47c76f94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302161315.h1GDFx1N000464@shire.frodo.local>
In-Reply-To: <200302161315.h1GDFx1N000464@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hello,

> I found a problem with the modprobe recommendation of sensors-detect.
>=20
> It should be=20
>=20
>   MODULE_0=3Di2c-viapro
>   MODULE_1=3Di2c-isa
>   MODULE_2=EEprom
>   MODULE_3=ADm1021
>   MODULE_4=3Dvia686a
>=20
> instead of
>=20
>   MODULE_1=3Di2c-viapro
>   MODULE_2=3Di2c-isa
>   MODULE_3=EEprom
>   MODULE_4=ADm1021
>   MODULE_5=3Dvia686a

This is a known problem. We fixed it in 2.6.5, so you might want to
upgrade.

Thanks for the report anyway.

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
