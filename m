From: david-b@pacbell.net (david-b@pacbell.net)
Date: Sat, 16 Jul 2005 03:22:52 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <20050716012130.60D1685F45@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Date: Wed, 13 Jul 2005 16:06:48 -0700
> From: david-b@pacbell.net
>
> > > However, the REALLY nice way to do this would be if the I2C bus
> > > framework had a clean way to handle static device configuration
> > > (like "platform_bus" does).  Then such a flag could be just one
> > > of several bits of information provided to driver using driver
> > > model infrastructure like platform_data.
> >
> > Where are the patches? ;)
>
> The only bright idea I've had so far involves board-specific code
> providing a platform pseudo-device whose platform_data would be
> morphed (by a "pseudo-driver", registered and deregistered before
> the "at24c" i2c driver) into the addr_data (and coupled fields) that
> are currently used to init that i2c driver.
>
> That's a bit hacky though.  Better if there were some real device
> node that the at24c driver would bind to ... which would sort of
> turn the current I2C model on its head.  
>
> Or maybe not ... maybe a static I2C device tree could just be set
> up early by board-specific code, and the I2C infrastructure could
> view it as an alternate way to specify more "probe" or "force"
> entries, without using module params.

Yeah, the best way to do that is really going to involve turning
the I2C stack a bit on its head ... making it work more like most
other Linux driver stacks.

That is, significant API surgery ... stuff I suspect folk believe
is needed in any case, but still it's a lot of change.

One way to start thinking about that is to look at the attached
patch (NOT suitable for merging!  Though it does solve the problem)
and see how the new probe() gets used.  And then observe, "hey, if
i2c core creates and registers the i2c client, like it would in
other Linux bus frameworks, and then passed it into this routine...
then the second two parameters would be implicit."   A significant
change to the driver's role.

- Dave


This is an experimental patch for system-specific static config
support in the I2C framework.

    - New i2c core interfaces:
	* New driver probe() method, with platform string data
	* Board-specific data storage for i2c
    - OSK board init provides static i2c config data
    - at24c implements the new probe()
    - i2c-core uses it
	* retrieves the new device descriptions
	* new probe only after attach() gets a first whack
    - new static i2c code implements it
	* optional, CONFIG_I2C_BOOTDATA
	* get/set device record array

It might be better push the driver model deeper into this patch, but
that would involve formally adding a lifecycle where the device
drivers are no longer responsible for creating device nodes (which
are embedded in a "struct i2c_client").

--- h2.orig/include/linux/i2c.h	2005-07-15 17:50:08.000000000 -0700
+++ h2/include/linux/i2c.h	2005-07-15 17:50:14.000000000 -0700
@@ -129,6 +129,11 @@
 	 */
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
 
+	/* set up devices and drivers according to system description
+	 * tables; see <linux/i2c-config.h>
+	 */
+	void (*probe)(struct i2c_adapter *adapter, int address, char *data);
+
 	struct device_driver driver;
 	struct list_head list;
 };
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ h2/include/linux/i2c-config.h	2005-07-15 17:50:14.000000000 -0700
@@ -0,0 +1,56 @@
+#ifndef	__I2C_CONFIG_H
+#define	__I2C_CONFIG_H
+
+
+	/* DRAFT/RFC for some static config support for I2C
+	 *
+	 * This preserves current I2C probe model characteristic that
+	 * i2c device drivers are responsible for creating devices.
+	 *
+	 * Otherwise, platform_device.dev.platform_data is the usage
+	 * model for the new data being provided to drivers from
+	 * board-specific initialization.
+	 */
+
+/* Board init code can supply i2c core a table describing devices,
+ * and providing driver-specific setup data for a given device.
+ *
+ * These act like "probe" entries in addr_data, except that they
+ * include device-specific configuration data.
+ */
+struct i2c_device_record {
+	char		driver_name[32];
+	int		adapter_id;
+	u16		dev_num;
+
+	/* data[] will be passed to a new probe() driver entrypoint.
+	 *  - if probe of address dev_num@adapter_id succeeds
+	 *  - and the driver named "driver_name" is registered
+	 */
+	char		data[26];
+
+	/* REVISIT:  for passing a string, this is probably enough.
+	 * But functions and binary data will be needed too...
+	 */
+};
+
+#ifdef	CONFIG_I2C_BOOTDATA
+extern int i2c_set_boot_data(const struct i2c_device_record *, unsigned);
+extern unsigned i2c_get_boot_data(struct i2c_device_record **);
+
+#else
+static inline int
+i2c_set_boot_data(const struct i2c_device_record *data, unsigned n)
+{
+	return -ENOSYS;
+}
+
+static inline unsigned i2c_get_boot_data(struct i2c_device_record **pp)
+{
+	*pp = NULL;
+	return 0;
+}
+
+#endif	/* I2C_BOOTDATA */
+
+#endif	/* __I2C_CONFIG_H */
--- h2.orig/drivers/i2c/chips/at24c.c	2005-07-15 17:50:08.000000000 -0700
+++ h2/drivers/i2c/chips/at24c.c	2005-07-15 17:50:14.000000000 -0700
@@ -639,6 +639,7 @@
 }
 
 
