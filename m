From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <20040413224205.4fe62163.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Apr 2004 20:02:42 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > Patch attached.
> > Tested. Works.
> 
> -ENOPATCH

Yep.
Attached.

> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
-------------- next part --------------
--- kernel/chips/lm92.c.orig	2004-04-13 21:27:17.000000000 +0400
+++ kernel/chips/lm92.c	2004-04-13 21:28:13.000000000 +0400
@@ -28,6 +28,7 @@
 #include <linux/proc_fs.h>
 #include <linux/sysctl.h>
 #include <asm/semaphore.h>
+#include "version.h"
 
 /* if defined, 4 faults must occur consecutively to set alarm flags */
 /* #define ENABLE_FAULT_QUEUE */
@@ -266,7 +267,7 @@
 	data->temp.high = swab16(temp_high);
 	data->temp.crit	= swab16(temp_max);
 	data->temp.hyst = swab16(temp_hyst);
-	data->temp.low 	= swab16(i2c_smbus_read_word_data(client, MAX6635_TEMP));
+	data->temp.low 	= swab16(i2c_smbus_read_word_data(client, LM92_REG_TEMPERATURE));
 
 	return 1;
 }
@@ -334,20 +335,25 @@
 		return (-ERESTARTSYS);
 	}
 
-	if ((kind < 0 && lm92_read16 (client,LM92_REG_MANUFACTURER,&manufacturer) < 0) ||
-		manufacturer != LM92_MANUFACTURER_ID) {
-		kfree (client);
-		up (&mutex);
-		return (-ENODEV);
-	}
-
 	if ((result = i2c_attach_client (client))) {
 		kfree (client);
 		up (&mutex);
 		return (result);
 	}
 
-	if ((result = i2c_register_entry (client,client->name,lm92_dir_table)) < 0) {
+	if ((kind < 0 && lm92_read16 (client,LM92_REG_MANUFACTURER,&manufacturer) < 0) ||
+		manufacturer != LM92_MANUFACTURER_ID) {
+
+		if (!max6635_check(client))
+		{
+			i2c_detach_client (client);
+			kfree (client);
+			up (&mutex);
+			return (-ENODEV);
+		}
+	}
+
+	if ((result = i2c_register_entry (client,client->name,lm92_dir_table, THIS_MODULE)) < 0) {
 		i2c_detach_client (client);
 		kfree (client);
 		up (&mutex);
@@ -405,9 +411,7 @@
 
 
 static struct i2c_driver lm92_driver = {
-	.owner		= THIS_MODULE,
 	.name		= "lm92",
-	.id		= I2C_DRIVERID_LM92,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm92_attach_adapter,
 	.detach_client	= lm92_detach_client,
