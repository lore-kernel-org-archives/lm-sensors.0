From: Dirk Eibach <eibach@gdsys.de>
Date: Wed, 09 Mar 2011 13:52:40 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads1015) Make gain and datarate
Message-Id: <1299678760-4027-1-git-send-email-eibach@gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-doc@vger.kernel.org, rdunlap@xenotime.net, devicetree-discuss@lists.ozlabs.org, w.sang@pengutronix.de, khali@linux-fr.org, Dirk Eibach <eibach@gdsys.de>

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
 .../devicetree/bindings/hwmon/ads1015.txt          |   73 ++++++++++++++
 Documentation/devicetree/bindings/i2c/ads1015.txt  |   29 ------
 Documentation/hwmon/ads1015                        |   48 +++++++---
 drivers/hwmon/ads1015.c                            |  104 ++++++++++++++++----
 include/linux/i2c/ads1015.h                        |    8 ++
 5 files changed, 202 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ads1015.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/ads1015.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ads1015.txt b/Documentation/devicetree/bindings/hwmon/ads1015.txt
new file mode 100644
index 0000000..fb6e139
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ads1015.txt
@@ -0,0 +1,73 @@
+ADS1015 (I2C)
+
+This device is a 12-bit A-D converter with 4 inputs.
+
+The inputs can be used single ended or in certain differential combinations.
+
+For configuration all possible combinations are mapped to 8 channels:
+  0: Voltage over AIN0 and AIN1.
+  1: Voltage over AIN0 and AIN3.
+  2: Voltage over AIN1 and AIN3.
+  3: Voltage over AIN2 and AIN3.
+  4: Voltage over AIN0 and GND.
+  5: Voltage over AIN1 and GND.
+  6: Voltage over AIN2 and GND.
+  7: Voltage over AIN3 and GND.
+
+Each channel can be configured indvidually:
+ - pga ist the programmable gain amplifier
+    0: FS = +/- 6.144 V
+    1: FS = +/- 4.096 V
+    2: FS = +/- 2.048 V (default)
+    3: FS = +/- 1.024 V
+    4: FS = +/- 0.512 V
+    5: FS = +/- 0.256 V
+ - data_rate in samples per second
+    0: 128
+    1: 250
+    2: 490
+    3: 920
+    4: 1600
+    5: 2400
+    6: 3300
+
+1) The /ads1015 node
+
+  Required properties:
+
+   - compatible : must be "ti,ads1015"
+   - reg : I2C busaddress of the device
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
+   - ti,datarate : the converter datarate
+
+  Example ADS1015 node:
+
+    channel@4 {
+	    reg = <4>;
+	    ti,gain = <3>;
+	    ti,datarate = <5>;
+    };
diff --git a/Documentation/devicetree/bindings/i2c/ads1015.txt b/Documentation/devicetree/bindings/i2c/ads1015.txt
deleted file mode 100644
index 985e24d..0000000
--- a/Documentation/devicetree/bindings/i2c/ads1015.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-ADS1015 (I2C)
-
-This device is a 12-bit A-D converter with 4 inputs.
-
-The inputs can be used single ended or in certain differential combinations.
-
-For configuration all possible combinations are mapped to 8 channels:
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
diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
index 56ee797..30250ca 100644
--- a/Documentation/hwmon/ads1015
+++ b/Documentation/hwmon/ads1015
@@ -38,30 +38,52 @@ Platform Data
 
 In linux/i2c/ads1015.h platform data is defined as:
 
+struct ads1015_channel_data {
+	unsigned int pga;
+	unsigned int data_rate;
+};
+
 struct ads1015_platform_data {
 	unsigned int exported_channels;
+	struct ads1015_channel_data channel_data[ADS1015_CONFIG_CHANNELS];
 };
 
 exported_channels is a bitmask that specifies which inputs should be exported.
 
+channel_data contains configuration data for the exported inputs:
+- pga ist the programmable gain amplifier
+  0: FS = +/- 6.144 V
+  1: FS = +/- 4.096 V
+  2: FS = +/- 2.048 V (default)
+  3: FS = +/- 1.024 V
+  4: FS = +/- 0.512 V
+  5: FS = +/- 0.256 V
+- data_rate in samples per second
+  0: 128
+  1: 250
+  2: 490
+  3: 920
+  4: 1600
+  5: 2400
+  6: 3300
+
 Example:
 struct ads1015_platform_data data = {
-	.exported_channels = (1 << 2) | (1 << 4)
+	.exported_channels = (1 << 2) | (1 << 4),
+	.channel_data = {
+		{},
+		{},
+		{ .pga = 1, .data_rate = 0 },
+		{},
+		{ .pga = 4, .data_rate = 5},
+	}
 };
 
-In this case only in2_input and in4_input would be created.
+In this case only in2_input(FS +/- 4.096 V, 128 SPS) and in4_input
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
index 8ef2b60..8657863 100644
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
+	struct ads1015_channel_data channel_data[ADS1015_CONFIG_CHANNELS];
 };
 
 static s32 ads1015_read_reg(struct i2c_client *client, unsigned int reg)
