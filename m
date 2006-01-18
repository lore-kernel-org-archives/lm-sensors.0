From: rigelf@gmail.com (Rigel Freden)
Date: Wed, 18 Jan 2006 22:45:03 +0000
Subject: [lm-sensors] initial draft for asus mozart-2 chip kernel module
Message-Id: <9328bcc00601181445v2e6e2400x48eea8e92b5f6108@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i have completed a module for the asus mozart-2 (asm58 and as2k129r)
based mostly on the xmbmon project code for this chip, and related
existing kernel modules.  there are probably features of the chip i am
ignorant of.  if anyone is interested, please flame me for egregious
bugs (look at the fan divisor register auto update if you need
something to hate).  also, if anyone has the prerequisite hardware i'd
love to hear it worked, or failing that, how it ruined your entire
life or whatever ^^
cheers,
Rigel Freden
-------------- next part --------------
diff -Nru linux-2.6.14-gentoo-r5/drivers/hwmon/Kconfig linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/Kconfig
--- linux-2.6.14-gentoo-r5/drivers/hwmon/Kconfig	2006-01-18 12:42:38.000000000 -0700
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
--- linux-2.6.14-gentoo-r5/drivers/hwmon/Makefile	2006-01-18 12:42:38.000000000 -0700
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
+++ linux-2.6.14-gentoo-r5-asm58/drivers/hwmon/asm58.c	2006-01-18 11:36:42.585171112 -0700
@@ -0,0 +1,391 @@
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
+static ssize_t show_fan1(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n",
+		       ASM58_FAN_FROM_REG(state->fan[0],
+					  ASM58_FANDIV_FROM_REG(state->
+								fan_div[0])));
+}
+
+static ssize_t show_fan2(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct asm58_state *state = asm58_update_device(dev);
+	return sprintf(buf, "%d\n",
+		       ASM58_FAN_FROM_REG(state->fan[1],
+					  ASM58_FANDIV_FROM_REG(state->
+								fan_div[1])));
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
+	if (chipid = 0x56 && subtype = 0x94 && vendid = 0x36) {
+		client_name = "ASM58 Mozart-2";
+	} else if ((chipid = 0x56 && subtype = 0x94 && vendid = 0x06) ||
+		   (chipid = 0x10 && subtype = 0x5c && vendid = 0xa3)) {
+		client_name = "AS2K129R Mozart-2";
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
+		i = 0;
+		while (i < 2) {
+			if ((state->fan[i] +			     asm58_read_byte(client, ASM58_FAN_REG(i))) = 0xff)
+			{
+				if (state->fan_div[i] < 3)
+					++(state->fan_div[i]);
+				else
+					state->fan_div[i] = 0;
+				asm58_write_byte(client, ASM58_FANDIV_REG,
+						 (fandivreg & 0x0F) |
+						 ((state->
+						   fan_div[0] & 0x03) << 4) |
+						 ((state->
+						   fan_div[1] & 0x03) << 6));
+			}
+			i++;
+		}
+		for (i = 0; i < 2; i++)
+
+			for (i = 0; i < 2; i++)
+				state->temp[i] +				    asm58_read_byte(client, ASM58_TEMP_REG(i));
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
--- linux-2.6.14-gentoo-r5/include/linux/i2c-id.h	2006-01-18 12:42:38.000000000 -0700
+++ linux-2.6.14-gentoo-r5-asm58/include/linux/i2c-id.h	2006-01-18 11:37:54.700207960 -0700
@@ -157,6 +157,7 @@
 #define I2C_DRIVERID_FSCHER 1046
 #define I2C_DRIVERID_W83L785TS 1047
 #define I2C_DRIVERID_SMSC47B397 1050
+#define I2C_DRIVERID_ASMOZART2 1051
 
 /*
  * ---- Adapter types ----------------------------------------------------
