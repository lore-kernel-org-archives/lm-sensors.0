From: David Brownell <david-b@pacbell.net>
Date: Wed, 16 Apr 2008 17:33:47 +0000
Subject: [lm-sensors] [patch 2.6.25-rc9 4/5] i2c: smbusalert# support
Message-Id: <200804161033.47264.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Infrastructure supporting SMBALERT# interrupts and the related SMBus
protocols.  These are defined as "optional" by the spec.

 - The i2c_adapter now includes a work_struct doing the work of talking
   to the Alert Response Address until nobody responds any more (and
   hence the IRQ is no longer asserted).  Follows SMBus 2.0 not 1.1;
   there seems to be no point in trying to handle ten-bit addresses.

 - Some of the ways that work_struct could be driven:

     * Adapter driver provides an IRQ, which is bound to a handler
       which schedules that work_struct (using keventd for now).

     * Adapter driver schedules that work struct itself, maybe even
       on a workqueue of its own.  It asks the core to set it up by
       setting i2c_adapter.do_setup_alert ... SMBALERT# could be a
       subcase of the adapter's normal interrupt handler.  (Or, some
       boards may want to use polling.)

 - The "i2c-gpio" driver now handles an optional named resource for
   that SMBus alert signal.  Named since, when this is substituted
   for a misbehaving "native" driver, positional ids should be left
   alone.  (It might be better to put this logic into i2c core, to
   apply whenever the i2c_adapter.dev.parent is a platform device.)

 - There's a new driver method used to report that a given device has
   issued an alert. Its parameter includes the one bit of information
   provided by the device in its alert response message.

The IRQ driven code path is always enabled, if it's available.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
NOTE:  the i2c list archives hold a previous SMBALERT# patch from
Hendrik Sattler <post@hendrik-sattler.de> on Sept 7 2006.  This
patch improves on that one one in several respects.

NOTE:  The SMBus "Host Notify" protocol is sometimes used for similar
purposes.  Although host support for it is "mandatory", there seems to
be no Linux support for it.  The minimal support would seem to involve
a callback accepting the 17 bits of data provided by the slave device,
plus I2C adapter updates needed to receive those unsolicited messages.

 drivers/i2c/busses/i2c-gpio.c |    6 +
 drivers/i2c/i2c-core.c        |  127 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h           |   13 ++++
 3 files changed, 146 insertions(+)

