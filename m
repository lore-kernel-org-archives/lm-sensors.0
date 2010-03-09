From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Mar 2010 12:56:36 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
Message-Id: <20100309135636.373a40a9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When the user passes the kernel parameter acpi_enforce_resources=lax,
the ACPI resources are no longer protected, so a native driver can
make use of them. In that case, we do not want the asus_atk0110 to be
loaded. Unfortunately, this driver loads automatically due to its
MODULE_DEVICE_TABLE, so the user ends up with two drivers loaded for
the same device - this is bad.

So I suggest that we prevent the asus_atk0110 driver from loading if
acpi_enforce_resources=lax.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>
Cc: Len Brown <lenb@kernel.org>
---
Luca, what do you think? I had the idea to write this patch after
seeing this bug report:
https://bugzilla.novell.com/show_bug.cgi?idX0988
I'm not sure if the driver conflict is the root cause of the problem,
but it certainly did not help.

Another approach would be to hide the ATK0110 ACPI device itself, but I
don't know if it is possible?

 drivers/acpi/osl.c           |    9 +++++++++
 drivers/hwmon/asus_atk0110.c |    7 +++++++
 include/linux/acpi.h         |    2 ++
 3 files changed, 18 insertions(+)

--- linux-2.6.34-rc1.orig/drivers/acpi/osl.c	2010-03-09 08:24:52.000000000 +0100
+++ linux-2.6.34-rc1/drivers/acpi/osl.c	2010-03-09 13:38:49.000000000 +0100
@@ -1206,6 +1206,15 @@ int acpi_check_mem_region(resource_size_
 EXPORT_SYMBOL(acpi_check_mem_region);
 
 /*
+ * Let drivers know whether the resource checks are effective
+ */
+int acpi_resources_are_enforced(void)
+{
+	return acpi_enforce_resources = ENFORCE_RESOURCES_STRICT;
+}
+EXPORT_SYMBOL(acpi_resources_are_enforced);
+
+/*
  * Acquire a spinlock.
  *
  * handle is a pointer to the spinlock_t.
--- linux-2.6.34-rc1.orig/drivers/hwmon/asus_atk0110.c	2010-02-25 09:12:22.000000000 +0100
+++ linux-2.6.34-rc1/drivers/hwmon/asus_atk0110.c	2010-03-09 13:23:50.000000000 +0100
@@ -1406,6 +1406,13 @@ static int __init atk0110_init(void)
 {
 	int ret;
 
+	/* Make sure it's safe to access the device through ACPI */
+	if (!acpi_resources_are_enforced()) {
+		pr_err("atk: Resources not safely usable due to "
+		       "acpi_enforce_resources kernel parameter\n");
+		return -EBUSY;
+	}
+
 	ret = acpi_bus_register_driver(&atk_driver);
 	if (ret)
 		pr_info("atk: acpi_bus_register_driver failed: %d\n", ret);
--- linux-2.6.34-rc1.orig/include/linux/acpi.h	2010-02-25 09:13:22.000000000 +0100
+++ linux-2.6.34-rc1/include/linux/acpi.h	2010-03-09 13:46:33.000000000 +0100
@@ -247,6 +247,8 @@ int acpi_check_region(resource_size_t st
 int acpi_check_mem_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 
+int acpi_resources_are_enforced(void);
+
 #ifdef CONFIG_PM_SLEEP
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
