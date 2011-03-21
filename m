From: Dirk Eibach <eibach@gdsys.de>
Date: Mon, 21 Mar 2011 10:37:45 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads1015) Make gain and datarate
Message-Id: <1300703865-23939-1-git-send-email-eibach@gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110318220240.399ade64@endymion.delvare>
In-Reply-To: <20110318220240.399ade64@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-doc@vger.kernel.org, rdunlap@xenotime.net, devicetree-discuss@lists.ozlabs.org, w.sang@pengutronix.de, khali@linux-fr.org, Dirk Eibach <eibach@gdsys.de>

Configuration for ads1015 gain and datarate is possible via
devicetree or platform data.

This is a followup patch to previous ads1015 patches on Jean Delvares
tree.

Changes since v1:
- replaced exported_channels bitmask with an enable entry per channel
- improved platform data example in Documentation
- improved patch description

Changes since v2:
- fixed spelling and whitespace in Documentation
- marked default data_rate
- replaced FS by full scale
- removed structure definition from Documentation
- used DIV_ROUND_UP()
- improved comments
- improved waiting for conversion
- moved devicetree stuff to ads1015_get_channels_config_of()
- renamed ads1015_get_exported_channels() to ads1015_get_channels_config()
- renamed ADS1015_CONFIG_CHANNELS to ADS1015_CHANNELS
- fixed some style inconsistencies

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
 .../devicetree/bindings/hwmon/ads1015.txt          |   88 +++++++++---
 Documentation/hwmon/ads1015                        |   49 ++++---
 drivers/hwmon/ads1015.c                            |  151 ++++++++++++++------
 include/linux/i2c/ads1015.h                        |   10 ++-
 4 files changed, 212 insertions(+), 86 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ads1015.txt b/Documentation/devicetree/bindings/hwmon/ads1015.txt
index 985e24d..918a507 100644
--- a/Documentation/devicetree/bindings/hwmon/ads1015.txt
+++ b/Documentation/devicetree/bindings/hwmon/ads1015.txt
@@ -5,25 +5,69 @@ This device is a 12-bit A-D converter with 4 inputs.
 The inputs can be used single ended or in certain differential combinations.
 
 For configuration all possible combinations are mapped to 8 channels:
-0: Voltage over AIN0 and AIN1.
-1: Voltage over AIN0 and AIN3.
-2: Voltage over AIN1 and AIN3.
-3: Voltage over AIN2 and AIN3.
-4: Voltage over AIN0 and GND.
-5: Voltage over AIN1 and GND.
-6: Voltage over AIN2 and GND.
-7: Voltage over AIN3 and GND.
-
-Optional properties:
-
- - exported-channels : exported_channels is a bitmask that specifies which
-		       channels should be accessible by the user.
-
-Example:
-ads1015@49 {
-	compatible = "ti,ads1015";
-	reg = <0x49>;
-	exported-channels = <0x14>;
-};
-
-In this example only channel 2 and 4 would be accessible by the user.
+  0: Voltage over AIN0 and AIN1.
+  1: Voltage over AIN0 and AIN3.
+  2: Voltage over AIN1 and AIN3.
+  3: Voltage over AIN2 and AIN3.
+  4: Voltage over AIN0 and GND.
+  5: Voltage over AIN1 and GND.
+  6: Voltage over AIN2 and GND.
+  7: Voltage over AIN3 and GND.
+
+Each channel can be configured individually:
+ - pga is the programmable gain amplifier (values are full scale)
+    0: +/- 6.144 V
+    1: +/- 4.096 V
+    2: +/- 2.048 V (default)
+    3: +/- 1.024 V
+    4: +/- 0.512 V
+    5: +/- 0.256 V
+ - data_rate in samples per second
+    0: 128
+    1: 250
+    2: 490
+    3: 920
+    4: 1600 (default)
+    5: 2400
+    6: 3300
+
+1) The /ads1015 node
+
+  Required properties:
+
+   - compatible : must be "ti,ads1015"
+   - reg : I2C bus address of the device
+   - #address-cells : must be <1>
+   - #size-cells : must be <0>
+
+  The node contains child nodes for each channel that the platform uses.
+
+  Example ADS1015 node:
+
+    ads1015@49 {
+	    compatible = "ti,ads1015";
+	    reg = <0x49>;
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    [ child node definitions... ]
+    }
+
+2) channel nodes
+
+  Required properties:
+
+   - reg : the channel number
+
+  Optional properties:
+
+   - ti,gain : the programmable gain amplifier setting
+   - ti,datarate : the converter data rate
+
+  Example ADS1015 channel node:
+
+    channel@4 {
+	    reg = <4>;
+	    ti,gain = <3>;
+	    ti,datarate = <5>;
+    };
diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
index 56ee797..f6fe9c2 100644
--- a/Documentation/hwmon/ads1015
+++ b/Documentation/hwmon/ads1015
@@ -19,7 +19,7 @@ This device is a 12-bit A-D converter with 4 inputs.
 
 The inputs can be used single ended or in certain differential combinations.
 
