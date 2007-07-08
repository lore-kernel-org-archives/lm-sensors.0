From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 12:14:34 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-check-dmi-vendor.patch
Message-Id: <4690D52A.7040402@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080000060801000103040901"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080000060801000103040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

With this patch the abituguru refuses to load on non Abit motherboards, as
discussed in lkml CONFIG_BREAK_MY_MACHINE thread.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

--------------080000060801000103040901
Content-Type: text/x-patch;
 name="hwmon-abituguru-check-dmi-vendor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="hwmon-abituguru-check-dmi-vendor.patch"

With this patch the abituguru refuses to load on non Abit motherboards, as 
discussed in lkml CONFIG_BREAK_MY_MACHINE thread.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22-rc4/drivers/hwmon/abituguru.c~ linux-2.6.22-rc4/drivers/hwmon/abituguru.c
--- linux-2.6.22-rc4/drivers/hwmon/abituguru.c~	2007-07-08 14:06:28.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/abituguru.c	2007-07-08 14:08:36.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 
 /* Banks */
@@ -1446,6 +1447,14 @@ static int __init abituguru_init(void)
 	int address, err;
 	struct resource res = { .flags = IORESOURCE_IO };
 
+#ifdef CONFIG_DMI
+	char *board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+
+	/* safety check, refuse to load on non Abit motherboards */
+	if (!board_vendor || strcmp(board_vendor, "http://www.abit.com.tw/"))
+		return -ENODEV;
+#endif
+
 	address = abituguru_detect();
 	if (address < 0)
 		return address;

--------------080000060801000103040901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080000060801000103040901--
