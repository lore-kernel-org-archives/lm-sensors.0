From: rigelf@gmail.com (Rigel Freden)
Date: Thu, 30 Mar 2006 05:07:57 +0000
Subject: [lm-sensors] asm58 for 2.10.0, linux 2.6.15
Message-Id: <9328bcc00603292107p34468168sd96afb5ee3727fe@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9328bcc00602262007h79e1b9ffu5f9c463b486b1da@mail.gmail.com>
In-Reply-To: <9328bcc00602262007h79e1b9ffu5f9c463b486b1da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thank you for the review; i believe i made every change you requested,
except the sysfs attribute array and device file creation thing, which
i'm too tired or coded out or just plain stupid to understand (perhaps
my google-fu is weak tonight).  attached are the resultant patches to
kernel 2.6.16 and lm sensors 2.10.0.  My former system instability
turned out to be a power supply fan failure rather than my hwmon
driver.  now to install a i2c sensor on my psu heatsink...
-------------- next part --------------
diff -Nru linux-2.6.16/Documentation/hwmon/asm58 linux-2.6.16-asm58/Documentation/hwmon/asm58
--- linux-2.6.16/Documentation/hwmon/asm58	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-asm58/Documentation/hwmon/asm58	2006-03-29 20:48:28.950053496 -0700
@@ -0,0 +1,42 @@
+Kernel driver asm58
+=========+
+Supported Chips:
+* Asus ASM58 Mozart-2
+* Asus AS2K129R Mozart-2
+* Asus ??? Mozart-2
+  All three seem to be the same save for exterior markings
+  Prefix: 'asm58'
+  Addresses scanned: I2C 0x77
+  Datasheet: not available
+
+
+Description
+-----------
+
+This chip is discontinued and unsupported by the manufacturer. The driver was
+developed with xmbmon205 source as a reference.  It is found on
+the following Asus mainboards:
+ P4B533-VM
+ P4S333 (in conjunction with another asus chip?)
+ P4S333-VM
+ Terminator P4
+
+Registers:
+temp:
+temp1: 0x27
+temp2: 0x13
+fan:
+fan 1:  0x28,  divisor on register 0xA1 (bits 4-5)
+fan 2: 0x29,  divisor on register 0xA1 (bits 6-7)
+voltage:
+in0=r(0x20)
+in1=r(0x22)
+in2=r(0x23)
+in3=r(0x24)
+config, or bank register at 0x40
+
+notes:
+ * there is another undocumented asus chip at i2c 0x77 on a different board
+ * there is reason to believe this chip implements a watchdog and perhaps other
+   features, probably fan control among them
diff -Nru linux-2.6.16/drivers/hwmon/Kconfig linux-2.6.16-asm58/drivers/hwmon/Kconfig
--- linux-2.6.16/drivers/hwmon/Kconfig	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-asm58/drivers/hwmon/Kconfig	2006-03-27 21:00:05.148154144 -0700
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
diff -Nru linux-2.6.16/drivers/hwmon/Makefile linux-2.6.16-asm58/drivers/hwmon/Makefile
--- linux-2.6.16/drivers/hwmon/Makefile	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-asm58/drivers/hwmon/Makefile	2006-03-27 21:00:05.166151408 -0700
@@ -16,6 +16,7 @@
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
+obj-$(CONFIG_SENSORS_ASM58)	+= asm58.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
diff -Nru linux-2.6.16/drivers/hwmon/asm58.c linux-2.6.16-asm58/drivers/hwmon/asm58.c
--- linux-2.6.16/drivers/hwmon/asm58.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.16-asm58/drivers/hwmon/asm58.c	2006-03-29 21:04:24.044857016 -0700
@@ -0,0 +1,330 @@
+/*
+  asm58.c - Part of lm_sensors, Linux kernel modules for hardware
+  monitoring
+  Copyright (c) 2006 Rigel Freden <rigelf at users.sf.net>
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include<linux/kernel.h>
+#include<linux/module.h>
+#include<linux/init.h>
+#include<linux/jiffies.h>
+#include<linux/i2c.h>
+#include<linux/hwmon.h>
+#include<linux/err.h>
+#include<linux/mutex.h>
+#include<linux/hwmon-sysfs.h>
+
+static unsigned short normal_i2c[] = { 0x77, I2C_CLIENT_END };
+
+I2C_CLIENT_INSMOD;
+
+#define ASM58_CONFIG_REG 0x40
+#define ASM58_MODE_REG   0x4e
+
+#define ASM58_CHIPID_REG 0x58
+#define ASM58_VENDID_REG 0x4f
+
+/* 0-1 */
+#define ASM58_TEMP_REG(i) ( (i) ? 0x13 : 0x27 )
+
+/* 0-1 */
+#define ASM58_FAN_REG(i) ( 0x28 + (i) )
+
+#define ASM58_FANDIV_REG 0xa1
+
+/* 0-3 */
+#define ASM58_IN_REG(i) ( ! (i) ? 0x20 : 0x20 + (i) + 1 )
+
+/*
+   r is the fan register value
+*/
+#define ASM58_FANDIV_FROM_REG(r) ( 1 << (r) )
+
+/*
+  f is the fan register
+  r is the FANDIV_FROM_REG adjusted fan divisor register
+*/
+#define ASM58_RPM_FROM_REG(f,r) ( (f) =0 ? -1 : (f) = 255 ? 0 : \
+1350000 / ( (f) * (r) ) )
+
+#define ASM58_TEMP_FROM_REG(t) ( ( (t) & 0x80 ? (t) -0x100 : (t) ) * 1000 )
+
+#define ASM58_IN_FROM_REG(i) ( (i) * 16 )
+
+/* a structure for state */
+struct asm58_state {
+	struct i2c_client client;
+	struct class_device *class_dev;
+
+	struct mutex update_mtx;
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
+	.driver = {
+		   .name = "asm58"},
+	.id = I2C_DRIVERID_ASM58,
+	.attach_adapter = asm58_attach_adapter,
+	.detach_client = asm58_detach_client,
+};
+
+/* maybe ret a u8 */
+static int asm58_read_byte(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int asm58_write_byte(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static struct asm58_state *asm58_update_device(struct device *dev);
+
+static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n",
+		       ASM58_TEMP_FROM_REG(state->temp[attr->index]));
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+
+static int asm58_fan_min_lim[] = { 5314, 2657, 1328, 664 };
+
+static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct asm58_state *state = asm58_update_device(dev);
+	int n = attr->index;
+	int fan_rpm = ASM58_RPM_FROM_REG(state->fan[n],
+					 ASM58_FANDIV_FROM_REG(state->
+							       fan_div[n]));
+	int div_mod = 0;
+
+	/* if the fan is spinning below 150% of the current divisor limit,
+	   increment */
+	if ((fan_rpm < (15 * asm58_fan_min_lim[state->fan_div[n]]) / 10)
+	    && (state->fan_div[n] < 3) && (fan_rpm != 0))
+		/* could set to the "right" value here instead of incrementing */
+		div_mod = 1;
+	/* if above 285%, decrement */
+	else if ((fan_rpm > (285 * asm58_fan_min_lim[state->fan_div[n]]) / 100)
+		 && (state->fan_div[n] > 0))
+		div_mod = -1;
+
+	if (div_mod) {
+		mutex_lock(&state->update_mtx);
+		state->fan_div[n] += div_mod;
+		/* just masking and shifting for the hardware fandiv reg */
+		asm58_write_byte(&(state->client), ASM58_FANDIV_REG,
+				 ((state->fan_div[0] & 0x03) << 4) |
+				 ((state->fan_div[1] & 0x03) << 6));
+		mutex_unlock(&state->update_mtx);
+	}
+
+	return sprintf(buf, "%d\n", fan_rpm);
+}
+
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
+
+static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
+		       char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n", ASM58_IN_FROM_REG(state->in[attr->index]));
+}
+
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
+
+/* kind parameter ignored */
+static int asm58_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	struct asm58_state *state;
+	int chipid, subtype, vendid;
+	int ret;
+	const char *client_name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		ret = -EINVAL;
+		goto deallocate_none;
+	}
+
+	if (!(state = kzalloc(sizeof(struct asm58_state), GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto deallocate_none;
+	}
+
+	client = &state->client;
+	i2c_set_clientdata(client, state);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &asm58_driver;
+	client->flags = 0;
+
+	chipid = asm58_read_byte(client, ASM58_CHIPID_REG);
+	subtype = asm58_read_byte(client, ASM58_MODE_REG);
+	if (!(chipid = 0x56 && subtype = 0x94) &&
+	    !(chipid = 0x56 && subtype = 0x94) &&
+	    !(chipid = 0x10 && subtype = 0x5c)) {
+		ret = -ENODEV;
+		goto deallocate_state_struct;
+	}
+	asm58_write_byte(client, ASM58_MODE_REG, 0x00);
+	vendid = asm58_read_byte(client, ASM58_VENDID_REG);
+
+	if ((chipid = 0x56 && subtype = 0x94 && vendid = 0x36) ||
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
+	mutex_init(&state->update_mtx);
+
+	if ((ret = i2c_attach_client(client)))
+		goto deallocate_state_struct;
+
+	/* any errors after this and goto detach_client */
+	asm58_write_byte(client, ASM58_CONFIG_REG, 0x01);
+	asm58_write_byte(client, ASM58_FANDIV_REG, 0xf0);
+
+	state->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(state->class_dev)) {
+		ret = PTR_ERR(state->class_dev);
+		goto detach_client;
+	}
+
+	device_create_file(&client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_fan1_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_fan2_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in0_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in1_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in2_input.dev_attr);
+	device_create_file(&client->dev, &sensor_dev_attr_in3_input.dev_attr);
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
+static int asm58_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, asm58_detect);
+}
+
+static int asm58_detach_client(struct i2c_client *client)
+{
+	struct asm58_state *state = i2c_get_clientdata(client);
+	int ret = 0;
+	if (state)
+		hwmon_device_unregister(state->class_dev);
+	if ((ret = i2c_detach_client(client)))
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
+	mutex_lock(&state->update_mtx);
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
+		for (i = 0; i < 2; i++) {
+			state->fan[i] +			    asm58_read_byte(client, ASM58_FAN_REG(i));
+			state->temp[i] +			    asm58_read_byte(client, ASM58_TEMP_REG(i));
+		}
+
+		state->last_updated = jiffies;
+		state->valid = 1;
+	}
+
+	mutex_unlock(&state->update_mtx);
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
diff -Nru linux-2.6.16/include/linux/i2c-id.h linux-2.6.16-asm58/include/linux/i2c-id.h
--- linux-2.6.16/include/linux/i2c-id.h	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.16-asm58/include/linux/i2c-id.h	2006-03-27 22:49:40.765508360 -0700
@@ -151,6 +151,7 @@
 #define I2C_DRIVERID_ASB100 1043
 #define I2C_DRIVERID_FSCHER 1046
 #define I2C_DRIVERID_W83L785TS 1047
