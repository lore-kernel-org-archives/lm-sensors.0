From: Wei Ni <wni@nvidia.com>
Date: Mon, 04 Nov 2013 10:26:33 +0000
Subject: [lm-sensors] [PATCH RESEND v4 2/3] hwmon: (lm90) add support to handle IRQ
Message-Id: <1383560793-11039-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

When the temperature exceed the limit range value,
the driver can handle the interrupt.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/hwmon/lm90.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 57485ef..d55c25d 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -89,6 +89,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/interrupt.h>
 
 /*
  * Addresses to scan
@@ -1435,6 +1436,17 @@ static bool lm90_is_tripped(struct i2c_client *client, u16 *status)
 	return true;
 }
 
+static irqreturn_t lm90_irq_thread(int irq, void *dev_id)
+{
+	struct i2c_client *client = dev_id;
+	u16 status;
+
+	if (lm90_is_tripped(client, &status))
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
@@ -1511,6 +1523,18 @@ static int lm90_probe(struct i2c_client *client,
 		goto exit_remove_files;
 	}
 
+	if (client->irq) {
+		dev_dbg(dev, "IRQ: %d\n", client->irq);
+		err = devm_request_threaded_irq(dev, client->irq,
+						NULL, lm90_irq_thread,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"lm90", client);
+		if (err < 0) {
+			dev_err(dev, "cannot request IRQ: %d\n", client->irq);
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
