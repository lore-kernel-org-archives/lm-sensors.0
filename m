From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Apr 2013 15:55:36 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/4] hwmon: (tmp401) Add support for TMP432
Message-Id: <20130421155536.GA18522@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1366478293-8167-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1366478293-8167-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Apr 21, 2013 at 11:35:03AM +0200, Jean Delvare wrote:
> On Sat, 20 Apr 2013 10:18:13 -0700, Guenter Roeck wrote:
> > TMP432 is similar to TMP431 with a second external temperature sensor.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v3: Add array entry for write critical temp register MSB
> >     (no idea how that got lost)
> > 
> > v2: Fixed spelling error in commit log
> >     Improved documentation
> > 
[ ... ]

> >  This driver implements support for Texas Instruments TMP401, TMP411,
> > -and TMP431 chips. These chips implement one remote and one local
> > -temperature sensor. Temperature is measured in degrees
> > +TMP431, and TMP432 chips. These chips implement one or two remote and
> > +one local temperature sensor. Temperature is measured in degrees
> 
> Shouldn't it be "sensors", plural?
> 
I never know. I changed it to sensors.

[ ... ]

> > +
> > +static const u8 TMP432_TEMP_MSB_WRITE[4][3] = {
> > +	{ 0, 0, 0 },		/* temp  - unused */
> > +	{ 0x0C, 0x0E, 0x16 },	/* low limit */
> > +	{ 0x0B, 0x0D, 0x15 },	/* high limit */
> > +	{ 0x20, 0x19, 0x1A },	/* therm (crit) limit */
> > +};
> > +
> > +static const u8 TMP432_TEMP_LSB[3][3] = {
> > +	{ 0x29, 0x10, 0x24 },	/* temp */
> > +	{ 0x3E, 0x14, 0x18 },	/* low limit */
> > +	{ 0x3D, 0x13, 0x17 },	/* high limit */
> > +};
> 
> TI engineers are idiots :( How hard was it to make both register maps
> compatible, really?
> 
Actually, to be fair, it seems to be a common theme that hardware engineers
tend to make it hard for software engineers by making unnecessary API changes.
I don't think that is on purpose, though. Keeping the API stable just doesn't
seem to be part of their training.

[ ... ]

> >  
> > +/* On TMP432, each status has its own register */
> > +#define TMP432_STATUS_LOCAL			BIT(0)
> > +#define TMP432_STATUS_REMOTE1			BIT(1)
> > +#define TMP432_STATUS_REMOTE2			BIT(2)
> 
> These are not strictly needed. Given that they match the driver's
> internal order, you could just pass 0, 1 and 2 as you do for every
> other attribute and use BIT() in the function itself as needed.
> 
> But well, I'm just thinking out loud, your code is fine so up to you.
> 
While it isn't needed, it saves an instruction or so in the function,
so I think it is still worth it.

I've made all the other changes you suggested.

[ ... ]

> All the rest looks good.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks a lot for the review!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