+#define I2C_DRIVERID_ASM58 1051
 
 /*
  * ---- Adapter types ----------------------------------------------------




-------------- next part --------------
diff -Nru lm_sensors-2.10.0/CONTRIBUTORS lm_sensors-2.10.0-asm58/CONTRIBUTORS
--- lm_sensors-2.10.0/CONTRIBUTORS	2006-02-14 18:46:46.000000000 -0700
+++ lm_sensors-2.10.0-asm58/CONTRIBUTORS	2006-02-26 07:52:07.126514040 -0700
@@ -100,3 +100,6 @@
   Author of the max1619 chip driver.
 * Rudolf Marek <r.marek at sh.cvut.cz>
   Various fixes and support handling
+* Rigel Freden <rigelf at users.sf.net>
+  Author of Mozart-2 driver
+
diff -Nru lm_sensors-2.10.0/README lm_sensors-2.10.0-asm58/README
--- lm_sensors-2.10.0/README	2006-02-14 18:46:46.000000000 -0700
+++ lm_sensors-2.10.0-asm58/README	2006-02-26 07:49:41.348675640 -0700
@@ -75,7 +75,7 @@
   Analog Devices ADM1021, ADM1021A, ADM1022, ADM1023, ADM1024,
                  ADM1025, ADM1026, ADM1027, ADM1030, ADM1031,
                  ADM1032, ADM9240, ADT7461 and ADT7463
-  Asus AS99127F, ASB100 Bach
+  Asus AS99127F, ASB100 Bach, Mozart-2
   Dallas Semiconductor DS75, DS1621, DS1625, DS1775, and DS1780
   Hewlett Packard Maxilife (several revisions including '99 NBA)
   Fintek F71805F/FG
diff -Nru lm_sensors-2.10.0/doc/chips/SUMMARY lm_sensors-2.10.0-asm58/doc/chips/SUMMARY
--- lm_sensors-2.10.0/doc/chips/SUMMARY	2006-02-14 18:46:47.000000000 -0700
+++ lm_sensors-2.10.0-asm58/doc/chips/SUMMARY	2006-02-26 07:49:41.412665912 -0700
@@ -89,6 +89,10 @@
 asb100
 	asb100		4	7	3	1	yes	no
 
+asm58
+	asm58		2	4	2	-	yes	no
+	as2k129r	2	4	2	-	yes	no
+
 bmcsensors
 	bmcsensors	?	?	?	-	no	no
 
diff -Nru lm_sensors-2.10.0/doc/chips/asm58 lm_sensors-2.10.0-asm58/doc/chips/asm58
--- lm_sensors-2.10.0/doc/chips/asm58	1969-12-31 17:00:00.000000000 -0700
+++ lm_sensors-2.10.0-asm58/doc/chips/asm58	2006-02-26 07:49:41.417665152 -0700
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
diff -Nru lm_sensors-2.10.0/etc/sensors.conf.eg lm_sensors-2.10.0-asm58/etc/sensors.conf.eg
--- lm_sensors-2.10.0/etc/sensors.conf.eg	2006-02-14 18:46:47.000000000 -0700
+++ lm_sensors-2.10.0-asm58/etc/sensors.conf.eg	2006-03-28 22:40:42.462200544 -0700
@@ -2527,3 +2527,18 @@
    #set temp2_hyst  48
    #set temp3_max   50
    #set temp3_hyst  48
+
+chip "asm58-*"
+# this is the default config for the asus p4b533-vm mobo--will probably be fine
+# for any but the p4s333
+   label   temp1   "CPU Temp"
+   label   temp2   "M/B Temp"
+   label   fan1    "CPU Fan"
+   label   fan2    "Case Fan"
+   label   in0     "VCore"
+   label   in1     "V3.3"
+   label   in2     "V5.0"
+   label   in3     "V12.0"
+
+   compute in2 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
+   compute in3 ((30/10)+1)*@  ,  @/((30/10)+1)
diff -Nru lm_sensors-2.10.0/lib/chips.c lm_sensors-2.10.0-asm58/lib/chips.c
--- lm_sensors-2.10.0/lib/chips.c	2006-02-14 18:46:48.000000000 -0700
+++ lm_sensors-2.10.0-asm58/lib/chips.c	2006-02-26 07:56:25.821186472 -0700
@@ -5556,6 +5556,18 @@
 	{ 0 }
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
@@ -5656,5 +5668,6 @@
  { SENSORS_LM93_PREFIX, lm93_features },
  { SENSORS_SMSC47B397_PREFIX, smsc47b397_features },
  { SENSORS_F71805F_PREFIX, f71805f_features },
+ { SENSORS_ASM58_PREFIX, asm58_features},
  { 0 }
 };
diff -Nru lm_sensors-2.10.0/lib/chips.h lm_sensors-2.10.0-asm58/lib/chips.h
--- lm_sensors-2.10.0/lib/chips.h	2006-02-14 18:46:48.000000000 -0700
+++ lm_sensors-2.10.0-asm58/lib/chips.h	2006-03-29 20:19:24.648227680 -0700
@@ -2105,4 +2105,17 @@
 #define SENSORS_F71805F_ALARMS_FAN	201
 #define SENSORS_F71805F_ALARMS_TEMP	202
 
+
+/* asus mozart-2 all values read only */
+
+#define SENSORS_ASM58_PREFIX 		"asm58"
+#define SENSORS_ASM58_TEMP1		1
+#define SENSORS_ASM58_TEMP2		2
+#define SENSORS_ASM58_FAN1		3
+#define SENSORS_ASM58_FAN2		4
+#define SENSORS_ASM58_IN0		5
+#define SENSORS_ASM58_IN1		6
+#define SENSORS_ASM58_IN2		7
+#define SENSORS_ASM58_IN3   		8
+
 #endif /* def LIB_SENSORS_CHIPS_H */
