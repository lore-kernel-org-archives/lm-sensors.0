From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <20050326183138.1256d53c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/ds1621.c	2005-03-23 06:34:25.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/ds1621.c	2005-03-26 11:40:20.000000000 +1100
@@ -153,8 +153,11 @@
>  {									\
>  	struct i2c_client *client = to_i2c_client(dev);			\
>  	struct ds1621_data *data = ds1621_update_client(dev);		\
> +\

Please keep the backslash aligned with the other lines.

> --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscher.c	2005-03-23 06:34:25.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/fscher.c	2005-03-26 11:40:20.000000000 +1100
> @@ -497,6 +501,8 @@
>  	/* supported values: 2, 4, 8 */
>  	unsigned long v = simple_strtoul(buf, NULL, 10);
>  
> +	down(&data->update_lock);
> +
>  	switch (v) {
>  	case 2: v = 1; break;
>  	case 4: v = 2; break;
> @@ -504,14 +510,16 @@
>  	default:
>  		dev_err(&client->dev, "fan_div value %ld not "
>  			 "supported. Choose one of 2, 4 or 8!\n", v);
> +		up(&data->update_lock);
>  		return -EINVAL;
>  	}
>  

You can move the down() after the swicth block here.

> @@ -645,9 +661,10 @@
>  static ssize_t set_watchdog_preset(struct i2c_client *client, struct
>  fscher_data *data,
>  				   const char *buf, size_t count, int nr, int reg)
>  {
> +	down(&data->update_lock);
>  	data->watchdog[0] = simple_strtoul(buf, NULL, 10) & 0xff;
> -
>  	fscher_write_value(client, reg, data->watchdog[0]);
> +	up(&data->update_lock);
>  	return count;
>  }

Please move the call to simple_strtoul() outside of the lock, like the
other functions do.

> --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscpos.c	2005-03-23 06:34:25.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/fscpos.c	2005-03-26 11:40:20.000000000 +1100

You missed set_wdog_preset.



> --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl518sm.c	2005-03-23 06:34:25.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/gl518sm.c	2005-03-26 11:40:20.000000000 +1100
@@ -211,8 +211,11 @@
>  	struct i2c_client *client = to_i2c_client(dev);			\
>  	struct gl518_data *data = i2c_get_clientdata(client);		\
>  	long val = simple_strtol(buf, NULL, 10);			\
> +\

Keep it aligned.

> @@ -222,11 +225,15 @@
>  {									\
>  	struct i2c_client *client = to_i2c_client(dev);			\
>  	struct gl518_data *data = i2c_get_clientdata(client);		\
> -	int regvalue = gl518_read_value(client, reg);			\
> +	int regvalue;							\
>  	unsigned long val = simple_strtoul(buf, NULL, 10);		\
> +\

Same here.

> @@ -255,7 +262,10 @@
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct gl518_data *data = i2c_get_clientdata(client);
> -	int regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
> +	int regvalue;
> +

You could delete think blank line so as to keep set_fan_min1 and
set_fan_min2 "visualy identical".


> --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl520sm.c	2005-03-23 06:34:25.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/gl520sm.c	2005-03-26 11:40:20.000000000 +1100
@@ -299,6 +299,8 @@
>  static ssize_t set_in_min(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg) {
>  	long v = simple_strtol(buf, NULL, 10);
> +
> +	down(&data->update_lock);
>  	u8 r;

Nah, this won't work. All variable declarations must happen prior to any
instruction. Additionally, you can move the down() below the if
statement where the value of r is computed.

>  static ssize_t set_in_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg) {
>  	long v = simple_strtol(buf, NULL, 10);
> +
> +	down(&data->update_lock);
>  	u8 r;

Same here, obviously

> @@ -363,6 +369,8 @@
>  static ssize_t set_fan_min(struct i2c_client *client, struct
>  gl520_data *data, const char *buf, size_t count, int n, int reg) {
>  	unsigned long v = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
>  	u8 r = FAN_TO_REG(v, data->fan_div[n - 1]);

Meeeep! ;)
You'll have to split the declatation from the assignment.

>  static ssize_t set_fan_div(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg) {
>  	unsigned long v = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
>  	u8 r;

Same here. Additionally, you can move the down() after the switch block.


>  	if (n = 1)
> -		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xc0) | (r << 6));
> +		gl520_write_value(client, reg, (gl520_read_value(client, reg)
> +					& ~0xc0) | (r << 6));
>  	else
> -		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x30) | (r << 4));
> +		gl520_write_value(client, reg, (gl520_read_value(client, reg)
> +					& ~0x30) | (r << 4));

