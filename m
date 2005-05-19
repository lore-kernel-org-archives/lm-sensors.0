From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Sensors driver for Xeon(Pentium 4) thermal sensor
Message-Id: <3CF3C3CB.1040403@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The thermal diode on the Pentium III processors has been replaced by an 
SMBus device to monitor and convert the diode to degrees C in the 
Pentium 4 (Xeon) processors.

This Thermal Sensors is documented in the processor datasheet and I have 
written a driver to report the temperature, high and low limits, and the 
conversion rate.

I had to hack the i2c-i801 driver to recognize the intel 7500 xx801CA 
chip.  I think that fix might already be in the mainline sources.

I have assigned myself a "production" ID in i2c-ids.h.  If that ID has 
already been assigned, please assign me a new one and I'll redo the 
patch.  (Didn't read doc/writing-drivers until after I'd finished...)

I don't have the chips.c file that goes into 'sensors', so I haven't 
been able to add the 'temp', 'temp_over', and 'temp_hyst' parameters to 
sensors and sensors.conf.

Please let me know what I need to do to submit this patch to the 
main-line lm-sensors code.

Thanks,
:v)

-- 
Philip Pokorny, Senior Engineer
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING - Simplifying the Solution Process [tm]
www.penguincomputing.com
-------------- next part --------------
diff -wurP linux-2.4.18-4/drivers/i2c/i2c-i801.c linux-2.4.18-4p4xeon/drivers/i2c/i2c-i801.c
--- linux-2.4.18-4/drivers/i2c/i2c-i801.c	Thu May  2 14:36:45 2002
+++ linux-2.4.18-4p4xeon/drivers/i2c/i2c-i801.c	Mon May 27 12:16:34 2002
@@ -51,10 +51,14 @@
 #ifndef PCI_DEVICE_ID_INTEL_82801BA_2
 #define PCI_DEVICE_ID_INTEL_82801BA_2   0x2443
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_82801CA_3
+#define PCI_DEVICE_ID_INTEL_82801CA_3   0x2483
+#endif
 
 static int supported[] = {PCI_DEVICE_ID_INTEL_82801AA_3,
                           PCI_DEVICE_ID_INTEL_82801AB_3,
                           PCI_DEVICE_ID_INTEL_82801BA_2,
+                          PCI_DEVICE_ID_INTEL_82801CA_3,
                           0 };
 
 /* I801 SMBus address offsets */
diff -wurP linux-2.4.18-4/drivers/sensors/Config.in linux-2.4.18-4p4xeon/drivers/sensors/Config.in
--- linux-2.4.18-4/drivers/sensors/Config.in	Thu May  2 14:36:41 2002
+++ linux-2.4.18-4p4xeon/drivers/sensors/Config.in	Mon May 27 09:58:51 2002
@@ -25,6 +25,7 @@
     dep_tristate '  Texas Instruments THMC50 and compatibles' CONFIG_SENSORS_THMC50 $CONFIG_I2C $CONFIG_I2C_PROC
     dep_tristate '  VIA 686a Integrated Hardware Monitor' CONFIG_SENSORS_VIA686A $CONFIG_I2C $CONFIG_I2C_PROC $CONFIG_I2C_ISA
     dep_tristate '  Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F' CONFIG_SENSORS_W83781D $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Intel Xeon (Pentium 4) Thermal Sensor' CONFIG_SENSORS_P4XEON $CONFIG_SENSORS
     bool 'Other I2C devices' CONFIG_SENSORS_OTHER 
     if [ "$CONFIG_SENSORS_OTHER" = "y" ] ; then
       dep_tristate '  Brooktree BT869 Video Modulator' CONFIG_SENSORS_BT869 $CONFIG_I2C $CONFIG_I2C_PROC
@@ -36,4 +37,3 @@
   endmenu
 fi
 fi
-
diff -wurP linux-2.4.18-4/drivers/sensors/Makefile linux-2.4.18-4p4xeon/drivers/sensors/Makefile
--- linux-2.4.18-4/drivers/sensors/Makefile	Thu May  2 14:36:41 2002
+++ linux-2.4.18-4p4xeon/drivers/sensors/Makefile	Mon May 27 09:57:11 2002
@@ -24,6 +24,7 @@
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
+obj-$(CONFIG_SENSORS_P4XEON)	+= p4xeon.o
 
 include $(TOPDIR)/Rules.make
 
