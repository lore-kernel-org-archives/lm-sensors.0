From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 23 May 2008 14:10:41 +0000
Subject: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <4836D061.9080501@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040705090001060405060902"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705090001060405060902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

It has been reported that the abituguru3 driver fails to load after a BIOS
update. This patch fixes this by loosening the detection routine so that it
will work after the BIOS update too. To compensate for the now very loose
detection an additional check is added on the DMI Base Board vendor string to
make sure we only load on Abit motherboards, this is the same as the check in
the abituguru (1 / 2) driver.

Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

p.s.

Alistair can you test the abituguru3 driver compiled with this patch on your 
motherboard and confirm that it fixes the issue (and still works).

--------------040705090001060405060902
Content-Type: text/plain;
 name="abituguru3-fix-detect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="abituguru3-fix-detect.patch"

It has been reported that the abituguru3 driver fails to load after a BIOS
update. This patch fixes this by loosening the detection routine so that it
will work after the BIOS update too. To compensate for the now very loose
detection an additional check is added on the DMI Base Board vendor string to
make sure we only load on Abit motherboards, this is the same as the check in
the abituguru (1 / 2) driver.

Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up vanilla-2.6.26-rc3-git4/drivers/hwmon/abituguru3.c~ vanilla-2.6.26-rc3-git4/drivers/hwmon/abituguru3.c
--- vanilla-2.6.26-rc3-git4/drivers/hwmon/abituguru3.c~	2008-05-23 16:03:28.000000000 +0200
+++ vanilla-2.6.26-rc3-git4/drivers/hwmon/abituguru3.c	2008-05-23 16:03:28.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 
 /* uGuru3 bank addresses */
@@ -1111,11 +1112,12 @@ static int __init abituguru3_detect(void
 {
 	/* See if there is an uguru3 there. An idle uGuru3 will hold 0x00 or
 	   0x08 at DATA and 0xAC at CMD. Sometimes the uGuru3 will hold 0x05
-	   at CMD instead, why is unknown. So we test for 0x05 too. */
+	   or 0x55 at CMD instead, why is unknown. */
 	u8 data_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_DATA);
 	u8 cmd_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
 	if (((data_val == 0x00) || (data_val == 0x08)) &&
-			((cmd_val == 0xAC) || (cmd_val == 0x05)))
+			((cmd_val == 0xAC) || (cmd_val == 0x05) ||
+			 (cmd_val == 0x55)))
 		return ABIT_UGURU3_BASE;
 
 	ABIT_UGURU3_DEBUG("no Abit uGuru3 found, data = 0x%02X, cmd = "
@@ -1138,6 +1140,15 @@ static int __init abituguru3_init(void)
 	int address, err;
 	struct resource res = { .flags = IORESOURCE_IO };
 
+#ifdef CONFIG_DMI
+	const char *board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+
+	/* safety check, refuse to load on non Abit motherboards */
+	if (!force && (!board_vendor ||
+			strcmp(board_vendor, "http://www.abit.com.tw/")))
+		return -ENODEV;
+#endif
+
 	address = abituguru3_detect();
 	if (address < 0)
 		return address;

--------------040705090001060405060902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040705090001060405060902--

