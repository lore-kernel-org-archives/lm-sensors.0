From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 May 2009 12:28:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Fix W83782D support (NULL
Message-Id: <20090507142805.1be2d2f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 360782dde00a2e6e7d9fd57535f90934707ab8a8 (hwmon: (w83781d) Stop
abusing struct i2c_client for ISA devices) broke W83782D support for
devices connected on the ISA bus. You will hit a NULL pointer
dereference as soon as you read any device attribute. Other devices,
and W83782D devices on the SMBus, aren't affected.

Reported-by: Michel Abraham
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.29.orig/drivers/hwmon/w83781d.c	2009-03-24 13:43:33.000000000 +0100
+++ linux-2.6.29/drivers/hwmon/w83781d.c	2009-05-07 12:26:01.000000000 +0200
@@ -1462,7 +1462,8 @@ static struct w83781d_data *w83781d_upda
 				data->pwm[i]  				    w83781d_read_value(data,
 						       W83781D_REG_PWM[i]);
-				if ((data->type != w83782d || !client->driver)
+				/* Only W83782D on SMBus has PWM3 and PWM4 */
+				if ((data->type != w83782d || !client)
 				    && i = 1)
 					break;
 			}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
