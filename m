From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 09:18:40 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-git] lm75: add new-style driver
Message-Id: <20080503111840.4440360b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805020940.04227.david-b@pacbell.net>
In-Reply-To: <200805020940.04227.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Fri, 2 May 2008 09:40:03 -0700, David Brownell wrote:
> On Sunday 20 April 2008, Jean Delvare wrote:
> > Alternatively, you could just move the addition of the min and max
> > settings the next patch in the series, as I can't really see how they
> > are related to converting the driver to new-style i2c
> 
> Done.  This goes on top of
> 
>    http://marc.info/?l=lm-sensors&m0880547009929&w=2
> 
> and *CURRENT* git (with updates to driver modle style binding).
> 
> IMO these two patches should go into the hwmon queue ASAP
> (first one seems overdue for merge mainstream, FWIW).

Agreed. But I still would like to suggest one more update to this
second patch:

> 
> ==== CUT HERE
> More LM75 updates:
> 
>  - Teach the LM75 driver to use new-style driver binding:
> 
>      * Create a second driver struct, using new-style driver binding
>        methods cribbed from the legacy code.
> 
>      * Add a MODULE_DEVICE_TABLE (for "newER-style binding")
> 
>      * The legacy probe logic delegates its work to this new code.
> 
>      * The legacy driver uses the name "lm75_legacy".
> 
>  - Sensor range bugfix:  values are signed, not unsigned.
> 
>  - More careful initialization.  Chips are put into 9-bit mode so
>    the current interconversion routines will never fail.
> 
>  - Save the original chip configuration, and restore it on exit.
> 
> So the new-style code should catch all chips that boards declare,
> while the legacy code catches others.  This particular coexistence
> strategy may need some work yet ... legacy modes might best be set
> up explicitly by some tool not unlike "sensors-detect".  (Or else
> completely eradicated...)
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> UPDATED:  applies against update first patch.  Support for 12-bit
> conversions moves into a later patch.
> 
>  drivers/hwmon/Kconfig |    7 +
>  drivers/hwmon/lm75.c  |  204 ++++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 164 insertions(+), 47 deletions(-)
> 
> (...)
> --- g26.orig/drivers/hwmon/lm75.c	2008-05-01 23:39:13.000000000 -0700
> +++ g26/drivers/hwmon/lm75.c	2008-05-01 23:41:53.000000000 -0700
> @@ -36,6 +36,23 @@
>   * TMP100, TMP101, TMP75, TMP175, and TMP275.
>   */
>  
> +enum lm75_type {		/* keep sorted in alphabetical order */
> +	ds1775,
> +	ds75,
> +	LM75,			/* UPPERCASE prevents INSMOD_1 conflict(!) */

Huu, this is ugly. Not really your fault, of course, the
I2C_CLIENT_INSMOD stuff is ugly and there's not much we can do at this
point. I'm not only worried by the use of uppercase, that's only a
detail. What worries me more is the fact that a given chip type ends up
being enumerated twice with different values, and a given type number
corresponds to different chip types depending on which enum you look
at. This has potential for future trouble. As this problem is likely to
happen to all hybrid hardware monitoring drivers, I'd like to find a
clean solution right now...

My proposal would be to only list in enum lm75_type, the types which
are NOT declared by I2C_CLIENT_INSMOD. To prevent numbering conflict,
you would start lm75_type at 9 (I2C_CLIENT_INSMOD_8 is the max.) See my
proposed patch at the end of this post.

> +	lm75a,
> +	max6625,
> +	max6626,
> +	mcp980x,
> +	stds75,
> +	tcn75,
> +	tmp100,
> +	tmp101,
> +	tmp175,
> +	tmp275,
> +	tmp75,
> +};

Do you really need that many different types? I though that some of
those parts were 100% compatible, at least as far as this driver is
concerned. The more different types, the more tests you'll have to do
at initialization time or even at run time.

> +
>  /* Addresses scanned by legacy style driver binding */
>  static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
>  					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> @@ -54,18 +71,19 @@ static const u8 LM75_REG_TEMP[3] = {
>  
>  /* Each client has this additional data */
>  struct lm75_data {
> -	struct i2c_client	client;
> +	struct i2c_client	*client;
> +	enum lm75_type		type;

You don't use the type field anywhere. If you use it in a later patch,
then add it in that patch.

>  	struct device		*hwmon_dev;
>  	struct mutex		update_lock;
> +	u8			orig_conf;
>  	char			valid;		/* !=0 if registers are valid */
>  	unsigned long		last_updated;	/* In jiffies */
> -	u16			temp[3];	/* Register values,
> +	s16			temp[3];	/* Register values,

This too doesn't seem to belong to this patch any longer.

>  						   0 = input
>  						   1 = max
>  						   2 = hyst */
>  };

> (...)
> +static const struct i2c_device_id lm75_ids[] = {
> +	{ "ds1775", ds1775, },
> +	{ "ds75", ds75, },
> +	{ "lm75", LM75, },
> +	{ "lm75a", lm75a, },
> +	{ "max6625", max6625, },
> +	{ "max6626", max6626, },
> +	{ "mcp980x", mcp980x, },
> +	{ "stds75", stds75, },
> +	{ "tcn75", tcn75, },
> +	{ "tmp100", tmp100, },
> +	{ "tmp101", tmp101, },
> +	{ "tmp175", tmp175, },
> +	{ "tmp275", tmp275, },
> +	{ "tmp75", tmp75, },
> +	{ /* LIST END */ },

Trailing comma not needed - you can't grow the list beyond its end.

> +};
> +MODULE_DEVICE_TABLE(i2c, lm75_ids);
> (...)

Proposed patch:

---
 drivers/hwmon/lm75.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.26-rc0.orig/drivers/hwmon/lm75.c	2008-05-02 22:46:01.000000000 +0200
+++ linux-2.6.26-rc0/drivers/hwmon/lm75.c	2008-05-03 10:01:15.000000000 +0200
@@ -34,12 +34,14 @@
  * This driver handles the LM75 and compatible digital temperature sensors.
  * Compatibles include at least the DS75, DS1775, MCP980x, STDS75, TCN75,
  * TMP100, TMP101, TMP75, TMP175, and TMP275.
+ * Only types which are _not_ part of I2C_CLIENT_INSMOD below, need to be
+ * enumerated here. We start at 9 because I2C_CLIENT_INSMOD can be used to
+ * define up to 8 chip types.
  */
 
 enum lm75_type {		/* keep sorted in alphabetical order */
-	ds1775,
+	ds1775 = 9,
 	ds75,
-	LM75,			/* UPPERCASE prevents INSMOD_1 conflict(!) */
 	lm75a,
 	max6625,
 	max6626,
@@ -72,7 +74,7 @@ static const u8 LM75_REG_TEMP[3] = {
 /* Each client has this additional data */
 struct lm75_data {
 	struct i2c_client	*client;
-	enum lm75_type		type;
+	unsigned int		type;
 	struct device		*hwmon_dev;
 	struct mutex		update_lock;
 	u8			orig_conf;
@@ -220,7 +222,7 @@ static int lm75_remove(struct i2c_client
 static const struct i2c_device_id lm75_ids[] = {
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
-	{ "lm75", LM75, },
+	{ "lm75", lm75, },
 	{ "lm75a", lm75a, },
 	{ "max6625", max6625, },
 	{ "max6626", max6626, },

The advantages are: case consistency, each chip type has a single type
number, and it is possible and easy to move types from the
new-style-specific enum to the common one if needed. What do you think?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
