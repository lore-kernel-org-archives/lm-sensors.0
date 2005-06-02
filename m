From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 02 Jun 2005 07:24:43 +0000
Subject: [lm-sensors] RFC PATCH I2C adm9240: add alarms_mask accessor?
Message-Id: <utss91ldg3dta6097f186ld3dilkjnbrb6@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Before I recast this patch to development kernel, I would like 
to confirm I've not duplicated a libsensors option :)

Test user wants to mask alarm status, specifically chassis 
intrusion, I thought it would be easy, but turns out adm9240 
masked interrupt stills reports alarm state, so I masked status 
in driver...  If the idea not gonna fly I wont bother going 
further.  

Particularly if I missed a libsensors option to do same.

Run tested 2.6.11.11 -- for comment.

Thanks,
--Grant.
 

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 48 insertions(+), 7 deletions(-)

--- linux-2.6.11.11b/drivers/i2c/chips/adm9240.c	2005-06-02 12:11:13.000000000 +1000
+++ linux-2.6.11.11a/drivers/i2c/chips/adm9240.c	2005-06-02 12:13:32.000000000 +1000
@@ -164,7 +164,8 @@ struct adm9240_data {
 	s16 temp;		/* ro	temp1_input, 9-bit sign-extended */
 	s8 temp_high;		/* rw	temp1_max */
 	s8 temp_hyst;		/* rw	temp1_max_hyst */
-	u16 alarms;		/* ro	alarms */
+	u8 alarms[2];		/* ro	alarms, lo, hi */
+	u8 alarms_mask[2];	/* rw	alarms_mask, lo, hi */
 	u8 aout;		/* rw	aout_output */
 	u8 vid;			/* ro	vid */
 	u8 vrm;			/* --	vrm set on startup, no accessor */
@@ -428,14 +429,50 @@ static DEVICE_ATTR(fan##offset##_min, S_
 show_fan_offset(1);
 show_fan_offset(2);
 
-/* alarms */
+/* alarms - adm9240 interrupt mask does not disable alarm status bit,
+ * so we mask alarm status bits to match user-set alarms_mask */
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%u\n", data->alarms);
+	u8 alarms_masked[2];
+	unsigned i;
+
+	for (i = 0; i < 2; i++)
+		alarms_masked[i] = data->alarms[i] & (~data->alarms_mask[i]);
+
+	return sprintf(buf, "%u\n", (alarms_masked[1] << 8)
+			| alarms_masked[0]);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t show_alarms_mask(struct device *dev, char *buf)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%u\n", (data->alarms_mask[1] << 8)
+			| data->alarms_mask[0]);
+}
+
+static ssize_t set_alarms_mask(struct device *dev, const char *buf,
+		size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtol(buf, NULL, 10);
+
+	val &= 0x13df; /* clear reserved and /reset_enable bits */
+	down(&data->update_lock);
+	data->alarms_mask[0] = val & 0xff;
+	data->alarms_mask[1] = val >> 8;
+	adm9240_write_value(client, ADM9240_REG_INT_MASK(0),
+			data->alarms_mask[0]);
+	adm9240_write_value(client, ADM9240_REG_INT_MASK(1),
+			data->alarms_mask[1]);
+	up(&data->update_lock);
+	return count;
+}
+static DEVICE_ATTR(alarms_mask, S_IRUGO | S_IWUSR, show_alarms_mask, 
+		set_alarms_mask);
+
 /* vid */
 static ssize_t show_vid(struct device *dev, char *buf)
 {
@@ -590,6 +627,7 @@ static int adm9240_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_fan2_min);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_alarms_mask);
 	device_create_file(&new_client->dev, &dev_attr_aout_output);
 	device_create_file(&new_client->dev, &dev_attr_chassis_clear);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
@@ -678,10 +716,11 @@ static struct adm9240_data *adm9240_upda
 			data->in[i] = adm9240_read_value(client,
 					ADM9240_REG_IN(i));
 		}
-		data->alarms = adm9240_read_value(client,
-					ADM9240_REG_INT(0)) |
-					adm9240_read_value(client,
-					ADM9240_REG_INT(1)) << 8;
+
+		data->alarms[0] = adm9240_read_value(client,
+					ADM9240_REG_INT(0));
+		data->alarms[1] = adm9240_read_value(client,
+					ADM9240_REG_INT(1));
 
 		/* read temperature: assume temperature changes less than
 		 * 0.5'C per two measurement cycles thus ignore possible
@@ -727,6 +766,8 @@ static struct adm9240_data *adm9240_upda
 		{
 			data->fan_min[i] = adm9240_read_value(client,
 					ADM9240_REG_FAN_MIN(i));
+			data->alarms_mask[i] = adm9240_read_value(client,
+					ADM9240_REG_INT_MASK(i));
 		}
 		data->temp_high = adm9240_read_value(client,
 				ADM9240_REG_TEMP_HIGH);
