From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:57:33 +0000
Subject: [lm-sensors] [patch 17/36] hwmon: (w83795) Add support for dynamic
Message-Id: <20100915155733.1b625a4c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The W83795G can be configured to set the in0, in1 and/or in2 voltage
limits dynamically based on VID input pins. Switch the respective
sysfs attributes to read-only.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:56.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:58.000000000 +0200
@@ -316,6 +316,7 @@ struct w83795_data {
 	u8 bank;
 
 	u32 has_in;		/* Enable monitor VIN or not */
+	u8 has_dyn_in;		/* Only in2-0 can have this */
 	u16 in[21][3];		/* Register value, read/high/low */
 	u8 in_lsb[10][3];	/* LSB Register value, high/low */
 	u8 has_gain;		/* has gain: in17-20 * 8 */
@@ -450,6 +451,23 @@ static struct w83795_data *w83795_update
 		data->in[i][IN_READ] = tmp;
 	}
 
+	/* in0-2 can have dynamic limits (W83795G only) */
+	if (data->has_dyn_in) {
+		u8 lsb_max = w83795_read(client, IN_LSB_REG(0, IN_MAX));
+		u8 lsb_low = w83795_read(client, IN_LSB_REG(0, IN_LOW));
+
+		for (i = 0; i < 3; i++) {
+			if (!(data->has_dyn_in & (1 << i)))
+				continue;
+			data->in[i][IN_MAX] +				w83795_read(client, W83795_REG_IN[i][IN_MAX]);
+			data->in[i][IN_LOW] +				w83795_read(client, W83795_REG_IN[i][IN_LOW]);
+			data->in_lsb[i][IN_MAX] = (lsb_max >> (2 * i)) & 0x03;
+			data->in_lsb[i][IN_LOW] = (lsb_low >> (2 * i)) & 0x03;
+		}
+	}
+
 	/* Update fan */
 	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
 		if (!(data->has_fan & (1 << i)))
@@ -1450,6 +1468,8 @@ store_sf_setup(struct device *dev, struc
 
 #define NOT_USED			-1
 
+/* Don't change the attribute order, _max and _min are accessed by index
+ * somewhere else in the code */
 #define SENSOR_ATTR_IN(index) {						\
 	SENSOR_ATTR_2(in##index##_input, S_IRUGO, show_in, NULL,	\
 		IN_READ, index), \
@@ -1844,6 +1864,39 @@ static int device_remove_file_wrapper(st
 	return 0;
 }
 
+static void w83795_check_dynamic_in_limits(struct i2c_client *client)
+{
+	struct w83795_data *data = i2c_get_clientdata(client);
+	u8 vid_ctl;
+	int i, err_max, err_min;
+
+	vid_ctl = w83795_read(client, W83795_REG_VID_CTRL);
+
+	/* Return immediately if VRM isn't configured */
+	if ((vid_ctl & 0x07) = 0x00 || (vid_ctl & 0x07) = 0x07)
+		return;
+
+	data->has_dyn_in = (vid_ctl >> 3) & 0x07;
+	for (i = 0; i < 2; i++) {
+		if (!(data->has_dyn_in & (1 << i)))
+			continue;
+
+		/* Voltage limits in dynamic mode, switch to read-only */
+		err_max = sysfs_chmod_file(&client->dev.kobj,
+					   &w83795_in[i][2].dev_attr.attr,
+					   S_IRUGO);
+		err_min = sysfs_chmod_file(&client->dev.kobj,
+					   &w83795_in[i][3].dev_attr.attr,
+					   S_IRUGO);
+		if (err_max || err_min)
+			dev_warn(&client->dev, "Failed to set in%d limits "
+				 "read-only (%d, %d)\n", i, err_max, err_min);
+		else
+			dev_info(&client->dev, "in%d limits set dynamically "
+				 "from VID\n", i);
+	}
+}
+
 /* Check pins that can be used for either temperature or voltage monitoring */
 static void w83795_apply_temp_config(struct w83795_data *data, u8 config,
 				     int temp_chan, int in_chan)
@@ -2049,6 +2102,9 @@ static int w83795_probe(struct i2c_clien
 	if (err)
 		goto exit_remove;
 
+	if (data->chip_type = w83795g)
+		w83795_check_dynamic_in_limits(client);
+
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
