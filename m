From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 12 Aug 2007 18:47:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix w83781d temp sensor type setting
Message-Id: <11869444522955-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Mark M. Hoffman <mhoffman@lightlink.com>

Commit 348753379a7704087603dad403603e825422fd9a introduced a regression that
caused temp2 and temp3 sensor type settings to be written to temp1 instead.
The result is that temp sensor readings could be way off.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/w83781d.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index f85b48f..c95909c 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -740,9 +740,9 @@ store_sensor(struct device *dev, struct device_attribute *da,
 static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
 	show_sensor, store_sensor, 0);
 static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
-	show_sensor, store_sensor, 0);
+	show_sensor, store_sensor, 1);
 static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
-	show_sensor, store_sensor, 0);
+	show_sensor, store_sensor, 2);
 
 /* I2C devices get this name attribute automatically, but for ISA devices
    we must create it by ourselves. */
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
