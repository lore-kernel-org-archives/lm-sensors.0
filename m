From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Thu, 26 Aug 2010 13:45:17 +0000
Subject: [lm-sensors] [RFC PATCH] Trivial changes to pacify the checkpatch
Message-Id: <1282829597-19047-1-git-send-email-shubhrajyoti@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some trivial changes to pacify the checkpatch so that
real errors are highlighted.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d579290..97b3a89 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -1,21 +1,21 @@
 /*
-    lm75.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
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
+	lm75.c - Part of lm_sensors, Linux kernel modules for hardware
+			 monitoring
+	Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
 #include <linux/module.h>
@@ -339,9 +339,9 @@ static struct i2c_driver lm75_driver = {
 
 /* register access */
 
-/* All registers are word-sized, except for the configuration register.
-   LM75 uses a high-byte first convention, which is exactly opposite to
-   the SMBus standard. */
+/*	All registers are word-sized, except for the configuration register.
+	LM75 uses a high-byte first convention, which is exactly opposite to
+	the SMBus standard. */
 static int lm75_read_value(struct i2c_client *client, u8 reg)
 {
 	int value;
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
