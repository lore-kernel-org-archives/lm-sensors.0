From: Wei Ni <wni@nvidia.com>
Date: Thu, 04 Jul 2013 07:57:49 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm90) add support to handle irq
Message-Id: <1372924670-16355-3-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372924670-16355-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1372924670-16355-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add support to handle irq. When the temperature touch
the limit value, the driver can handle the interrupt.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/hwmon/lm90.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 2cb7f8e..fce9dfa 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -89,6 +89,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/interrupt.h>
 
 /*
  * Addresses to scan
@@ -1423,6 +1424,18 @@ static void lm90_init_client(struct i2c_client *client)
 		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
 }
 
+static void lm90_alert(struct i2c_client *client, unsigned int flag);
+
+static irqreturn_t lm90_irq_thread(int irq, void *dev_id)
+{
+	struct lm90_data *data = dev_id;
+	struct i2c_client *client = to_i2c_client(data->hwmon_dev->parent);
+
+	lm90_alert(client, 0);
+
+	return IRQ_HANDLED;
+}
+
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
@@ -1499,6 +1512,18 @@ static int lm90_probe(struct i2c_client *client,
 		goto exit_remove_files;
 	}
 
+	if (client->irq >= 0) {
+		dev_dbg(dev, "lm90 irq: %d\n", client->irq);
+		err = devm_request_threaded_irq(dev, client->irq,
+						NULL, lm90_irq_thread,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"lm90", data);
+		if (err < 0) {
+			dev_err(dev, "cannot request interrupt\n");
+			goto exit_remove_files;
+		}
+	}
+
 	return 0;
 
 exit_remove_files:
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
