From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 29 Jul 2007 20:32:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/adm1031: Fix broken links in
Message-Id: <20070729203246.GL3796@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713142941.160b839a@hyperion.delvare>
In-Reply-To: <20070713142941.160b839a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-07-13 14:29:41 +0200]:
> The Analog Devices chip information pages moved to a different location.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/adm1031 |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- linux-2.6.23-pre.orig/Documentation/hwmon/adm1031	2007-02-04 19:44:54=
.000000000 +0100
> +++ linux-2.6.23-pre/Documentation/hwmon/adm1031	2007-07-13 14:27:26.0000=
00000 +0200
> @@ -6,13 +6,13 @@ Supported chips:
>      Prefix: 'adm1030'
>      Addresses scanned: I2C 0x2c to 0x2e
>      Datasheet: Publicly available at the Analog Devices website
> -               http://products.analog.com/products/info.asp?product=ADM1=
030
> +               http://www.analog.com/en/prod/0%2C2877%2CADM1030%2C00.html
> =20
>    * Analog Devices ADM1031
>      Prefix: 'adm1031'
>      Addresses scanned: I2C 0x2c to 0x2e
>      Datasheet: Publicly available at the Analog Devices website
> -               http://products.analog.com/products/info.asp?product=ADM1=
031
> +               http://www.analog.com/en/prod/0%2C2877%2CADM1031%2C00.html
> =20
>  Authors:
>          Alexandre d'Alton <alex@alexdalton.org>
>=20
>=20

Applied to hwmon-2.6.git/testing, thanks.

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
