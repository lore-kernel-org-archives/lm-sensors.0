From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 05 Oct 2007 07:38:33 +0000
Subject: Re: [lm-sensors] [PATCH]hwmon/lm87: Add individual alarm files
Message-Id: <4705E9F9.202@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070926233901.1ea7aace@hyperion.delvare>
In-Reply-To: <20070926233901.1ea7aace@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

In this post:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021290.html]

Jean Delvare wrote:
--------------------------------------------
Add individual alarm files to the lm87 driver. The new libsensors
needs this.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
  drivers/hwmon/lm87.c |   67 +++++++++++++++++++++++++++++++++++++++++++++-----
  1 file changed, 61 insertions(+), 6 deletions(-)

--- linux-2.6.23-rc8.orig/drivers/hwmon/lm87.c	2007-09-25 11:28:55.000000000 +0200
+++ linux-2.6.23-rc8/drivers/hwmon/lm87.c	2007-09-26 19:39:27.000000000 +0200
@@ -58,6 +58,7 @@
  #include <linux/jiffies.h>
  #include <linux/i2c.h>
  #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
  #include <linux/hwmon-vid.h>
  #include <linux/err.h>
  #include <linux/mutex.h>
@@ -531,6 +532,29 @@ static ssize_t set_aout(struct device *d
  }
  static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);

+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 14);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 15);
+
  /*
   * Real code
   */
@@ -546,24 +570,31 @@ static struct attribute *lm87_attributes
  	&dev_attr_in1_input.attr,
  	&dev_attr_in1_min.attr,
  	&dev_attr_in1_max.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
  	&dev_attr_in2_input.attr,
  	&dev_attr_in2_min.attr,
  	&dev_attr_in2_max.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
  	&dev_attr_in3_input.attr,
  	&dev_attr_in3_min.attr,
  	&dev_attr_in3_max.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
  	&dev_attr_in4_input.attr,
  	&dev_attr_in4_min.attr,
  	&dev_attr_in4_max.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,

  	&dev_attr_temp1_input.attr,
  	&dev_attr_temp1_max.attr,
  	&dev_attr_temp1_min.attr,
  	&dev_attr_temp1_crit.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
  	&dev_attr_temp2_input.attr,
  	&dev_attr_temp2_max.attr,
  	&dev_attr_temp2_min.attr,
  	&dev_attr_temp2_crit.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,

  	&dev_attr_alarms.attr,
  	&dev_attr_aout_output.attr,
@@ -579,30 +610,38 @@ static struct attribute *lm87_attributes
  	&dev_attr_in6_input.attr,
  	&dev_attr_in6_min.attr,
  	&dev_attr_in6_max.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,

  	&dev_attr_fan1_input.attr,
  	&dev_attr_fan1_min.attr,
  	&dev_attr_fan1_div.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,

  	&dev_attr_in7_input.attr,
  	&dev_attr_in7_min.attr,
  	&dev_attr_in7_max.attr,
+	&sensor_dev_attr_in7_alarm.dev_attr.attr,

  	&dev_attr_fan2_input.attr,
  	&dev_attr_fan2_min.attr,
  	&dev_attr_fan2_div.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,

  	&dev_attr_temp3_input.attr,
  	&dev_attr_temp3_max.attr,
  	&dev_attr_temp3_min.attr,
  	&dev_attr_temp3_crit.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,

  	&dev_attr_in0_input.attr,
  	&dev_attr_in0_min.attr,
  	&dev_attr_in0_max.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
  	&dev_attr_in5_input.attr,
  	&dev_attr_in5_min.attr,
  	&dev_attr_in5_max.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,

  	&dev_attr_cpu0_vid.attr,
  	&dev_attr_vrm.attr,
@@ -690,7 +729,9 @@ static int lm87_detect(struct i2c_adapte
  		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_in6_min))
  		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in6_max)))
+					&dev_attr_in6_max))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_in6_alarm.dev_attr)))
  			goto exit_remove;
  	} else {
  		if ((err = device_create_file(&new_client->dev,
@@ -698,7 +739,9 @@ static int lm87_detect(struct i2c_adapte
  		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_fan1_min))
  		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan1_div)))
+					&dev_attr_fan1_div))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_fan1_alarm.dev_attr)))
  			goto exit_remove;
  	}

@@ -708,7 +751,9 @@ static int lm87_detect(struct i2c_adapte
  		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_in7_min))
  		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in7_max)))
+					&dev_attr_in7_max))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_in7_alarm.dev_attr)))
  			goto exit_remove;
  	} else {
  		if ((err = device_create_file(&new_client->dev,
@@ -716,7 +761,9 @@ static int lm87_detect(struct i2c_adapte
  		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_fan2_min))
  		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan2_div)))
+					&dev_attr_fan2_div))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_fan2_alarm.dev_attr)))
  			goto exit_remove;
  	}

@@ -728,7 +775,11 @@ static int lm87_detect(struct i2c_adapte
  		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_temp3_min))
  		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_crit)))
+					&dev_attr_temp3_crit))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_temp3_alarm.dev_attr))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_temp3_fault.dev_attr)))
  			goto exit_remove;
  	} else {
  		if ((err = device_create_file(&new_client->dev,
@@ -738,11 +789,15 @@ static int lm87_detect(struct i2c_adapte
  		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_in0_max))
  		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_in0_alarm.dev_attr))
+		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_in5_input))
  		 || (err = device_create_file(&new_client->dev,
  					&dev_attr_in5_min))
  		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in5_max)))
+					&dev_attr_in5_max))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_in5_alarm.dev_attr)))
  			goto exit_remove;
  	}

--------------------------------------------
Looks good:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
