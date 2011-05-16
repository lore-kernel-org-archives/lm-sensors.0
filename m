From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 May 2011 09:06:12 +0000
Subject: [lm-sensors] [PATCH] hwmon: (abituguru) Depend on DMI
Message-Id: <20110516110612.49ed4204@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The abituguru drivers are only built on X86, where DMI support is now
enabled by default. So let these drivers depend on DMI, for the
following gains:
* Robustness and safety. Detection of these devices is weak and uses
  non-standard methods, it should really be limited to Abit boards
  unless the user explicitly asks otherwise.
* Code simplicity. The code is easier to read without ifdefs.
* Better build testing coverage. Now there's only one way to build the
  drivers, so no risk of build failure on exotic systems.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Alistair John Strachan <alistair@devzero.co.uk>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/Kconfig      |    4 ++--
 drivers/hwmon/abituguru.c  |    3 ---
 drivers/hwmon/abituguru3.c |   13 -------------
 3 files changed, 2 insertions(+), 18 deletions(-)

--- linux-2.6.39-rc7.orig/drivers/hwmon/Kconfig	2011-05-16 08:35:03.000000000 +0200
+++ linux-2.6.39-rc7/drivers/hwmon/Kconfig	2011-05-16 09:07:57.000000000 +0200
@@ -41,7 +41,7 @@ comment "Native drivers"
 
 config SENSORS_ABITUGURU
 	tristate "Abit uGuru (rev 1 & 2)"
-	depends on X86 && EXPERIMENTAL
+	depends on X86 && DMI && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the sensor part of the first
 	  and second revision of the Abit uGuru chip. The voltage and frequency
@@ -56,7 +56,7 @@ config SENSORS_ABITUGURU
 
 config SENSORS_ABITUGURU3
 	tristate "Abit uGuru (rev 3)"
-	depends on X86 && EXPERIMENTAL
+	depends on X86 && DMI && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the sensor part of the
 	  third revision of the Abit uGuru chip. Only reading the sensors
--- linux-2.6.39-rc7.orig/drivers/hwmon/abituguru.c	2011-04-12 11:05:32.000000000 +0200
+++ linux-2.6.39-rc7/drivers/hwmon/abituguru.c	2011-05-16 09:08:40.000000000 +0200
@@ -1448,15 +1448,12 @@ static int __init abituguru_init(void)
 {
 	int address, err;
 	struct resource res = { .flags = IORESOURCE_IO };
-
-#ifdef CONFIG_DMI
 	const char *board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
 
 	/* safety check, refuse to load on non Abit motherboards */
 	if (!force && (!board_vendor ||
 			strcmp(board_vendor, "http://www.abit.com.tw/")))
 		return -ENODEV;
-#endif
 
 	address = abituguru_detect();
 	if (address < 0)
--- linux-2.6.39-rc7.orig/drivers/hwmon/abituguru3.c	2011-04-12 11:05:32.000000000 +0200
+++ linux-2.6.39-rc7/drivers/hwmon/abituguru3.c	2011-05-16 09:12:19.000000000 +0200
@@ -1119,8 +1119,6 @@ static struct platform_driver abituguru3
 	.resume = abituguru3_resume
 };
 
-#ifdef CONFIG_DMI
-
 static int __init abituguru3_dmi_detect(void)
 {
 	const char *board_vendor, *board_name;
@@ -1159,15 +1157,6 @@ static int __init abituguru3_dmi_detect(
 	return 1;
 }
 
-#else /* !CONFIG_DMI */
-
-static inline int abituguru3_dmi_detect(void)
-{
-	return 1;
-}
-
-#endif /* CONFIG_DMI */
-
 /* FIXME: Manual detection should die eventually; we need to collect stable
  *        DMI model names first before we can rely entirely on CONFIG_DMI.
  */
@@ -1216,10 +1205,8 @@ static int __init abituguru3_init(void)
 		if (err)
 			return err;
 
-#ifdef CONFIG_DMI
 		pr_warn("this motherboard was not detected using DMI. "
 			"Please send the output of \"dmidecode\" to the abituguru3 maintainer (see MAINTAINERS)\n");
-#endif
 	}
 
 	err = platform_driver_register(&abituguru3_driver);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
