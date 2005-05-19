From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: [PATCH] i2c driver changes for 2.5.68
Message-Id: <1051228746897@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030424235836.GA29888@kroah.com>
References: <10512287461373@kroah.com>
In-Reply-To: <10512287461373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1179.3.1, 2003/04/23 11:32:48-07:00, hch@lst.de

[PATCH] i2c: remove dead junk from i2c-sensors.h


 include/linux/i2c-sensor.h |   32 --------------------------------
 1 files changed, 32 deletions(-)


diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h	Thu Apr 24 16:47:45 2003
+++ b/include/linux/i2c-sensor.h	Thu Apr 24 16:47:45 2003
@@ -22,18 +22,6 @@
 #ifndef _LINUX_I2C_SENSOR_H
 #define _LINUX_I2C_SENSOR_H
 
-#include <linux/sysctl.h>
-
-/* The type of callback functions used in sensors_{proc,sysctl}_real */
-typedef void (*i2c_real_callback) (struct i2c_client * client,
-				       int operation, int ctl_name,
-				       int *nrels_mag, long *results);
-
-/* Values for the operation field in the above function type */
-#define SENSORS_PROC_REAL_INFO 1
-#define SENSORS_PROC_REAL_READ 2
-#define SENSORS_PROC_REAL_WRITE 3
-
 /* A structure containing detect information.
    Force variables overrule all other variables; they force a detection on
    that place. If a specific chip is given, the module blindly assumes this
@@ -350,24 +338,4 @@
 	else
 		return value;
 }
-
-
-/* The maximum length of the prefix */
-#define SENSORS_PREFIX_MAX 20
-
-/* Sysctl IDs */
-#ifdef DEV_HWMON
-#define DEV_SENSORS DEV_HWMON
-#else				/* ndef DEV_HWMOM */
-#define DEV_SENSORS 2		/* The id of the lm_sensors directory within the
-				   dev table */
-#endif				/* def DEV_HWMON */
-
-#define SENSORS_CHIPS 1
-struct i2c_chips_data {
-	int sysctl_id;
-	char name[SENSORS_PREFIX_MAX + 13];
-};
-
 #endif				/* def _LINUX_I2C_SENSOR_H */
-

