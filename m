From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Jan 2014 15:00:35 +0000
Subject: [lm-sensors] [PATCH, RFC] libsensors: Avoid insane memory allocations
Message-Id: <20140129160035.4537ecc9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

While there is no longer a hard limit to the number of sensor of a
given type per chip, I feel a little uncomfortable having no limit at
all on the amount of memory we may try to allocate. Add an arbitrary
safety limit so that a design error or a bug in a hwmon driver can't
result into an insane memory allocation.
---
Does anyone have an opinion on this? No limit at all makes me feel bad,
but I don't like arbitrary limits either. So I'm really not sure what
is the best option here.

 lib/sysfs.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- lm-sensors.orig/lib/sysfs.c	2014-01-29 15:44:03.544339229 +0100
+++ lm-sensors/lib/sysfs.c	2014-01-29 15:59:50.074019877 +0100
@@ -1,7 +1,7 @@
 /*
     sysfs.c - Part of libsensors, a library for reading Linux sensor data
     Copyright (c) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
-    Copyright (C) 2007-2010 Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2007-2014 Jean Delvare <khali@linux-fr.org>
 
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
@@ -468,8 +468,9 @@ static int sensors_read_dynamic_chip(sen
 			break;
 		}
 
-		/* Skip invalid entries */
-		if (nr < 0) {
+		/* Skip invalid entries. The high limit is arbitrary, we just
+		   don't want to allocate an insane amount of memory. */
+		if (nr < 0 || nr >= 8192) {
 #ifdef DEBUG
 			sensors_fatal_error(__func__,
 					    "Invalid channel number!");
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
