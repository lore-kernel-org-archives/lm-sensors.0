From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH 2.6] Cleanup adm1021 unused defines
Message-Id: <20050306085255.1cb6e862.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

While working on the adm1021 driver, I found that this driver has a
number of unused (and useless) defines we could get rid of.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-mm1/drivers/i2c/chips/adm1021.c.orig	Fri Mar  4 13:03:33 2005
+++ linux-2.6.11-mm1/drivers/i2c/chips/adm1021.c	Fri Mar  4 13:24:16 2005
@@ -28,18 +28,6 @@
 #include <linux/i2c-sensor.h>
 
 
-/* Registers */
-#define ADM1021_SYSCTL_TEMP		1200
-#define ADM1021_SYSCTL_REMOTE_TEMP	1201
-#define ADM1021_SYSCTL_DIE_CODE		1202
-#define ADM1021_SYSCTL_ALARMS		1203
-
-#define ADM1021_ALARM_TEMP_HIGH		0x40
-#define ADM1021_ALARM_TEMP_LOW		0x20
-#define ADM1021_ALARM_RTEMP_HIGH	0x10
-#define ADM1021_ALARM_RTEMP_LOW		0x08
-#define ADM1021_ALARM_RTEMP_NA		0x04
-
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
 					0x29, 0x2a, 0x2b,


-- 
Jean Delvare
