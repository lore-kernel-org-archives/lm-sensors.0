From: Marc Titinger <mtitinger@baylibre.com>
Date: Tue, 27 Oct 2015 09:51:08 +0000
Subject: [lm-sensors] [PATCH v2 2/2] hwmon: ina2xx: give precedence to DT over checking for platform data.
Message-Id: <1445939468-21755-2-git-send-email-mtitinger@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1445939468-21755-1-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1445939468-21755-1-git-send-email-mtitinger@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, bcousson@baylibre.com, ptitiano@baylibre.com, Marc Titinger <mtitinger@baylibre.com>

when checking for the value of the shunt resistor.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---

 v2:
	- do part type init earlier to regroup rshunt value checking
	  and assignement.

 drivers/hwmon/ina2xx.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 5e7ada8..5fe742b 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -417,7 +417,6 @@ static const struct attribute_group ina226_group = {
 static int ina2xx_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	struct ina2xx_platform_data *pdata;
 	struct device *dev = &client->dev;
 	struct ina2xx_data *data;
 	struct device *hwmon_dev;
@@ -428,24 +427,24 @@ static int ina2xx_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	if (dev_get_platdata(dev)) {
-		pdata = dev_get_platdata(dev);
-		data->rshunt = pdata->shunt_uohms;
-	} else if (!of_property_read_u32(dev->of_node,
-					 "shunt-resistor", &val)) {
-		data->rshunt = val;
-	} else {
-		data->rshunt = INA2XX_RSHUNT_DEFAULT;
-	}
-
 	/* set the device type */
 	data->kind = id->driver_data;
 	data->config = &ina2xx_config[data->kind];
 
-	if (data->rshunt <= 0 ||
-	    data->rshunt > data->config->calibration_factor)
+	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
+		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
+
+		if (pdata)
+			val = pdata->shunt_uohms;
+		else
+			val = INA2XX_RSHUNT_DEFAULT;
+	}
+
+	if (val <= 0 || val > data->config->calibration_factor)
 		return -ENODEV;
 
+	data->rshunt = val;
+
 	ina2xx_regmap_config.max_register = data->config->registers;
 
 	data->regmap = devm_regmap_init_i2c(client, &ina2xx_regmap_config);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
