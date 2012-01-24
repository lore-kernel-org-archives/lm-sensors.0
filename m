From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:50 +0000
Subject: [lm-sensors] [PATCH 71/79] hwmon: (smsc47b397) Fix multi-line comments
Message-Id: <1327373398-997-72-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Mark M Hoffman <mhoffman@lightlink.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47b397.c |   64 +++++++++++++++++++++++--------------------
 1 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index 65c88ff..d3b778d 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -1,30 +1,30 @@
 /*
-    smsc47b397.c - Part of lm_sensors, Linux kernel modules
-			for hardware monitoring
-
-    Supports the SMSC LPC47B397-NC Super-I/O chip.
-
-    Author/Maintainer: Mark M. Hoffman <mhoffman@lightlink.com>
-	Copyright (C) 2004 Utilitek Systems, Inc.
-
-    derived in part from smsc47m1.c:
-	Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
-	Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
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
+ * smsc47b397.c - Part of lm_sensors, Linux kernel modules
+ * for hardware monitoring
+ *
+ * Supports the SMSC LPC47B397-NC Super-I/O chip.
+ *
+ * Author/Maintainer: Mark M. Hoffman <mhoffman@lightlink.com>
+ * Copyright (C) 2004 Utilitek Systems, Inc.
+ *
+ * derived in part from smsc47m1.c:
+ * Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+ * Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
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
 
@@ -157,8 +157,10 @@ static struct smsc47b397_data *smsc47b397_update_device(struct device *dev)
 	return data;
 }
 
-/* TEMP: 0.001C/bit (-128C to +127C)
-   REG: 1C/bit, two's complement */
+/*
+ * TEMP: 0.001C/bit (-128C to +127C)
+ * REG: 1C/bit, two's complement
+ */
 static int temp_from_reg(u8 reg)
 {
 	return (s8)reg * 1000;
@@ -177,8 +179,10 @@ static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
 
-/* FAN: 1 RPM/bit
-   REG: count of 90kHz pulses / revolution */
+/*
+ * FAN: 1 RPM/bit
+ * REG: count of 90kHz pulses / revolution
+ */
 static int fan_from_reg(u16 reg)
 {
 	if (reg = 0 || reg = 0xffff)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
