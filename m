From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Sep 2009 11:32:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1031) Add sysfs files for
Message-Id: <20090917133205.5f137e4f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090630183918.GA3322@ovro.caltech.edu>
In-Reply-To: <20090630183918.GA3322@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 14 Sep 2009 22:48:46 +0200, Jean Delvare wrote:
> Hi Ira,
>=20
> On Tue, 30 Jun 2009 11:39:18 -0700, Ira Snyder wrote:
> > The ADM1030/ADM1031 chips have temperature offset registers, for both t=
he
> > local and remote temperature sensors. Following the example set forth in
> > the LM90/ADM1032 driver, expose the offset registers to userspace.
> >=20
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > ---
> >=20
> > I have tested this with an adm1031 chip, and I see the offsets as
> > expected. I do not have any other compatible chips to test with, however
> > I read the adm1030 datasheet, and everything should work fine.
> >=20
> > On the adm1031, the datasheet claims the offset registers can be used to
> > add/subtract 15 degC from the temperature reading. I have found that it
> > is actually possible to add 15 degC and subtract 16 degC. Following the
> > data sheet, I clamped the value to +- 15 degC, just in case other chips
> > are not compatible.
> >=20
> >  drivers/hwmon/adm1031.c |   40 ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 40 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> > index 7894418..5690595 100644
> > --- a/drivers/hwmon/adm1031.c
> > +++ b/drivers/hwmon/adm1031.c
> > @@ -145,6 +147,10 @@ adm1031_write_value(struct i2c_client *client, u8 =
reg, unsigned int value)
> > =20
> >  #define TEMP_FROM_REG_EXT(val, ext)	(TEMP_FROM_REG(val) + (ext) * 125)
> > =20
> > +#define TEMP_OFFSET_TO_REG(val)		(TEMP_TO_REG(val) & 0x8f)
> > +#define TEMP_OFFSET_FROM_REG(val)	TEMP_FROM_REG((val) < 0 ? \
> > +						      (val) | 0x70 : (val))
>=20
> This is not how I read the datasheet for negative offsets. The ADM1030
> datasheet says that -1=B0C would be coded 0x81, while your implementation
> would decode 0x81 to -15=B0C. But I admit the datasheet isn't too clear
> either... Did you test your code with negative offsets and found that
> it works OK?

Oh well, I've tested your patch on my ADM1031 evaluation board and it
seems to work just fine. So, consider it applied.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