diff -wurP linux-2.4.18-4/drivers/sensors/p4xeon.c linux-2.4.18-4p4xeon/drivers/sensors/p4xeon.c
--- linux-2.4.18-4/drivers/sensors/p4xeon.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18-4p4xeon/drivers/sensors/p4xeon.c	Tue May 28 02:43:35 2002
@@ -0,0 +1,427 @@
+/*
+    p4xeon.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2002  Philip Pokorny (ppokorny@penguincomputing.com)
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/sensors.h>
+#define LM_DATE "20020517"
+#define LM_VERSION "2.6.1"
+#include <linux/init.h>
+
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)) || \
+    (LINUX_VERSION_CODE = KERNEL_VERSION(2,3,0))
+#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
+#endif
+
+#ifndef THIS_MODULE
+#define THIS_MODULE NULL
+#endif
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
+static unsigned int normal_isa[] = { SENSORS_ISA_END };
+static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(p4xeon);
+
+/* Many P4Xeon Thermal Sensor constants specified below */
+
+/* The P4XEON registers */
+#define P4XEON_REG_TEMP 0x01
+#define P4XEON_REG_STATUS 0x02
+#define P4XEON_REG_CONFIG 0x03
+#define P4XEON_REG_RATE 0x04
+#define P4XEON_REG_HIGHLIM 0x07
+#define P4XEON_REG_LOWLIM 0x08
+#define P4XEON_REG_READ2WRITE 0x06
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+/* Intel spec says values less than 0 sould be read as 0... */
+#define TEMP_FROM_REG(val) (SENSORS_LIMIT((val),0,0x7f))
+#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val),0,0x7f))
+
+/* Initial values */
+#define P4XEON_INIT_TEMP_HIGH  (80)
+#define P4XEON_INIT_TEMP_LOW  (5)
+
+/* Each client has this additional data */
+struct p4xeon_data {
+	int sysctl_id;
+};
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init sensors_p4xeon_init(void);
+static int __init p4xeon_cleanup(void);
+static int p4xeon_attach_adapter(struct i2c_adapter *adapter);
+static int p4xeon_detect(struct i2c_adapter *adapter, int address,
+		       unsigned short flags, int kind);
+static void p4xeon_init_client(struct i2c_client *client);
+static int p4xeon_detach_client(struct i2c_client *client);
+static int p4xeon_command(struct i2c_client *client, unsigned int cmd,
+			void *arg);
+static void p4xeon_inc_use(struct i2c_client *client);
+static void p4xeon_dec_use(struct i2c_client *client);
+static int p4xeon_read_temp(struct i2c_client *client, u8 reg);
+static int p4xeon_write_temp(struct i2c_client *client, u8 reg, s16 value);
+static void p4xeon_temp(struct i2c_client *client, int operation, int ctl_name, int *nrels_mag, long *results);
+static void p4xeon_rate(struct i2c_client *client, int operation, int ctl_name, int *nrels_mag, long *results);
+static void p4xeon_update_client(struct i2c_client *client);
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver p4xeon_driver = {
+	/* name */ "P4-Xeon Thermal Sensor",
+	/* id */ I2C_DRIVERID_P4XEON,
+	/* flags */ I2C_DF_NOTIFY,
+	/* attach_adapter */ &p4xeon_attach_adapter,
+	/* detach_client */ &p4xeon_detach_client,
+	/* command */ &p4xeon_command,
+	/* inc_use */ &p4xeon_inc_use,
+	/* dec_use */ &p4xeon_dec_use
+};
+
+/* These files are created for each detected P4 Xeon. This is just a template;
+   though at first sight, you might think we could use a statically
+   allocated list, we need some way to get back to the parent - which
+   is done through one of the 'extra' fields which are initialized
+   when a new copy is allocated. */
+static ctl_table p4xeon_dir_table_template[] = {
+	{P4XEON_SYSCTL_TEMP, "temp", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &p4xeon_temp},
+	{P4XEON_SYSCTL_RATE, "rate", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &p4xeon_rate},
+	{0}
+};
+
+/* Used by init/cleanup */
+static int __initdata p4xeon_initialized = 0;
+
+static int p4xeon_id = 0;
+
+int p4xeon_attach_adapter(struct i2c_adapter *adapter)
+{
+#ifdef DEBUG
+	printk( "p4xeon.o: ENTER _attach_adapter ...\n" );
+#endif
+	return i2c_detect(adapter, &addr_data, p4xeon_detect);
+}
+
+/* This function is called by i2c_detect */
+int p4xeon_detect(struct i2c_adapter *adapter, int address,
+		unsigned short flags, int kind)
+{
+	int i;
+	u8  conv ;
+	s16  high ;
+	struct i2c_client *new_client;
+	struct p4xeon_data *data;
+	int err = 0;
+	const char *type_name, *client_name;
+
+#ifdef DEBUG
+	printk( "p4xeon.o: ENTER _detect ...\n" );
+#endif
+	/* Make sure we aren't probing the ISA bus!! This is just a safety check
+	   at this moment; i2c_detect really won't call us. */
+	if (i2c_is_isa_adapter(adapter)) {
+		printk("p4xeon.o: p4xeon_detect called for an ISA bus adapter?!?\n");
+		return 0;
+	}
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		    goto ERROR0;
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access i2c_smbus_### funcs.  */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct p4xeon_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR0;
+	}
+
+	data = (struct p4xeon_data *) (new_client + 1);
+	new_client->addr = address;
+	new_client->data = data;
+	new_client->adapter = adapter;
+	new_client->driver = &p4xeon_driver;
+	new_client->flags = 0;
+#ifdef DEBUG
+	printk( "p4xeon.o: INIT_DONE new_client ...\n" );
+#endif
+
+	/* It's a Xeon Thermal Sensor if:
+	   1. Processor Temp (0x01) < 0x80
+	   2. Conversion Rate (0x04) < 0x08
+	   3. High limit between 0 and 0x7f
+	   5. Reserved addresses (0x10 - 0x3f) are 0xff
+	 */
+	if (kind < 0) {
+#ifdef DEBUG
+	printk( "p4xeon.o: ENTER testing address: 0x%02x ...\n", address );
+#endif
+		err = -ENODEV ;
+		if( i2c_smbus_read_byte_data(new_client, P4XEON_REG_TEMP) > 0x7f )
+			goto ERROR1 ;
+		conv = i2c_smbus_read_byte_data(new_client, P4XEON_REG_RATE);
+		if( conv >= 0x08 )
+			goto ERROR1 ;
+		high = p4xeon_read_temp(new_client, P4XEON_REG_HIGHLIM);
+		if( high < 0 || high > 0x7f )
+			goto ERROR1 ;
+		for (i = 0x10; i <= 0x3f; i++)
+			if( i2c_smbus_read_byte_data(new_client, i) != 0xff ) {
+#ifdef DEBUG
+	printk( "p4xeon.o: Address: 0x%02x not 0xff ...\n", i );
+#endif
+				goto ERROR1;
+			}
+	}
+
+	/* Determine the chip type - only one kind supported! */
+	if (kind <= 0)
+		kind = p4xeon;
+
+	if (kind = p4xeon) {
+		type_name = "p4xeon";
+		client_name = "P4-Xeon Thermal Sensor";
+	} else {
+#ifdef DEBUG
+		printk("p4xeon.o: Internal error: unknown kind (%d)?!?",
+		       kind);
+#endif
+		err = -ENODEV ;
+		goto ERROR1;
+	}
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strcpy(new_client->name, client_name);
+
+	new_client->id = p4xeon_id++;
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR3;
+
+	/* Register a new directory entry with module sensors */
+	if ((i = i2c_register_entry(new_client, type_name,
+					p4xeon_dir_table_template,
+					THIS_MODULE)) < 0) {
+		err = i;
+		goto ERROR4;
+	}
+	data->sysctl_id = i;
+#ifdef DEBUG
+	printk( "p4xeon.o: DONE FOUND.  ID: %d  SYSCTL_ID: 0x%08x\n", new_client->id, data->sysctl_id );
+#endif
+
+	p4xeon_init_client(new_client);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR4:
+	i2c_detach_client(new_client);
+      ERROR3:
+      ERROR1:
+	kfree(new_client);
+      ERROR0:
+#ifdef DEBUG
+	printk( "p4xeon.o: EXIT with ERROR\n" );
+#endif
+	return err;
+}
+
+int p4xeon_detach_client(struct i2c_client *client)
+{
+	int err;
+
+#ifdef MODULE
+	if (MOD_IN_USE)
+		return -EBUSY;
+#endif
+
+	i2c_deregister_entry(((struct p4xeon_data *) (client->data))->sysctl_id);
+
+	if ((err = i2c_detach_client(client))) {
+		printk("p4xeon.o: Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+
+	return 0;
+}
+
+
+/* No commands defined yet */
+int p4xeon_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	return 0;
+}
+
+/* Module use counting */
+void p4xeon_inc_use(struct i2c_client *client)
+{
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+}
+
+/* Module use counting */
+void p4xeon_dec_use(struct i2c_client *client)
+{
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+}
+
+/* Nothing here yet */
+void p4xeon_init_client(struct i2c_client *client)
+{
+	/* Initialize the P4 Xeon Thermal Sensor */
+
+	/* Just leave it alone for now.  Perhaps
+	 * we should force it into automatic conversion
+	 * mode and make sure the config looks right?
+	 */
+}
+
+/* Read and write temperature values */
+int  p4xeon_read_temp( struct i2c_client *client, u8 addr )
+{
+	int  val = (s8)i2c_smbus_read_byte_data(client, addr) ;
+	return (SENSORS_LIMIT(val,-0x7f,0x7f));
+}
+int  p4xeon_write_temp( struct i2c_client *client, u8 addr, s16 value )
+{
+	int  val = SENSORS_LIMIT(value,-0x7f,0x7f);
+	return i2c_smbus_write_byte_data(client, addr+P4XEON_REG_READ2WRITE, val);
+}
+
+/* Do /proc/.../temp things... */
+void p4xeon_temp(struct i2c_client *client, int operation, int ctl_name,
+	       int *nrels_mag, long *results)
+{
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;  /* temps in 'C */
+
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		results[0] = TEMP_FROM_REG(p4xeon_read_temp(client, P4XEON_REG_HIGHLIM)) ;
+		results[1] = p4xeon_read_temp(client, P4XEON_REG_LOWLIM) ;
+		results[2] = p4xeon_read_temp(client, P4XEON_REG_TEMP) ;
+		*nrels_mag = 3;
+
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+			p4xeon_write_temp(client, P4XEON_REG_HIGHLIM, results[0]);
+		}
+		if (*nrels_mag >= 2) {
+			p4xeon_write_temp(client, P4XEON_REG_LOWLIM, results[1]);
+		}
+	}
+}
+
+/* Do /proc/.../rate things... */
+void p4xeon_rate(struct i2c_client *client, int operation, int ctl_name,
+	       int *nrels_mag, long *results)
+{
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		results[0] = i2c_smbus_read_byte_data(client, P4XEON_REG_RATE) ;
+		*nrels_mag = 1;
+
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+		    u8 val = SENSORS_LIMIT(results[0],0,7);
+			i2c_smbus_write_byte_data(client, P4XEON_REG_RATE+P4XEON_REG_READ2WRITE, val);
+		}
+	}
+}
+
+int __init sensors_p4xeon_init(void)
+{
+	int res;
+
+	printk("p4xeon.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	p4xeon_initialized = 0;
+	if ((res = i2c_add_driver(&p4xeon_driver))) {
+		printk("p4xeon.o: Driver registration failed, module not inserted.\n");
+		p4xeon_cleanup();
+		return res;
+	}
+	p4xeon_initialized++;
+	return 0;
+}
+
+int __init p4xeon_cleanup(void)
+{
+	int res;
+
+	if (p4xeon_initialized >= 1) {
+		if ((res = i2c_del_driver(&p4xeon_driver))) {
+			printk("p4xeon.o: Driver deregistration failed, module not removed.\n");
+			return res;
+		}
+		p4xeon_initialized--;
+	}
+
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>");
+MODULE_DESCRIPTION("P4Xeon driver");
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return sensors_p4xeon_init();
+}
+
+int cleanup_module(void)
+{
+	return p4xeon_cleanup();
+}
+
+#endif				/* MODULE */
diff -wurP linux-2.4.18-4/include/linux/i2c-id.h linux-2.4.18-4p4xeon/include/linux/i2c-id.h
--- linux-2.4.18-4/include/linux/i2c-id.h	Thu Oct 11 08:05:47 2001
+++ linux-2.4.18-4p4xeon/include/linux/i2c-id.h	Mon May 27 10:32:31 2002
@@ -127,6 +127,7 @@
 #define I2C_DRIVERID_ADM1024 1025
 #define I2C_DRIVERID_IT87 1026
 #define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
+#define I2C_DRIVERID_P4XEON 1028
 
 /*
  * ---- Adapter types ----------------------------------------------------
diff -wurP linux-2.4.18-4/include/linux/sensors.h linux-2.4.18-4p4xeon/include/linux/sensors.h
--- linux-2.4.18-4/include/linux/sensors.h	Tue May 21 08:19:07 2002
+++ linux-2.4.18-4p4xeon/include/linux/sensors.h	Mon May 27 11:49:03 2002
@@ -104,6 +104,9 @@
 
 #define LM75_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
 
+#define P4XEON_SYSCTL_TEMP 1000	/* Degrees Celcius */
+#define P4XEON_SYSCTL_RATE 1001	/* (2^rate / 16) conv/sec */
+
 #define ADM1021_SYSCTL_TEMP 1200
 #define ADM1021_SYSCTL_REMOTE_TEMP 1201
 #define ADM1021_SYSCTL_DIE_CODE 1202
