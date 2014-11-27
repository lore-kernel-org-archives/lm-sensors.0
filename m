From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 27 Nov 2014 09:59:06 +0000
Subject: [lm-sensors] [PATCH v2 1/5] hwmon: ina2xx: bail-out from ina2xx_probe() in case of configuration err
Message-Id: <1417082350-23470-2-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417082350-23470-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417082350-23470-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <jdelvare@suse.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

The return value of i2c_smbus_write_word_swapped() isn't checked in
ina2xx_probe(). This leads to devices being registered even if they cannot
be physically detected (e.g. device is not powered-up at boot-time).

Even after restoring power to such device, it is left unconfigured as the
configuration has never been actually written to the register.

Error out in case of write errors in probe and notify the user.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/ina2xx.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index bfd3f3e..0a6b60f 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -223,6 +223,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	struct device *hwmon_dev;
 	long shunt = 10000; /* default shunt value 10mOhms */
 	u32 val;
+	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
@@ -247,12 +248,24 @@ static int ina2xx_probe(struct i2c_client *client,
 	data->config = &ina2xx_config[data->kind];
 
 	/* device configuration */
-	i2c_smbus_write_word_swapped(client, INA2XX_CONFIG,
-				     data->config->config_default);
-	/* set current LSB to 1mA, shunt is in uOhms */
-	/* (equation 13 in datasheet) */
-	i2c_smbus_write_word_swapped(client, INA2XX_CALIBRATION,
-				     data->config->calibration_factor / shunt);
+	ret = i2c_smbus_write_word_swapped(client, INA2XX_CONFIG,
+					   data->config->config_default);
+	if (ret < 0) {
+		dev_err(dev,
+			"error writing to the config register: %d", ret);
+		return -ENODEV;
+	}
+
+	/* Set current LSB to 1mA, shunt is in uOhms
+	 * (equation 13 in datasheet).
+	 */
+	ret = i2c_smbus_write_word_swapped(client, INA2XX_CALIBRATION,
+				data->config->calibration_factor / shunt);
+	if (ret < 0) {
+		dev_err(dev,
+			"error writing to the calibration register: %d", ret);
+		return -ENODEV;
+	}
 
 	data->client = client;
 	mutex_init(&data->update_lock);
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
