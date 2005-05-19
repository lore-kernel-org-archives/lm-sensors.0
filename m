From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <1047603324728@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10476033233796@kroah.com>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1112, 2003/03/13 12:26:39-08:00, greg@kroah.com

i2c: add i2c sysfs bus support.


 drivers/i2c/i2c-core.c |   33 ++++++++++++++++++++++++++++++---
 include/linux/i2c.h    |    3 +++
 2 files changed, 33 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Thu Mar 13 16:57:09 2003
+++ b/drivers/i2c/i2c-core.c	Thu Mar 13 16:57:09 2003
@@ -598,10 +598,37 @@
 {
 	remove_proc_entry("i2c",proc_bus);
 }
+#else
+static int __init i2cproc_init(void) { return 0; }
+static void __exit i2cproc_cleanup(void) { }
+#endif /* CONFIG_PROC_FS */
 
-module_init(i2cproc_init);
-module_exit(i2cproc_cleanup);
-#endif /* def CONFIG_PROC_FS */
+/* match always succeeds, as we want the probe() to tell if we really accept this match */
+static int i2c_device_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+};
+
+
+static int __init i2c_init(void)
+{
+	bus_register(&i2c_bus_type);
+	return i2cproc_init();
+}
+
+static void __exit i2c_exit(void)
+{
+	i2cproc_cleanup();
+	bus_unregister(&i2c_bus_type);
+}
+
+module_init(i2c_init);
+module_exit(i2c_exit);
 
 /* ----------------------------------------------------
  * the functional interface to the i2c busses.
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Thu Mar 13 16:57:09 2003
+++ b/include/linux/i2c.h	Thu Mar 13 16:57:09 2003
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/i2c-id.h>
+#include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
 
 /* --- General options ------------------------------------------------	*/
@@ -143,6 +144,8 @@
 	 */
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
 };
+
+extern struct bus_type i2c_bus_type;
 
 /*
  * i2c_client identifies a single device (i.e. chip) that is connected to an 
