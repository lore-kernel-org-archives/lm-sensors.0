From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jul 2011 17:59:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Fix negative temperature
Message-Id: <1310061574.2387.7.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309876592-24015-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309876592-24015-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 2011-07-07 at 05:38 -0400, Jean Delvare wrote:
> On Tue, 5 Jul 2011 07:36:32 -0700, Guenter Roeck wrote:
> > Negative temperatures were returned in degrees C instead of milli-Degre=
es C.
> > Fix by multiplying with 1000.
> >=20
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/lm95241.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> > index f2cfecf..d1bbdf8 100644
> > --- a/drivers/hwmon/lm95241.c
> > +++ b/drivers/hwmon/lm95241.c
> > @@ -101,7 +101,7 @@ struct lm95241_data {
> >  static int TempFromReg(u8 val_h, u8 val_l)
> >  {
> >  	if (val_h & 0x80)
> > -		return val_h - 0x100;
> > +		return (val_h - 0x100) * 1000;
> >  	return val_h * 1000 + val_l * 1000 / 256;
> >  }
> > =20
>=20
> The fix is needed but is it sufficient? How comes that positive
> temperatures would be returned with a sub-degree resolution and negative
> ones with 1=C2=B0C resolution only? I don't see any such limitation in the
> datasheet.
>=20
> Also, negative values are really only 2's complement format so a simple
> cast should do (untested):
>=20
> 	s16 val_hl =3D (val_h << 8) | val_l;
> 	return val_hl * 1000 / 256;
>=20
Actually, it is getting more complicated than that. Like the LM95245,
the LM95241 supports both unsigned and signed temperature formats, and
the driver configures unsigned mode when loaded - meaning there are
actually no negative temperature values to report by default. I'll have
to change the code to take the chip configuration into account when
doing a conversion, similar to the LM95245 code.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
