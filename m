From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Dec 2011 17:13:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (f75375s) Added F75387SG/RG support
Message-Id: <20111212171340.GA10565@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2D36B16B-9487-4A4D-B4EB-60FA8766BFFB@bgerhart.de>
In-Reply-To: <2D36B16B-9487-4A4D-B4EB-60FA8766BFFB@bgerhart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bjoern,

On Sun, Dec 11, 2011 at 03:07:26PM -0500, Bj=F6rn Gerhart wrote:
> Added support for Fintek F75387SG/RG.
>=20
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Signed-off-by: Bjoern Gerhart <oss@extracloud.de>
> ---
>=20
> Tested with kernel 2.6.39, but without fans so far.
>=20
> v2:
> - suitable ontop of the latest set of f75375s related patches
> - simplified name of a local char variable
>=20
> Kconfig   |    4 -
> f75375s.c |  139 +++++++++++++++++++++++++++++++++++++++++++++-----------=
------
> 2 files changed, 105 insertions(+), 38 deletions(-)
>=20
> diff -uNr linux-2.6.39-5patched/drivers/hwmon/f75375s.c linux-2.6.39/driv=
ers/hwmon/f75375s.c
> --- linux-2.6.39-5patched/drivers/hwmon/f75375s.c	2011-12-09 15:41:01.000=
000000 +0100
> +++ linux-2.6.39/drivers/hwmon/f75375s.c	2011-12-11 19:15:18.000000000 +0=
100
> @@ -1,6 +1,6 @@
> /*

I am still having trouble applying your patch. The patch file is supposed
to start unmodified lines with an added blank, which is missing in your pat=
ch.
Both git am and the patch command complain about that.

[ ... ]

> @@ -660,11 +716,17 @@
> 	if (!f75375s_pdata) {
> 		u8 conf, mode;
> 		int nr;
> +		char ctrl;
>=20
> 		conf =3D f75375_read8(client, F75375_REG_CONFIG1);
> 		mode =3D f75375_read8(client, F75375_REG_FAN_TIMER);
> 		for (nr =3D 0; nr < 2; nr++) {
> -			if (!(conf & (1 << FAN_CTRL_LINEAR(nr))))
> +			if (data->kind =3D=3D f75387)
> +				ctrl =3D F75387_FAN_CTRL_LINEAR(nr);
> +			else
> +				ctrl =3D F75375_FAN_CTRL_LINEAR(nr);
> +
> +			if (!(conf & (1 << ctrl)))
> 				data->pwm_mode[nr] =3D 1;
> 			switch ((mode >> FAN_CTRL_MODE(nr)) & 3) {
> 			case 0:		/* speed */

You'll also need some F75387 specific code to detect/select pwm_enable[0,1].

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
