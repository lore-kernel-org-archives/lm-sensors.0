From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 May 2007 17:58:00 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon/ds1621: Fix swapped temperature
Message-Id: <20070516195800.19114e56@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The low temperature limit and the high temperature limit registers
have been accidentally swapped, causing alarms to trigger
when they shouldn't.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/ds1621.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.22-rc1.orig/drivers/hwmon/ds1621.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.22-rc1/drivers/hwmon/ds1621.c	2007-05-16 17:39:56.000000000 +0200
@@ -53,8 +53,8 @@ MODULE_PARM_DESC(polarity, "Output's pol
 
 /* The DS1621 registers */
 #define DS1621_REG_TEMP			0xAA /* word, RO */
-#define DS1621_REG_TEMP_MIN		0xA1 /* word, RW */
-#define DS1621_REG_TEMP_MAX		0xA2 /* word, RW */
+#define DS1621_REG_TEMP_MIN		0xA2 /* word, RW */
+#define DS1621_REG_TEMP_MAX		0xA1 /* word, RW */
 #define DS1621_REG_CONF			0xAC /* byte, RW */
 #define DS1621_COM_START		0xEE /* no data */
 #define DS1621_COM_STOP			0x22 /* no data */
@@ -328,9 +328,9 @@ static struct ds1621_data *ds1621_update
 
 		/* reset alarms if necessary */
 		new_conf = data->conf;
-		if (data->temp < data->temp_min)
+		if (data->temp > data->temp_min)
 			new_conf &= ~DS1621_ALARM_TEMP_LOW;
-		if (data->temp > data->temp_max)
+		if (data->temp < data->temp_max)
 			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
 		if (data->conf != new_conf)
 			ds1621_write_value(client, DS1621_REG_CONF,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
