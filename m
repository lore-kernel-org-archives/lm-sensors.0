From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:48 +0000
Subject: [lm-sensors] [PATCH 69/79] hwmon: (max1668) Fix multi-line comments
Message-Id: <1327373398-997-70-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: David George <david.george@ska.ac.za>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1668.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index 12249f7..335b183 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -1,23 +1,23 @@
 /*
-    Copyright (c) 2011 David George <david.george@ska.ac.za>
-
-    based on adm1021.c
-    some credit to Christoph Scheurer, but largely a rewrite
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
+ * Copyright (c) 2011 David George <david.george@ska.ac.za>
+ *
+ * based on adm1021.c
+ * some credit to Christoph Scheurer, but largely a rewrite
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
 
 #include <linux/module.h>
 #include <linux/init.h>
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
