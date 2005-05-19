From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030623234114.GB11698@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 19, 2003 at 06:45:36PM -0700, Philip Pokorny wrote:
> The data->foo and device register need to be in sync.  So I suppose both...
> 
> At first I thought that if I always updated the chip first and then the 
> data->foo cached value, I'd be OK, but it seemed like there were too 
> many exceptions where values were broken apart, or recombined...
> 
> The primary thing I was trying to avoid was one CPU writing a value 
> while another CPU was reading a value (and therefore calling 
> update_client) and the result being that the data->foo cached value was 
> different from actual device register.

But if that happens, then the worse thing that could happen is we would
show "stale" data in the resulting value.

Hm, so I can understand if we need to protect access to the hardware
when we read two values in a row, like this:
                res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
                res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;

or the same thing when writing.

But what about this simpler patch, that pushes the lock down to the
hardware reads and writes for multiple registers.  And it doesn't try to
mirror the write in the "data" structure, as it's always read with the
latest values for every read.

Does it look ok?  It has the added benefit of making the .c and .o files
smaller :)

thanks,

greg k-h


# I2C: clean up lm85's locking code.

diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Jun 23 16:39:23 2003
+++ b/drivers/i2c/chips/lm85.c	Mon Jun 23 16:39:23 2003
@@ -433,14 +433,11 @@
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
 	int	val;
 
-	down(&data->update_lock);
 	val = simple_strtol(buf, NULL, 10);
-	data->fan_min[nr] = FAN_TO_REG(val);
-	lm85_write_value(client, LM85_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	val = FAN_TO_REG(val);
+	lm85_write_value(client, LM85_REG_FAN_MIN(nr), val);
 	return count;
 }
 
@@ -527,14 +524,11 @@
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
 	int	val;
 
-	down(&data->update_lock);
 	val = simple_strtol(buf, NULL, 10);
-	data->pwm[nr] = PWM_TO_REG(val);
-	lm85_write_value(client, LM85_REG_PWM(nr), data->pwm[nr]);
-	up(&data->update_lock);
+	val = PWM_TO_REG(val);
+	lm85_write_value(client, LM85_REG_PWM(nr), val);
 	return count;
 }
 static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
@@ -592,14 +586,11 @@
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
 	int	val;
 
-	down(&data->update_lock);
 	val = simple_strtol(buf, NULL, 10);
-	data->in_min[nr] = INS_TO_REG(nr, val);
-	lm85_write_value(client, LM85_REG_IN_MIN(nr), data->in_min[nr]);
-	up(&data->update_lock);
+	val = INS_TO_REG(nr, val);
+	lm85_write_value(client, LM85_REG_IN_MIN(nr), val);
 	return count;
 }
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
@@ -614,14 +605,11 @@
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
 	int	val;
 
-	down(&data->update_lock);
 	val = simple_strtol(buf, NULL, 10);
-	data->in_max[nr] = INS_TO_REG(nr, val);
-	lm85_write_value(client, LM85_REG_IN_MAX(nr), data->in_max[nr]);
-	up(&data->update_lock);
+	val = INS_TO_REG(nr, val);
+	lm85_write_value(client, LM85_REG_IN_MAX(nr), val);
 	return count;
 }
 #define show_in_reg(offset)						\
@@ -681,14 +669,11 @@
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
 	int	val;
 
-	down(&data->update_lock);
 	val = simple_strtol(buf, NULL, 10);
-	data->temp_min[nr] = TEMP_TO_REG(val);
-	lm85_write_value(client, LM85_REG_TEMP_MIN(nr), data->temp_min[nr]);
-	up(&data->update_lock);
+	val = TEMP_TO_REG(val);
+	lm85_write_value(client, LM85_REG_TEMP_MIN(nr), val);
 	return count;
 }
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
@@ -703,14 +688,11 @@
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
 	int	val;
 
-	down(&data->update_lock);
 	val = simple_strtol(buf, NULL, 10);
-	data->temp_max[nr] = TEMP_TO_REG(val);
-	lm85_write_value(client, LM85_REG_TEMP_MAX(nr), data->temp_max[nr]);
-	up(&data->update_lock);
+	val = TEMP_TO_REG(val);
+	lm85_write_value(client, LM85_REG_TEMP_MAX(nr), val);
 	return count;
 }
 #define show_temp_reg(offset)						\
@@ -955,8 +937,12 @@
 
 int lm85_read_value(struct i2c_client *client, u8 reg)
 {
+	struct lm85_data *data = i2c_get_clientdata(client);
 	int res;
 
+	/* serialize access to the hardware */
+	down(&data->update_lock);
+
 	/* What size location is it? */
 	switch( reg ) {
 	case LM85_REG_FAN(0) :  /* Read WORD data */
@@ -980,14 +966,19 @@
 		res = i2c_smbus_read_byte_data(client, reg);
 		break ;
 	}
+	up(&data->update_lock);
 
 	return res ;
 }
 
 int lm85_write_value(struct i2c_client *client, u8 reg, int value)
 {
+	struct lm85_data *data = i2c_get_clientdata(client);
 	int res ;
 
+	/* serialize access to the hardware */
+	down(&data->update_lock);
+
 	switch( reg ) {
 	case LM85_REG_FAN(0) :  /* Write WORD data */
 	case LM85_REG_FAN(1) :
@@ -1009,6 +1000,7 @@
 		res = i2c_smbus_write_byte_data(client, reg, value);
 		break ;
 	}
+	up(&data->update_lock);
 
 	return res ;
 }
@@ -1070,8 +1062,6 @@
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int i;
 
-	down(&data->update_lock);
-
 	if ( !data->valid ||
 	     (jiffies - data->last_reading > LM85_DATA_INTERVAL ) ) {
 		/* Things that change quickly */
@@ -1209,8 +1199,6 @@
 	};  /* last_config */
 
 	data->valid = 1;
-
-	up(&data->update_lock);
 }
 
 