diff -Nru lm_sensors-2.10.0/prog/detect/sensors-detect lm_sensors-2.10.0-asm58/prog/detect/sensors-detect
--- lm_sensors-2.10.0/prog/detect/sensors-detect	2006-02-14 18:46:49.000000000 -0700
+++ lm_sensors-2.10.0-asm58/prog/detect/sensors-detect	2006-02-26 07:49:41.671626544 -0700
@@ -1108,19 +1108,19 @@
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
diff -Nru lm_sensors-2.10.0/prog/sensors/chips.c lm_sensors-2.10.0-asm58/prog/sensors/chips.c
--- lm_sensors-2.10.0/prog/sensors/chips.c	2006-02-14 18:46:49.000000000 -0700
+++ lm_sensors-2.10.0-asm58/prog/sensors/chips.c	2006-03-29 20:25:41.320964720 -0700
@@ -5851,6 +5851,57 @@
   }
 }
 
+void print_asm58(const sensors_chip_name *name)
+{
+  double value;
+  char *label;
+  int valid;
+  int i;
+
+  for(i = 0; i < 2; i++) {
+    if(!sensors_get_label_and_valid(*name, SENSORS_ASM58_TEMP1 + i, &label, 
+	&valid) &&
+       !sensors_get_feature(*name, SENSORS_ASM58_TEMP1 + i, &value)) {
+      if(valid) {
+	print_label(label, 10);
+	print_temp_info(value, 0, 0, SINGLE, 0, 0);
+	printf("\n");
+      }
+    }
+    else
+      printf("ERROR: Can't get TEMP%d data!\n",i+1);
+    free(label);
+  }
+
+  for(i = 0; i < 2; i++) {
+    if(!sensors_get_label_and_valid(*name, SENSORS_ASM58_FAN1 + i, 
+	&label, &valid) &&
+       !sensors_get_feature(*name, SENSORS_ASM58_FAN1 + i, &value)) {
+      if(valid) {
+	print_label(label, 10);
+	printf("%4.0f RPM\n", value);
+      }
+    }
+    else
+      printf("ERROR: Can't get FAN%d data!\n", i + 1);
+    free(label);
+  }
+
+  for(i = 0; i < 4; i++) {
+    if(!sensors_get_label_and_valid(*name, SENSORS_ASM58_IN0 + i,
+	&label, &valid) &&
+       !sensors_get_feature(*name, SENSORS_ASM58_IN0 + i, &value)) {
+      if(valid) {
+	print_label(label, 10);
+	printf("%+6.2f V\n", value);
+      }
+    }
+    else
+      printf("ERROR: Can't get IN%d data!\n", i);
+    free(label);
+  }
+}
+
 void print_unknown_chip(const sensors_chip_name *name)
 {
   int a,b,valid;
@@ -5879,4 +5930,3 @@
       printf("(%s)\n",label);
   }
 }
