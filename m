From: David Brownell <david-b@pacbell.net>
Date: Sat, 03 May 2008 15:20:41 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-git] lm75: add new-style driver
Message-Id: <200805030820.42304.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805020940.04227.david-b@pacbell.net>
In-Reply-To: <200805020940.04227.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 03 May 2008, Jean Delvare wrote:
> > +enum lm75_type {		/* keep sorted in alphabetical order */
> > +	ds1775,
> > +	ds75,
> > +	LM75,			/* UPPERCASE prevents INSMOD_1 conflict(!) */
> 
> Huu, this is ugly. Not really your fault, of course, the
> I2C_CLIENT_INSMOD stuff is ugly and there's not much we can do at this
> point.

Right ...


> I'm not only worried by the use of uppercase, that's only a 
> detail. What worries me more is the fact that a given chip type ends up
> being enumerated twice with different values, and a given type number
> corresponds to different chip types depending on which enum you look
> at. This has potential for future trouble. As this problem is likely to
> happen to all hybrid hardware monitoring drivers, I'd like to find a
> clean solution right now...

Fair enough.

 
> My proposal would be to only list in enum lm75_type, the types which
> are NOT declared by I2C_CLIENT_INSMOD. To prevent numbering conflict,
> you would start lm75_type at 9 (I2C_CLIENT_INSMOD_8 is the max.) See my
> proposed patch at the end of this post.

Looked OK to me, modulo a header comment (read infix below).

 
> > +	lm75a,
> > +	max6625,
> > +	max6626,
> > +	mcp980x,
> > +	stds75,
> > +	tcn75,
> > +	tmp100,
> > +	tmp101,
> > +	tmp175,
> > +	tmp275,
> > +	tmp75,
> > +};
> 
> Do you really need that many different types? I though that some of
> those parts were 100% compatible, at least as far as this driver is
> concerned. The more different types, the more tests you'll have to do
> at initialization time or even at run time.

ISTR most of them handle 12-bit encodings.  And it turns
out that the probe() code has most need to know about the
differences:  it's what will set up the state used by the rest
of the driver.  (Albeit not in this particular patch...)

Re compatibility, I think explicit listings inside driver
code lead to a lot less confusion and time wasted on writing
needless drivers; and it also avoids wondering "is it *really*
compatible?".  Plus it's easier to trust board init code that
matches the schematics (and other board docs).


> >  /* Each client has this additional data */
> >  struct lm75_data {
> > -	struct i2c_client	client;
> > +	struct i2c_client	*client;
> > +	enum lm75_type		type;
> 
> You don't use the type field anywhere. If you use it in a later patch,
> then add it in that patch.

Fair enough.  Your update doesn't remove it though...

 
> >  	struct device		*hwmon_dev;
> >  	struct mutex		update_lock;
> > +	u8			orig_conf;
> >  	char			valid;		/* !=0 if registers are valid */
> >  	unsigned long		last_updated;	/* In jiffies */
> > -	u16			temp[3];	/* Register values,
> > +	s16			temp[3];	/* Register values,
> 
> This too doesn't seem to belong to this patch any longer.

First time you commented on that, and that bugfix has been
in this patch for ages.  :)

Yeah, that could stand to get pulled out and merged ASAP.

 
> >  			...
> > +	{ "tmp75", tmp75, },
> > +	{ /* LIST END */ },
> 
> Trailing comma not needed - you can't grow the list beyond its end.

Doesn't hurt either.

> > +};
> > +MODULE_DEVICE_TABLE(i2c, lm75_ids);
> > (...)
> 
> Proposed patch:

ACK, modulo the comment below:

> ---
>  drivers/hwmon/lm75.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.26-rc0.orig/drivers/hwmon/lm75.c	2008-05-02 22:46:01.000000000 +0200
> +++ linux-2.6.26-rc0/drivers/hwmon/lm75.c	2008-05-03 10:01:15.000000000 +0200
> @@ -34,12 +34,14 @@
>   * This driver handles the LM75 and compatible digital temperature sensors.
>   * Compatibles include at least the DS75, DS1775, MCP980x, STDS75, TCN75,
>   * TMP100, TMP101, TMP75, TMP175, and TMP275.
> + * Only types which are _not_ part of I2C_CLIENT_INSMOD below, need to be
> + * enumerated here. We start at 9 because I2C_CLIENT_INSMOD can be used to
> + * define up to 8 chip types.
>   */

Better to also strike the "Compatibles include..." sentence;
it's already out of sync.

>  enum lm75_type {		/* keep sorted in alphabetical order */
> -	ds1775,
> +	ds1775 = 9,
>  	ds75,
> -	LM75,			/* UPPERCASE prevents INSMOD_1 conflict(!) */
>  	lm75a,
>  	max6625,
>  	max6626,
> @@ -72,7 +74,7 @@ static const u8 LM75_REG_TEMP[3] = {
>  /* Each client has this additional data */
>  struct lm75_data {
>  	struct i2c_client	*client;
> -	enum lm75_type		type;
> +	unsigned int		type;
>  	struct device		*hwmon_dev;
>  	struct mutex		update_lock;
>  	u8			orig_conf;
> @@ -220,7 +222,7 @@ static int lm75_remove(struct i2c_client
>  static const struct i2c_device_id lm75_ids[] = {
>  	{ "ds1775", ds1775, },
>  	{ "ds75", ds75, },
> -	{ "lm75", LM75, },
> +	{ "lm75", lm75, },
>  	{ "lm75a", lm75a, },
>  	{ "max6625", max6625, },
>  	{ "max6626", max6626, },
> 
> The advantages are: case consistency, each chip type has a single type
> number, and it is possible and easy to move types from the
> new-style-specific enum to the common one if needed. What do you think?

I think adding new chip support to legacy driver side
should be avoided.  ;)

- Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
