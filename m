From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:15 +0000
Subject: [lm-sensors] [PATCH 12/17 v2] hwmon: (g760a) fix checkpatch issues
Message-Id: <1326047660-20539-12-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
ERROR: code indent should use tabs where possible
#3: FILE: g760a.c:3:
+            fan speed PWM controller chip$

ERROR: trailing whitespace
#8: FILE: g760a.c:8:
+      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf $


If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/g760a.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 1d6a6fa..d1ccba5 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -1,11 +1,11 @@
 /*
     g760a - Driver for the Global Mixed-mode Technology Inc. G760A
-            fan speed PWM controller chip
+	    fan speed PWM controller chip
 
     Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
 
     Complete datasheet is available at GMT's website:
-      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf 
+      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
