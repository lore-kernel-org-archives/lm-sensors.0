From: Evgeniy Dushistov <dushistov@mail.ru>
Date: Mon, 29 Jul 2013 21:36:23 +0000
Subject: [lm-sensors] [PATCH] support ads1115 to ads1015 driver
Message-Id: <20130729213623.GA5065@fifteen>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for ads1115 device to ads1015 driver.
Based on work of Emiliano Carnati <carnatiatebneuro.com>.
Tested on ARM CPU based board.

Signed-off-by: Evgeniy A. Dushistov <dushistov@mail.ru>
---
 Documentation/hwmon/ads1015 |  8 ++++++--
 drivers/hwmon/Kconfig       |  4 ++--
 drivers/hwmon/ads1015.c     | 28 +++++++++++++++++++++++-----
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
index f6fe9c2..063b80d 100644
--- a/Documentation/hwmon/ads1015
+++ b/Documentation/hwmon/ads1015
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'ads1015'
     Datasheet: Publicly available at the Texas Instruments website :
                http://focus.ti.com/lit/ds/symlink/ads1015.pdf
+  * Texas Instruments ADS1115
+    Prefix: 'ads1115'
+    Datasheet: Publicly available at the Texas Instruments website :
+               http://focus.ti.com/lit/ds/symlink/ads1115.pdf
 
 Authors:
         Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
@@ -13,9 +17,9 @@ Authors:
 Description
 -----------
 
-This driver implements support for the Texas Instruments ADS1015.
+This driver implements support for the Texas Instruments ADS1015/ADS1115.
 
-This device is a 12-bit A-D converter with 4 inputs.
+This device is a 12/16-bit A-D converter with 4 inputs.
 
 The inputs can be used single ended or in certain differential combinations.
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e989f7f..47b3e58 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1202,8 +1202,8 @@ config SENSORS_ADS1015
 	tristate "Texas Instruments ADS1015"
 	depends on I2C
 	help
-	  If you say yes here you get support for Texas Instruments ADS1015
-	  12-bit 4-input ADC device.
+	  If you say yes here you get support for Texas Instruments
+	  ADS1015/ADS1115 12/16-bit 4-input ADC device.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ads1015.
diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 2798246..d542a70 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -46,8 +46,13 @@ static const unsigned int fullscale_table[8] = {
 	6144, 4096, 2048, 1024, 512, 256, 256, 256 };
 
 /* Data rates in samples per second */
-static const unsigned int data_rate_table[8] = {
-	128, 250, 490, 920, 1600, 2400, 3300, 3300 };
+static const unsigned int data_rate_table_1015[8] = {
+	128, 250, 490, 920, 1600, 2400, 3300, 3300
+};
+
+static const unsigned int data_rate_table_1115[8] = {
+	8, 16, 32, 64, 128, 250, 475, 860
+};
 
 #define ADS1015_DEFAULT_CHANNELS 0xff
 #define ADS1015_DEFAULT_PGA 2
@@ -57,6 +62,12 @@ struct ads1015_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock; /* mutex protect updates */
 	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
+	int id;
+};
+
+enum ads1015_num_id {
+	ads1015,
+	ads1115,
 };
 
 static int ads1015_read_adc(struct i2c_client *client, unsigned int channel)
@@ -66,6 +77,8 @@ static int ads1015_read_adc(struct i2c_client *client, unsigned int channel)
 	unsigned int pga = data->channel_data[channel].pga;
 	unsigned int data_rate = data->channel_data[channel].data_rate;
 	unsigned int conversion_time_ms;
+	const unsigned int * const rate_table = data->id = ads1115 ?
+		data_rate_table_1115 : data_rate_table_1015;
 	int res;
 
 	mutex_lock(&data->update_lock);
@@ -75,7 +88,7 @@ static int ads1015_read_adc(struct i2c_client *client, unsigned int channel)
 	if (res < 0)
 		goto err_unlock;
 	config = res;
-	conversion_time_ms = DIV_ROUND_UP(1000, data_rate_table[data_rate]);
+	conversion_time_ms = DIV_ROUND_UP(1000, rate_table[data_rate]);
 
 	/* setup and start single conversion */
 	config &= 0x001f;
@@ -113,8 +126,9 @@ static int ads1015_reg_to_mv(struct i2c_client *client, unsigned int channel,
 	struct ads1015_data *data = i2c_get_clientdata(client);
 	unsigned int pga = data->channel_data[channel].pga;
 	int fullscale = fullscale_table[pga];
+	const unsigned mask = data->id = ads1115 ? 0x7fff : 0x7ff0;
 
-	return DIV_ROUND_CLOSEST(reg * fullscale, 0x7ff0);
+	return DIV_ROUND_CLOSEST(reg * fullscale, mask);
 }
 
 /* sysfs callback function */
@@ -277,6 +291,9 @@ static int ads1015_probe(struct i2c_client *client,
 		goto exit_remove;
 	}
 
+	data->id = id->driver_data;
+	pr_debug("%s: id %d\n", __func__, data->id);
+
 	return 0;
 
 exit_remove:
@@ -286,7 +303,8 @@ exit_remove:
 }
 
 static const struct i2c_device_id ads1015_id[] = {
-	{ "ads1015", 0 },
+	{ "ads1015",  ads1015},
+	{ "ads1115",  ads1115},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ads1015_id);
-- 
1.8.1.5

-- 
/Evgeniy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