Please don't include changes which are not related to the locking issue.
You'll have all the time to propose changes later.

> -	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x0c) | (r << 2));
> +	gl520_write_value(client, reg, (gl520_read_value(client, reg)
> +				& ~0x0c) | (r << 2));

Same here, don't.

> @@ -439,22 +458,28 @@
>  static ssize_t set_temp_max(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg) {
>  	long v = simple_strtol(buf, NULL, 10);
> +
> +	down(&data->update_lock);
>  	u8 r = TEMP_TO_REG(v);

Wrong order again.

>  static ssize_t set_temp_max_hyst(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg) {
>  	long v = simple_strtol(buf, NULL, 10);
> +
> +	down(&data->update_lock);
>  	u8 r = TEMP_TO_REG(v);

Here as well.

> -	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x04) | (r << 2));
> +	gl520_write_value(client, reg, (gl520_read_value(client, reg)
> +				& ~0x04) | (r << 2));

Don't.

>  static ssize_t set_beep_mask(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg) {
> +	down(&data->update_lock);
>  	u8 r = simple_strtoul(buf, NULL, 10) & data->alarm_mask;

Wrong order, you have to split it.

Mmmm, looks like gl520sm wasn't your best one ;)

Skipping pcf8574 and pcf8591, they are different chip and might need
special handling.

>  --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/via686a.c	2005-03-23 06:34:26.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/via686a.c	2005-03-26 11:40:20.000000000 +1100
> @@ -511,10 +526,13 @@
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct via686a_data *data = i2c_get_clientdata(client);
>  	int val = simple_strtol(buf, NULL, 10);
> +
> +	down(&data->update_lock);
>  	int old = via686a_read_value(client, VIA686A_REG_FANDIV);

Wrong order here, move declaration up.

> --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83627hf.c	2005-03-26 07:26:41.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83627hf.c	2005-03-26 11:40:20.000000000 +1100
> @@ -354,10 +354,13 @@
>  	u32 val; \
>  	 \
>  	val = simple_strtoul(buf, NULL, 10); \
> +\

Please align like the other blank lines.

> @@ -573,6 +587,8 @@
>  	u32 val; \
>  	 \
>  	val = simple_strtoul(buf, NULL, 10); \
> +\

Same here.

> --- linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83781d.c	2005-03-23 06:34:26.000000000 +1100
> +++ linux-2.6.12-rc1-mm3b/drivers/i2c/chips/w83781d.c	2005-03-26 11:40:20.000000000 +1100
> @@ -302,9 +302,12 @@
>  	u32 val; \
>  	 \
>  	val = simple_strtoul(buf, NULL, 10) / 10; \
> +\

Same here.

> @@ -431,6 +437,8 @@
>  	s32 val; \
>  	 \
>  	val = simple_strtol(buf, NULL, 10); \
> +\
> +	down(&data->update_lock); \

And here.

> @@ -859,6 +884,8 @@
>  	struct w83781d_data *data = i2c_get_clientdata(client);
>  	u32 val, i;
>  
> +	down(&data->update_lock);
> +
>  	for (i = 0; i < count; i++) {
>  		val = simple_strtoul(buf + count, NULL, 10);

BTW, there is a bug here, isn't it? "buf + count" makes no sense? "buf +
i" would make more, but would still not work as far as I can see. It's
plain broken to me. This would tend to prove that nobody ever used this
function... Couldn't we just get rid of that RT thing? I always wondered
who was using this, and now the answer seems to be "no one".

Soooo... that's not so bad (except gl520sm), please fix all points I
listed here and post new patches.

I would also appreciate if you could review my own patches now. There is
no reason you would have made mistakes and I wouldn't, after all. The
best way to check is to apply the patch and check the new driver code.
Checking the patches directly doesn't help that much, as you'll miss the
in-function returns lacking up() and the functions lacking locking
altogether.

Remaining drivers:
ds1337, isp1301_omap, m41t00, rtc8564: Don't use sysfs, so we don't care
smsc47b397: read-only, so no changes needed.

So we covered all chip driver :) Once cross-review and fixes are done we
can build the big patch and send it over.

Thanks,
-- 
Jean Delvare
