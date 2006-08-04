From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Fri, 04 Aug 2006 23:03:39 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060804230339.GA10800@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 04, 2006 at 03:19:52PM -0700, Andrew Morton wrote:
> Could I please be sent a new copy of the whole patch, with the appropriate
> acked-bys, signed-off-bys, etc?

Sure, here we go.

- Rename exported variable "ams" to "ams_info"
- Fix leaked input device on error
- Change I?C read code to use schedule_timeout instead of msleep() in
  case the first read failed

Signed-off-by: Michael Hanselmann <linux-kernel at hansmi.ch>
Signed-off-by: Aristeu Sergio Rozanski Filho <aris at cathedrallabs.org>
Acked-by: Ren? Nussbaumer <linux-kernel at killerfox.forkbomb.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-core.c linux-2.6.18-rc3/drivers/hwmon/ams/ams-core.c
--- linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-core.c	2006-08-05 00:47:46.000000000 +0200
+++ linux-2.6.18-rc3/drivers/hwmon/ams/ams-core.c	2006-08-05 00:49:56.000000000 +0200
@@ -29,22 +29,22 @@
 #include "ams.h"
 
 /* There is only one motion sensor per machine */
-struct ams ams;
+struct ams ams_info;
 
 static unsigned int verbose;
 module_param(verbose, bool, 0644);
 MODULE_PARM_DESC(verbose, "Show free falls and shocks in kernel output");
 
