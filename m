From: David Brownell <david-b@pacbell.net>
Date: Tue, 18 Nov 2008 22:01:34 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <200811181401.34809.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com> <200809231532.40083.david-b@pacbell.net> <20081118091546.421d6b78@hyperion.delvare>
In-Reply-To: <20081118091546.421d6b78-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Tuesday 18 November 2008, Jean Delvare wrote:
> I guess it's about time that I review this patch and merge it. Is this
> still the latest version of your code, or do you have anything more
> recent?

I don't recall changing any functionality in a long time.
But I've appended the current patch version, just in case.

But I did looking at Intel's adapter hardware (i2c-i801)
and noticing that at least ICH8 -- and probably many older
versions -- can support SMBus alert IRQs in a way that's
very compatible with the approach I took.

- Dave


==== SNIP SNIP SNIP!
From: David Brownell <dbrownell@users.sourceforge.net>

Infrastructure supporting SMBALERT# interrupts and the related SMBus
protocols.  These are defined as "optional" by the SMBus spec.

 - The i2c_adapter now includes a work_struct doing the work of talking
   to the Alert Response Address until nobody responds any more (and
   hence the IRQ is no longer asserted).  Follows SMBus 2.0 not 1.1;
   there seems to be no point in trying to handle ten-bit addresses.

 - Some of the ways that work_struct could be driven:

     * Adapter driver provides an IRQ, which is bound to a handler
       which schedules that work_struct (using keventd for now).
       NOTE:  it's nicest if this is edge triggered, but the code
       should handle level triggered IRQs too.

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
 drivers/i2c/busses/i2c-gpio.c |   10 ++
 drivers/i2c/i2c-core.c        |  155 ++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h           |   14 +++
 3 files changed, 179 insertions(+)

