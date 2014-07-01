From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 01 Jul 2014 02:55:55 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (g760a) Avoid forward declaration
Message-Id: <1404183355.17083.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move g760a_driver to proper place to avoid forward declaration.
Also move g760a_id table close to g760a_driver.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/g760a.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index ea6480b..8460f80 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -24,12 +24,6 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 
-static const struct i2c_device_id g760a_id[] = {
-	{ "g760a", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, g760a_id);
-
 enum g760a_regs {
 	G760A_REG_SET_CNT = 0x00,
 	G760A_REG_ACT_CNT = 0x01,
@@ -74,20 +68,6 @@ static inline unsigned int rpm_from_cnt(u8 val, u32 clk, u16 div)
 	return ((val = 0x00) ? 0 : ((clk*30)/(val*div)));
 }
 
-/* new-style driver model */
-static int g760a_probe(struct i2c_client *client,
-			const struct i2c_device_id *id);
-static int g760a_remove(struct i2c_client *client);
-
-static struct i2c_driver g760a_driver = {
-	.driver = {
-		.name	= "g760a",
-	},
-	.probe	  = g760a_probe,
-	.remove	  = g760a_remove,
-	.id_table = g760a_id,
-};
-
 /* read/write wrappers */
 static int g760a_read_value(struct i2c_client *client, enum g760a_regs reg)
 {
@@ -247,6 +227,21 @@ static int g760a_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id g760a_id[] = {
+	{ "g760a", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, g760a_id);
+
+static struct i2c_driver g760a_driver = {
+	.driver = {
+		.name	= "g760a",
+	},
+	.probe	  = g760a_probe,
+	.remove	  = g760a_remove,
+	.id_table = g760a_id,
+};
+
 module_i2c_driver(g760a_driver);
 
 MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
