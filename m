From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix dme1737 temp fault attribute
Message-Id: <11858460011939-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Juerg Haefliger <juergh@gmail.com>

Fix temp?_fault attribute. The temp was incorrectly compared against
0x0800 rather than 0x8000. Only the upper 8 bits are compared as the
datasheet doesn't specify what happens to the lower bits in case of a
diode fault.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/dme1737.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index be3aaa5..e9cbc72 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -750,7 +750,7 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
 		res = (data->alarms >> DME1737_BIT_ALARM_TEMP[ix]) & 0x01;
 		break;
 	case SYS_TEMP_FAULT:
-		res = (data->temp[ix] = 0x0800);
+		res = (((u16)data->temp[ix] & 0xff00) = 0x8000);
 		break;
 	default:
 		res = 0;
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