--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -82,6 +82,7 @@ static int __devinit i2c_gpio_probe(stru
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
+	struct resource *smbalert;
 	int ret;
 
 	pdata = pdev->dev.platform_data;
@@ -143,6 +144,15 @@ static int __devinit i2c_gpio_probe(stru
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->dev.parent = &pdev->dev;
 
+	smbalert = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+			"smbalert#");
+	if (smbalert) {
+		adap->irq = smbalert->start;
+		if ((IORESOURCE_IRQ_LOWEDGE | IORESOURCE_IRQ_HIGHEDGE)
+				& smbalert->flags)
+			adap->alert_edge_triggered = 1;
+	}
+
 	/*
 	 * If "dev->id" is negative we consider it as zero.
 	 * The reason to do so is to avoid sysfs names that only make
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -32,6 +32,8 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
+#include <linux/interrupt.h>
+
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
 #include <asm/uaccess.h>
@@ -404,6 +406,117 @@ static struct class i2c_adapter_class = 
 	.dev_attrs		= i2c_adapter_attrs,
 };
 
+struct alert_data {
+	unsigned short	addr;
+	bool		flag;
+};
+
+/* If this is the alerting device, notify its driver. */
+static int i2c_do_alert(struct device *dev, void *addrp)
+{
+	struct i2c_client	*client = i2c_verify_client(dev);
+	struct alert_data	*data = addrp;
+
+	if (!client || client->addr != data->addr)
+		return 0;
+	if (client->flags & I2C_CLIENT_TEN)
+		return 0;
+
+	/* Drivers should either disable alerts, or provide at least
+	 * a minimal handler.  Lock so client->driver won't change.
+	 */
+	down(&dev->sem);
+	if (client->driver) {
+		if (client->driver->alert)
+			client->driver->alert(client, data->flag);
+		else
+			dev_warn(&client->dev, "no driver alert()!\n");
+	} else
+		dev_dbg(&client->dev, "alert with no driver\n");
+	up(&dev->sem);
+
+	/* Stop iterating after we find the device. */
+	return -EBUSY;
+}
+
+/*
+ * The alert IRQ handler needs to hand work off to a task which can issue
+ * SMBus calls, because those sleeping calls can't be made in IRQ context.
+ */
+static void smbus_alert(struct work_struct *work)
+{
+	struct i2c_adapter	*bus;
+
+	bus = container_of(work, struct i2c_adapter, alert);
+	for (;;) {
+		s32			status;
+		struct alert_data	data;
+
+		/* Devices with pending alerts reply in address order, low
+		 * to high, because of slave transmit arbitration.  After
+		 * responding, an SMBus device stops asserting SMBALERT#.
+		 *
+		 * NOTE that SMBus 2.0 reserves 10-bit addresess for future
+		 * use.  We neither handle them, nor try to use PEC here.
+		 */
+		status = i2c_smbus_read_byte(bus->ara);
+		if (status < 0)
+			break;
+
+		data.flag = (status & 1) != 0;
+		data.addr = status >> 1;
+		dev_dbg(&bus->dev, "SMBALERT# %s from dev 0x%02x\n",
+				data.flag ? "true" : "false", data.addr);
+
+		/* Notify driver for the device which issued the alert. */
+		device_for_each_child(&bus->dev, &data, i2c_do_alert);
+	}
+
+	/* We handled all alerts; reenable level-triggered IRQs. */
+	if (!bus->alert_edge_triggered)
+		enable_irq(bus->irq);
+}
+
+static irqreturn_t smbus_irq(int irq, void *adap)
+{
+	struct i2c_adapter	*bus = adap;
+
+	/* Disable level-triggered IRQs until we handle them. */
+	if (!bus->alert_edge_triggered)
+		disable_irq_nosync(irq);
+
+	schedule_work(&bus->alert);
+	return IRQ_HANDLED;
+}
+
+static int smbalert_probe(struct i2c_client *c, const struct i2c_device_id *id)
+{
+	return 0;
+}
+
+static int smbalert_remove(struct i2c_client *c)
+{
+	return 0;
+}
+
+static const struct i2c_device_id smbalert_ids[] = {
+	{ "smbus_alert", 0, },
+	{ /* LIST END */ }
+};
+
+static struct i2c_driver smbalert_driver = {
+	.driver = {
+		.name	= "smbus_alert",
+	},
+	.probe		= smbalert_probe,
+	.remove		= smbalert_remove,
+	.id_table	= smbalert_ids,
+};
+
+static const struct i2c_board_info ara_board_info = {
+	I2C_BOARD_INFO("smbus_alert", 0x0c),
+};
+
 static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 {
 	struct i2c_devinfo	*devinfo;
@@ -448,6 +561,9 @@ static int i2c_register_adapter(struct i
 	mutex_init(&adap->clist_lock);
 	INIT_LIST_HEAD(&adap->clients);
 
+	/* Setup SMBALERT# infrastructure. */
+	INIT_WORK(&adap->alert, smbus_alert);
+
 	mutex_lock(&core_lock);
 
 	/* Add the adapter to the driver core.
@@ -466,6 +582,33 @@ static int i2c_register_adapter(struct i
 	if (res)
 		goto out_list;
 
+	/* If we'll be handling SMBus alerts, register the alert responder
+	 * address so that nobody else can accidentally claim it.
+	 * Handling can be done either through our IRQ handler, or by the
+	 * adapter (from its handler, periodic polling, or whatever).
+	 *
+	 * NOTE that if we manage the IRQ, we *MUST* know if it's level or
+	 * edge triggered in order to hand it to the workqueue correctly.
+	 * If triggering the alert seems to wedge the system, you probably
+	 * should have said it's level triggered.
+	 */
+	if (adap->irq > 0 || adap->do_setup_alert)
+		adap->ara = i2c_new_device(adap, &ara_board_info);
+
+	if (adap->irq > 0 && adap->ara) {
+		res = devm_request_irq(&adap->dev, adap->irq, smbus_irq,
+				0, "smbus_alert", adap);
+		if (res = 0) {
+			dev_info(&adap->dev,
+				"supports SMBALERT#, %s trigger\n",
+				adap->alert_edge_triggered
+					? "edge" : "level");
+			adap->has_alert_irq = 1;
+		} else
+			res = 0;
+
+	}
+
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes for new-style drivers */
@@ -651,6 +794,12 @@ int i2c_del_adapter(struct i2c_adapter *
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
@@ -970,12 +1119,17 @@ static int __init i2c_init(void)
 	retval = class_register(&i2c_adapter_class);
 	if (retval)
 		goto bus_err;
+	retval = i2c_add_driver(&smbalert_driver);
+	if (retval)
+		goto alert_err;
 	retval = i2c_add_driver(&dummy_driver);
 	if (retval)
 		goto class_err;
 	return 0;
 
 class_err:
+	i2c_del_driver(&smbalert_driver);
+alert_err:
 	class_unregister(&i2c_adapter_class);
 bus_err:
 	bus_unregister(&i2c_bus_type);
@@ -986,6 +1140,7 @@ static void __exit i2c_exit(void)
 {
 	i2c_del_driver(&dummy_driver);
 	class_unregister(&i2c_adapter_class);
+	i2c_del_driver(&smbalert_driver);
 	bus_unregister(&i2c_bus_type);
 }
 
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -34,6 +34,7 @@
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 extern struct bus_type i2c_bus_type;
 
@@ -165,6 +166,11 @@ struct i2c_driver {
 	int (*suspend)(struct i2c_client *, pm_message_t mesg);
 	int (*resume)(struct i2c_client *);
 
+	/* SMBus alert protocol support.  The alert response's low bit
+	 * is the event flag (e.g. exceeding upper vs lower limit).
+	 */
+	void (*alert)(struct i2c_client *, bool flag);
+
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
 	 */
@@ -369,6 +375,14 @@ struct i2c_adapter {
 	struct list_head clients;	/* DEPRECATED */
 	char name[48];
 	struct completion dev_released;
+
+	/* SMBALERT# support */
+	unsigned		do_setup_alert:1;
+	unsigned		has_alert_irq:1;
+	unsigned		alert_edge_triggered:1;
+	int			irq;
+	struct i2c_client	*ara;
+	struct work_struct	alert;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