+/* "legacy" i2c driver api entry:  bind to bus, not device */
 static int __devinit at24c_attach_adapter(struct i2c_adapter *adapter)
 {
 	/* REVISIT: using SMBUS calls would improve portability, though
@@ -652,6 +653,20 @@
 	return i2c_probe(adapter, &addr_data, at24c_old_probe);
 }
 
+/* experimental static config support: bind to device */
+static void __devinit
+at24c_probe(struct i2c_adapter *adapter, int address, char *data)
+{
+	const struct chip_desc		*chip;
+
+	chip = find_chip(data);
+	if (!chip)
+		dev_err(&adapter->dev, "unknown chipname %s\n", data);
+	else
+		at24c_activate(adapter, address, chip,
+				!(chip->flags & EE_READONLY));
+}
+
 static int __devexit at24c_detach_client(struct i2c_client *client)
 {
 	int			err;
@@ -678,11 +693,13 @@
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= at24c_attach_adapter,
 	.detach_client	= __devexit_p(at24c_detach_client),
+	.probe		= at24c_probe,
 };
 
 static int __init at24c_init(void)
 {
-#ifdef CONFIG_OMAP_OSK_MISTRAL
+#if 0
+//#ifdef CONFIG_OMAP_OSK_MISTRAL
 	/* REVISIT ...  */
 	if (machine_is_omap_osk()) {
 		n_chip_names = 1;
--- h2.orig/arch/arm/mach-omap1/board-osk.c	2005-07-15 17:50:08.000000000 -0700
+++ h2/arch/arm/mach-omap1/board-osk.c	2005-07-15 17:50:14.000000000 -0700
@@ -34,6 +34,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
+#include <linux/i2c-config.h>
+
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -191,6 +193,31 @@
 	{ OMAP_TAG_USB,           &osk_usb_config },
 };
 
+
+static struct i2c_device_record i2c_devs[] __initdata = {
+{
+	/* this autprobes OK, but there are several chip variants */
+	.driver_name	= "tps65010",
+	.adapter_id	= 0,
+	.dev_num	= 0x48,
+	.data 		= "tps65010",	/* vs 65013 etc */
+}, {
+	.driver_name	= "tlv320aic23",
+	.adapter_id	= 0,
+	.dev_num	= 0x1b,
+	// clock setup is board-specific ...
+},
+#ifdef	CONFIG_OMAP_OSK_MISTRAL
+{
+	.driver_name	= "at24c",
+	.adapter_id	= 0,
+	.dev_num	= 0x50,
+	.data 		= "24c04",
+},
+	/* the camera connector may also have an ov9640 sensor */
+#endif
+};
+
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 
 #ifdef	CONFIG_PM
@@ -248,6 +275,8 @@
 	omap_board_config_size = ARRAY_SIZE(osk_config);
 	USB_TRANSCEIVER_CTRL_REG |= (3 << 1);
 
+	i2c_set_boot_data(i2c_devs, ARRAY_SIZE(i2c_devs));
+
 	osk_mistral_init();
 }
 
--- h2.orig/drivers/i2c/i2c-core.c	2005-07-15 17:50:08.000000000 -0700
+++ h2/drivers/i2c/i2c-core.c	2005-07-15 17:50:14.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/i2c-config.h>
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/seq_file.h>
@@ -138,6 +139,47 @@
  * --------------------------------------------------- 
  */
 
+#ifdef	CONFIG_I2C_BOOTDATA
+
+/* static board config data -- e.g. what type of eeprom chip, how
+ * the chip's irqs are wired, etc -- can be passed to drivers.
+ */
+static struct i2c_device_record		*records;
+static unsigned				nrecords;
+
+static void maybe_probe(struct i2c_adapter *adap, struct i2c_driver *driver)
+{
+	unsigned	i;
+	u16		addr;
+
+	for (i = 0; i < nrecords; i++) {
+		if (records[i].adapter_id != i2c_adapter_id(adap))
+			continue;
+		if (strncmp(records[i].driver_name, driver->name,
+					sizeof driver->name) != 0)
+			continue;
+
+		/* Skip if already in use */
+		addr = records[i].dev_num;
+		if (i2c_check_addr(adap, addr))
+			continue;
+
+		/* if hardware probe succeeds, then tell the software */
+		if (i2c_smbus_xfer(adap,addr,0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
+			driver->probe(adap, addr, records[i].data);
+	}
+}
+
+#else
+
+static inline void
+maybe_probe(struct i2c_adapter *adap, struct i2c_driver *driver)
+{
+	/* NOP */
+}
+
+#endif
+
 /* -----
  * i2c_add_adapter is called from within the algorithm layer,
  * when a new hw adapter registers. A new device is register to be
@@ -194,6 +236,11 @@
 		if (driver->flags & I2C_DF_NOTIFY)
 			/* We ignore the return code; if it fails, too bad */
 			driver->attach_adapter(adap);
+
+		/* fallback to static config records, where available */
+		if (!driver->probe)
+			continue;
+		maybe_probe(adap, driver);
 	}
 
 	dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr);
@@ -313,6 +360,14 @@
 		}
 	}
 