--- ngw.orig/drivers/i2c/busses/i2c-gpio.c	2008-03-26 10:13:08.000000000 -0700
+++ ngw/drivers/i2c/busses/i2c-gpio.c	2008-03-26 10:29:07.000000000 -0700
@@ -82,6 +82,7 @@ static int __init i2c_gpio_probe(struct 
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
+	struct resource *smbalert;
 	int ret;
 
 	pdata = pdev->dev.platform_data;
@@ -143,6 +144,11 @@ static int __init i2c_gpio_probe(struct 
 	adap->class = I2C_CLASS_HWMON;
 	adap->dev.parent = &pdev->dev;
 
+	smbalert = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+			"smbalert#");
+	if (smbalert)
+		adap->irq = smbalert->start;
+
 	/*
 	 * If "dev->id" is negative we consider it as zero.
 	 * The reason to do so is to avoid sysfs names that only make
--- ngw.orig/drivers/i2c/i2c-core.c	2008-03-26 10:20:11.000000000 -0700
+++ ngw/drivers/i2c/i2c-core.c	2008-03-26 21:30:52.000000000 -0700
@@ -33,6 +33,8 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
+#include <linux/interrupt.h>
+
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
 #include <asm/uaccess.h>
@@ -400,6 +402,96 @@ static int i2c_do_add_adapter(struct dev
 	return 0;
 }
 
+/*
+ * The IRQ handler needs to hand work off to a task which can issue SMBus
+ * calls, because those sleeping calls can't be made in IRQ context.
+ */
+static void smbus_alert(struct work_struct *work)
+{
+	struct i2c_adapter	*bus;
+
+	bus = container_of(work, struct i2c_adapter, alert);
+	for (;;) {
+		s32			status;
+		unsigned short		addr;
+		struct i2c_client	*client;
+		bool			flag;
+
+		/* Devices with pending alerts reply in address order, low
+		 * to high, because of arbitration.  After responding, an
+		 * SMBus device stops asserting SMBALERT# ... so we can
+		 * re-enable the IRQ as soon as read_byte() gets no reply.
+		 *
+		 * NOTE that SMBus 2.0 reserves 10-bit addresess for future
+		 * use.  We neither handle them, nor try to use PEC here.
+		 */
+		status = i2c_smbus_read_byte(bus->ara);
+		if (status < 0)
+			break;
+		flag = status & 1;
+		addr = status >> 1;
+
+		dev_info(&bus->dev, "SMBALERT# %d addr 0x%02x\n", flag, addr);
+//		dev_dbg(&bus->dev, "SMBALERT# %d addr 0x%02x\n", flag, addr);
+
+		/* Notify any driver for the device which issued the alert.
+		 * The locking ensures it won't disappear while we do that.
+		 */
+		mutex_lock(&core_lock);
+		list_for_each_entry(client, &bus->clients, list) {
+			if (client->addr != addr)
+				continue;
+			if (client->flags & I2C_CLIENT_TEN)
+				continue;
+			if (!client->driver)
+				break;
+
+			/* Drivers should either disable alerts or provide
+			 * at least a minimal handler.
+			 *
+			 * REVISIT:  drop lock while we call alert().
+			 *
+			 * FIXME i2cdev should have an alert path ...
+			 */
+			if (client->driver->alert)
+				client->driver->alert(client, flag);
+			else
+				dev_warn(&client->dev, "no driver alert()!\n");
+			break;
+		}
+		mutex_unlock(&core_lock);
+	}
+
+	enable_irq(bus->irq);
+}
+
+static irqreturn_t smbus_irq(int irq, void *adap)
+{
+	struct i2c_adapter	*bus = adap;
+
+	disable_irq_nosync(irq);
+	schedule_work(&bus->alert);
+	return IRQ_HANDLED;
+}
+
+static int smbalert_nop(struct i2c_client *c)
+{
+	return 0;
+}
+
+static struct i2c_driver smbalert_driver = {
+	.driver = {
+		.name	= "smbus_alert",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= smbalert_nop,
+	.remove		= smbalert_nop,
+};
+
+static const struct i2c_board_info ara_board_info = {
+	I2C_BOARD_INFO("smbus_alert", 0x0c),
+};
+
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = 0, dummy;
@@ -408,6 +500,9 @@ static int i2c_register_adapter(struct i
 	mutex_init(&adap->clist_lock);
 	INIT_LIST_HEAD(&adap->clients);
 
+	/* Setup SMBALERT# infrastructure. */
+	INIT_WORK(&adap->alert, smbus_alert);
+
 	mutex_lock(&core_lock);
 
 	/* Add the adapter to the driver core.
@@ -426,6 +521,26 @@ static int i2c_register_adapter(struct i
 	if (res)
 		goto out_list;
 
+	/* If we'll be handling SMBus alerts, register the alert responder
+	 * address so that nobody else can accidentally claim it.
+	 * Handling can be done either through our IRQ handler, or by the
+	 * adapter (from its handler, periodic polling, or whatever).
+	 */
+	if (adap->irq > 0 || adap->do_setup_alert)
+		adap->ara = i2c_new_device(adap, &ara_board_info);
+
+	if (adap->irq > 0 && adap->ara) {
+		/* Platform setup probably made this IRQF_TRIGGER_LOW */
+		res = devm_request_irq(&adap->dev, adap->irq, smbus_irq,
+				0, "smbus_alert", adap);
+		if (res = 0) {
+			dev_dbg(&adap->dev, "supports SMBALERT#\n");
+			adap->has_alert_irq = 1;
+		} else
+			res = 0;
+
+	}
+
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes for new-style drivers */
@@ -602,6 +717,12 @@ int i2c_del_adapter(struct i2c_adapter *
 		}
 	}
 
+	if (adap->has_alert_irq) {
+		devm_free_irq(&adap->dev, adap->irq, adap);
+		adap->has_alert_irq = 0;
+	}
+	cancel_work_sync(&adap->alert);
+
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
@@ -889,6 +1010,9 @@ static int __init i2c_init(void)
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
+	retval = i2c_add_driver(&smbalert_driver);
+	if (retval)
+		goto alert_err;
 	retval = class_register(&i2c_adapter_class);
 	if (retval)
 		goto bus_err;
@@ -900,6 +1024,8 @@ static int __init i2c_init(void)
 class_err:
 	class_unregister(&i2c_adapter_class);
 bus_err:
+	i2c_del_driver(&smbalert_driver);
+alert_err:
 	bus_unregister(&i2c_bus_type);
 	return retval;
 }
@@ -908,6 +1034,7 @@ static void __exit i2c_exit(void)
 {
 	i2c_del_driver(&dummy_driver);
 	class_unregister(&i2c_adapter_class);
+	i2c_del_driver(&smbalert_driver);
 	bus_unregister(&i2c_bus_type);
 }
 
--- ngw.orig/include/linux/i2c.h	2008-03-26 10:13:08.000000000 -0700
+++ ngw/include/linux/i2c.h	2008-03-26 10:29:07.000000000 -0700
@@ -34,6 +34,7 @@
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 /* --- General options ------------------------------------------------	*/
 
@@ -134,6 +135,11 @@ struct i2c_driver {
 	int (*suspend)(struct i2c_client *, pm_message_t mesg);
 	int (*resume)(struct i2c_client *);
 
+	/* SMBus alert protocol support; the low bit of the code sometimes
+	 * passes event data (e.g. exceeding upper vs lower limit).
+	 */
+	void (*alert)(struct i2c_client *, bool flag);
+
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
 	 */
@@ -333,6 +339,13 @@ struct i2c_adapter {
 	struct list_head clients;	/* DEPRECATED */
 	char name[48];
 	struct completion dev_released;
+
+	/* SMBALERT# support */
+	unsigned		do_setup_alert:1;
+	unsigned		has_alert_irq:1;
+	int			irq;
+	struct i2c_client	*ara;
+	struct work_struct	alert;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
