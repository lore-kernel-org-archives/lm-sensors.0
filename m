From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 30 Jan 2012 13:20:44 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120130132044.GD13788@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327784107-18923-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1327784107-18923-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Jan 30, 2012 at 03:45:02AM -0500, Jean Delvare wrote:
> Hi Uwe,
>=20
> On Sat, 28 Jan 2012 21:55:07 +0100, Uwe Kleine-K=F6nig wrote:
> > Based on a patch by David Jander that mostly did s/mc13783/mc13xxx/
> >=20
> > Cc: David Jander <david.jander@protonic.nl>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > I didn't manage to send this "later today" as promised yesterday. So it
> > comes only today.
>=20
> No problem :)
>=20
> > changes since v2:
> >  - make code generating name attribute more robust and strip [-_]adc
> >  - consistenly use MC13783_ADC_16CHANS / mc13783_attr_16chans
>=20
> Thanks for the update. I have a few more comments, but these are only
> minor things.
>=20
> >  Documentation/hwmon/mc13783-adc |   48 ++++++++++++----
> >  drivers/hwmon/Kconfig           |    6 +-
> >  drivers/hwmon/mc13783-adc.c     |  116 +++++++++++++++++++++++++++++--=
--------
> >  3 files changed, 126 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/Documentation/hwmon/mc13783-adc b/Documentation/hwmon/mc13=
783-adc
> > index 044531a..86f6da5 100644
> > --- a/Documentation/hwmon/mc13783-adc
> > +++ b/Documentation/hwmon/mc13783-adc
> > @@ -5,6 +5,9 @@ Supported chips:
> >    * Freescale Atlas MC13783
> >      Prefix: 'mc13783_adc'
> >      Datasheet: http://www.freescale.com/files/rf_if/doc/data_sheet/MC1=
3783.pdf?fsrch=3D1
> > +  * Freescale Atlas MC13892
> > +    Prefix: 'mc13892_adc'
> > +    Datasheet: http://cache.freescale.com/files/analog/doc/data_sheet/=
MC13892.pdf?fsrch=3D1&sr=3D1
>=20
> The _adc is gone from the prefixes with this version, so the
> documentation should be updated to reflect that.
>=20
> >  static ssize_t mc13783_adc_show_name(struct device *dev, struct device=
_attribute
> >  			      *devattr, char *buf)
> >  {
> > -	return sprintf(buf, "mc13783_adc\n");
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
>=20
> When you don't need pdev itself, the above can be abbreviated as:
>=20
> 	struct mc13783_adc_priv *priv =3D dev_get_drvdata(dev);
>=20
> Same in function mc13783_adc_read(). This can be cleaned up later, gcc
> is apparently smart enough to optimize it anyway.
>=20
> All the rest looks good, so assuming the prefixes get fixed in the docume=
ntation,
>=20
> Acked-by: Jean Delvare <khali@linux-fr.org>
>=20
> Guenter, how do we proceed? I see you have a small cleanup patch to the
> mc13783-adc driver in your tree, the same cleanup is included in Uwe's
> patch so they will conflict. Let me know if you want to take Uwe's
> patch and handle the conflict, or prefer to drop the cleanup patch from
> you tree and let me handle that driver for this cycle. Either way is
> fine with me, as long as it actually happens.
>=20
I'll drop the cleanup patch. Isn't much anyway.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
