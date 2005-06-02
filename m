From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 02 Jun 2005 05:35:11 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 1/3] core: add
Message-Id: <20050602033431.GB4906@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch adds a va_args version of the class_device_create function.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.12-rc5-mm1/drivers/base/class.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/base/class.c
+++ linux-2.6.12-rc5-mm1/drivers/base/class.c
@@ -543,7 +543,29 @@ int class_device_register(struct class_d
 struct class_device *class_device_create(struct class *cls, dev_t devt,
 					 struct device *device, char *fmt, ...)
 {
+	struct class_device *class_dev = NULL;
 	va_list args;
+
+	va_start(args, fmt);
+	class_dev = class_device_create_v(cls, devt, device, fmt, args);
+	va_end(args);
+
+	return class_dev;
+}
+
+/**
+ * class_device_create_v - creates a class device and registers it with sysfs
+ * @cs: pointer to the struct class that this device should be registered to.
+ * @dev: the dev_t for the char device to be added.
+ * @device: a pointer to a struct device that is assiociated with this class device.
+ * @fmt: string for the class device's name
+ * 
+ * this function is to class_device_create as (e.g.) vprintf is to printf
+ */
+struct class_device *class_device_create_v(struct class *cls, dev_t devt,
+					   struct device *device, char *fmt,
+					   va_list args)
+{
 	struct class_device *class_dev = NULL;
 	int retval = -ENODEV;
 
@@ -561,9 +583,7 @@ struct class_device *class_device_create
 	class_dev->dev = device;
 	class_dev->class = cls;
 
-	va_start(args, fmt);
 	vsnprintf(class_dev->class_id, BUS_ID_SIZE, fmt, args);
-	va_end(args);
 	retval = class_device_register(class_dev);
 	if (retval)
 		goto error;
@@ -749,6 +769,7 @@ EXPORT_SYMBOL_GPL(class_device_del);
 EXPORT_SYMBOL_GPL(class_device_get);
 EXPORT_SYMBOL_GPL(class_device_put);
 EXPORT_SYMBOL_GPL(class_device_create);
+EXPORT_SYMBOL_GPL(class_device_create_v);
 EXPORT_SYMBOL_GPL(class_device_destroy);
 EXPORT_SYMBOL_GPL(class_device_create_file);
 EXPORT_SYMBOL_GPL(class_device_remove_file);
Index: linux-2.6.12-rc5-mm1/include/linux/device.h
=================================--- linux-2.6.12-rc5-mm1.orig/include/linux/device.h
+++ linux-2.6.12-rc5-mm1/include/linux/device.h
@@ -256,8 +256,13 @@ extern void class_interface_unregister(s
 extern struct class *class_create(struct module *owner, char *name);
 extern void class_destroy(struct class *cls);
 extern struct class_device *class_device_create(struct class *cls, dev_t devt,
-						struct device *device, char *fmt, ...)
+						struct device *device,
+						char *fmt, ...)
 					__attribute__((format(printf,4,5)));
+extern struct class_device *class_device_create_v(struct class *cls, dev_t devt,
+						  struct device *device,
+						  char *fmt, va_list args)
+					__attribute__((format(printf,4,0)));
 extern void class_device_destroy(struct class *cls, dev_t devt);
 
 
-- 
Mark M. Hoffman
mhoffman@lightlink.com