+	/* fallback to static config records, where relevant */
+	if (driver->probe) {
+		list_for_each(item,&adapters) {
+			adapter = list_entry(item, struct i2c_adapter, list);
+			maybe_probe(adapter, driver);
+		}
+	}
+
  out_unlock:
 	up(&core_lists);
 	return res;
@@ -557,6 +612,10 @@
 {
 	int retval;
 
+#ifdef	CONFIG_I2C_BOOTDATA
+	nrecords = i2c_get_boot_data(&records);
+#endif
+
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
--- h2.orig/drivers/i2c/Kconfig	2005-07-15 17:50:08.000000000 -0700
+++ h2/drivers/i2c/Kconfig	2005-07-15 17:50:14.000000000 -0700
@@ -74,5 +74,13 @@
 	  a problem with I2C support and want to see more of what is going
 	  on.
 
+# for testing, this is always forced on ...  systems that want to
+# pass board data this way should eventually enable it selectively
+
+config I2C_BOOTDATA
+	bool
+	depends on I2C
+	default y
+
 endmenu
 
--- h2.orig/drivers/i2c/Makefile	2005-07-15 17:50:08.000000000 -0700
+++ h2/drivers/i2c/Makefile	2005-07-15 17:50:14.000000000 -0700
@@ -5,6 +5,7 @@
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
+obj-$(CONFIG_I2C_BOOTDATA)	+= i2c-boot.o
 obj-y				+= busses/ chips/ algos/
 
 i2c-sensor-objs := i2c-sensor-detect.o i2c-sensor-vid.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ h2/drivers/i2c/i2c-boot.c	2005-07-15 17:57:23.000000000 -0700
@@ -0,0 +1,45 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/i2c-config.h>
+
+static struct i2c_device_record *records;
+static unsigned nrecords;
+
+int __init i2c_set_boot_data(const struct i2c_device_record *data, unsigned len)
+{
+	if (nrecords)
+		return -EBUSY;
+
+	/* boot code should call this with __initdata; must copy */
+	records = kcalloc(nrecords, sizeof *records, SLAB_KERNEL);
+	if (!records)
+		return -ENOMEM;
+	nrecords = len;
+	memcpy(records, data, nrecords * sizeof (*records));
+	return 0;
+}
+EXPORT_SYMBOL(i2c_set_boot_data);
+
+unsigned i2c_get_boot_data(struct i2c_device_record **datap)
+{
+	*datap = records;
+	return nrecords;
+}
+EXPORT_SYMBOL(i2c_get_boot_data);
+
+/*
+ * That's not much code, but it could be generalized something like
+ *
+ * static inline unsigned i2c_get_boot_data(struct ... **datap)
+ * {
+ *	return bus_get_boot_data("i2c", datap);
+ * }
+ *
+ * and likewise for setting it.  Another approach would use an
+ * add_boot_data() model.  Maybe the best approach would be to
+ * use the driver model in more typical ways, and store this
+ * information in i2c_client.dev.platform_data from the moment
+ * the board-specific code creates that i2c_client node.
+ */
