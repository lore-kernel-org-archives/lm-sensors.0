From: Rini <rini@arvoo.nl>
Date: Thu, 21 Oct 2010 13:44:41 +0000
Subject: [lm-sensors] [PATCH] adt7411: set reserved bit
Message-Id: <20101021134441.GA10439@arv-002>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch set the reserved bit in cfg1 register.
This bit should be 1 at startup but it's not.

Signed-off-by: Rini <rini@arvoo.nl>
---
 drivers/hwmon/adt7411.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index f13c843..c516876 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -31,6 +31,7 @@
 
 #define ADT7411_REG_CFG1			0x18
 #define ADT7411_CFG1_START_MONITOR		(1 << 0)
+#define ADT7411_CFG1_RESERVED			(1 << 3)
 
 #define ADT7411_REG_CFG2			0x19
 #define ADT7411_CFG2_DISABLE_AVG		(1 << 5)
@@ -291,6 +292,15 @@ static int __devinit adt7411_probe(struct i2c_client *client,
 	mutex_init(&data->device_lock);
 	mutex_init(&data->update_lock);
 
+	/*
+	 * reserved bit should be 1, despite document say it's 1 at powerup
+	 * it's not. Gives bad values at input3 when 0
+	 */
+	ret = adt7411_modify_bit(client, ADT7411_REG_CFG1,
+				ADT7411_CFG1_RESERVED, 1);
+	if (ret < 0)
+		goto exit_free;
+
 	ret = adt7411_modify_bit(client, ADT7411_REG_CFG1,
 				 ADT7411_CFG1_START_MONITOR, 1);
 	if (ret < 0)
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
