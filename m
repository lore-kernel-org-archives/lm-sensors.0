From: roger@planbit.co.uk (Roger Lucas)
Date: Tue, 01 Nov 2005 19:41:36 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <20051101184045.6AB0F12E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Retry... Hopefully Outlook will attach it as text since it now has a .TXT
extension...

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Roger Lucas
Sent: 01 November 2005 18:20
To: 'LM Sensors'
Subject: RE: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE
2.6

Attached is the updated patch file for the vt8231 with kernel 2.6.14.

I believe that this has all the corrections requested by Jean in his mail
below. Thanks for reviewing it, Jean, your quick response was appreciated. 

It insmod's, runs and rmmod's OK on my Via Epia 5000 box, but it needs
testing on a wider range of machines if possible...

- Roger

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 01 November 2005 17:27
To: Roger Lucas
Cc: Rudolf Marek; LM Sensors
Subject: Re: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE
2.6

Hi Roger,

Please answer to the list rather than to me only.

> I have a patch for the vt8231 driver now (attached).  It seems OK but I
get
> a compilation warning:
> 
> drivers/hwmon/vt8231.c:63: warning: `addr_data' defined but not used
> 
> This is generated because I am using the macro
"I2C_CLIENT_INSMOD_1(vt8231)"
> to register the module, but then never use the addr_data structure that is
> created by it.
> 
> I cannot see a reason to use this structure, so I suppose I should be
using
> a different macro to register the driver...  Any thoughts ?

Don't use I2C_CLIENT_INSMOD_1. The VT8231 is not an I2C chip. It is
attached to the i2c subsystem for historical reasons, but we are trying
to separate such chips from the i2c subsystem now.

A few additional comments about your code:

> +config SENSORS_VT8231
> +	tristate "VT8231"
> +	depends on HWMON && I2C && PCI

You should make it depend on EXPERIMENTAL too.

> +/* Supports VIA VT8231 South Bridge embedded sensors 
> +**
> +** Change log:
> +**
> +**  2005-11-01: Roger Lucas (roger@planbit.co.uk)
> +**     Updated to work with the 2.6.14 kernel that I have.  This is the
first
> +**     lm-sensors port that I have done, so there may be nasty mistakes
in it.
> +**     That having been said, insmod and rmmod seem to work cleanly on my

> +**	   system and the values reported are reasonable.
> +**     I merged the Aaron Marsh vt8231 port with the most recent via686a
driver 
> +**     in the 2.6.14 kernel source to create this code.
> +**     VRM doesn't work on the Via Epia 5000 that I have as the kernel
call
> +**	   vid_which_vrm() returns -1.  Apparently the Via CPU is
unrecognised....
> +*/

Changelog doesn't belong to the code. You can add whatever comment you
want at the top of the patch, and it'll be used in the git commit.

The vid_which_vrm issue is interesting. Rudolf, can you please look
into it?

> +static int force_addr = 0;

Do not explicitely intialize static globals to 0, the compiler does it
for you.

> +MODULE_PARM(force_addr, "i");

Please use module_param instead. MODULE_PARM is deprecated.

> +static unsigned short normal_i2c[] = { I2C_CLIENT_END };

You shouldn't need this one.

> +static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);

S_IWUSR is not correct, that file is read-only.

> +static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);

This attribute has been renamed to cpu0_vid.

> +        struct vt8231_data *data = vt8231_update_device(dev);

Indentation issue, you use spaces instead of a tab. Same in other
places, please fix them all.

> +	return sprintf(buf,"%ld\n", (long)data->vrm);

Please use a space after the comma. Same in other places, please fix
them all.

> +	printk("Setting VRM to \"%s\" = %d\n", buf, val );

No space before closing parenthesis.

> +	if (!request_region(isa_address, VT8231_EXTENT, "vt8231-sensors")) {

Please use the driver name to request the region.

> +	if (!(data = kmalloc(sizeof(struct vt8231_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit_release;
> +	}
> +
> +	memset(data, 0, sizeof(struct vt8231_data));

Please use kzalloc instead of kmalloc + memset.

> +	snprintf(new_client->name, I2C_NAME_SIZE, type_name);

strlcpy will do the same, more efficiently.

> +	/* TODO: vid and vrm */
> +       	device_create_file(&new_client->dev, &dev_attr_in0_ref);
> +	device_create_file(&new_client->dev, &dev_attr_vrm);

Bad indentation. Why this "TODO" comment?

This was only a quick and partial review, I've been reviewing too much
code today already, I'll go mad if I do more.

One last general comment: please cut long lines so that the code fits
in 80 columns.

Thanks,
-- 
Jean Delvare
-------------- next part --------------
diff -Naur reference/drivers/hwmon/Kconfig linux-2.6.14/drivers/hwmon/Kconfig
--- reference/drivers/hwmon/Kconfig	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/hwmon/Kconfig	2005-11-01 17:35:18.000000000 +0000
@@ -350,6 +350,18 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called via686a.
 
+config SENSORS_VT8231
+	tristate "VT8231"
+	depends on HWMON && I2C && PCI && EXPERIMENTAL
+	select HWMON_VID
+	select I2C_ISA
+	help
+	  If you say yes here then you get support for the integrated sensors
+	  in the Via VT8231 device.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called vt8231.
+
 config SENSORS_W83781D
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on HWMON && I2C
diff -Naur reference/drivers/hwmon/Makefile linux-2.6.14/drivers/hwmon/Makefile
--- reference/drivers/hwmon/Makefile	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/hwmon/Makefile	2005-11-01 10:59:10.000000000 +0000
@@ -40,6 +40,7 @@
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
+obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
diff -Naur reference/drivers/hwmon/vt8231.c linux-2.6.14/drivers/hwmon/vt8231.c
--- reference/drivers/hwmon/vt8231.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14/drivers/hwmon/vt8231.c	2005-11-01 18:06:17.000000000 +0000
@@ -0,0 +1,785 @@
+/*
+	vt8231.c - Part of lm_sensors, Linux kernel modules
+				for hardware monitoring
+				
+	Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+			   Aaron M. Marsh <amarsh@sdf.lonestar.org>
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful, 
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/* Supports VIA VT8231 South Bridge embedded sensors 
+*/
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/i2c-isa.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+static int force_addr;
+module_param(force_addr, int,0644);
+MODULE_PARM_DESC(force_addr, "Initialize the base address of the sensors");
+
+/* Device address
+   Note that we can't determine the ISA address until we have initialized
+   our module */
+static unsigned short isa_address;
+
+#define VT8231_EXTENT 0x80
+#define VT8231_BASE_REG 0x70
+#define VT8231_ENABLE_REG 0x74
+
+/* pwm numbered 1-2 */
+#define VT8231_REG_PWM(nr) (0x5f + (nr))
+#define VT8231_REG_PWM_CTL 0x51
+
+/* The VT8231 registers */
+/* We define the sensors as follows. Somewhat convoluted to minimize
+   changes from via686a.
+	Sensor		Voltage Mode	Temp Mode
+	--------	------------	---------
+	Reading 1			temp3
+	Reading 3			temp1	not in vt8231
+	UCH1/Reading2	in0		temp2
+	UCH2		in1		temp4
+	UCH3		in2		temp5
+	UCH4		in3		temp6
+	UCH5		in4		temp7
+	3.3V		in5
+	-12V		in6			not in vt8231
+*/
+
+/* ins numbered 0-6 */
+#define VT8231_REG_IN_MAX(nr) ((nr)=0 ? 0x3d : 0x29 + ((nr) * 2))
+#define VT8231_REG_IN_MIN(nr) ((nr)=0 ? 0x3e : 0x2a + ((nr) * 2))
+#define VT8231_REG_IN(nr)	 (0x21 + (nr))
+
+/* fans numbered 1-2 */
+#define VT8231_REG_FAN_MIN(nr) (0x3a + (nr))
+#define VT8231_REG_FAN(nr)	 (0x28 + (nr))
+
+static const u8 regtemp[] = { 0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25 };
+static const u8 regover[] = { 0x39, 0x3d, 0x1d, 0x2b, 0x2d, 0x2f, 0x31 };
+static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e, 0x2c, 0x2e, 0x30, 0x32 };
+
+/* temps numbered 1-7 */
+#define VT8231_REG_TEMP(nr)		(regtemp[(nr) - 1])
+#define VT8231_REG_TEMP_OVER(nr)	(regover[(nr) - 1])
+#define VT8231_REG_TEMP_HYST(nr)	(reghyst[(nr) - 1])
+#define VT8231_REG_TEMP_LOW3	0x4b	/* bits 7-6 */
+#define VT8231_REG_TEMP_LOW2	0x49	/* bits 5-4 */
+#define VT8231_REG_TEMP_LOW47	0x4d
+
+#define VT8231_REG_CONFIG 0x40
+#define VT8231_REG_ALARM1 0x41
+#define VT8231_REG_ALARM2 0x42
+#define VT8231_REG_VID	0x45
+#define VT8231_REG_FANDIV 0x47
+#define VT8231_REG_UCH_CONFIG 0x4a
+#define VT8231_REG_TEMP1_CONFIG 0x4b
+#define VT8231_REG_TEMP2_CONFIG 0x4c
+
+/* temps 1-7; voltages 0-6 */
+#define ISTEMP(i, ch_config) ((i) = 1 ? 1 : \
+		  (i) = 3 ? 1 : \
+		  (i) = 2 ? ((ch_config) >> 1) & 0x01 : \
+					 ((ch_config) >> ((i)-1)) & 0x01)
+#define ISVOLT(i, ch_config) ((i) > 4 ? 1 : !(((ch_config) >> ((i)+2)) & 0x01))
+
+#define ALARMS_FROM_REG(val) (val)
+
+#define DIV_FROM_REG(val) (1 << (val))
+#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
+#define PWM_FROM_REG(val) (val)
+#define PWM_TO_REG(val) SENSORS_LIMIT((val), 0, 255)
+
+#define TEMP_FROM_REG(val) (long)((val)*10)
+#define TEMP_FROM_REG10(val) (long)(((val)*10)/4)
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
+			 ((val)+5)/10), 0, 255))
+#define IN_FROM_REG(val) ((long)(val))
+#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 5)/10), 0, 255))
+
+
+/********* FAN RPM CONVERSIONS ********/
+/* But this chip saturates back at 0, not at 255 like all the other chips.
+   So, 0 means 0 RPM */
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm = 0)
+		return 0;						
+	rpm = SENSORS_LIMIT(rpm, 1, 1000000);   
+	return SENSORS_LIMIT((1310720 + rpm * div / 2) / (rpm * div), 1, 255);
+}
+
+#define MIN_TO_REG(a, b) FAN_TO_REG(a, b)
+#define FAN_FROM_REG(val, div) ((val)=0?0:(val)=255?0:1310720/((val)*(div)))
+
+struct vt8231_data {
+	struct i2c_client client;
+	struct semaphore update_lock;
+	struct class_device *class_dev;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u8 in[7];		/* Register value */
+	u8 in_max[7];		/* Register value */
+	u8 in_min[7];		/* Register value */
+	u16 temp[7];		/* Register value 10 bit */
+	u8 temp_over[7];	/* Register value */
+	u8 temp_hyst[7];	/* Register value */
+	u8 fan[2];		/* Register value */
+	u8 fan_min[2];		/* Register value */
+	u8 fan_div[2];		/* Register encoding, shifted right */
+	u16 alarms;		/* Register encoding */
+	u8 pwm[2];		/* Register value */
+	u8 pwm_ctl;		/* Register value */
+	u8 cpu0_vid;		/* Register encoding */
+	u8 vrm;
+	u8 uch_config;
+};
+
+static struct pci_dev *s_bridge;
+static int vt8231_detect(struct i2c_adapter *adapter);
+static int vt8231_detach_client(struct i2c_client *client);
+
+static inline int vt8231_read_value(struct i2c_client *client, u8 reg)
+{
+	return (inb_p(client->addr + reg));
+}
+
+static inline void vt8231_write_value(struct i2c_client *client, u8 reg, 
+					u8 value)
+{
+	outb_p(value, client->addr + reg);
+}
+
+static struct vt8231_data *vt8231_update_device(struct device *dev);
+static void vt8231_init_client(struct i2c_client *client);
+
+/* following are the sysfs callback functions */
+static ssize_t show_in(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr]));
+}
+
+static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr]));
+}
+
+static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr]));
+}
+
+static ssize_t set_in_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	data->in_min[nr] = IN_TO_REG(val);
+	vt8231_write_value(client, VT8231_REG_IN_MIN(nr), 
+			data->in_min[nr]);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	data->in_max[nr] = IN_TO_REG(val);
+	vt8231_write_value(client, VT8231_REG_IN_MAX(nr), 
+			data->in_max[nr]);
+	return count;
+}
+
+#define show_in_offset(offset)					\
+static ssize_t show_in##offset (struct device *dev, 		\
+	struct device_attribute *attr, char *buf)		\
+{								\
+	return show_in(dev, buf, offset);			\
+}								\
+static ssize_t show_in##offset##_min (struct device *dev,	\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_in_min(dev, buf, offset);			\
+}								\
+static ssize_t show_in##offset##_max (struct device *dev,	\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_in_max(dev, buf, offset);			\
+}								\
+static ssize_t set_in##offset##_min (struct device *dev, 	\
+		struct device_attribute *attr,	  		\
+		const char *buf, size_t count)			\
+{								\
+	return set_in_min(dev, buf, count, offset);		\
+}								\
+static ssize_t set_in##offset##_max (struct device *dev, 	\
+			struct device_attribute *attr,	 	\
+			const char *buf, size_t count)		\
+{								\
+	return set_in_max(dev, buf, count, offset);		\
+}								\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);\
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	  	\
+		show_in##offset##_min, set_in##offset##_min);	\
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	  	\
+		show_in##offset##_max, set_in##offset##_max);
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+show_in_offset(5);
+
+/* 3 temperatures */
+static ssize_t show_temp(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr]));
+}
+static ssize_t show_temp_over(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr]));
+}
+static ssize_t show_temp_hyst(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr]));
+}
+static ssize_t set_temp_over(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->temp_over[nr] = TEMP_TO_REG(val);
+	vt8231_write_value(client, VT8231_REG_TEMP_OVER(nr), 
+			data->temp_over[nr]);
+	return count;
+}
+static ssize_t set_temp_hyst(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->temp_hyst[nr] = TEMP_TO_REG(val);
+	vt8231_write_value(client, VT8231_REG_TEMP_HYST(nr), 
+			data->temp_hyst[nr]);
+	return count;
+}
+#define show_temp_offset(offset)					\
+static ssize_t show_temp_##offset (struct device *dev, 			\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	return show_temp(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_temp_##offset##_over (struct device *dev, 		\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	return show_temp_over(dev, buf, offset - 1);			\
+}									\
+static ssize_t show_temp_##offset##_hyst (struct device *dev, 		\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	return show_temp_hyst(dev, buf, offset - 1);			\
+}									\
+static ssize_t set_temp_##offset##_over (struct device *dev, 		\
+			struct device_attribute *attr,		  	\
+			const char *buf, size_t count)			\
+{									\
+	return set_temp_over(dev, buf, count, offset - 1);		\
+}									\
+static ssize_t set_temp_##offset##_hyst (struct device *dev, 		\
+			struct device_attribute *attr,		  	\
+			const char *buf, size_t count)			\
+{									\
+	return set_temp_hyst(dev, buf, count, offset - 1);		\
+}									\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);\
+static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,		\
+		show_temp_##offset##_over, set_temp_##offset##_over);	\
+static DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR,		\
+		show_temp_##offset##_hyst, set_temp_##offset##_hyst);
+
+
+/* show_temp_offset(1); */
+show_temp_offset(2);
+show_temp_offset(3);
+show_temp_offset(4);
+show_temp_offset(5);
+show_temp_offset(6);
+show_temp_offset(7);
+
+/* 2 Fans */
+static ssize_t show_fan(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr], 
+				DIV_FROM_REG(data->fan_div[nr])));
+}
+static ssize_t show_fan_min(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", 
+		FAN_FROM_REG(data->fan_min[nr], 
+			DIV_FROM_REG(data->fan_div[nr])));
+}
+static ssize_t show_fan_div(struct device *dev, char *buf, int nr) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
+}
+static ssize_t set_fan_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	return count;
+}
+static ssize_t set_fan_div(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	int old = vt8231_read_value(client, VT8231_REG_FANDIV);
+	data->fan_div[nr] = DIV_TO_REG(val);
+	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
+	vt8231_write_value(client, VT8231_REG_FANDIV, old);
+	return count;
+}
+
+#define show_fan_offset(offset)						\
+static ssize_t show_fan_##offset (struct device *dev, 			\
+				struct device_attribute *attr, char *buf) \
+{									\
+	return show_fan(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_fan_##offset##_min (struct device *dev, 		\
+				struct device_attribute *attr, char *buf) \
+{									\
+	return show_fan_min(dev, buf, offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_div (struct device *dev, 		\
+				struct device_attribute *attr, char *buf) \
+{									\
+	return show_fan_div(dev, buf, offset - 1);			\
+}									\
+static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+				struct device_attribute *attr,		\
+				const char *buf, size_t count)		\
+{									\
+	return set_fan_min(dev, buf, count, offset - 1);		\
+}									\
+static ssize_t set_fan_##offset##_div (struct device *dev, 		\
+				struct device_attribute *attr,		\
+				const char *buf, size_t count)		\
+{									\
+	return set_fan_div(dev, buf, count, offset - 1);		\
+}									\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_fan_##offset##_min, set_fan_##offset##_min);	\
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
+		show_fan_##offset##_div, set_fan_##offset##_div);
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, 
+			char *buf) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+}
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+
+/**** VRM and VID *****/
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, 
+			char *buf) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", (long)vid_from_reg(data->cpu0_vid, data->vrm)); 
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, 
+			char *buf) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%ld\n", (long)data->vrm);
+}
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, 
+			const char *buf, size_t count) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	printk("Setting VRM to \"%s\" = %d\n", buf, val);
+	data->vrm = val;
+	return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+
+static struct i2c_driver vt8231_driver = {
+	.owner		= THIS_MODULE, 
+	.name		= "vt8231", 
+	.id		= I2C_DRIVERID_VT8231, 
+	.flags		= I2C_DF_NOTIFY, 
+	.attach_adapter	= vt8231_detect, 
+	.detach_client	= vt8231_detach_client, 
+};
+
+int vt8231_detect(struct i2c_adapter *adapter)
+{
+	struct i2c_client *new_client;
+	struct vt8231_data *data;
+	int err = 0;
+	const char type_name[] = "vt8231";
+	u16 val;
+
+	/* 8231 requires multiple of 256 */
+	if (force_addr)
+		isa_address = force_addr & 0xFF00;
+
+	if (force_addr) {
+		dev_warn(&adapter->dev, "forcing ISA address 0x%04X\n", 
+				 isa_address);
+		if (PCIBIOS_SUCCESSFUL != pci_write_config_word(s_bridge, 
+						VT8231_BASE_REG, isa_address))
+			return -ENODEV;
+	}
+	if (PCIBIOS_SUCCESSFUL !+		pci_read_config_word(s_bridge, VT8231_ENABLE_REG, &val))
+		return -ENODEV;
+	if (!(val & 0x0001)) {
+		dev_warn(&adapter->dev, "enabling sensors\n");
+		if (PCIBIOS_SUCCESSFUL !+			pci_write_config_word(s_bridge, VT8231_ENABLE_REG, 
+							  val | 0x0001))
+			return -ENODEV;
+	}
+
+	/* Reserve the ISA region */
+	if (!request_region(isa_address, VT8231_EXTENT, type_name)) {
+		dev_err(&adapter->dev, "region 0x%x already in use!\n", 
+			   isa_address);
+		return -ENODEV;
+	}
+
+	if (!(data = kzalloc(sizeof(struct vt8231_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_release;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = isa_address;
+	new_client->adapter = adapter;
+	new_client->driver = &vt8231_driver;
+	new_client->flags = 0;
+	new_client->dev.parent = &adapter->dev;
+
+	/* Fill in the remaining client fields and put into the global list */
+	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
+
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	vt8231_init_client(new_client);
+
+	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in5_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in5_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_in5_max);
+
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp3_input);
+	device_create_file(&new_client->dev, &dev_attr_temp4_input);
+	device_create_file(&new_client->dev, &dev_attr_temp5_input);
+	device_create_file(&new_client->dev, &dev_attr_temp6_input);
+	device_create_file(&new_client->dev, &dev_attr_temp7_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max);
+	device_create_file(&new_client->dev, &dev_attr_temp4_max);
+	device_create_file(&new_client->dev, &dev_attr_temp5_max);
+	device_create_file(&new_client->dev, &dev_attr_temp6_max);
+	device_create_file(&new_client->dev, &dev_attr_temp7_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp4_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp5_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp6_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp7_max_hyst);
+
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
+	device_create_file(&new_client->dev, &dev_attr_vrm);
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(new_client);
+exit_free:
+	kfree(data);
+exit_release:
+	release_region(isa_address, VT8231_EXTENT);
+	return err;
+}
+
+static int vt8231_detach_client(struct i2c_client *client)
+{
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->class_dev);
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, 
+		   "Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	release_region(client->addr, VT8231_EXTENT);
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static void vt8231_init_client(struct i2c_client *client)
+{
+	struct vt8231_data *data = i2c_get_clientdata(client);
+
+	data->vrm = vid_which_vrm();
+
+	/* set "default" interrupt mode for alarms, which isn't the default */
+	vt8231_write_value(client, VT8231_REG_TEMP1_CONFIG, 0);
+	vt8231_write_value(client, VT8231_REG_TEMP2_CONFIG, 0);
+}
+
+static struct vt8231_data *vt8231_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int i, j;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+		(jiffies < data->last_updated) || !data->valid) {
+		data->uch_config = vt8231_read_value(client, 
+						VT8231_REG_UCH_CONFIG);
+		for (i = 0; i <= 5; i++) {
+			if(ISVOLT(i, data->uch_config)) {
+				data->in[i] = vt8231_read_value(client, 
+							VT8231_REG_IN(i));
+				data->in_min[i] = vt8231_read_value(client, 
+							VT8231_REG_IN_MIN(i));
+				data->in_max[i] = vt8231_read_value(client, 
+							VT8231_REG_IN_MAX(i));
+			} else {
+				data->in[i] = 0;
+				data->in_min[i] = 0;
+				data->in_max[i] = 0;
+			}
+		}
+		for (i = 1; i <= 2; i++) {
+			data->fan[i - 1] = vt8231_read_value(client, 
+							VT8231_REG_FAN(i));
+			data->fan_min[i - 1] = vt8231_read_value(client, 
+							VT8231_REG_FAN_MIN(i));
+		}
+		for (i = 2; i <= 7; i++) {
+			if(ISTEMP(i, data->uch_config)) {
+				data->temp[i - 1] = vt8231_read_value(client, 
+						       VT8231_REG_TEMP(i)) << 2;
+				switch(i) {
+					case 1:
+						/* ? */
+						j = 0;
+						break;
+					case 2:
+						j = (vt8231_read_value(client, 
+							VT8231_REG_TEMP_LOW2) &
+							0x30) >> 4;
+						break;
+					case 3:
+						j = (vt8231_read_value(client, 
+							VT8231_REG_TEMP_LOW3) &
+							0xc0) >> 6;
+						break;
+					case 4:
+					case 5:
+					case 6:
+					case 7:
+					default:
+						j = (vt8231_read_value(client, 
+						  	VT8231_REG_TEMP_LOW47)
+							 >> ((i-4)*2)) & 0x03;	
+						break;
+	
+				}
+				data->temp[i - 1] |= j;
+				data->temp_over[i - 1] = 
+					vt8231_read_value(client, 
+						VT8231_REG_TEMP_OVER(i));
+				data->temp_hyst[i - 1] = 
+					vt8231_read_value(client, 
+						VT8231_REG_TEMP_HYST(i));
+			} else {
+				data->temp[i - 1] = 0;
+				data->temp_over[i - 1] = 0;
+				data->temp_hyst[i - 1] = 0;
+			}
+		}
+
+		for (i = 1; i <= 2; i++) {
+			data->fan[i - 1] = vt8231_read_value(client, 
+						VT8231_REG_FAN(i));
+			data->fan_min[i - 1] = vt8231_read_value(client, 
+						VT8231_REG_FAN_MIN(i));
+			data->pwm[i - 1] = vt8231_read_value(client, 
+						VT8231_REG_PWM(i));
+		}
+
+		data->pwm_ctl = vt8231_read_value(client, VT8231_REG_PWM_CTL);
+		i = vt8231_read_value(client, VT8231_REG_FANDIV);
+		data->fan_div[0] = (i >> 4) & 0x03;
+		data->fan_div[1] = i >> 6;
+		data->alarms = vt8231_read_value(client, VT8231_REG_ALARM1) |
+			(vt8231_read_value(client, VT8231_REG_ALARM2) << 8);
+		data->cpu0_vid= vt8231_read_value(client, VT8231_REG_VID) 
+					& 0x1f;
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+
+	return data;
+}
+
+static struct pci_device_id vt8231_pci_ids[] = {
+	{
+		.vendor		 = PCI_VENDOR_ID_VIA, 
+		.device		 = PCI_DEVICE_ID_VIA_8231_4, 
+		.subvendor	= PCI_ANY_ID, 
+		.subdevice	= PCI_ANY_ID, 
+	}, 
+	{ 0, }
+};
+
+static int __devinit vt8231_pci_probe(struct pci_dev *dev, 
+				const struct pci_device_id *id)
+{
+	u16 val;
+	
+	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_BASE_REG, 
+							&val))
+		return -ENODEV;
+	
+	isa_address = val & ~(VT8231_EXTENT - 1);
+	if (isa_address = 0 && force_addr = 0) {
+		dev_err(&dev->dev, "base address not set -\
+				 upgrade BIOS or use force_addr=0xaddr\n");
+		return -ENODEV;
+	}
+	if (force_addr)
+		isa_address = force_addr; /* so detect will get called */
+	
+	if (!isa_address) {
+		dev_err(&dev->dev, "No Via 8231 sensors found.\n");
+		return -ENODEV;
+	}
+	s_bridge = pci_dev_get(dev);
+	
+	if (i2c_isa_add_driver(&vt8231_driver)) {
+		pci_dev_put(s_bridge);
+		s_bridge = NULL;
+	}
+	
+	/* Always return failure here.  This is to allow other drivers to bind
+	* to this pci device.  We don't really want to have control over the
+	* pci device, we only wanted to read as few register values from it.
+	*/
+	return -ENODEV;
+}
+
+static struct pci_driver vt8231_pci_driver = {
+	.name		= "vt8231", 
+	.id_table	= vt8231_pci_ids, 
+	.probe		= vt8231_pci_probe, 
+};
+
+
+static int __init sm_vt8231_init(void)
+{
+	return pci_module_init(&vt8231_pci_driver);
+}
+
+static void __exit sm_vt8231_exit(void)
+{
+	pci_unregister_driver(&vt8231_pci_driver);
+	if (s_bridge != NULL) {
+		i2c_isa_del_driver(&vt8231_driver);
+		pci_dev_put(s_bridge);
+		s_bridge = NULL;
+	}
+}
+
+
+MODULE_AUTHOR("Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("VT8231 sensors");
+MODULE_LICENSE("GPL");
+
+module_init(sm_vt8231_init);
+module_exit(sm_vt8231_exit);
