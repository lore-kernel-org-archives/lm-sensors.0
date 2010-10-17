From: Simon Guinot <simon@sequanux.org>
Date: Sun, 17 Oct 2010 15:40:21 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: DNS323 rev C1 fan support
Message-Id: <20101017154021.GB29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0067160802848569131=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1274525694.1931.142.camel@pasglop>
	<20101013115951.GA5649@kw.sim.vm.gnt>
	<1286987650.9690.175.camel@groeck-laptop>
In-Reply-To: <1286987650.9690.175.camel@groeck-laptop>
To: linux-arm-kernel@lists.infradead.org


--===============0067160802848569131==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thanks for your comments.

On Wed, Oct 13, 2010 at 09:34:10AM -0700, Guenter Roeck wrote:
> On Wed, 2010-10-13 at 07:59 -0400, Simon Guinot wrote:
> > Hi Benjamin,
> >=20
> > What is the status for the DNS323 fan support ?
> > Have this patch been merged yet ?
> >=20
> The most recent version I found on the web (dated June 13) has problems
> with error detection and reporting, and fails to remove sysfs files in
> some error conditions. So I would be surprised if it was merged, unless
> there is a more recent version which I missed.
>=20
> On a side note, there are several versions of the patch on the web, none
> indicating what has changed between versions. Would be great to have
> such data attached to the various patch versions.
>=20
> > I am currently looking to add hwmon support for the GPIO fan found
> > on Network Space Max v2 boards. Obviously, some attributes are shared
> > with the DNS323 fan. Maybe there is some room for a generic GPIO fan
> > driver ?
> >=20
> > Platform data could provide the board specific GPIO pinout and a speed
> > conversion array (rpm from/to GPIO value). Here is a proposal for this
> > platform data interface:
> >=20
> > struct gpio_fan {
> >         const char      *name;
> >         unsigned        gpio;
> >         unsigned        active_low;
> > };
> >=20
> > struct gpio_fan_speed {
> >         int value;
> >         int rpm;
> > };
> >=20
> > struct gpio_fan_platform_data {
> >         struct gpio_fan         *alarm; /* fan alarm GPIO. */
> >         struct gpio_fan         *ctrl;  /* fan control GPIOs. */
> >         int                     num_ctrl;
> >         /*
> >          * Speed conversion array: rpm from/to GPIO bit field.
> >          * This array _must_ be sorted in ascending rpm order.
> >          */
> >         struct gpio_fan_speed   *speed;
> >         int                     num_speed;
> > };
> >=20
> > Based on this informations the GPIO fan driver could perform the
> > speed conversions (pwm, rpm, GPIO value) and then provide a hwmon
> > interface.
> >=20
> Sounds like a good idea to me.
>=20
> Couple of comments.
>=20
> Personally, I prefer to see num_XXX variables before the actual objects,
> but maybe that is just a personal preference.=20

Ok.

>=20
> I am not sure what one would do with "active_low". Would that be used
> for the alarm ?

Yes.

>=20
> Adding a "fault" object might make sense.

Yes.

>=20
> It seems that bit write order is missing. Since it is not always the
> same, as the proposed dns323 driver indicates, that might be a tricky
> problem to solve. You would have to come up with an at least somewhat
> generic solution for that.

Prevent from writing illegal GPIO values during some transitional states
is really a painful task. This workaround looks really due to a hardware
specific limitation. A different GPIO fan hardware could provide
different limitations. As an example, enabling a latch could be needed
to set the fan speed...

No one can predict all the possible hardware designs for a GPIO fan :)

So, rather than dealing with the specific issues within the driver, we
could simply allow board-setup code to override the "generic"
{get,set}_fan_control functions.

Simon

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky7GOUACgkQgtp0PDeOcDqcNACfUdfbgR+N9iLUOOEoAYzB/d9C
XZcAnR5ItRLy+G2JgvTmeB/Gtqyx2Z9o
=mWU6
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--


--===============0067160802848569131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0067160802848569131==--