-The inputs can be exported to 8 sysfs input files in0_input - in7_input:
+The inputs can be made available by 8 sysfs input files in0_input - in7_input:
 in0: Voltage over AIN0 and AIN1.
 in1: Voltage over AIN0 and AIN3.
 in2: Voltage over AIN1 and AIN3.
@@ -29,39 +29,44 @@ in5: Voltage over AIN1 and GND.
 in6: Voltage over AIN2 and GND.
 in7: Voltage over AIN3 and GND.
 
-Which inputs are exported can be configured using platform data or devicetree.
+Which inputs are available can be configured using platform data or devicetree.
 
 By default all inputs are exported.
 
 Platform Data
 -------------
 
-In linux/i2c/ads1015.h platform data is defined as:
-
-struct ads1015_platform_data {
-	unsigned int exported_channels;
-};
-
-exported_channels is a bitmask that specifies which inputs should be exported.
+In linux/i2c/ads1015.h platform data is defined, channel_data contains
+configuration data for the used input combinations:
+- pga is the programmable gain amplifier (values are full scale)
+  0: +/- 6.144 V
+  1: +/- 4.096 V
+  2: +/- 2.048 V
+  3: +/- 1.024 V
+  4: +/- 0.512 V
+  5: +/- 0.256 V
+- data_rate in samples per second
+  0: 128
+  1: 250
+  2: 490
+  3: 920
+  4: 1600
+  5: 2400
+  6: 3300
 
 Example:
 struct ads1015_platform_data data = {
-	.exported_channels = (1 << 2) | (1 << 4)
+	.channel_data = {
+		[2] = { .enabled = true, .pga = 1, .data_rate = 0 },
+		[4] = { .enabled = true, .pga = 4, .data_rate = 5 },
+	}
 };
 
-In this case only in2_input and in4_input would be created.
+In this case only in2_input (FS +/- 4.096 V, 128 SPS) and in4_input
+(FS +/- 0.512 V, 2400 SPS) would be created.
 
 Devicetree
 ----------
 
-The ads1015 node may have an "exported-channels" property.
-exported_channels is a bitmask that specifies which inputs should be exported.
-
-Example:
-ads1015@49 {
-	compatible = "ti,ads1015";
-	reg = <0x49>;
-	exported-channels = < 0x14 >;
-};
-
-In this case only in2_input and in4_input would be created.
+Configuration is also possible via devicetree:
+Documentation/devicetree/bindings/hwmon/ads1015.txt
diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 8ef2b60..e9beeda 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -25,7 +25,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/jiffies.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -45,12 +45,18 @@ enum {
 static const unsigned int fullscale_table[8] = {
 	6144, 4096, 2048, 1024, 512, 256, 256, 256 };
 
-#define ADS1015_CONFIG_CHANNELS 8
+/* Data rates in samples per second */
+static const unsigned int data_rate_table[8] = {
+	128, 250, 490, 920, 1600, 2400, 3300, 3300 };
+
 #define ADS1015_DEFAULT_CHANNELS 0xff
+#define ADS1015_DEFAULT_PGA 2
+#define ADS1015_DEFAULT_DATA_RATE 4
 
 struct ads1015_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock; /* mutex protect updates */
+	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
 };
 
 static s32 ads1015_read_reg(struct i2c_client *client, unsigned int reg)
