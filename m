From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:47 +0000
Subject: [lm-sensors] [PATCH 53/82] hwmon: (pcf8591) Fix multi-line comments
Message-Id: <1327017376-20466-54-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pcf8591.c |   80 ++++++++++++++++++++++++++--------------------
 1 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index 474c97d..4ab2a0e 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -1,22 +1,22 @@
 /*
-    Copyright (C) 2001-2004 Aurelien Jarno <aurelien@aurel32.net>
-    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
-    the help of Jean Delvare <khali@linux-fr.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * Copyright (C) 2001-2004 Aurelien Jarno <aurelien@aurel32.net>
+ * Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
+ * the help of Jean Delvare <khali@linux-fr.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -39,28 +39,34 @@ MODULE_PARM_DESC(input_mode,
 	" 2 = single ended and differential mixed\n"
 	" 3 = two differential inputs\n");
 
-/* The PCF8591 control byte
-      7    6    5    4    3    2    1    0
-   |  0 |AOEF|   AIP   |  0 |AINC|  AICH   | */
+/*
+ * The PCF8591 control byte
+ * 7    6    5    4    3    2    1    0
+ * |  0 |AOEF|   AIP   |  0 |AINC|  AICH   |
+ */
 
 /* Analog Output Enable Flag (analog output active if 1) */
 #define PCF8591_CONTROL_AOEF		0x40
 
-/* Analog Input Programming
-   0x00 = four single ended inputs
-   0x10 = three differential inputs
-   0x20 = single ended and differential mixed
-   0x30 = two differential inputs */
+/*
+ * Analog Input Programming
+ * 0x00 = four single ended inputs
+ * 0x10 = three differential inputs
+ * 0x20 = single ended and differential mixed
+ * 0x30 = two differential inputs
+ */
 #define PCF8591_CONTROL_AIP_MASK	0x30
 
 /* Autoincrement Flag (switch on if 1) */
 #define PCF8591_CONTROL_AINC		0x04
 
-/* Channel selection
-   0x00 = channel 0
-   0x01 = channel 1
-   0x02 = channel 2
-   0x03 = channel 3 */
+/*
+ * Channel selection
+ * 0x00 = channel 0
+ * 0x01 = channel 1
+ * 0x02 = channel 2
+ * 0x03 = channel 3
+ */
 #define PCF8591_CONTROL_AICH_MASK	0x03
 
 /* Initial values */
@@ -262,8 +268,10 @@ static void pcf8591_init_client(struct i2c_client *client)
 
 	i2c_smbus_write_byte_data(client, data->control, data->aout);
 
-	/* The first byte transmitted contains the conversion code of the
-	   previous read cycle. FLUSH IT! */
+	/*
+	 * The first byte transmitted contains the conversion code of the
+	 * previous read cycle. FLUSH IT!
+	 */
 	i2c_smbus_read_byte(client);
 }
 
@@ -280,8 +288,10 @@ static int pcf8591_read_channel(struct device *dev, int channel)
 			      | channel;
 		i2c_smbus_write_byte(client, data->control);
 
-		/* The first byte transmitted contains the conversion code of
-		   the previous read cycle. FLUSH IT! */
+		/*
+		 * The first byte transmitted contains the conversion code of
+		 * the previous read cycle. FLUSH IT!
+		 */
 		i2c_smbus_read_byte(client);
 	}
 	value = i2c_smbus_read_byte(client);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
