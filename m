From: Wei Ni <wni@nvidia.com>
Date: Mon, 09 Sep 2013 10:29:11 +0000
Subject: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <1378722552-10357-2-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1378722552-10357-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The device lm90 can be controlled by the vcc rail.
Adding the regulator support to power on/off the vcc rail.
Enable the "vcc" regulator before accessing the device.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/hwmon/lm90.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index cdff742..bd313f4 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -89,6 +89,8 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/regulator/consumer.h>
+#include <linux/delay.h>
 
 /*
  * Addresses to scan
@@ -302,6 +304,7 @@ static const struct lm90_params lm90_params[] = {
 struct lm90_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock;
+	struct regulator *lm90_reg;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 	int kind;
@@ -1397,8 +1400,23 @@ static int lm90_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
 	struct lm90_data *data;
+	struct regulator *reg;
 	int err;
 
+	reg = devm_regulator_get_optional(dev, "vcc");
+	if (!IS_ERR(reg)) {
+		err = regulator_enable(reg);
+		if (err < 0) {
+			dev_err(&client->dev,
+				"Failed to enable regulator: %d\n", err);
+			return err;
+		}
+		msleep(25);
+	} else {
+		if (PTR_ERR(reg) = -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	data = devm_kzalloc(&client->dev, sizeof(struct lm90_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -1406,6 +1424,8 @@ static int lm90_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
+	data->lm90_reg = reg;
+
 	/* Set the device type */
 	data->kind = id->driver_data;
 	if (data->kind = adm1032) {
@@ -1473,6 +1493,9 @@ exit_remove_files:
 	lm90_remove_files(client, data);
 exit_restore:
 	lm90_restore_conf(client, data);
+	if (!IS_ERR(data->lm90_reg))
+		regulator_disable(data->lm90_reg);
+
 	return err;
 }
 
@@ -1483,6 +1506,8 @@ static int lm90_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	lm90_remove_files(client, data);
 	lm90_restore_conf(client, data);
+	if (!IS_ERR(data->lm90_reg))
+		regulator_disable(data->lm90_reg);
 
 	return 0;
 }
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
