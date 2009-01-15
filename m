From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Thu, 15 Jan 2009 17:01:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (abituguru3) Fix CONFIG_DMI=n fallback
Message-Id: <200901151701.47672.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When CONFIG_DMI is not enabled, dmi detection should flag that no board
could be detected (err=1) rather than another error condition (err<0).

This fixes the fallback to manual probing for all motherboards, even
those without DMI strings, when CONFIG_DMI=n.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/abituguru3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 70bb854..fcf74eb 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1153,7 +1153,7 @@ static int __init abituguru3_dmi_detect(void)
 
 static inline int abituguru3_dmi_detect(void)
 {
-	return -ENODEV;
+	return 1;
 }
 
 #endif /* CONFIG_DMI */

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
