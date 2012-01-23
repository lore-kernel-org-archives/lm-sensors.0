From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 23 Jan 2012 14:22:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for G781 and G781-1
Message-Id: <20120123142200.GA16697@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327275811-29546-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327275811-29546-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, Jan 23, 2012 at 04:26:09AM -0500, Jean Delvare wrote:
> On Sun, 22 Jan 2012 15:43:31 -0800, Guenter Roeck wrote:
> > GMT G781 and G781-1 are ADM1032-compatible temperature sensor chips. Add support
> > to the LM90 driver.
> > 
> > Cc: Mike Gorchak <lestat@i.com.ua>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Compile-tested only.
> > 
> >  drivers/hwmon/lm90.c |   16 +++++++++++++++-
> >  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> You'll also have to update Documentation/hwmon/lm90, Kconfig, the
> header comment of lm90.c and the address information comment right
> before normal_i2c[] in that file.
> 
ok

> > 
> > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > index 2e207de..7694b98 100644
> > --- a/drivers/hwmon/lm90.c
> > +++ b/drivers/hwmon/lm90.c
> > @@ -107,7 +107,7 @@ static const unsigned short normal_i2c[] = {
> >  	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> >  
> >  enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
> > -	max6646, w83l771, max6696, sa56004 };
> > +	max6646, w83l771, max6696, sa56004, g781 };
> >  
> >  /*
> >   * The LM90 registers
> > @@ -184,6 +184,7 @@ static const struct i2c_device_id lm90_id[] = {
> >  	{ "adm1032", adm1032 },
> >  	{ "adt7461", adt7461 },
> >  	{ "adt7461a", adt7461 },
> > +	{ "g781", g781 },
> >  	{ "lm90", lm90 },
> >  	{ "lm86", lm86 },
> >  	{ "lm89", lm86 },
> > @@ -229,6 +230,12 @@ static const struct lm90_params lm90_params[] = {
> >  		.alert_alarms = 0x7c,
> >  		.max_convrate = 10,
> >  	},
> > +	[g781] = {
> > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
> > +		  | LM90_HAVE_BROKEN_ALERT,
> 
> How do you know it has broken alert? Playing it safe, or does anything
> in the datasheet suggest so? So far, only Analog Devices chips are
> known to need this. I'd rather have Mike test first, and only put this
> flag if really needed (it has a cost.)
> 
Datasheet says "Note that the ALERT interrupt latch is not automatically
cleared when the status flag bit is cleared." Maybe I misunderstood that ?
No problem, though, I'll take it out.

> > +		.alert_alarms = 0x7c,
> > +		.max_convrate = 8,
> > +	},
> >  	[lm86] = {
> >  		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> >  		.alert_alarms = 0x7b,
> > @@ -1291,6 +1298,13 @@ static int lm90_detect(struct i2c_client *client,
> >  		 && convrate <= 0x09) {
> >  			name = "sa56004";
> >  		}
> > +	} else
> > +	if (man_id = 0x47) { /* GMT */
> > +		if (convrate <= 0x08
> > +		    && (config1 & 0x3F) = 0x00
> 
> Would be nice to use the same alignment logic as the rest of the code
> in this function, even though it might not be your preferred one.
> 
Sure.

> > +		    && ((address = 0x4C && chip_id = 0x01)      /* G781   */
> > +			|| (address = 0x4D && chip_id = 0x03))) /* G781-1 */
> 
> As for the sensors-detect patch, 0x01 is the right value for both
> variants of the chip.
> 
Datasheet says:

The G781 and G781-1 have the following SMBus
slave address:
	A6 A5 A4 A3 A2 A1 A0
G781	1  0  0  1  1  0  0
G781-1	1  0  0  1  1  0  1

and:

MFGIO	FEh		0100 0111	Manufacturer ID
DEVID	FFh	G781	0000 0001	Device ID
		G781-1	0000 0011

Obviously G781 can be on both addresses, but what to do with devid 0x03 ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
