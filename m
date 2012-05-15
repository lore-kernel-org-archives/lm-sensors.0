From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Tue, 15 May 2012 17:25:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Drop uart6 condition for vin5&vin6 for IT8783F
Message-Id: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Bjoern Gerhart <oss@extracloud.de>

Drop UART6 condition for IT8783F related to VIN5 and VIN6.
In case UART6 is routed via JP4 to a different set of pins,
VIN5 and VIN6 can be used at the same time.

diff -Naur a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c	2012-05-15 16:53:07.156061059 +0200
+++ b/drivers/hwmon/it87.c	2012-05-15 17:19:31.717061875 +0200
@@ -1806,11 +1806,11 @@
 			sio_data->skip_pwm |= (1 << 1);
 
 		/* VIN5 */
-		if ((reg27 & (1 << 0)) || uart6)
+		if (reg27 & (1 << 0))
 			sio_data->skip_in |= (1 << 5); /* No VIN5 */
 
 		/* VIN6 */
-		if ((reg27 & (1 << 1)) || uart6)
+		if (reg27 & (1 << 1))
 			sio_data->skip_in |= (1 << 6); /* No VIN6 */
 
 		/*



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
