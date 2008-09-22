From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Sep 2008 08:59:33 +0000
Subject: [lm-sensors] [PATCH] hwmon-vid: Be quiet if CPU has no VID pins
Message-Id: <20080922105933.225364ac@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There's no point in warning the user about the "unknown VRM version"
of his/her CPU is we know that said CPU has no VID pins. Better just
keep quiet in this case.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
Rudolf, what do you think?
David, I guess that you don't have the opportunity to test this patch?

 drivers/hwmon/hwmon-vid.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.27-rc7.orig/drivers/hwmon/hwmon-vid.c	2008-08-21 09:10:45.000000000 +0200
+++ linux-2.6.27-rc7/drivers/hwmon/hwmon-vid.c	2008-09-22 10:52:08.000000000 +0200
@@ -1,7 +1,8 @@
 /*
  * hwmon-vid.c - VID/VRM/VRD voltage conversions
  *
- * Copyright (c) 2004 Rudolf Marek <r.marek@assembler.cz>
+ * Copyright (c) 2004-2007 Rudolf Marek <r.marek@assembler.cz>
+ * Copyright (c) 2007-2008 Jean Delvare <khali@linux-fr.org>
  *
  * Partly imported from i2c-vid.h of the lm_sensors project
  * Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
@@ -167,6 +168,7 @@ struct vrm_model {
 };
 
 #define ANY 0xFF
+#define NO_VID 1
 
 #ifdef CONFIG_X86
 
@@ -196,6 +198,7 @@ static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M, Eden-N */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0x7, 0},		/* No information */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* C7, Esther */
+	{X86_VENDOR_NSC, 0x5, 0x9, ANY, NO_VID},	/* Geode */
 	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
 };
 
@@ -239,6 +242,8 @@ u8 vid_which_vrm(void)
 	if (vrm_ret = 0)
 		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your "
 		       "x86 CPU\n");
+	else if (vrm_ret = NO_VID)	/* No warning if no VID pins */
+		vrm_ret = 0;
 	return vrm_ret;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
