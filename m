From: Wei Ni <wni@nvidia.com>
Date: Fri, 12 Jul 2013 07:48:06 +0000
Subject: [lm-sensors] [PATCH v3 3/4] hwmon: (lm90) add support to handle IRQ
Message-Id: <1373615287-18502-4-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1373615287-18502-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, linux@roeck-us.net, thierry.reding@gmail.com
Cc: linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

When the temperature exceed the limit range value,
the driver can handle the interrupt.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/hwmon/lm90.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c90037f..1cc3d19 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -89,6 +89,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/interrupt.h>
 
 /*
  * Addresses to scan
@@ -1460,6 +1461,17 @@ static bool lm90_is_tripped(struct i2c_client *client)
 	return true;
 }
 
+static irqreturn_t lm90_irq_thread(int irq, void *dev_id)
+{
+	struct lm90_data *data = dev_id;
+	struct i2c_client *client = to_i2c_client(data->hwmon_dev->parent);
+
+	if (lm90_is_tripped(client))
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
@@ -1536,6 +1548,18 @@ static int lm90_probe(struct i2c_client *client,
 		goto exit_remove_files;
 	}
 
+	if (client->irq >= 0) {
+		dev_dbg(dev, "lm90 IRQ: %d\n", client->irq);
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