@@ -71,40 +77,42 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
 {
 	u16 config;
 	s16 conversion;
-	unsigned int pga;
-	int fullscale;
-	unsigned int k;
 	struct ads1015_data *data = i2c_get_clientdata(client);
+	unsigned int pga = data->channel_data[channel].pga;
+	int fullscale;
+	unsigned int data_rate = data->channel_data[channel].data_rate;
+	unsigned int conversion_time_ms;
 	int res;
 
 	mutex_lock(&data->update_lock);
 
-	/* get fullscale voltage */
+	/* get channel parameters */
 	res = ads1015_read_reg(client, ADS1015_CONFIG);
 	if (res < 0)
 		goto err_unlock;
 	config = res;
-	pga = (config >> 9) & 0x0007;
 	fullscale = fullscale_table[pga];
+	conversion_time_ms = DIV_ROUND_UP(1000, data_rate_table[data_rate]);
 
-	/* set channel and start single conversion */
-	config &= ~(0x0007 << 12);
-	config |= (1 << 15) | (1 << 8) | (channel & 0x0007) << 12;
+	/* setup and start single conversion */
+	config &= 0x001f;
+	config |= (1 << 15) | (1 << 8);
+	config |= (channel & 0x0007) << 12;
+	config |= (pga & 0x0007) << 9;
+	config |= (data_rate & 0x0007) << 5;
 
-	/* wait until conversion finished */
 	res = ads1015_write_reg(client, ADS1015_CONFIG, config);
 	if (res < 0)
 		goto err_unlock;
-	for (k = 0; k < 5; ++k) {
-		schedule_timeout(msecs_to_jiffies(1));
-		res = ads1015_read_reg(client, ADS1015_CONFIG);
-		if (res < 0)
-			goto err_unlock;
-		config = res;
-		if (config & (1 << 15))
-			break;
-	}
-	if (k = 5) {
+
+	/* wait until conversion finished */
+	msleep(conversion_time_ms);
+	res = ads1015_read_reg(client, ADS1015_CONFIG);
+	if (res < 0)
+		goto err_unlock;
+	config = res;
+	if (!(config & (1 << 15))) {
+		/* conversion not finished in time */
 		res = -EIO;
 		goto err_unlock;
 	}
@@ -160,35 +168,97 @@ static int ads1015_remove(struct i2c_client *client)
 	int k;
 
 	hwmon_device_unregister(data->hwmon_dev);
-	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k)
+	for (k = 0; k < ADS1015_CHANNELS; ++k)
 		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
 	kfree(data);
 	return 0;
 }
 
