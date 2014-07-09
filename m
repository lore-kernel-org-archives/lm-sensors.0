From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 09 Jul 2014 01:18:59 +0000
Subject: [lm-sensors] [RFT][PATCH v2 1/2] hwmon: (da9052) Don't use dash in the name attribute
Message-Id: <1404868739.12195.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dashes are not allowed in hwmon name attributes.
So now use "da9052" instead of "da9052-hwmon" in name attribue.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/da9052-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index afd3104..d14ab3c 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -194,7 +194,7 @@ static ssize_t da9052_hwmon_show_name(struct device *dev,
 				      struct device_attribute *devattr,
 				      char *buf)
 {
-	return sprintf(buf, "da9052-hwmon\n");
+	return sprintf(buf, "da9052\n");
 }
 
 static ssize_t show_label(struct device *dev,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
