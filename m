From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Fri, 22 Jul 2011 17:57:09 +0000
Subject: [lm-sensors] [PATCH] hwmon: (sht15) correct a comment mistake
Message-Id: <1311357429-16006-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sht15_store_heater() is called on _write_ access to heater_enable.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/hwmon/sht15.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index cf4330b..7d231cf 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -671,7 +671,7 @@ static ssize_t sht15_show_status(struct device *dev,
  * @buf:	sysfs buffer to read the new heater state from.
  * @count:	length of the data.
  *
- * Will be called on read access to heater_enable sysfs attribute.
+ * Will be called on write access to heater_enable sysfs attribute.
  * Returns number of bytes actually decoded, negative errno on error.
  */
 static ssize_t sht15_store_heater(struct device *dev,
-- 
1.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
