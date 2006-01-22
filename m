From: rigelf@gmail.com (Rigel Freden)
Date: Sun, 22 Jan 2006 03:19:20 +0000
Subject: [lm-sensors] full asm58 patch
Message-Id: <9328bcc00601211919s40ace8c3n2258e22ed26fc539@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i have revised the fan divisor code in the kernel module from my
previous post and completed a patch against lm-sensors for user space
support.  i have tested my code on my machine and believe it to be
ready for incorporation into the main source trees.  the patches are
against a gentoo revision of kernel 2.6.14 and lm_sensors 2.9.2.  of
course there are probably still bugs, so any feedback would be much
appreciated

--
Rigel Freden

and sorry for the .txt file extensions, my email client...
-------------- next part --------------
diff -Nru linux-2.6.14-gentoo-r5/drivers/hwmon/Kconfig linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/Kconfig
--- linux-2.6.14-gentoo-r5/drivers/hwmon/Kconfig	2006-01-21 14:35:10.000000000 -0700
+++ linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/Kconfig	2006-01-18 11:32:28.368817872 -0700
@@ -89,6 +89,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
+config SENSORS_ASM58
+        tristate "Asus Mozart-2"
+        depends on HWMON && I2C && EXPERIMENTAL
+        help
+          If you say yes here you get support for the ASM58 Mozart-2 sensor
+          chip found on some Asus mainboards.
+
+          This driver can also be built as a module.  If so, the module
+          will be called asm58.
+
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on HWMON && I2C && EXPERIMENTAL
diff -Nru linux-2.6.14-gentoo-r5/drivers/hwmon/Makefile linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/Makefile
--- linux-2.6.14-gentoo-r5/drivers/hwmon/Makefile	2006-01-21 14:35:10.000000000 -0700
+++ linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/Makefile	2006-01-18 11:33:16.269535856 -0700
@@ -16,6 +16,7 @@
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
+obj-$(CONFIG_SENSORS_ASM58)	+= asm58.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
diff -Nru linux-2.6.14-gentoo-r5/drivers/hwmon/asm58.c linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/asm58.c
--- linux-2.6.14-gentoo-r5/drivers/hwmon/asm58.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/asm58.c	2006-01-21 13:22:25.067075496 -0700
@@ -0,0 +1,423 @@
+/*
+    asm58.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2006 Rigel Freden <rigelf at users.sf.net>
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
+/*
+ * attempt one at an asus asm58 (asus mozart-2) hwmon driver
+ */
+
+/*
+ * Motherboards with this chip:
+ * P4B533-VM -- developed and tested on this mobo
+ * P4S333 (in conjunction with another asus chip?)
+ * P4S333-VM
+ * Terminator P4
+ */
+
+/* from kernel documentation
+ * detection:
+ *  - I2C address: 0x77
+ *  - If register 0x58 holds 0x56 or 0x10 then we have a Mozart-2
+ *  - Of the Mozart there are 3 types:
+ *  0x58=0x56, 0x4E=0x94, 0x4F=0x36: Asus ASM58 Mozart-2
+ *  0x58=0x56, 0x4E=0x94, 0x4F=0x06: Asus AS2K129R Mozart-2
+ *  0x58=0x10, 0x4E=0x5C, 0x4F=0xA3: Asus ??? Mozart-2
+ *   the chip on my mobo says Asus AS2K129R Mozart-2 but detects as unknown
+ *  You can handle all 3 the exact same way :)
+ *
+ * temp:
+ *  - sensor 1: register 0x27
+ *  - sensor 2: register 0x13
+ *
+ * fan:
+ *  - 2 fans only, 1350000/RPM/div -- methinks this is 1350000/(reg*div)
+ *  - fan 1: register 0x28,  divisor on register 0xA1 (bits 4-5)
+ *  - fan 2: register 0x29,  divisor on register 0xA1 (bits 6-7)
+ *
+ * voltage:
+ *  in0=r(0x20)*0.016
+ *  in1%5
+ *  in2=r(0x22)*0.016
+ *  in3=r(0x23)*0.016*1.68
+ *  in4=r(0x24)*0.016*4
+ *  in5%5
+ *  in6%5
+ */
+
+/*
+ * from mbmon2.05 sens_winbond.c
+ *
+ * config register at 0x40
+ *  write 0x01 to init chip
+ */
+
+#include<linux/kernel.h>
+#include<linux/module.h>
+#include<linux/init.h>
+#include<asm/semaphore.h>
+#include<linux/jiffies.h>
+#include<linux/i2c.h>
+#include<linux/hwmon.h>
+#include<linux/err.h>
+
+static unsigned short normal_i2c[] = { 0x77, I2C_CLIENT_END };
+
+I2C_CLIENT_INSMOD;
+
+/* FIXME: move this definition to i2c-dev.h */
+#define I2C_DRIVERID_ASMOZART2 1051
+
+#define ASM58_CONFIG_REG 0x40
+#define ASM58_BANK_REG   0x4e
+
+#define ASM58_CHIPID_REG 0x58
+#define ASM58_VENDID_REG 0x4f
+
+#define ASM58_TEMP_REG(i) ((i)?0x13:0x27)
+
+#define ASM58_FAN_REG(i) (0x28+i)
+
+#define ASM58_FANDIV_REG 0xa1
+
+#define ASM58_IN_REG(i) (!(i)?0x20:0x20+(i)+1)
+
+/* i is the fan register number, 0,1
+   r is the fan register value
+*/
+#define ASM58_FANDIV_FROM_REG(r) (1<<(r))
+
+#define ASM58_FAN_FROM_REG(f,r) ((f)=0?-1:(f)=255?0:1350000/((f)*(r)))
+
+#define ASM58_TEMP_FROM_REG(t) (((t) & 0x80 ? (t)-0x100 : (t)) *1000)
+
+/* a structure for state */
+struct asm58_state {
+	/* lock all reads and writes */
+	struct semaphore mtx;
+	struct i2c_client client;
+	struct class_device *class_dev;
+
+	struct semaphore update_mtx;
+	char valid;		/* boolean */
+	unsigned long last_updated;	/* in jiffies */
+	/* registers */
+	u8 temp[2];
+	u8 fan[2];
+	u8 fan_div[2];		/* shifted to the right */
+	u8 in[4];
+};
+
+static int asm58_attach_adapter(struct i2c_adapter *a);
+
+static int asm58_detach_client(struct i2c_client *c);
+
+static struct i2c_driver asm58_driver = {
+	.owner = THIS_MODULE,
+	.name = "asm58",
+	.id = I2C_DRIVERID_ASMOZART2,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = asm58_attach_adapter,
+	.detach_client = asm58_detach_client,
+};
+
+/* maybe ret a u8 */
+static int asm58_read_byte(struct i2c_client *client, u8 reg)
+{
+	struct asm58_state *state = i2c_get_clientdata(client);
+	int ret;
+	down(&state->mtx);
+	ret = i2c_smbus_read_byte_data(client, reg);
+	up(&state->mtx);
+	return ret;
+}
+
+static int asm58_write_byte(struct i2c_client *client, u8 reg, u8 value)
+{
+	struct asm58_state *state = i2c_get_clientdata(client);
+	down(&state->mtx);
+	i2c_smbus_write_byte_data(client, reg, value);
+	up(&state->mtx);
+	return 0;
+}
+
+static struct asm58_state *asm58_update_device(struct device *dev);
+
+static ssize_t show_temp1(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n", ASM58_TEMP_FROM_REG(state->temp[0]));
+}
+
+static ssize_t show_temp2(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n", ASM58_TEMP_FROM_REG(state->temp[1]));
+}
+
+static ssize_t show_fan(struct asm58_state *state, int n, char *buf)
+{
+	int fan_min_lim[] = { 5314, 2657, 1328, 664 };
+	int fan_rpm = ASM58_FAN_FROM_REG(state->fan[n],
+					 ASM58_FANDIV_FROM_REG(state->
+							       fan_div[n]));
+	int div_mod = 0;
+
+	if ((fan_rpm < (125 * fan_min_lim[state->fan_div[n]]) / 100)
+	    && (state->fan_div[n] < 3) && (fan_rpm > 0))
+		/* could set to the "right" value here instead of incrementing */
+		div_mod = 1;
+	else if ((fan_rpm > (25 * fan_min_lim[state->fan_div[n]]) / 10)
+		 && (state->fan_div[n] > 1))
+		div_mod = -1;
+
+	if (div_mod) {
+		down(&state->update_mtx);
+		state->fan_div[n] += div_mod;
+		asm58_write_byte(&(state->client), ASM58_FANDIV_REG,
+				 ((state->fan_div[0] & 0x03) << 4) | ((state->
+								       fan_div
+								       [1] &
+								       0x03) <<
+								      6));
+		up(&state->update_mtx);
+	}
+
+	return sprintf(buf, "%d\n", fan_rpm);
+}
+
+static ssize_t show_fan1(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return show_fan(state, 0, buf);
+}
+
+static ssize_t show_fan2(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return show_fan(state, 1, buf);
+}
+
+static ssize_t show_in0(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n", state->in[0] * 16);
+}
+
+static ssize_t show_in1(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n", state->in[1] * 16);
+}
+
+static ssize_t show_in2(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	/* check this multiplier */
+	return sprintf(buf, "%d\n", (state->in[1] * 16 * 1680) / 1000);
+}
+
+static ssize_t show_in3(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	/* check this multiplier */
+	return sprintf(buf, "%d\n", (state->in[1] * 16 * 3800) / 1000);
+}
+
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1, NULL);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp2, NULL);
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan1, NULL);
+static DEVICE_ATTR(fan2_input, S_IRUGO, show_fan2, NULL);
+static DEVICE_ATTR(in0_input, S_IRUGO, show_in0, NULL);
+static DEVICE_ATTR(in1_input, S_IRUGO, show_in1, NULL);
+static DEVICE_ATTR(in2_input, S_IRUGO, show_in2, NULL);
+static DEVICE_ATTR(in3_input, S_IRUGO, show_in3, NULL);
+
+/* right now, the kind paramter is ignored */
+static int asm58_detect(struct i2c_adapter *a, int address, int kind)
+{
+	struct i2c_client *client;
+	struct asm58_state *state;
+	int chipid, subtype, vendid;
+	int ret;
+	const char *client_name = "";
+
+	if (!i2c_check_functionality(a, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		ret = -EINVAL;
+		goto deallocate_none;
+	}
+
+	if (!(state = kmalloc(sizeof(struct asm58_state), GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto deallocate_none;
+	}
+	memset(state, 0, sizeof(struct asm58_state));
+
+	client = &state->client;
+	i2c_set_clientdata(client, state);
+	client->addr = address;
+	init_MUTEX(&state->mtx);
+	client->adapter = a;
+	client->driver = &asm58_driver;
+	client->flags = 0;
+
+	chipid = asm58_read_byte(client, ASM58_CHIPID_REG);
+	subtype = asm58_read_byte(client, ASM58_BANK_REG);
+	/* the vendor id can only be read from bank 0 */
+	asm58_write_byte(client, ASM58_BANK_REG, 0x00);
+	vendid = asm58_read_byte(client, ASM58_VENDID_REG);
+	/*
+	 *  chipid     subtype     vendid
+	 *  0x58=0x56, 0x4E=0x94, 0x4F=0x36: Asus ASM58 Mozart-2
+	 *  0x58=0x56, 0x4E=0x94, 0x4F=0x06: Asus AS2K129R Mozart-2
+	 *  0x58=0x10, 0x4E=0x5C, 0x4F=0xA3: Asus ??? Mozart-2
+	 */
+	if ((chipid = 0x56 && subtype = 0x94 && vendid = 0x36) ||
+	    /* these two are the as2k129r but so far i know of no difference */
+	    (chipid = 0x56 && subtype = 0x94 && vendid = 0x06) ||
+	    (chipid = 0x10 && subtype = 0x5c && vendid = 0xa3)) {
+		client_name = "asm58";
+	} else {
+		ret = -ENODEV;
+		goto deallocate_state_struct;
+	}
+	strlcpy(client->name, client_name, I2C_NAME_SIZE);
+
+	state->valid = 0;
+	init_MUTEX(&state->update_mtx);
+
+	if ((ret = i2c_attach_client(client)))
+		goto deallocate_state_struct;
+
+	/* any errors after this and goto detach_client */
+	/* initialize the chip, anything else? */
+	asm58_write_byte(client, ASM58_CONFIG_REG, 0x01);
+
+	/* then read initial values of monitoring registers? */
+
+	state->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(state->class_dev)) {
+		ret = PTR_ERR(state->class_dev);
+		goto detach_client;
+	}
+
+	/* maybe export fan_div */
+	device_create_file(&client->dev, &dev_attr_temp1_input);
+	device_create_file(&client->dev, &dev_attr_temp2_input);
+	device_create_file(&client->dev, &dev_attr_fan1_input);
+	device_create_file(&client->dev, &dev_attr_fan2_input);
+	device_create_file(&client->dev, &dev_attr_in0_input);
+	device_create_file(&client->dev, &dev_attr_in1_input);
+	device_create_file(&client->dev, &dev_attr_in2_input);
+	device_create_file(&client->dev, &dev_attr_in3_input);
+
+	return 0;
+
+      detach_client:
+	i2c_detach_client(client);
+
+      deallocate_state_struct:
+	kfree(state);
+
+      deallocate_none:
+	return ret;
+}
+
+static int asm58_attach_adapter(struct i2c_adapter *a)
+{
+	if (!(a->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(a, &addr_data, asm58_detect);
+}
+
+static int asm58_detach_client(struct i2c_client *c)
+{
+	struct asm58_state *state = i2c_get_clientdata(c);
+	int ret = 0;
+	if (state)
+		hwmon_device_unregister(state->class_dev);
+	if ((ret = i2c_detach_client(c)))
+		return ret;
+	if (state)
+		kfree(state);
+	return ret;
+}
+
+static struct asm58_state *asm58_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct asm58_state *state = i2c_get_clientdata(client);
+
+	down(&state->update_mtx);
+
+	if (time_after(jiffies, state->last_updated + HZ + HZ / 2)
+	    || !state->valid) {
+		int i;
+		int fandivreg;
+
+		for (i = 0; i < 4; i++)
+			state->in[i] = asm58_read_byte(client, ASM58_IN_REG(i));
+
+		fandivreg = asm58_read_byte(client, ASM58_FANDIV_REG);
+		state->fan_div[0] = (fandivreg >> 4) & 0x03;
+		state->fan_div[1] = fandivreg >> 6;
+
+		for (i = 0; i < 2; i++)
+			state->fan[i] +			    asm58_read_byte(client, ASM58_FAN_REG(i));
+
+		for (i = 0; i < 2; i++)
+			state->temp[i] +			    asm58_read_byte(client, ASM58_TEMP_REG(i));
+
+		state->last_updated = jiffies;
+		state->valid = 1;
+	}
+
+	up(&state->update_mtx);
+	return state;
+}
+
+/* entry and exit */
+static int __init sensors_asm58_init(void)
+{
+	int ret;
+	if ((ret = i2c_add_driver(&asm58_driver)))
+		return ret;
+	return 0;
+}
+
+static void __exit sensors_asm58_exit(void)
+{
+	i2c_del_driver(&asm58_driver);
+}
+
+MODULE_AUTHOR("Rigel Freden <rigelf at users.sf.net>");
+MODULE_DESCRIPTION("Asus Mozart-2 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_asm58_init);
+module_exit(sensors_asm58_exit);
diff -Nru linux-2.6.14-gentoo-r5/include/linux/i2c-id.h linux-2.6.14-gentoo-r5-asm58/include/linux/i2c-id.h
--- linux-2.6.14-gentoo-r5/include/linux/i2c-id.h	2006-01-21 14:35:10.000000000 -0700
+++ linux-2.6.14-gentoo-r5-asm58/include/linux/i2c-id.h	2006-01-18 11:37:54.700207960 -0700
@@ -157,6 +157,7 @@
 #define I2C_DRIVERID_FSCHER 1046
 #define I2C_DRIVERID_W83L785TS 1047
 #define I2C_DRIVERID_SMSC47B397 1050
+#define I2C_DRIVERID_ASMOZART2 1051
 
 /*
  * ---- Adapter types ----------------------------------------------------
-------------- next part --------------
diff -Nru lm_sensors-2.9.2/CONTRIBUTORS lm_sensors-2.9.2-asm58/CONTRIBUTORS
--- lm_sensors-2.9.2/CONTRIBUTORS	2004-05-24 14:25:12.000000000 -0600
+++ lm_sensors-2.9.2-asm58/CONTRIBUTORS	2006-01-21 12:45:36.318856264 -0700
@@ -96,3 +96,5 @@
   Author of the fscher driver.
 * Alexey Fisher <fishor at mail.ru>
   Author of the max1619 chip driver.
+* Rigel Freden <rigelf at users.sf.net>
+  Author of Mozart-2 driver
diff -Nru lm_sensors-2.9.2/README lm_sensors-2.9.2-asm58/README
--- lm_sensors-2.9.2/README	2005-09-06 13:38:09.000000000 -0600
+++ lm_sensors-2.9.2-asm58/README	2006-01-21 12:44:40.435351848 -0700
@@ -75,7 +75,7 @@
   Analog Devices ADM1021, ADM1021A, ADM1022, ADM1023, ADM1024,
                  ADM1025, ADM1026, ADM1027, ADM1030, ADM1031,
                  ADM1032, ADM9240, ADT7461 and ADT7463
-  Asus AS99127F, ASB100 Bach
+  Asus AS99127F, ASB100 Bach, Mozart-2
   Dallas Semiconductor DS75, DS1621, DS1625, DS1775, and DS1780
   Hewlett Packard Maxilife (several revisions including '99 NBA)
   Fujitsu Siemens Poseidon, Scylla, Hermes
diff -Nru lm_sensors-2.9.2/doc/chips/SUMMARY lm_sensors-2.9.2-asm58/doc/chips/SUMMARY
--- lm_sensors-2.9.2/doc/chips/SUMMARY	2005-09-06 13:38:09.000000000 -0600
+++ lm_sensors-2.9.2-asm58/doc/chips/SUMMARY	2006-01-21 13:07:20.353612848 -0700
@@ -80,6 +80,10 @@
 asb100
 	asb100		4	7	3	1	yes	no
 
+asm58
+	asm58		2	4	2	-	yes	no
+	as2k129r	2	4	2	-	yes	no
+
 bmcsensors
 	bmcsensors	?	?	?	-	no	no
 
diff -Nru lm_sensors-2.9.2/doc/chips/asm58 lm_sensors-2.9.2-asm58/doc/chips/asm58
--- lm_sensors-2.9.2/doc/chips/asm58	1969-12-31 17:00:00.000000000 -0700
+++ lm_sensors-2.9.2-asm58/doc/chips/asm58	2006-01-21 12:55:13.701080824 -0700
@@ -0,0 +1,17 @@
+Kernel driver 'asm58.ko'
+============
+
+Status: only monitoring functions implemented, other functionality unknown
+	2.4 kernel version incomplete
+
+Supported chips:
+  * Asus asm58, as2k129r, there may be other mozart-2 chips
+    Prefix: 'asm58'
+    Addresses scanned: i2c 0x77
+    Datasheet: unavailable, chip information gleaned from xmbmon 2,05
+
+Description
+-----------
+
+This driver conforms to well defined rules of the 2.6 series kernel for hwmon
+chips (should work on at least kernel 2.6.10 and later, maybe others)
diff -Nru lm_sensors-2.9.2/etc/sensors.conf.eg lm_sensors-2.9.2-asm58/etc/sensors.conf.eg
--- lm_sensors-2.9.2/etc/sensors.conf.eg	2005-09-06 13:38:10.000000000 -0600
+++ lm_sensors-2.9.2-asm58/etc/sensors.conf.eg	2006-01-21 12:26:28.192398016 -0700
@@ -2371,3 +2371,13 @@
    set temp2_over  45
    set temp2_hyst  40
 
+chip "asm58-*"
+# this is the default config for the asus p4b533-vm mobo--will probably be fine
+# for any but the p4s333
+	label	temp1	"CPU Temp"
+	label	fan1	"CPU Fan"
+	label	fan2	"Case Fan"
+	label	in0	"VCore"
+	label	in1	"V3.3"
+	label	in2	"V5.0"
+	label	in3	"V12.0"
diff -Nru lm_sensors-2.9.2/lib/chips.c lm_sensors-2.9.2-asm58/lib/chips.c
--- lm_sensors-2.9.2/lib/chips.c	2005-09-06 13:38:10.000000000 -0600
+++ lm_sensors-2.9.2-asm58/lib/chips.c	2006-01-21 09:41:54.100488152 -0700
@@ -5417,6 +5417,18 @@
 	SENSORS_SMSC47B397_FAN(4),
 };
 
+static sensors_chip_feature asm58_features[]+{
+  {SENSORS_ASM58_TEMP1,"temp1",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),3},
+  {SENSORS_ASM58_TEMP2,"temp2",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),3},
+  {SENSORS_ASM58_FAN1,"fan1",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),0},
+  {SENSORS_ASM58_FAN2,"fan2",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),0},
+  {SENSORS_ASM58_IN0,"in0",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),3},
+  {SENSORS_ASM58_IN1,"in1",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),3},
+  {SENSORS_ASM58_IN2,"in2",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),3},
+  {SENSORS_ASM58_IN3,"in3",NOMAP,NOMAP,R,NOSYSCTL,VALUE(3),3}
+};
+
 sensors_chip_features sensors_chip_features_list[]  {
  { SENSORS_LM78_PREFIX, lm78_features },
@@ -5515,5 +5527,6 @@
  { SENSORS_ADM1031_PREFIX, adm1031_features },
  { SENSORS_LM93_PREFIX, lm93_features },
  { SENSORS_SMSC47B397_PREFIX, smsc47b397_features },
+ { SENSORS_ASM58_PREFIX, asm58_features},
  { 0 }
 };
diff -Nru lm_sensors-2.9.2/lib/chips.h lm_sensors-2.9.2-asm58/lib/chips.h
--- lm_sensors-2.9.2/lib/chips.h	2005-09-06 13:38:10.000000000 -0600
+++ lm_sensors-2.9.2-asm58/lib/chips.h	2006-01-21 09:41:06.302754512 -0700
@@ -2090,4 +2090,17 @@
 #define SENSORS_SMSC47B397_FAN3		0x13 /* R */
 #define SENSORS_SMSC47B397_FAN4		0x14 /* R */
 
+
+/* asus mozart-2 all values read only */
+
+#define SENSORS_ASM58_PREFIX "asm58"
+#define SENSORS_ASM58_TEMP1 1
+#define SENSORS_ASM58_TEMP2 2
+#define SENSORS_ASM58_FAN1  3
+#define SENSORS_ASM58_FAN2  4
+#define SENSORS_ASM58_IN0   5
+#define SENSORS_ASM58_IN1   6
+#define SENSORS_ASM58_IN2   7
+#define SENSORS_ASM58_IN3   8
+
 #endif /* def LIB_SENSORS_CHIPS_H */
diff -Nru lm_sensors-2.9.2/prog/detect/sensors-detect lm_sensors-2.9.2-asm58/prog/detect/sensors-detect
--- lm_sensors-2.9.2/prog/detect/sensors-detect	2005-09-06 13:38:10.000000000 -0600
+++ lm_sensors-2.9.2-asm58/prog/detect/sensors-detect	2006-01-21 13:00:45.975567424 -0700
@@ -1109,19 +1109,19 @@
      } ,
      {
        name => "Asus ASM58 Mozart-2",
-       driver => "to-be-written",
+       driver => "asm58",
        i2c_addrs => [0x77],
        i2c_detect => sub { mozart_detect 0, @_},
      } ,
      {
        name => "Asus AS2K129R Mozart-2",
-       driver => "to-be-written",
+       driver => "asm58",
        i2c_addrs => [0x77],
        i2c_detect => sub { mozart_detect 1, @_},
      } ,
      {
        name => "Asus Mozart-2",
-       driver => "to-be-written",
+       driver => "asm58",
        i2c_addrs => [0x77],
        i2c_detect => sub { mozart_detect 2, @_},
      } ,
diff -Nru lm_sensors-2.9.2/prog/sensors/chips.c lm_sensors-2.9.2-asm58/prog/sensors/chips.c
--- lm_sensors-2.9.2/prog/sensors/chips.c	2005-09-06 13:38:10.000000000 -0600
+++ lm_sensors-2.9.2-asm58/prog/sensors/chips.c	2006-01-21 13:13:55.126598232 -0700
@@ -5776,6 +5776,64 @@
     PRINT_SMSC47B397_FAN(ii, name);
 }
 
+void print_asm58(const sensors_chip_name *name)
+{
+  double value;
+  char *label;
+  int valid;
+  int i;
+
+  for(i=0;i<2;i++)
+  {
+    if(!sensors_get_label_and_valid(*name,SENSORS_ASM58_TEMP1+i,&label,&valid)&&
+       !sensors_get_feature(*name,SENSORS_ASM58_TEMP1+i,&value))
+    {
+      if(valid)
+      {
+	print_label(label,10);
+	print_temp_info(value,0,0,SINGLE,0,0);
+	printf("\n");
+      }
+    }
+    else
+      printf("ERROR: Can't get TEMP%d data!\n",i+1);
+    free_the_label(&label);
+  }
+
+  for(i=0;i<2;i++)
+  {
+    if(!sensors_get_label_and_valid(*name,SENSORS_ASM58_FAN1+i,&label,&valid)&&
+       !sensors_get_feature(*name,SENSORS_ASM58_FAN1+i,&value))
+    {
+      if(valid)
+      {
+	print_label(label,10);
+	printf("%4.0f RPM\n",value);
+      }
+    }
+    else
+      printf("ERROR: Can't get FAN%d data!\n",i+1);
+    free_the_label(&label);
+  }
+
+  for(i=0;i<4;i++)
+  {
+    if(!sensors_get_label_and_valid(*name,SENSORS_ASM58_IN0+i,&label,&valid)&&
+       !sensors_get_feature(*name,SENSORS_ASM58_IN0+i,&value))
+    {
+      if(valid)
+      {
+	print_label(label,10);
+	printf("%+6.2f V\n",value);
+      }
+    }
+    else
+      printf("ERROR: Can't get IN%d data!\n",i);
+    free_the_label(&label);
+  }
+
+}
+
 void print_unknown_chip(const sensors_chip_name *name)
 {
   int a,b,valid;
@@ -5804,4 +5862,3 @@
       printf("(%s)\n",label);
   }
 }
-
diff -Nru lm_sensors-2.9.2/prog/sensors/chips.h lm_sensors-2.9.2-asm58/prog/sensors/chips.h
--- lm_sensors-2.9.2/prog/sensors/chips.h	2005-09-06 13:38:10.000000000 -0600
+++ lm_sensors-2.9.2-asm58/prog/sensors/chips.h	2006-01-21 09:46:05.876212424 -0700
@@ -70,5 +70,6 @@
 extern void print_max6650(const sensors_chip_name *name);
 extern void print_adm1031(const sensors_chip_name *name);
 extern void print_smsc47b397(const sensors_chip_name *name);
+extern void print_asm58(const sensors_chip_name *name);
 
 #endif /* def PROG_SENSORS_CHIPS_H */
diff -Nru lm_sensors-2.9.2/prog/sensors/main.c lm_sensors-2.9.2-asm58/prog/sensors/main.c
--- lm_sensors-2.9.2/prog/sensors/main.c	2005-09-06 13:38:10.000000000 -0600
+++ lm_sensors-2.9.2-asm58/prog/sensors/main.c	2006-01-21 10:52:49.879511400 -0700
@@ -405,6 +405,7 @@
 	{ "adm1031", print_adm1031 },
 	{ "lm93", print_lm93 },
 	{ "smsc47b397", print_smsc47b397 },
+	{ "asm58", print_asm58},
 	{ NULL, NULL }
 };
 
