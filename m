From: david-b@pacbell.net (David Brownell)
Date: Fri, 16 Feb 2007 00:03:13 +0000
Subject: [lm-sensors] [patch 2.6.20-git] hwmon should use subsys_init
Message-Id: <200702151603.13810.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The hwmon subsystem registers itself excessively late when it's not linked
as a module.  That can cause problems when multifunction chips, that happen
to have hwmon capabilities and live outside the hwmon subdirectory, need to
initialize earlier than on various platforms.

This patch makes the hwmon subsystem code register itself appropriately early:
as a subsystem, like other subsystems.

Signed-off-by: David Brownell <dbrownell at users.sourceforge.net>

Index: osk/drivers/hwmon/hwmon.c
=================================--- osk.orig/drivers/hwmon/hwmon.c	2006-05-02 19:18:31.000000000 -0700
+++ osk/drivers/hwmon/hwmon.c	2006-05-02 19:18:46.000000000 -0700
@@ -102,7 +102,7 @@ static void __exit hwmon_exit(void)
 	class_destroy(hwmon_class);
 }
 
-module_init(hwmon_init);
+subsys_initcall(hwmon_init);
 module_exit(hwmon_exit);
 
 EXPORT_SYMBOL_GPL(hwmon_device_register);

