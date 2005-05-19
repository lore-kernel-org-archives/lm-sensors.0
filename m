From: aedil@alchar.org (Kris Van Hees)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: Small bug fix in mtp008.c
Message-Id: <20040726234302.A25950@alchar.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is a small patch that fixes the setting of limits on the temp2 sensors
in the MTP008 chip.  The code (embarassingly written by myself when I wrote
the MTP008 chip driver a long time ago) would always update the hyst and max
limits of the first temp sensor, even when you tried to set it for the 2nd
or 3rd sensors.

	Kris
-- 
Never underestimate a Mage with:
 - the Intelligence to cast Magic Missile,
 - the Constitution to survive the first hit, and
 - the Dexterity to run fast enough to avoid being hit a second time.
-------------- next part --------------
Index: kernel/chips/mtp008.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/mtp008.c,v
retrieving revision 1.21
diff -u -2 -r1.21 mtp008.c
--- kernel/chips/mtp008.c	17 Apr 2004 17:20:01 -0000	1.21
+++ kernel/chips/mtp008.c	27 Jul 2004 03:52:50 -0000
@@ -2,5 +2,5 @@
    mtp008.c - Part of lm_sensors, Linux kernel modules for hardware
    monitoring
-   Copyright (c) 2001  Kris Van Hees <aedil@alchar.org>
+   Copyright (c) 2001-2004  Kris Van Hees <aedil@alchar.org>
 
    This program is free software; you can redistribute it and/or modify
@@ -338,7 +338,7 @@
 	 &i2c_proc_real, &i2c_sysctl_real, NULL, &mtp008_temp},
 	{MTP008_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL,
-       &i2c_proc_real, &i2c_sysctl_real, NULL, &mtp008_temp_add},
+	 &i2c_proc_real, &i2c_sysctl_real, NULL, &mtp008_temp_add},
 	{MTP008_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL,
-       &i2c_proc_real, &i2c_sysctl_real, NULL, &mtp008_temp_add},
+	 &i2c_proc_real, &i2c_sysctl_real, NULL, &mtp008_temp_add},
 	{MTP008_SYSCTL_VID, "vid", NULL, 0, 0444, NULL,
 	 &i2c_proc_real, &i2c_sysctl_real, NULL, &mtp008_vid},
@@ -810,11 +810,15 @@
 			if (*nrels_mag >= 1) {
 				data->in_max[nr] = TEMP_TO_REG(results[0]);
-				mtp008_write_value(client, MTP008_REG_TEMP_MAX,
-						   data->in_max[nr]);
+				mtp008_write_value(
+					client, MTP008_REG_IN_MAX(nr),
+					data->in_max[nr]
+				);
 			}
 			if (*nrels_mag >= 2) {
 				data->in_min[nr] = TEMP_TO_REG(results[1]);
-				mtp008_write_value(client, MTP008_REG_TEMP_MIN,
-						   data->in_min[nr]);
+				mtp008_write_value(
+					client, MTP008_REG_IN_MIN(nr),
+					data->in_min[nr]
+				);
 			}
 		}
