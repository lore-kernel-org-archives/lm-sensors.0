From: david-b@pacbell.net (david-b@pacbell.net)
Date: Wed, 13 Jul 2005 19:25:31 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <20050713163839.1B5FCBF40A@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here's a refreshed version of the patch ... addressing much of
your feedback and replacing those nasty switch statements with
some more reasonable table driven logic.  It's more generic.

It now has working chip configuration, using probing as you
suggested (simpler etc) including that AT28RF04 workaround.

Modulo the need for more testing, probably the biggest potential
problem with this version is that it still doesn't claim all the
addresses some chips use.  Safe in controlled environments...

This is a better version for anyone else to hack on.  :)

- Dave


Add a simple driver for most I2C EEPROMs, giving sysfs read/write
access to their contents.

Tested only with AT24C04 so far, but support for many others is
coded and ready for you.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- osk.orig/drivers/i2c/chips/Kconfig	2005-07-11 10:37:39.000000000 -0700
+++ osk/drivers/i2c/chips/Kconfig	2005-07-13 09:09:27.000000000 -0700
@@ -406,6 +406,25 @@
 menu "Other I2C Chip support"
 	depends on I2C
 
+config I2C_AT24C
+	tristate "Atmel AT24C series EEPROMs (and compatibles)"
+	depends on I2C && EXPERIMENTAL
+	help
+	  This driver should handle most I2C EEPROMS, including the AT24C
+	  series and compatible ones like those from Microchip and other
+	  vendors.  For example, most memory DIMMS have 24c02 EEPROMs.
+
+	     24c00, 24c01, 24c02, 24c04, 24c08, 24c16,
+	     24c32, 24c64, 24c128, 24c256, 24c512, 24c1024
+
+	  If you say yes here you get support for most Atmel AT24C series
+	  serial EEPROMS.  The driver provides read and write access to the
+	  EEPROM data through sysfs, once you've configured it to know about
+	  the particular chips on your target board.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called at24c.
+
 config SENSORS_DS1337
 	tristate "Dallas Semiconductor DS1337 and DS1339 Real Time Clock"
 	depends on I2C && EXPERIMENTAL
