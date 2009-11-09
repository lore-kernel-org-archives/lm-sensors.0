From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Nov 2009 10:37:46 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7475) Fix temperature fault flags
Message-Id: <20091109113746.337b8062@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The logic of temperature fault flags is wrong, it shows faults when
there are none and vice versa. Fix it.

I can't believe this has been broken since the driver was added, 8
months ago, basically breaking temp1 and temp3, and nobody ever
complained.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
---
 drivers/hwmon/adt7475.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.32-rc6.orig/drivers/hwmon/adt7475.c	2009-11-08 19:21:34.000000000 +0100
+++ linux-2.6.32-rc6/drivers/hwmon/adt7475.c	2009-11-08 19:22:06.000000000 +0100
@@ -350,8 +350,7 @@ static ssize_t show_temp(struct device *
 
 	case FAULT:
 		/* Note - only for remote1 and remote2 */
-		out = data->alarms & (sattr->index ? 0x8000 : 0x4000);
-		out = out ? 0 : 1;
+		out = !!(data->alarms & (sattr->index ? 0x8000 : 0x4000));
 		break;
 
 	default:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
