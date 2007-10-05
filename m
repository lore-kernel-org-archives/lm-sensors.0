From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 05 Oct 2007 07:42:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm90: Export temperature offset
Message-Id: <4705EAE9.9040603@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070905141537.58990ad4@hyperion.delvare>
In-Reply-To: <20070905141537.58990ad4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

In this post:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021154.html

Jean Delvare wrote:
--------------------------------------------
Now that we have standard sysfs names to export temperature offset
values, add this feature to the lm90 driver. All supported chips
except the MAX6657, MAX6658 and MAX6659 support it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
  drivers/hwmon/lm90.c |   29 +++++++++++++++++++++++++----
  1 file changed, 25 insertions(+), 4 deletions(-)

--- linux-2.6.23-rc5.orig/drivers/hwmon/lm90.c	2007-09-05 09:20:57.000000000 +0200
+++ linux-2.6.23-rc5/drivers/hwmon/lm90.c	2007-09-05 13:54:51.000000000 +0200
@@ -41,7 +41,8 @@
   *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
   * Note that there is no easy way to differentiate between the three
   * variants. The extra address and features of the MAX6659 are not
- * supported by this driver.
+ * supported by this driver. These chips lack the remote temperature
+ * offset feature.
   *
   * This driver also supports the MAX6680 and MAX6681, two other sensor
   * chips made by Maxim. These are quite similar to the other Maxim
@@ -226,9 +227,10 @@ struct lm90_data {
  			   2: local high limit
  			   3: local critical limit
  			   4: remote critical limit */
-	s16 temp11[3];	/* 0: remote input
+	s16 temp11[4];	/* 0: remote input
  			   1: remote low limit
-			   2: remote high limit */
+			   2: remote high limit
+			   3: remote offset (except max6657) */
  	u8 temp_hyst;
  	u8 alarms; /* bitvector */
  };
@@ -282,11 +284,13 @@ static ssize_t show_temp11(struct device
  static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
  			  const char *buf, size_t count)
  {
-	static const u8 reg[4] = {
+	static const u8 reg[6] = {
  		LM90_REG_W_REMOTE_LOWH,
  		LM90_REG_W_REMOTE_LOWL,
  		LM90_REG_W_REMOTE_HIGHH,
  		LM90_REG_W_REMOTE_HIGHL,
+		LM90_REG_W_REMOTE_OFFSH,
+		LM90_REG_W_REMOTE_OFFSL,
  	};

  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -367,6 +371,8 @@ static SENSOR_DEVICE_ATTR(temp2_crit, S_
  static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temphyst,
  	set_temphyst, 3);
  static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temphyst, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 3);

  /* Individual alarm files */
  static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
@@ -652,6 +658,11 @@ static int lm90_detect(struct i2c_adapte
  					      &dev_attr_pec)))
  			goto exit_remove_files;
  	}
+	if (data->kind != max6657) {
+		if ((err = device_create_file(&new_client->dev,
+				&sensor_dev_attr_temp2_offset.dev_attr)))
+			goto exit_remove_files;
+	}

  	data->hwmon_dev = hwmon_device_register(&new_client->dev);
  	if (IS_ERR(data->hwmon_dev)) {
@@ -710,6 +721,9 @@ static int lm90_detach_client(struct i2c
  	hwmon_device_unregister(data->hwmon_dev);
  	sysfs_remove_group(&client->dev.kobj, &lm90_group);
  	device_remove_file(&client->dev, &dev_attr_pec);
+	if (data->kind != max6657)
+		device_remove_file(&client->dev,
+				   &sensor_dev_attr_temp2_offset.dev_attr);

  	if ((err = i2c_detach_client(client)))
  		return err;
@@ -763,6 +777,13 @@ static struct lm90_data *lm90_update_dev
  		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &newh) = 0
  		 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL, &l) = 0)
  			data->temp11[2] = (newh << 8) | l;
+		if (data->kind != max6657) {
+			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
+					  &newh) = 0
+			 && lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSL,
+			 		  &l) = 0)
+				data->temp11[3] = (newh << 8) | l;
+		}
  		lm90_read_reg(client, LM90_REG_R_STATUS, &data->alarms);

  		data->last_updated = jiffies;
--------------------------------------------
Looks good:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
