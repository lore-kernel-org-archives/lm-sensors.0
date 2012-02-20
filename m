From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 20 Feb 2012 23:53:52 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <20120220235352.GA24915@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 20, 2012 at 05:44:59PM -0500, Chris wrote:
> Fix variable intializations in max6639_init_client
> Signed-off-by: Chris D Schimp <silverchris <at> gmail.com>
> ---
>=20
Can we somehow reach an agreement that patches are sent as patches and not =
in reply
to other e-mail or patches ? I for my part all but lost track about which e=
-mail
fixes which problem, since all have the same headline.

> diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/max6639.c
> b/drivers/hwmon/max6639.c
> --- a/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -0500
> +++ b/drivers/hwmon/max6639.c	2012-02-20 17:40:36.821422457 -0500
> @@ -429,16 +429,15 @@ static int max6639_init_client(struct i2
>  	struct max6639_data *data =3D i2c_get_clientdata(client);
>  	struct max6639_platform_data *max6639_info =3D
>  		client->dev.platform_data;
> -	int i =3D 0;
> +	int i;
>  	int rpm_range =3D 1; /* default: 4000 RPM */
> -	int err =3D 0;
> +	int err;
>=20
>  	/* Reset chip to default values, see below for GCONFIG setup */
>  	err =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
>  				  MAX6639_GCONFIG_POR);
>  	if (err)
>  		goto exit;
> -

... and I think I have seen this unnecessary line removal several times now,
suggesting that the patch won't apply in any sequence.

Please, do some homework. Applying this series of patches will/would require
a lot of unnecessary extra work from either me or Jean.

Guenter

>  	/* Fans pulse per revolution is 2 by default */
>  	if (max6639_info && max6639_info->ppr > 0 &&
>  			max6639_info->ppr < 5)
>=20
> On Mon, Feb 20, 2012 at 5:31 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Mon, 2012-02-20 at 17:14 -0500, Chris wrote:
> >> The patches I just submitted fix the main issues with the driver on my
> >> system. I didn't fix the variable initialization because it seems to
> >> generate a warning when ever I move them closer to were they belong
> >> in, it generates a compiler warning of "warning: ISO C90 forbids mixed
> >> declarations and code". I am looking into how platform_data works to
> >> see how it works to see if I can handle checking it and changing the
> >> chip initialization to work with platform data if its provided and to
> >> leave it alone if its not. Thanks for the patience with my patch
> >> submissions, I am learning a lot from this
> >>
> >
> > The initializations are not needed.
> >
> > =A0 =A0 =A0 =A0s/int i =3D 0/int i/
> > =A0 =A0 =A0 =A0s/int err =3D 0/int err/
> >
> > should do it.
> >
> > Guenter
> >
> >> On Mon, Feb 20, 2012 at 1:58 PM, Roland Stigge <stigge@antcom.de> wrot=
e:
> >> > Hi!
> >> >
> >> > On 02/20/2012 06:39 PM, Guenter Roeck wrote:
> >> >>> Please resubmit a (-p1) patch fixing the issue your originally spo=
tted
> >> >>> instead.
> >> >>>
> >> >> We really need input from Roland on the initialization problem.
> >> >> Might make sense to kwwp him copied on this exchange.
> >> >
> >> > Thanks for your notification and sorry for the delay!
> >> >
> >> > Unfortunately, when I ported the driver from the other original auth=
or,
> >> > I kept the initialization procedure which is obviously wrong, doing
> >> > initialization only for one channel. (I adjusted the driver locally
> >> > platform-dependent, so didn't find a chance for mainline integration=
 and
> >> > this way, the obvious problems in the mainline driver slipped.)
> >> >
> >> > Therefore, a fix for doing this for both channels, possibly in a loo=
p,
> >> > would be good, IMO.
> >> >
> >> > Jean's note about the broken variable initialization is correct. Sho=
uld
> >> > have done this differently.
> >> >
> >> > The other note about initialization only with platform_data is also a
> >> > good idea.
> >> >
> >> > I'm using the chip on a custom ARM board without BIOS initialization,
> >> > but providing platform_data in this case should be the correct way, =
anyway.
> >> >
> >> > So Chris, if you are already at it, do it this way. Otherwise please
> >> > notify me and I can prepare patches.
> >> >
> >> > Thanks for your work!
> >> >
> >> > Roland
> >
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
