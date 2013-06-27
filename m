From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Jun 2013 14:31:25 +0000
Subject: Re: [lm-sensors] [lm-sensors 1/2] hwmon: (ds1621) Add ds1721 chip support
Message-Id: <20130627143125.GA6047@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jun 27, 2013 at 10:36:31AM +0200, Jean Delvare wrote:
> I'm once again late, but I could not find the time to test your ds1621
> patches before today.
>=20
> On Wed, 8 May 2013 22:45:53 -0700, Robert Coulson wrote:
> > --- a/drivers/hwmon/ds1621.c
> > +++ b/drivers/hwmon/ds1621.c
> > (...)
> > +/*
> > + * TEMP: 0.001C/bit (-55C to +125C)
> > + * REG:
> > + *  - 1621, 1625: x =3D 0.5C
> > + *  - 1721:       x =3D 0.0625C
> > + * Assume highest resolution and let the bits fall where they may..
> > + */
> > +static inline u16 DS1621_TEMP_TO_REG(long temp)
> > +{
> > +	int ntemp =3D clamp_val(temp, DS1621_TEMP_MIN, DS1621_TEMP_MAX);
> > +	ntemp +=3D (ntemp < 0 ? -31 : 31);
> > +	ntemp =3D DIV_ROUND_CLOSEST(ntemp * 10, 625) << 4;
> > +	return (u16)ntemp;
> > +}
>=20
> This breaks limit rounding on the DS1621. Limits have a resolution of
> 0.5=B0C on that chip, so limit values should rounded to the closest
> half-degree. It used to work but no longer: if I write 20300 to
> temp1_min, it is rounded down to 20000, while it should be rounded up
> to 20500.
>=20
My fault, since I proposed that approach. Didn't I have the same problem
with some other driver ? Makes it even worse. I'll have to look up my notes.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
