From: Marc Titinger <mtitinger@baylibre.com>
Date: Thu, 29 Oct 2015 09:07:17 +0000
Subject: [lm-sensors] [PATCH] hwmon: ina2xx: remove no longer used variable 'kind'
Message-Id: <1446109637-3617-1-git-send-email-mtitinger@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/hwmon/ina2xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 1ba0c72..b24f1d3 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -109,7 +109,6 @@ struct ina2xx_data {
 	struct mutex config_lock;
 	struct regmap *regmap;
 
-	int kind;
 	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
 };
 
@@ -431,8 +430,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	/* set the device type */
-	data->kind = id->driver_data;
-	data->config = &ina2xx_config[data->kind];
+	data->config = &ina2xx_config[id->driver_data];
 
 	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
 		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
@@ -465,7 +463,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	mutex_init(&data->config_lock);
 
 	data->groups[group++] = &ina2xx_group;
-	if (data->kind = ina226)
+	if (id->driver_data = ina226)
 		data->groups[group++] = &ina226_group;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
