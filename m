From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 10 Jul 2007 15:09:57 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru-check-dmi-vendor.patch
Message-Id: <4693A145.4000400@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030100080307050007060205"
List-Id: <lm-sensors.vger.kernel.org>
References: <4690D52A.7040402@hhs.nl>
In-Reply-To: <4690D52A.7040402@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030100080307050007060205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hans,
> 
> On Mon, 9 Jul 2007 20:27:46 +0200, Jean Delvare wrote:
>> On Sun, 08 Jul 2007 14:14:34 +0200, Hans de Goede wrote:
>>> With this patch the abituguru refuses to load on non Abit motherboards, as
>>> discussed in lkml CONFIG_BREAK_MY_MACHINE thread.
>>>
>>> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>> Thanks for doing this.
>>
>> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Thinking about it some more... You may want to skip the DMI test if the
> force module parameter is used, in case Abit stops being consistent for
> the DMI board vendor name field.
> 

Good point, attached is an updated version which does that.

Regards,

Hans


--------------030100080307050007060205
Content-Type: text/x-patch;
 name="hwmon-abituguru-check-dmi-vendor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="hwmon-abituguru-check-dmi-vendor.patch"

With this patch the abituguru refuses to load on non Abit motherboards, as 
discussed in lkml CONFIG_BREAK_MY_MACHINE thread.

This is an updates version, which will skip this test when the force parameter
is used.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22-rc4/drivers/hwmon/abituguru.c~ linux-2.6.22-rc4/drivers/hwmon/abituguru.c
--- linux-2.6.22-rc4/drivers/hwmon/abituguru.c~	2007-07-08 14:06:28.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/abituguru.c	2007-07-10 13:19:55.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 
 /* Banks */
@@ -1446,6 +1447,15 @@ static int __init abituguru_init(void)
 	int address, err;
 	struct resource res = { .flags = IORESOURCE_IO };
 
+#ifdef CONFIG_DMI
+	char *board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+
+	/* safety check, refuse to load on non Abit motherboards */
+	if (!force && (!board_vendor ||
+			strcmp(board_vendor, "http://www.abit.com.tw/")))
+		return -ENODEV;
+#endif
+
 	address = abituguru_detect();
 	if (address < 0)
 		return address;

--------------030100080307050007060205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030100080307050007060205--