-static unsigned int ads1015_get_exported_channels(struct i2c_client *client)
-{
-	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
 #ifdef CONFIG_OF
-	struct device_node *np = client->dev.of_node;
-	const __be32 *of_channels;
-	int of_channels_size;
+static int ads1015_get_channels_config_of(struct i2c_client *client)
+{
+	struct ads1015_data *data = i2c_get_clientdata(client);
+	struct device_node *node;
+
+	if (!client->dev.of_node
+	    || !of_get_next_child(client->dev.of_node, NULL))
+		return -EINVAL;
+
+	for_each_child_of_node(client->dev.of_node, node) {
+		const __be32 *property;
+		int len;
+		unsigned int channel;
+		unsigned int pga = ADS1015_DEFAULT_PGA;
+		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
+
+		property = of_get_property(node, "reg", &len);
+		if (!property || len != sizeof(int)) {
+			dev_err(&client->dev, "invalid reg on %s\n",
+				node->full_name);
+			continue;
+		}
+
+		channel = be32_to_cpup(property);
+		if (channel > ADS1015_CHANNELS) {
+			dev_err(&client->dev,
+				"invalid channel index %d on %s\n",
+				channel, node->full_name);
+			continue;
+		}
+
+		property = of_get_property(node, "ti,gain", &len);
+		if (property && len = sizeof(int)) {
+			pga = be32_to_cpup(property);
+			if (pga > 6) {
+				dev_err(&client->dev,
+					"invalid gain on %s\n",
+					node->full_name);
+			}
+		}
+
+		property = of_get_property(node, "ti,datarate", &len);
+		if (property && len = sizeof(int)) {
+			data_rate = be32_to_cpup(property);
+			if (data_rate > 7) {
+				dev_err(&client->dev,
+					"invalid data_rate on %s\n",
+					node->full_name);
+			}
+		}
+
+		data->channel_data[channel].enabled = true;
+		data->channel_data[channel].pga = pga;
+		data->channel_data[channel].data_rate = data_rate;
+	}
+
+	return 0;
+}
 #endif
 
+static void ads1015_get_channels_config(struct i2c_client *client)
+{
+	unsigned int k;
+	struct ads1015_data *data = i2c_get_clientdata(client);
+	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
+
 	/* prefer platform data */
-	if (pdata)
-		return pdata->exported_channels;
+	if (pdata) {
+		memcpy(data->channel_data, pdata->channel_data,
+		       sizeof(data->channel_data));
+		return;
+	}
 
 #ifdef CONFIG_OF
-	/* fallback on OF */
-	of_channels = of_get_property(np, "exported-channels",
-				      &of_channels_size);
-	if (of_channels && (of_channels_size = sizeof(*of_channels)))
-		return be32_to_cpup(of_channels);
+	if (!ads1015_get_channels_config_of(client))
+		return;
 #endif
 
 	/* fallback on default configuration */
-	return ADS1015_DEFAULT_CHANNELS;
+	for (k = 0; k < ADS1015_CHANNELS; ++k) {
+		data->channel_data[k].enabled = true;
+		data->channel_data[k].pga = ADS1015_DEFAULT_PGA;
+		data->channel_data[k].data_rate = ADS1015_DEFAULT_DATA_RATE;
+	}
 }
 
 static int ads1015_probe(struct i2c_client *client,
@@ -196,7 +266,6 @@ static int ads1015_probe(struct i2c_client *client,
 {
 	struct ads1015_data *data;
 	int err;
-	unsigned int exported_channels;
 	unsigned int k;
 
 	data = kzalloc(sizeof(struct ads1015_data), GFP_KERNEL);
@@ -209,9 +278,9 @@ static int ads1015_probe(struct i2c_client *client,
 	mutex_init(&data->update_lock);
 
 	/* build sysfs attribute group */
-	exported_channels = ads1015_get_exported_channels(client);
-	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k) {
-		if (!(exported_channels & (1<<k)))
+	ads1015_get_channels_config(client);
+	for (k = 0; k < ADS1015_CHANNELS; ++k) {
+		if (!data->channel_data[k].enabled)
 			continue;
 		err = device_create_file(&client->dev, &ads1015_in[k].dev_attr);
 		if (err)
@@ -227,7 +296,7 @@ static int ads1015_probe(struct i2c_client *client,
 	return 0;
 
 exit_remove:
-	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k)
+	for (k = 0; k < ADS1015_CHANNELS; ++k)
 		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
 exit_free:
 	kfree(data);
diff --git a/include/linux/i2c/ads1015.h b/include/linux/i2c/ads1015.h
index 8541c6a..d5aa2a0 100644
--- a/include/linux/i2c/ads1015.h
+++ b/include/linux/i2c/ads1015.h
@@ -21,8 +21,16 @@
 #ifndef LINUX_ADS1015_H
 #define LINUX_ADS1015_H
 
+#define ADS1015_CHANNELS 8
+
+struct ads1015_channel_data {
+	bool enabled;
+	unsigned int pga;
+	unsigned int data_rate;
+};
+
 struct ads1015_platform_data {
-	unsigned int exported_channels;
+	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
 };
 
 #endif /* LINUX_ADS1015_H */
-- 
1.5.6.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
