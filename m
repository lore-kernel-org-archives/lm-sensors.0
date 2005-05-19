From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: sysfs names
Message-Id: <20040219024545.GF21829@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Greg KH <greg@kroah.com> [2004-02-18 14:03:17 -0800]:
> On Sun, Feb 15, 2004 at 07:36:33PM +0100, Jean Delvare wrote:
> > > In looking at these drivers they can easily be shrunk today with just
> > > a bit of rewriting of the functions and macros.  I sure wasn't
> > > thinking about driver size when writing the first few ones, and it
> > > looks like everyone has copied my "style" in the rest of them.
> > 
> > If you could provide an example of how to do that, I'm interested in
> > shrinking the existing drivers.
> 
> Hm, I thought I saw some drivers that could be shrunk, but at a quick
> glance, I was wrong.  It's probably not worth the complexity...

One little bit of refactoring I see is this... bah, it only saves ~19
lines and 150 bytes.  Is it worth it to do this to all the drivers?
(compiles, untested but pretty trivial)

--- linux-2.6.3-orig/drivers/i2c/chips/lm78.c	2004-02-10 12:55:15.000000000 -0500
+++ linux-2.6.3-mmh/drivers/i2c/chips/lm78.c	2004-02-18 21:36:42.000000000 -0500
@@ -223,7 +223,7 @@
 
 static int lm78_read_value(struct i2c_client *client, u8 register);
 static int lm78_write_value(struct i2c_client *client, u8 register, u8 value);
-static void lm78_update_client(struct i2c_client *client);
+static struct lm78_data *lm78_update_device(struct device *dev);
 static void lm78_init_client(struct i2c_client *client);
 
 
@@ -239,25 +239,19 @@
 /* 7 Voltages */
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
 }
 
@@ -327,17 +321,13 @@
 /* Temperature */
 static ssize_t show_temp(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
 static ssize_t show_temp_over(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
@@ -353,9 +343,7 @@
 
 static ssize_t show_temp_hyst(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }
 
@@ -378,18 +366,14 @@
 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
 
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
@@ -407,9 +391,7 @@
 
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
 
@@ -490,9 +472,7 @@
 /* VID */
 static ssize_t show_vid(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
 }
 static DEVICE_ATTR(vid, S_IRUGO, show_vid, NULL);
@@ -500,9 +480,7 @@
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm78_data *data = i2c_get_clientdata(client);
-	lm78_update_client(client);
+	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
@@ -829,8 +807,9 @@
 
 }
 
-static void lm78_update_client(struct i2c_client *client)
+static struct lm78_data *lm78_update_device(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
 	int i;
 
@@ -879,6 +858,8 @@
 	}
 
 	up(&data->update_lock);
+
+	return data;
 }
 
 static int __init sm_lm78_init(void)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
