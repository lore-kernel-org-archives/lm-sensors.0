From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 24 Jul 2007 13:00:17 +0000
Subject: Re: [lm-sensors] drivers/hwmon/lm93.c: array overruns
Message-Id: <20070724130017.GA5101@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070723005453.GS26212@stusta.de> <200707230936.58135.hjk@linutronix.de>
In-Reply-To: <200707230936.58135.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>
Cc: Adrian Bunk <bunk@stusta.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

* Hans-J=FCrgen Koch <hjk@linutronix.de> [2007-07-23 09:36:57 +0200]:
> Am Montag 23 Juli 2007 02:54 schrieb Adrian Bunk:
> > The Coverity checker spotted the following array overruns
> > in drivers/hwmon/lm93.c:
> >=20
> > <--  snip  -->
> >=20
> > ...
> > struct lm93_data {
> > ...
> >         struct {
> >                 u8 min;
> >                 u8 max;
> >         } temp_lim[3];
> > ...
> > };
> > ...
> > static void lm93_update_client_common(struct lm93_data *data,
> >                                       struct i2c_client *client)
> > {
> > ...
> >         for (i =3D 0; i < 4; i++) {
> >                 data->temp_lim[i].min > >                         lm93_=
read_byte(client, LM93_REG_TEMP_MIN(i));
> >                 data->temp_lim[i].max > >                         lm93_=
read_byte(client, LM93_REG_TEMP_MAX(i));
> >         }
> > ...
> >=20
> > <--  snip  -->
>=20
> This patch should fix it. Thanks a lot, Adrian!
>=20
> ----
> This fixes an array overflow bug. We have 4 pairs of min/max temperature =

> limits, not 3.
>=20
> Signed-off-by: Hans J. Koch <hjk@linutronix.de>
>=20
> --
> Index: linux-2.6.23-rc/drivers/hwmon/lm93.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.23-rc.orig/drivers/hwmon/lm93.c	=
2007-07-23 09:22:56.000000000 +0200
> +++ linux-2.6.23-rc/drivers/hwmon/lm93.c	2007-07-23 09:29:37.000000000 +0=
200
> @@ -234,7 +234,7 @@
>  	struct {
>  		u8 min;
>  		u8 max;
> -	} temp_lim[3];
> +	} temp_lim[4];
> =20
>  	/* vin1 - vin16: low and high limits */
>  	struct {
>=20
>=20

Applied to testing, thanks.

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