--- osk.orig/drivers/i2c/chips/Makefile	2005-07-11 10:37:39.000000000 -0700
+++ osk/drivers/i2c/chips/Makefile	2005-07-11 10:51:01.000000000 -0700
@@ -47,6 +47,7 @@
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
+obj-$(CONFIG_I2C_AT24C)		+= at24c.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_SENSORS_TLV320AIC23) += tlv320aic23.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/drivers/i2c/chips/at24c.c	2005-07-13 09:24:00.000000000 -0700
@@ -0,0 +1,610 @@
+/*
+ * at24c.c -- support many I2C EEPROMs
+ *
+ * Copyright (C) 2005 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+// #define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+
+#ifdef CONFIG_ARM
+#include <asm/mach-types.h>
+#endif
+
+
+/* If all the bus drivers are statically linked, I2C drivers often won't
+ * need hotplug support.  Iff that's true in your config, you can #define
+ * NO_I2C_DYNAMIC_BUSSES and shrink this driver's runtime footprint.
+ */
+//#define NO_I2C_DYNAMIC_BUSSES
+
+
+/* I2C EEPROMs from most vendors are reasonably interchangeable; vendors
+ * have their own parts (like Atmel AT24C, MicroChip 24LC, etc) but the
+ * I2C behavior is normally the same.
+ *
+ * Dynamic typing of these chips isn't really possible; there's no way to
+ * reliably distingush the chips.  And guessing wrong can be dangerous.
+ * If you issue the request to set a 16-bit address, and the chip that
+ * receves that is one using only 8-bit addresses, that request writes
+ * a byte to the EEPROM instead.   Address size is only one of several
+ * chip characteristics that the driver needs to be told.
+ *
+ * So the best way to configure I2C EEPROMS uses static configuration
+ * descriptions.  Right now /etc/modprobe.conf can hold this easily.
+ *
+ *   modprobe at24c chip_names$c02,24c64 probe=0,50,1,50
+ *
+ * CONFIGURATION MECHANISM IS SUBJECT TO CHANGE!!
+ */
+static unsigned short ignore[] = { I2C_CLIENT_END };
+I2C_CLIENT_MODULE_PARM(probe,
+		"List of adapter,address pairs for I2C eeproms");
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c	= ignore,
+	.probe		= probe,
+	.ignore		= ignore,
+	.force		= ignore,
+};
+
+static char *chip_names[I2C_CLIENT_MAX_OPTS / 2];
+static unsigned n_chip_names;
+module_param_array(chip_names, charp, &n_chip_names, 0);
+MODULE_PARM_DESC(chip_names,
+		"Type of chip; one chip name per probe pair");
+
+static int readonly[I2C_CLIENT_MAX_OPTS / 2];
+static unsigned n_readonly;
+module_param_array(readonly, bool, &n_readonly, 0);
+MODULE_PARM_DESC(chip_names, "Readonly flags, one per probe pair");
+
+
+#ifdef	NO_I2C_DYNAMIC_BUSSES
+#undef	__devinit
+#undef	__devinitdata
+#undef	__devexit
+#undef	__devexit_p
+/* no I2C devices will be hotplugging, so modules can shrink */
+#define	__devinit	__init
+#define	__devinitdata	__initdata
+#define	__devexit	__exit
+#define	__devexit_p	__exit_p
+#endif
+
+
+/* As seen through Linux I2C, differences between the most common types
+ * of I2C memory include:
+ *	- How many I2C addresses the chip consumes: 1, 2, 4, or 8?
+ *	- Memory address space for one I2C address:  256 bytes, or 64 KB?
+ *	- How full that memory space is:  16 bytes, 256, 32Kb, etc?
+ *	- What write page size does it support?
+ */
+struct chip_desc {
+	u32		byte_len;		/* of 1..8 i2c addrs, total */
+	char		name[10];
+	u16		page_size;		/* for writes */
+	u8		i2c_addr_mask;		/* for multi-addr chips */
+	u8		flags;
+#define	EE_ADDR2	0x0002			/* 16 bit addrs; <= 64 KB */
+};
+
+struct at24c_data {
+	struct i2c_client	client;
+	struct semaphore	lock;
+	struct bin_attribute	bin;
+
+	struct chip_desc	chip;
+
+	/* each chip has an internal "memory address" pointer;
+	 * we remember it for faster read access.
+	 */
+	u32			next_addr;
+};
+
+/*-------------------------------------------------------------------------*/
+
+static const struct chip_desc __devinitdata chips[] = {
+
+/* this first block of EEPROMS uses 8 bit memory addressing
+ * and can be accessed using standard SMBUS requests.
+ */
+{
+	/* 128 bit chip */
+	.name		= "24c00",
+	.byte_len	= 128 / 8,
+	.i2c_addr_mask	= 0x07,			/* A0-A2 ignored */
+	.page_size	= 1,
+}, {
+	/* 1 Kbit chip */
+	.name		= "24c01",
+	.byte_len	= 1024 / 8,
+	/* some have 16 byte pages: */
+	.page_size	= 8,
+}, {
+	/* 2 Kbit chip */
+	.name		= "24c02",		/* common in memory DIMMs etc */
+	.byte_len	= 2048 / 8,
+	/* some have 16 byte pages: */
+	.page_size	= 8,
+}, {
+	/* 4 Kbit chip */
+	.name		= "24c04",
+	.byte_len	= 4096 / 8,
+	.page_size	= 16,
+	.i2c_addr_mask	= 0x01,			/* I2C A0 is MEM A8 */
+}, {
+	/* 8 Kbit chip */
+	.name		= "24c08",
+	.byte_len	= 8192 / 8,
+	.page_size	= 16,
+	.i2c_addr_mask	= 0x03, 		/* I2C A1-A0 is MEM A9-A8 */
+}, {
+	/* 16 Kbit chip */
+	.name		= "24c16",
+	.byte_len	= 16384 / 8,
+	.page_size	= 16,
+	.i2c_addr_mask	= 0x07,			/* I2C A2-A0 is MEM A10-A8 */
+},
+
+/* this second block of EEPROMS uses 16 bit memory addressing
+ * and can't be accessed using standard SMBUS requests.
+ * REVISIT maybe SMBUS 2.0 requests would work ...
+ */
+{
+	/* 32 Kbits */
+	.name		= "24c32",
+	.byte_len	= 32768 / 8,
+	.flags		= EE_ADDR2,
+	.page_size	= 32,
+}, {
+	/* 64 Kbits */
+	.name		= "24c64",
+	.byte_len	= 65536 / 8,
+	.flags		= EE_ADDR2,
+	.page_size	= 32,
+}, {
+	/* 128 Kbits */
+	.name		= "24c128",
+	.byte_len	= 131072 / 8,
+	.flags		= EE_ADDR2,
+	.page_size	= 64,
+}, {
+	/* 256 Kbits */
+	.name		= "24c256",
+	.byte_len	= 262144 / 8,
+	.flags		= EE_ADDR2,
+	.page_size	= 64,
+}, {
+	/* 512 Kbits */
+	.name		= "24c512",
+	.byte_len	= 524288 / 8,
+	.flags		= EE_ADDR2,
+	.page_size	= 128,
+}, {
+	/* 1 Mbits */
+	.name		= "24c1024",
+	.byte_len	= 1048576 / 8,
+	.flags		= EE_ADDR2,
+	.page_size	= 256,
+	.i2c_addr_mask	= 0x01,			/* I2C A0 is MEM A16 */
+}
+
+};
+#define	NUM_EEPROM_CHIPS	ARRAY_SIZE(chips)
+
+static inline const struct chip_desc *__devinit
+find_chip(const char *s)
+{
+	unsigned i;
+
+	for (i = 0; i < NUM_EEPROM_CHIPS; i++)
+		if (strnicmp(s, chips[i].name, 16) = 0)
+			return &chips[i];
+	return NULL;
+}
+
+static inline const struct chip_desc *__devinit
+which_chip(struct i2c_adapter *adapter, int address, int *writable)
+{
+	unsigned		i;
+
+	for (i = 0; i < I2C_CLIENT_MAX_OPTS; i++) {
+		const struct chip_desc	*chip;
+		char			*name;
+
+		if (probe[i++] != adapter->id)
+			continue;
+		if (probe[i] != address)
+			continue;
+
+		i >>= 1;
+		if ((name = chip_names[i]) = NULL) {
+			dev_err(&adapter->dev, "no chipname for addr %d\n",
+				address);
+			return NULL;
+
+		}
+		chip = find_chip(name);
+		if (chip = NULL)
+			dev_err(&adapter->dev, "unknown chipname %s\n", name);
+		/* default to writable */
+		*writable = !readonly[i];
+		return chip;
+	}
+
+	/* "can't happen" */
+	dev_dbg(&adapter->dev, "addr %d not in probe[]\n", address);
+	return NULL;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static inline int at24c_ee_address(
+	const struct chip_desc	*chip,
+	struct i2c_msg		*msg,
+	unsigned		*offset,
+	u32			*next_addr
+)
+{
+	unsigned	per_address = 256;
+
+	if (*offset >= chip->byte_len)
+		return -EINVAL;
+
+	/* Nothing to do unless accessing that memory would go to some
+	 * later I2C address.  In that case, modify the output params.
+	 * Yes, it can loop more than once on 24c08 and 24c16.
+	 */
+	if (chip->flags & EE_ADDR2)
+		per_address = 64 * 1024;
+	while (*offset >= per_address) {
+		msg->addr++;
+		*offset -= per_address;
+		*next_addr -= per_address;
+	}
+	return 0;
+}
+
+/* This parameter is to help this driver avoid blocking other drivers
+ * out of I2C for potentially troublesome amounts of time.  With a
+ * 100 KHz I2C clock, one 256 byte read takes about 1/43 second.
+ */
+static unsigned io_limit = 128;
+module_param(io_limit, uint, 0);
+MODULE_PARM_DESC(io_limit, "maximum bytes per i/o (default 128)");
+
+static ssize_t
+at24c_ee_read(struct at24c_data *at24c, char *buf, unsigned offset, size_t count)
+{
+	struct i2c_msg	msg;
+	ssize_t		status;
+	u32		next_addr;
+
+	down(&at24c->lock);
+	msg.addr = at24c->client.addr;
+	msg.flags = 0;
+
+	next_addr = at24c->next_addr;
+	status = at24c_ee_address(&at24c->chip, &msg, &offset, &next_addr);
+	if (status < 0)
+		goto done;
+
+	/* FIXME switching to the next i2c address confuses the
+	 * record keeping for the next memory address ...
+	 */
+	next_addr = at24c->bin.size;
+
+	/* advantages of not using i2c_smbus_read_i2c_block_data() here
+	 * include both functionality and performance:
+	 *  (a) uses i2c addresses other than at24c->client.addr, as needed;
+	 *  (b) handles two-byte "register" addresses;
+	 *  (c) this can often rely on the chip's internal address pointer,
+	 *      and omit the initial dummy write;
+	 *  (d) bigger reads than 32-byte niblets;
+	 *  (e) less data copying.
+	 */
+
+	/* Maybe change the current on-chip address with a dummy write */
+	if (next_addr != offset) {
+		u8	tmp[2];
+
+		msg.buf = tmp;
+		tmp[1] = (u8) offset;
+		tmp[0] = (u8) (offset >> 8);
+		if (at24c->chip.flags & EE_ADDR2) {
+			msg.len = 2;
+		} else {
+			msg.len = 1;
+			msg.buf++;
+		}
+		dev_dbg(&at24c->client.dev, "addr %02x, set current to %d\n",
+				msg.addr, offset);
+		status = i2c_transfer(at24c->client.adapter, &msg, 1);
+		if (status < 0)
+			goto done;
+	}
+
+	/* issue sequential read for the data bytes, knowing that read
+	 * page rollover will go to the next page and/or memory block.
+	 */
+	if (count > io_limit)
+		count = io_limit;
+
+	msg.len = count;
+	msg.buf = buf;
+	msg.flags = I2C_M_RD;
+	status = i2c_transfer(at24c->client.adapter, &msg, 1);
+done:
+	dev_dbg(&at24c->client.dev, "read %d bytes --> %d\n", count, status);
+	if (status < 0)
+		at24c->next_addr = at24c->bin.size;
+	else
+		at24c->next_addr = offset + count;
+	up(&at24c->lock);
+	return status < 0 ? status : count;
+}
+
+static ssize_t
+at24c_bin_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct i2c_client	*client;
+	struct at24c_data	*at24c;
+
+	client = to_i2c_client(container_of(kobj, struct device, kobj));
+	at24c = container_of(client, struct at24c_data, client);
+
+	if (unlikely(off > at24c->bin.size))
+		return 0;
+	if ((off + count) > at24c->bin.size)
+		count = at24c->bin.size - off;
+	if (unlikely(!count))
+		return count;
+
+	/* we don't maintain caches for any data:  simpler, cheaper */
+	return at24c_ee_read(at24c, buf, off, count);
+
+}
+
+/* Note that if the hardware write-protect pin is pulled high, the whole
+ * chip is normally write protected.
+ */
+static ssize_t
+at24c_bin_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct i2c_client	*client;
+	struct at24c_data	*at24c;
+	struct i2c_msg		msg;
+	ssize_t			status = 0;
+	unsigned		written = 0;
+	u32			scratch;
+	unsigned		buf_size;
+
+	client = to_i2c_client(container_of(kobj, struct device, kobj));
+	at24c = container_of(client, struct at24c_data, client);
+
+	if (unlikely(off > at24c->bin.size))
+		return 0;
+	if ((off + count) > at24c->bin.size)
+		count = at24c->bin.size - off;
+
+	/* temp buffer lets us stick the address at the beginning */
+	buf_size = at24c->chip.page_size;
+	if (buf_size > io_limit)
+		buf_size = io_limit;
+	msg.buf = kmalloc(buf_size + 2, GFP_KERNEL);
+	if (!msg.buf)
+		return -ENOMEM;
+	msg.flags = 0;
+
+	/* FIXME split this write logic out separately, so it's easier to
+	 * call from non-sysfs contexts... the read side code does this,
+	 * but "struct at24c *" isn't really better than a kobject.
+	 */
+
+	/* for write, rollover is within the page ... so we must write
+	 * at most one page at a time, and manually roll over to the
+	 * next page and/or block.
+	 */
+	down(&at24c->lock);
+	while (count > 0) {
+		unsigned	segment;
+		unsigned	offset = (unsigned) off;
+
+		msg.addr = at24c->client.addr;
+		status = at24c_ee_address(&at24c->chip, &msg, &offset, &scratch);
+		if (status < 0)
+			break;
+
+		/* write as much of a page as we can */
+		segment = buf_size - (offset % buf_size);
+		if (segment > count)
+			segment = count;
+		msg.len = segment + 1;
+		if (at24c->chip.flags & EE_ADDR2) {
+			msg.len++;
+			msg.buf[1] = (u8) offset;
+			msg.buf[0] = (u8) (offset >> 8);
+			memcpy(&msg.buf[2], buf, segment);
+		} else {
+			msg.buf[0] = offset;
+			memcpy(&msg.buf[1], buf, segment);
+		}
+		status = i2c_transfer(at24c->client.adapter, &msg, 1);
+		dev_dbg(&at24c->client.dev,
+			"write %d bytes to %02x at %d --> %d\n",
+			segment, msg.addr, offset, status);
+
+		/* REVISIT while we're advancing, the chip is finishing up its
+		 * write.  We should wait for that; chips often spec a max of
+		 * 5 msec (sometimes 20 msec).
+		 */
+		off += segment;
+		buf += segment;
+		count -= segment;
+		written += segment;
+		if (status < 0 || count = 0) {
+			if (written != 0)
+				status = written;
+			break;
+		}
+	}
+	at24c->next_addr = at24c->bin.size;
+	up(&at24c->lock);
+
+	kfree(msg.buf);
+	return status;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static struct i2c_driver at24c_driver;
+
+static int __devinit at24c_probe(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct at24c_data	*at24c;
+	int			err = 0;
+	int			writable;
+	const struct chip_desc	*chip;
+
+	if (!(at24c = kcalloc(1, sizeof(struct at24c_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto done;
+	}
+	init_MUTEX(&at24c->lock);
+
+	/* if there's no param saying what kind of chip this is,
+	 * don't guess!  just ignore it.
+	 */
+	chip = which_chip(adapter, address, &writable);
+	if (!chip) {
+		err = -ENOENT;
+		goto done;
+	}
+	at24c->chip = *chip;
+	snprintf(at24c->client.name, I2C_NAME_SIZE,
+			"%s I2C EEPROM", at24c->chip.name);
+
+	/* Export the EEPROM bytes through sysfs, since that's convenient */
+	at24c->bin.attr.name = "eeprom";
+	at24c->bin.attr.mode = S_IRUGO;
+	at24c->bin.attr.owner = THIS_MODULE;
+	at24c->bin.read = at24c_bin_read;
+
+	at24c->bin.size = at24c->chip.byte_len;
+	at24c->next_addr = at24c->bin.size;
+	if (writable) {
+		at24c->bin.write = at24c_bin_write;
+		at24c->bin.attr.mode |= S_IWUSR;
+	}
+
+	/* some chips use several addresses ... register the first one.
+	 *
+	 * FIXME register the others, to prevent various misbehaviors.
+	 */
+	address &= ~at24c->chip.i2c_addr_mask;
+
+	at24c->client.addr = address;
+	at24c->client.adapter = adapter;
+	at24c->client.driver = &at24c_driver;
+	at24c->client.flags = 0;
+
+	/* prevent AT24RF08 corruption, a possible consequence of the
+	 * probe done by the i2c core (verifying a chip is present).
+	 */
+	i2c_smbus_write_quick(&at24c->client, 0);
+
+	/* connect to I2C layer */
+	if ((err = i2c_attach_client(&at24c->client)))
+		goto done;
+
+	sysfs_create_bin_file(&at24c->client.dev.kobj, &at24c->bin);
+
+	dev_info(&at24c->client.dev, "%d byte %s%s\n",
+		at24c->bin.size, at24c->client.name,
+		writable ? " (writable)" : "");
+	dev_dbg(&at24c->client.dev, "page_size %d, i2c_addr_mask %d\n",
+		at24c->chip.page_size, at24c->chip.i2c_addr_mask);
+done:
+	if (err) {
+		dev_dbg(&adapter->dev, "%s probe, err %d\n",
+			at24c_driver.name, err);
+		kfree(at24c);
+	}
+	return 0;
+}
+
+static int __devinit at24c_attach_adapter(struct i2c_adapter *adapter)
+{
+	/* REVISIT: using SMBUS calls would improve portability, though
+	 * maybe at the cost of support for 16 bit memory addressing...
+	 */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
+		dev_dbg(&adapter->dev, "%s probe, no I2C\n",
+			at24c_driver.name);
+		return 0;
+	}
+	return i2c_probe(adapter, &addr_data, at24c_probe);
+}
+
+static int __devexit at24c_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	err = i2c_detach_client(client);
+	if (err) {
+		dev_err(&client->dev, "deregistration failed, %d\n", err);
+		return err;
+	}
+
+	kfree(container_of(client, struct at24c_data, client));
+	return 0;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static struct i2c_driver at24c_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "at24c",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= at24c_attach_adapter,
+	.detach_client	= __devexit_p(at24c_detach_client),
+};
+
+static int __init at24c_init(void)
+{
+#ifdef CONFIG_OMAP_OSK_MISTRAL
+	/* REVISIT This is a bit hackish.  But until we have a cleaner way
+	 * to provide compile-time descriptions of the I2C devices on a
+	 * given system (platform_data for something?), it suffices.
+	 */
+	if (machine_is_omap_osk()) {
+		n_chip_names = 1;
+
+		probe[0] = 0;
+		probe[1] = 0x50;
+		chip_names[0] = "24c04";
+	}
+#endif
+	return i2c_add_driver(&at24c_driver);
+}
+module_init(at24c_init);
+
+static void __exit at24c_exit(void)
+{
+	i2c_del_driver(&at24c_driver);
+}
+module_exit(at24c_exit);
+
+MODULE_DESCRIPTION("Driver for AT24C series (and compatible) I2C EEPROMs");
+MODULE_AUTHOR("David Brownell");
+MODULE_LICENSE("GPL");
+