-/* Call with lock held! */
+/* Call with ams_info.lock held! */
 void ams_sensors(s8 *x, s8 *y, s8 *z)
 {
-	u32 orient = ams.vflag? ams.orient1 : ams.orient2;
+	u32 orient = ams_info.vflag? ams_info.orient1 : ams_info.orient2;
 
 	if (orient & 0x80)
 		/* X and Y swapped */
-		ams.get_xyz(y, x, z);
+		ams_info.get_xyz(y, x, z);
 	else
-		ams.get_xyz(x, y, z);
+		ams_info.get_xyz(x, y, z);
 
 	if (orient & 0x04)
 		*z = ~(*z);
@@ -59,9 +59,9 @@ static ssize_t ams_show_current(struct d
 {
 	s8 x, y, z;
 
-	mutex_lock(&ams.lock);
+	mutex_lock(&ams_info.lock);
 	ams_sensors(&x, &y, &z);
-	mutex_unlock(&ams.lock);
+	mutex_unlock(&ams_info.lock);
 
 	return snprintf(buf, PAGE_SIZE, "%d %d %d\n", x, y, z);
 }
@@ -72,12 +72,12 @@ static void ams_handle_irq(void *data)
 {
 	enum ams_irq irq = *((enum ams_irq *)data);
 
-	spin_lock(&ams.irq_lock);
+	spin_lock(&ams_info.irq_lock);
 
-	ams.worker_irqs |= irq;
-	schedule_work(&ams.worker);
+	ams_info.worker_irqs |= irq;
+	schedule_work(&ams_info.worker);
 
-	spin_unlock(&ams.irq_lock);
+	spin_unlock(&ams_info.irq_lock);
 }
 
 static enum ams_irq ams_freefall_irq_data = AMS_IRQ_FREEFALL;
@@ -99,68 +99,68 @@ static struct pmf_irq_client ams_shock_c
  */
 static void ams_worker(void *data)
 {
-	mutex_lock(&ams.lock);
+	mutex_lock(&ams_info.lock);
 
-	if (ams.has_device) {
+	if (ams_info.has_device) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&ams.irq_lock, flags);
+		spin_lock_irqsave(&ams_info.irq_lock, flags);
 
-		if (ams.worker_irqs & AMS_IRQ_FREEFALL) {
+		if (ams_info.worker_irqs & AMS_IRQ_FREEFALL) {
 			if (verbose)
 				printk(KERN_INFO "ams: freefall detected!\n");
 
-			ams.worker_irqs &= ~AMS_IRQ_FREEFALL;
+			ams_info.worker_irqs &= ~AMS_IRQ_FREEFALL;
 
 			/* we must call this with interrupts enabled */
-			spin_unlock_irqrestore(&ams.irq_lock, flags);
-			ams.clear_irq(AMS_IRQ_FREEFALL);
-			spin_lock_irqsave(&ams.irq_lock, flags);
+			spin_unlock_irqrestore(&ams_info.irq_lock, flags);
+			ams_info.clear_irq(AMS_IRQ_FREEFALL);
+			spin_lock_irqsave(&ams_info.irq_lock, flags);
 		}
 
-		if (ams.worker_irqs & AMS_IRQ_SHOCK) {
+		if (ams_info.worker_irqs & AMS_IRQ_SHOCK) {
 			if (verbose)
 				printk(KERN_INFO "ams: shock detected!\n");
 
-			ams.worker_irqs &= ~AMS_IRQ_SHOCK;
+			ams_info.worker_irqs &= ~AMS_IRQ_SHOCK;
 
 			/* we must call this with interrupts enabled */
-			spin_unlock_irqrestore(&ams.irq_lock, flags);
-			ams.clear_irq(AMS_IRQ_SHOCK);
-			spin_lock_irqsave(&ams.irq_lock, flags);
+			spin_unlock_irqrestore(&ams_info.irq_lock, flags);
+			ams_info.clear_irq(AMS_IRQ_SHOCK);
+			spin_lock_irqsave(&ams_info.irq_lock, flags);
 		}
 
-		spin_unlock_irqrestore(&ams.irq_lock, flags);
+		spin_unlock_irqrestore(&ams_info.irq_lock, flags);
 	}
 
-	mutex_unlock(&ams.lock);
+	mutex_unlock(&ams_info.lock);
 }
 
-/* Call with lock held! */
+/* Call with ams_info.lock held! */
 int ams_sensor_attach(void)
 {
 	int result;
 	u32 *prop;
 
 	/* Get orientation */
-	prop = (u32*)get_property(ams.of_node, "orientation", NULL);
+	prop = (u32*)get_property(ams_info.of_node, "orientation", NULL);
 	if (!prop)
 		return -ENODEV;
-	ams.orient1 = *prop;
-	ams.orient2 = *(prop + 1);
+	ams_info.orient1 = *prop;
+	ams_info.orient2 = *(prop + 1);
 
 	/* Register freefall interrupt handler */
-	result = pmf_register_irq_client(ams.of_node,
+	result = pmf_register_irq_client(ams_info.of_node,
 			"accel-int-1",
 			&ams_freefall_client);
 	if (result < 0)
 		return -ENODEV;
 
 	/* Reset saved irqs */
-	ams.worker_irqs = 0;
+	ams_info.worker_irqs = 0;
 
 	/* Register shock interrupt handler */
-	result = pmf_register_irq_client(ams.of_node,
+	result = pmf_register_irq_client(ams_info.of_node,
 			"accel-int-2",
 			&ams_shock_client);
 	if (result < 0) {
@@ -169,17 +169,17 @@ int ams_sensor_attach(void)
 	}
 
 	/* Create device */
-	ams.of_dev = of_platform_device_create(ams.of_node, "ams", NULL);
-	if (!ams.of_dev) {
+	ams_info.of_dev = of_platform_device_create(ams_info.of_node, "ams", NULL);
+	if (!ams_info.of_dev) {
 		pmf_unregister_irq_client(&ams_shock_client);
 		pmf_unregister_irq_client(&ams_freefall_client);
 		return -ENODEV;
 	}
 
 	/* Create attributes */
-	device_create_file(&ams.of_dev->dev, &dev_attr_current);
+	device_create_file(&ams_info.of_dev->dev, &dev_attr_current);
 
-	ams.vflag = !!(ams.get_vendor() & 0x10);
+	ams_info.vflag = !!(ams_info.get_vendor() & 0x10);
 
 	/* Init mouse device */
 	ams_mouse_init();
@@ -191,9 +191,9 @@ int __init ams_init(void)
 {
 	struct device_node *np;
 
-	spin_lock_init(&ams.irq_lock);
-	mutex_init(&ams.lock);
-	INIT_WORK(&ams.worker, ams_worker, NULL);
+	spin_lock_init(&ams_info.irq_lock);
+	mutex_init(&ams_info.lock);
+	INIT_WORK(&ams_info.worker, ams_worker, NULL);
 
 #ifdef CONFIG_SENSORS_AMS_I2C
 	np = of_find_node_by_name(NULL, "accelerometer");
@@ -216,35 +216,35 @@ int __init ams_init(void)
 
 void ams_exit(void)
 {
-	mutex_lock(&ams.lock);
+	mutex_lock(&ams_info.lock);
 
-	if (ams.has_device) {
+	if (ams_info.has_device) {
 		/* Remove mouse device */
 		ams_mouse_exit();
 
 		/* Shut down implementation */
-		ams.exit();
+		ams_info.exit();
 
 		/* Cancel interrupt worker
 		 *
-		 * We do this after ams.exit(), because an interrupt might
+		 * We do this after ams_info.exit(), because an interrupt might
 		 * have arrived before disabling them.
 		 */
-		cancel_delayed_work(&ams.worker);
+		cancel_delayed_work(&ams_info.worker);
 		flush_scheduled_work();
 
 		/* Remove attributes */
-		device_remove_file(&ams.of_dev->dev, &dev_attr_current);
+		device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
 
 		/* Remove device */
-		of_device_unregister(ams.of_dev);
+		of_device_unregister(ams_info.of_dev);
 
 		/* Remove handler */
 		pmf_unregister_irq_client(&ams_shock_client);
 		pmf_unregister_irq_client(&ams_freefall_client);
 	}
 
-	mutex_unlock(&ams.lock);
+	mutex_unlock(&ams_info.lock);
 }
 
 MODULE_AUTHOR("Stelian Pop, Michael Hanselmann");
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams.h linux-2.6.18-rc3/drivers/hwmon/ams/ams.h
--- linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams.h	2006-08-05 00:47:46.000000000 +0200
+++ linux-2.6.18-rc3/drivers/hwmon/ams/ams.h	2006-08-05 00:49:56.000000000 +0200
@@ -60,7 +60,7 @@ struct ams {
 	int xcalib, ycalib, zcalib;
 };
 
-extern struct ams ams;
+extern struct ams ams_info;
 
 extern void ams_sensors(s8 *x, s8 *y, s8 *z);
 extern int ams_sensor_attach(void);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-i2c.c linux-2.6.18-rc3/drivers/hwmon/ams/ams-i2c.c
--- linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-i2c.c	2006-08-05 00:47:46.000000000 +0200
+++ linux-2.6.18-rc3/drivers/hwmon/ams/ams-i2c.c	2006-08-05 00:51:33.000000000 +0200
@@ -74,26 +74,30 @@ static struct i2c_driver ams_i2c_driver 
 
 static s32 ams_i2c_read(u8 reg)
 {
-	return i2c_smbus_read_byte_data(&ams.i2c_client, reg);
+	return i2c_smbus_read_byte_data(&ams_info.i2c_client, reg);
 }
 
 static int ams_i2c_write(u8 reg, u8 value)
 {
-	return i2c_smbus_write_byte_data(&ams.i2c_client, reg, value);
+	return i2c_smbus_write_byte_data(&ams_info.i2c_client, reg, value);
 }
 
 static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
 {
 	s32 result;
-	int i;
+	int remaining = HZ / 20;
 
 	ams_i2c_write(AMS_COMMAND, cmd);
-	for (i = 0; i < 10; i++) {
-		mdelay(5);
+	mdelay(5);
+
+	while (remaining) {
 		result = ams_i2c_read(AMS_COMMAND);
 		if (result = 0 || result & 0x80)
 			return 0;
+
+		remaining = schedule_timeout(remaining);
 	}
+
 	return -1;
 }
 
@@ -101,22 +105,28 @@ static void ams_i2c_set_irq(enum ams_irq
 {
 	if (reg & AMS_IRQ_FREEFALL) {
 		u8 val = ams_i2c_read(AMS_CTRLX);
-		if (enable)     val |= 0x80;
-		else            val &= ~0x80;
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
 		ams_i2c_write(AMS_CTRLX, val);
 	}
 
 	if (reg & AMS_IRQ_SHOCK) {
 		u8 val = ams_i2c_read(AMS_CTRLY);
-		if (enable)     val |= 0x80;
-		else            val &= ~0x80;
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
 		ams_i2c_write(AMS_CTRLY, val);
 	}
 
 	if (reg & AMS_IRQ_GLOBAL) {
 		u8 val = ams_i2c_read(AMS_CTRLZ);
-		if (enable)     val |= 0x80;
-		else            val &= ~0x80;
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
 		ams_i2c_write(AMS_CTRLZ, val);
 	}
 }
@@ -149,20 +159,20 @@ static int ams_i2c_attach(struct i2c_ada
 	int result;
 
 	/* There can be only one */
-	if (unlikely(ams.has_device))
+	if (unlikely(ams_info.has_device))
 		return -ENODEV;
 
 	if (strncmp(adapter->name, "uni-n", 5))
 		return -ENODEV;
 
 	bus = simple_strtoul(adapter->name + 6, NULL, 10);
-	if (bus != ams.i2c_bus)
+	if (bus != ams_info.i2c_bus)
 		return -ENODEV;
 
-	ams.i2c_client.addr = ams.i2c_address;
-	ams.i2c_client.adapter = adapter;
-	ams.i2c_client.driver = &ams_i2c_driver;
-	strcpy(ams.i2c_client.name, "Apple Motion Sensor");
+	ams_info.i2c_client.addr = ams_info.i2c_address;
+	ams_info.i2c_client.adapter = adapter;
+	ams_info.i2c_client.driver = &ams_i2c_driver;
+	strcpy(ams_info.i2c_client.name, "Apple Motion Sensor");
 
 	if (ams_i2c_cmd(AMS_CMD_RESET)) {
 		printk(KERN_INFO "ams: Failed to reset the device\n");
@@ -217,7 +227,7 @@ static int ams_i2c_attach(struct i2c_ada
 	/* Clear interrupts */
 	ams_i2c_clear_irq(AMS_IRQ_ALL);
 
-	ams.has_device = 1;
+	ams_info.has_device = 1;
 
 	/* Enable interrupts */
 	ams_i2c_set_irq(AMS_IRQ_ALL, 1);
@@ -229,7 +239,7 @@ static int ams_i2c_attach(struct i2c_ada
 
 static int ams_i2c_detach(struct i2c_adapter *adapter)
 {
-	if (ams.has_device) {
+	if (ams_info.has_device) {
 		/* Disable interrupts */
 		ams_i2c_set_irq(AMS_IRQ_ALL, 0);
 
@@ -238,7 +248,7 @@ static int ams_i2c_detach(struct i2c_ada
 
 		printk(KERN_INFO "ams: Unloading\n");
 
-		ams.has_device = 0;
+		ams_info.has_device = 0;
 	}
 
 	return 0;
@@ -255,35 +265,35 @@ int __init ams_i2c_init(struct device_no
 	int result;
 	u32 *prop;
 
-	mutex_lock(&ams.lock);
+	mutex_lock(&ams_info.lock);
 
 	/* Set implementation stuff */
-	ams.of_node = np;
-	ams.exit = ams_i2c_exit;
-	ams.get_vendor = ams_i2c_get_vendor;
-	ams.get_xyz = ams_i2c_get_xyz;
-	ams.clear_irq = ams_i2c_clear_irq;
-	ams.bustype = BUS_I2C;
+	ams_info.of_node = np;
+	ams_info.exit = ams_i2c_exit;
+	ams_info.get_vendor = ams_i2c_get_vendor;
+	ams_info.get_xyz = ams_i2c_get_xyz;
+	ams_info.clear_irq = ams_i2c_clear_irq;
+	ams_info.bustype = BUS_I2C;
 
 	/* look for bus either using "reg" or by path */
-	prop = (u32*)get_property(ams.of_node, "reg", NULL);
+	prop = (u32*)get_property(ams_info.of_node, "reg", NULL);
 	if (!prop) {
 		result = -ENODEV;
 
 		goto exit;
 	}
 
-	tmp_bus = strstr(ams.of_node->full_name, "/i2c-bus@");
+	tmp_bus = strstr(ams_info.of_node->full_name, "/i2c-bus@");
 	if (tmp_bus)
-		ams.i2c_bus = *(tmp_bus + 9) - '0';
+		ams_info.i2c_bus = *(tmp_bus + 9) - '0';
 	else
-		ams.i2c_bus = ((*prop) >> 8) & 0x0f;
-	ams.i2c_address = ((*prop) & 0xff) >> 1;
+		ams_info.i2c_bus = ((*prop) >> 8) & 0x0f;
+	ams_info.i2c_address = ((*prop) & 0xff) >> 1;
 
 	result = i2c_add_driver(&ams_i2c_driver);
 
 exit:
-	mutex_unlock(&ams.lock);
+	mutex_unlock(&ams_info.lock);
 
 	return result;
 }
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-mouse.c linux-2.6.18-rc3/drivers/hwmon/ams/ams-mouse.c
--- linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-mouse.c	2006-08-05 00:47:46.000000000 +0200
+++ linux-2.6.18-rc3/drivers/hwmon/ams/ams-mouse.c	2006-08-05 00:49:56.000000000 +0200
@@ -28,17 +28,17 @@ static int ams_mouse_kthread(void *data)
 	s8 x, y, z;
 
 	while (!kthread_should_stop()) {
-		mutex_lock(&ams.lock);
+		mutex_lock(&ams_info.lock);
 
 		ams_sensors(&x, &y, &z);
 
-		input_report_abs(ams.idev, ABS_X, x - ams.xcalib);
-		input_report_abs(ams.idev, ABS_Y, y - ams.ycalib);
-		input_report_abs(ams.idev, ABS_Z, z - ams.zcalib);
+		input_report_abs(ams_info.idev, ABS_X, x - ams_info.xcalib);
+		input_report_abs(ams_info.idev, ABS_Y, y - ams_info.ycalib);
+		input_report_abs(ams_info.idev, ABS_Z, z - ams_info.zcalib);
 
-		input_sync(ams.idev);
+		input_sync(ams_info.idev);
 
-		mutex_unlock(&ams.lock);
+		mutex_unlock(&ams_info.lock);
 
 		msleep(25);
 	}
@@ -46,56 +46,57 @@ static int ams_mouse_kthread(void *data)
 	return 0;
 }
 
-/* Call with lock held! */
+/* Call with ams_info.lock held! */
 static void ams_mouse_enable(void)
 {
 	s8 x, y, z;
 
-	if (ams.idev)
+	if (ams_info.idev)
 		return;
 
 	ams_sensors(&x, &y, &z);
-	ams.xcalib = x;
-	ams.ycalib = y;
-	ams.zcalib = z;
+	ams_info.xcalib = x;
+	ams_info.ycalib = y;
+	ams_info.zcalib = z;
 
-	ams.idev = input_allocate_device();
-	if (!ams.idev)
+	ams_info.idev = input_allocate_device();
+	if (!ams_info.idev)
 		return;
 
-	ams.idev->name = "Apple Motion Sensor";
-	ams.idev->id.bustype = ams.bustype;
-	ams.idev->id.vendor = 0;
-	ams.idev->cdev.dev = &ams.of_dev->dev;
-
-	input_set_abs_params(ams.idev, ABS_X, -50, 50, 3, 0);
-	input_set_abs_params(ams.idev, ABS_Y, -50, 50, 3, 0);
-	input_set_abs_params(ams.idev, ABS_Z, -50, 50, 3, 0);
-
-	set_bit(EV_ABS, ams.idev->evbit);
-	set_bit(EV_KEY, ams.idev->evbit);
-
-	if (input_register_device(ams.idev)) {
-		input_free_device(ams.idev);
-		ams.idev = NULL;
+	ams_info.idev->name = "Apple Motion Sensor";
+	ams_info.idev->id.bustype = ams_info.bustype;
+	ams_info.idev->id.vendor = 0;
+	ams_info.idev->cdev.dev = &ams_info.of_dev->dev;
+
+	input_set_abs_params(ams_info.idev, ABS_X, -50, 50, 3, 0);
+	input_set_abs_params(ams_info.idev, ABS_Y, -50, 50, 3, 0);
+	input_set_abs_params(ams_info.idev, ABS_Z, -50, 50, 3, 0);
+
+	set_bit(EV_ABS, ams_info.idev->evbit);
+	set_bit(EV_KEY, ams_info.idev->evbit);
+
+	if (input_register_device(ams_info.idev)) {
+		input_free_device(ams_info.idev);
+		ams_info.idev = NULL;
 		return;
 	}
 
-	ams.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
-	if (IS_ERR(ams.kthread)) {
-		input_unregister_device(ams.idev);
-		ams.idev = NULL;
+	ams_info.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
+	if (IS_ERR(ams_info.kthread)) {
+		input_unregister_device(ams_info.idev);
+		input_free_device(ams_info.idev);
+		ams_info.idev = NULL;
 		return;
 	}
 }
 
-/* Call with lock held! */
+/* Call with ams_info.lock held! */
 static void ams_mouse_disable(void)
 {
-	if (ams.idev) {
-		kthread_stop(ams.kthread);
-		input_unregister_device(ams.idev);
-		ams.idev = NULL;
+	if (ams_info.idev) {
+		kthread_stop(ams_info.kthread);
+		input_unregister_device(ams_info.idev);
+		ams_info.idev = NULL;
 	}
 }
 
@@ -111,16 +112,14 @@ static ssize_t ams_mouse_store_mouse(str
 	if (sscanf(buf, "%d\n", &mouse) != 1)
 		return -EINVAL;
 
-	mouse = !!mouse;
-
-	mutex_lock(&ams.lock);
+	mutex_lock(&ams_info.lock);
 
 	if (mouse)
 		ams_mouse_enable();
 	else
 		ams_mouse_disable();
 
-	mutex_unlock(&ams.lock);
+	mutex_unlock(&ams_info.lock);
 
 	return count;
 }
@@ -128,18 +127,18 @@ static ssize_t ams_mouse_store_mouse(str
 static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
 	ams_mouse_show_mouse, ams_mouse_store_mouse);
 
-/* Call with lock held! */
+/* Call with ams_info.lock held! */
 void ams_mouse_init()
 {
-	device_create_file(&ams.of_dev->dev, &dev_attr_mouse);
+	device_create_file(&ams_info.of_dev->dev, &dev_attr_mouse);
 
 	if (mouse)
 		ams_mouse_enable();
 }
 
-/* Call with lock held! */
+/* Call with ams_info.lock held! */
 void ams_mouse_exit()
 {
 	ams_mouse_disable();
-	device_remove_file(&ams.of_dev->dev, &dev_attr_mouse);
+	device_remove_file(&ams_info.of_dev->dev, &dev_attr_mouse);
 }
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-pmu.c linux-2.6.18-rc3/drivers/hwmon/ams/ams-pmu.c
--- linux-2.6.18-rc3.orig/drivers/hwmon/ams/ams-pmu.c	2006-08-05 00:47:46.000000000 +0200
+++ linux-2.6.18-rc3/drivers/hwmon/ams/ams-pmu.c	2006-08-05 00:49:56.000000000 +0200
@@ -84,22 +84,28 @@ static void ams_pmu_set_irq(enum ams_irq
 {
 	if (reg & AMS_IRQ_FREEFALL) {
 		u8 val = ams_pmu_get_register(AMS_FF_ENABLE);
-		if (enable)	val |= 0x80;
-		else		val &= ~0x80;
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
 		ams_pmu_set_register(AMS_FF_ENABLE, val);
 	}
 
 	if (reg & AMS_IRQ_SHOCK) {
 		u8 val = ams_pmu_get_register(AMS_SHOCK_ENABLE);
-		if (enable)	val |= 0x80;
-		else		val &= ~0x80;
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
 		ams_pmu_set_register(AMS_SHOCK_ENABLE, val);
 	}
 
 	if (reg & AMS_IRQ_GLOBAL) {
 		u8 val = ams_pmu_get_register(AMS_CONTROL);
-		if (enable)	val |= 0x80;
-		else		val &= ~0x80;
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
 		ams_pmu_set_register(AMS_CONTROL, val);
 	}
 }
@@ -133,29 +139,28 @@ static void ams_pmu_exit(void)
 	/* Clear interrupts */
 	ams_pmu_clear_irq(AMS_IRQ_ALL);
 
-	ams.has_device = 0;
+	ams_info.has_device = 0;
 
 	printk(KERN_INFO "ams: Unloading\n");
 }
 
-/* Call with lock held! */
 int __init ams_pmu_init(struct device_node *np)
 {
 	u32 *prop;
 	int result;
 
-	mutex_lock(&ams.lock);
+	mutex_lock(&ams_info.lock);
 
 	/* Set implementation stuff */
-	ams.of_node = np;
-	ams.exit = ams_pmu_exit;
-	ams.get_vendor = ams_pmu_get_vendor;
-	ams.get_xyz = ams_pmu_get_xyz;
-	ams.clear_irq = ams_pmu_clear_irq;
-	ams.bustype = BUS_HOST;
+	ams_info.of_node = np;
+	ams_info.exit = ams_pmu_exit;
+	ams_info.get_vendor = ams_pmu_get_vendor;
+	ams_info.get_xyz = ams_pmu_get_xyz;
+	ams_info.clear_irq = ams_pmu_clear_irq;
+	ams_info.bustype = BUS_HOST;
 
 	/* Get PMU command, should be 0x4e, but we can never know */
-	prop = (u32*)get_property(ams.of_node, "reg", NULL);
+	prop = (u32*)get_property(ams_info.of_node, "reg", NULL);
 	if (!prop) {
 		result = -ENODEV;
 		goto exit;
@@ -186,7 +191,7 @@ int __init ams_pmu_init(struct device_no
 	/* Clear interrupts */
 	ams_pmu_clear_irq(AMS_IRQ_ALL);
 
-	ams.has_device = 1;
+	ams_info.has_device = 1;
 
 	/* Enable interrupts */
 	ams_pmu_set_irq(AMS_IRQ_ALL, 1);
@@ -196,7 +201,7 @@ int __init ams_pmu_init(struct device_no
 	result = 0;
 
 exit:
-	mutex_unlock(&ams.lock);
+	mutex_unlock(&ams_info.lock);
 
 	return result;
 }

