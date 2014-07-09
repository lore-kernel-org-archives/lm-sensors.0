From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 09 Jul 2014 01:22:54 +0000
Subject: [lm-sensors] [RFT][PATCH v2 1/2] hwmon: (da9055) Don't use dash in the name attribute
Message-Id: <1404868974.12195.4.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dashes are not allowed in hwmon name attributes.
So now use "da9055" instead of "da9055-hwmon" in name attribute.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/da9055-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 73b3865..35eb773 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -204,7 +204,7 @@ static ssize_t da9055_hwmon_show_name(struct device *dev,
 				      struct device_attribute *devattr,
 				      char *buf)
 {
-	return sprintf(buf, "da9055-hwmon\n");
+	return sprintf(buf, "da9055\n");
 }
 
 static ssize_t show_label(struct device *dev,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