@@ -71,32 +77,38 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
 {
 	u16 config;
 	s16 conversion;
-	unsigned int pga;
+	struct ads1015_data *data = i2c_get_clientdata(client);
+	unsigned int pga = data->channel_data[channel].pga;
 	int fullscale;
+	unsigned int data_rate = data->channel_data[channel].data_rate;
+	unsigned int conversion_time_ms;
 	unsigned int k;
-	struct ads1015_data *data = i2c_get_clientdata(client);
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
+	conversion_time_ms = 1 + 1000 / data_rate_table[data_rate];
 
 	/* set channel and start single conversion */
-	config &= ~(0x0007 << 12);
-	config |= (1 << 15) | (1 << 8) | (channel & 0x0007) << 12;
+	config &= 0x001f;
+	config |= (1 << 15) | (1 << 8);
+	config |= (channel & 0x0007) << 12;
+	config |= (pga & 0x0007) << 9;
+	config |= (data_rate & 0x0007) << 5;
 
-	/* wait until conversion finished */
 	res = ads1015_write_reg(client, ADS1015_CONFIG, config);
 	if (res < 0)
 		goto err_unlock;
+
+	/* wait until conversion finished */
 	for (k = 0; k < 5; ++k) {
-		schedule_timeout(msecs_to_jiffies(1));
+		msleep(k ? 1 : conversion_time_ms);
 		res = ads1015_read_reg(client, ADS1015_CONFIG);
 		if (res < 0)
 			goto err_unlock;
@@ -168,26 +180,82 @@ static int ads1015_remove(struct i2c_client *client)
 
 static unsigned int ads1015_get_exported_channels(struct i2c_client *client)
 {
+	unsigned int k;
+	struct ads1015_data *data = i2c_get_clientdata(client);
 	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
 #ifdef CONFIG_OF
-	struct device_node *np = client->dev.of_node;
-	const __be32 *of_channels;
-	int of_channels_size;
+	unsigned int of_exported_channels = 0;
+	struct device_node *node;
 #endif
 
 	/* prefer platform data */
-	if (pdata)
+	if (pdata) {
+		memcpy(data->channel_data, pdata->channel_data,
+		       sizeof(data->channel_data));
 		return pdata->exported_channels;
+	}
 
 #ifdef CONFIG_OF
 	/* fallback on OF */
-	of_channels = of_get_property(np, "exported-channels",
-				      &of_channels_size);
-	if (of_channels && (of_channels_size = sizeof(*of_channels)))
-		return be32_to_cpup(of_channels);
+	if (!client->dev.of_node
+	    || !of_get_next_child(client->dev.of_node, NULL))
+		goto fallback_default;
+
+	for_each_child_of_node(client->dev.of_node, node) {
+		const __be32 *property;
+		int len;
+		unsigned int channel;
+		unsigned int pga = ADS1015_DEFAULT_PGA;
+		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
+
+		property = of_get_property(node, "reg", &len);
+		if (!property || (len < sizeof(int))) {
+			dev_err(&client->dev, "ads1015: invalid reg on %s\n",
+				node->full_name);
+			continue;
+		}
+
+		channel = be32_to_cpup(property);
+		if (channel > ADS1015_CONFIG_CHANNELS) {
+			dev_err(&client->dev, "ads1015: invalid addr=%x on %s\n",
+				channel, node->full_name);
+			continue;
+		}
+
+		property = of_get_property(node, "ti,gain", &len);
+		if (property && (len = sizeof(int))) {
+			pga = be32_to_cpup(property);
+			if (pga > 7) {
+				dev_err(&client->dev,
+					"ads1015: invalid gain on %s\n",
+					node->full_name);
+			}
+		}
+
+		property = of_get_property(node, "ti,datarate", &len);
+		if (property && (len = sizeof(int))) {
+			data_rate = be32_to_cpup(property);
+			if (data_rate > 7)
+				dev_err(&client->dev,
+					"ads1015: invalid data_rate on %s\n",
+					node->full_name);
+		}
+
+		of_exported_channels |= (1 << channel);
+		data->channel_data[channel].pga = pga;
+		data->channel_data[channel].data_rate = data_rate;
+	}
+
+	return of_exported_channels;
 #endif
 
 	/* fallback on default configuration */
+fallback_default:
+	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k) {
+		data->channel_data[k].pga = ADS1015_DEFAULT_PGA;
+		data->channel_data[k].data_rate = ADS1015_DEFAULT_DATA_RATE;
+	}
+
 	return ADS1015_DEFAULT_CHANNELS;
 }
 
diff --git a/include/linux/i2c/ads1015.h b/include/linux/i2c/ads1015.h
index 8541c6a..8f32040 100644
--- a/include/linux/i2c/ads1015.h
+++ b/include/linux/i2c/ads1015.h
@@ -21,8 +21,16 @@
 #ifndef LINUX_ADS1015_H
 #define LINUX_ADS1015_H
 
+#define ADS1015_CONFIG_CHANNELS 8
+
+struct ads1015_channel_data {
+	unsigned int pga;
+	unsigned int data_rate;
+};
+
 struct ads1015_platform_data {
 	unsigned int exported_channels;
+	struct ads1015_channel_data channel_data[ADS1015_CONFIG_CHANNELS];
 };
 
 #endif /* LINUX_ADS1015_H */
-- 
1.5.6.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
