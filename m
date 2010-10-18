From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 18 Oct 2010 18:35:30 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101018183530.GA10070@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com> <4CBC8B3B.8090201@free.fr>
In-Reply-To: <4CBC8B3B.8090201@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Oct 18, 2010 at 02:00:27PM -0400, Chris Moore wrote:
>=20
>   Hi,
>=20
> Le 18/10/2010 18:08, Guenter Roeck a =E9crit :
> > On Sun, Oct 17, 2010 at 11:50:11AM -0400, Simon Guinot wrote:
> >
> >> +static void __set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_v=
al)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D 0; i<  fan_data->num_ctrl; i++) {
> >> +               int value =3D !!(ctrl_val&  (1<<  i));
> >> +
> > 	value =3D (ctrl_val&  (1>>  i));
> >      would be much simpler and easier to understand.
>=20
> IMHO you mean:
>=20
> 	value =3D (ctrl_val>>  i)&  1;
>=20
yes...

thanks for the correction.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