-
diff -Nru lm_sensors-2.10.0/prog/sensors/chips.h lm_sensors-2.10.0-asm58/prog/sensors/chips.h
--- lm_sensors-2.10.0/prog/sensors/chips.h	2006-02-14 18:46:49.000000000 -0700
+++ lm_sensors-2.10.0-asm58/prog/sensors/chips.h	2006-02-26 07:57:31.137256920 -0700
@@ -71,5 +71,6 @@
 extern void print_adm1031(const sensors_chip_name *name);
 extern void print_smsc47b397(const sensors_chip_name *name);
 extern void print_f71805f(const sensors_chip_name *name);
+extern void print_asm58(const sensors_chip_name *name);
 
 #endif /* def PROG_SENSORS_CHIPS_H */
diff -Nru lm_sensors-2.10.0/prog/sensors/main.c lm_sensors-2.10.0-asm58/prog/sensors/main.c
--- lm_sensors-2.10.0/prog/sensors/main.c	2006-02-14 18:46:49.000000000 -0700
+++ lm_sensors-2.10.0-asm58/prog/sensors/main.c	2006-02-26 08:00:20.676483040 -0700
@@ -414,6 +414,7 @@
 	{ "lm93", print_lm93 },
 	{ "smsc47b397", print_smsc47b397 },
 	{ "f71805f", print_f71805f },
+	{ "asm58", print_asm58},
 	{ NULL, NULL }
 };
 




