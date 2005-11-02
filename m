From: roger@planbit.co.uk (Roger Lucas)
Date: Wed, 02 Nov 2005 15:17:46 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051102141658.BC2D912E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Updated patch attached.  I love it when you inherit loads of code that you
end up fixing... :-)

I am not so sure I am very keen on the intelligence for the auto-div
calculation moving into the driver.  I think this code should be in the
sensors utility.

On the other hand, however, the way the DIV_TO_REG() function was coded, it
would be almost impossible for any application to determine the legal values
for DIV without knowing the details of the device.  Any illegal value would
end up with DIV set at zero - not very helpful.  As an alternative, this
attached patch includes a code revision that sets DIV to the smallest legal
DIV value that is the same as or larger than the requested DIV value.
Hence, the mapping is as below:

	Requested DIV   Set DIV
		1		1
		2		2
		3		4
		4		4
		5		8
		6		8
		7		8
		8		8
		8+		8

From this sequence, the DIV returned is predictable and an application can
very quickly determine the legal DIV values and make its calculations
accordingly.  

With this revised code, if you ask for a low limit 1000 RPM with a divisor
of 4, you get a low limit of 1285 RPM returned.  If you ask for a low limit
of 1000 RPM with a divisor of 5 then you get a low limit of 999 RPM returned
with a divisor of 8.

Consider the pseudo-code below:

set_div = 1;
set_rpm_div(set_div);
set_low_limit_rpm(requested_limit_rpm);

while( get_low_limit_rpm() > requested_limit_rpm )
{
	true_div = get_rpm_div();
	if (set_div > true_div)
	{
		break; // we have exceeded the DIV range
	}
	// Try next div value
	set_div = true_div + 1;
	set_rpm_div(set_div);
	set_low_limit_rpm(requested_limit_rpm);
}


This will iterate through the valid DIV values and stop when it reaches the
best RPM match or the highest valid DIV setting.

I feel that this should be up in the application, however, and not in the
driver.  IMHO, the drivers should be a simple as possible.

- Roger


-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 02 November 2005 13:12
To: roger@planbit.co.uk
Cc: 'LM Sensors'; Knut Petersen
Subject: [lm-sensors] RE: vt8231.c


Hi Roger,

On 2005-11-2, Roger Lucas wrote:
> The fan is handled correctly, but you have the nasty condition where if
> you set a minimum speed that is too low, it is set to zero.  The Via
> speed sensor works on period rather than frequency, so there is a 1/x
> conversion done in the driver.

Note that this is pretty standard, almost all fan tachometers work that
way. The only drivers which do not have to invert the register value are
the FSC ones if I remember correctly.

> If you select a frequency that is too low, then the conversion to a
> period creates a period that is too large for the counters and the
> resulting illegal result is rejected.

It's not rejected, it's even worse than that: it's rounded to the
greatest possible value (255), which in turn is read back as 0 RPM.

>                                        If you want very slow fan
> speeds then you must make sure the divider is set high enough so that
> the resulting period is within the limits of the device.
>
> Personally, I don't like this.  It isn't really a massive amount of work
> to get the driver to automatically either:
>
> 1) Automatically select the appropriate divider for the minimum speed
> that you have requested (i.e. pick the highest divider ratio that can
> give the speed you want range)
>
> Or
> 2) Select the lowest possible minimum speed if the one you selected is
> still too low.

I think that most drivers implement solution 2. We have a (low) number of
drivers which implement automatic fan-div switching (pc87360, adm9240),
which is a subset of solution 1.

> A minimum speed of 0 should always disable the minimum speed detection.

We can't always do that, as it depends on what the chip itself does.
Some chips have a dedicated bit to disable the alarm. Some chips disable
the alarm if the limit register is set to 0. Some chips disable the
alarm if the limit register is set to 255. What does the VT8231 do?

> Resetting the minimum speed to zero when you select a non-zero minimum
> speed is just plain wrong, however, as it is not obvious exactly what is
> happening "behind the scenes".  I spent quite a bit of time debugging the
> system to convince myself it was working "correctly".
> (...)
> Anyone else have thoughts on this?

I completely agree with you. Please fix the driver. We should port the
fix back to lm_sensors CVS too. In fact, I think the current behavior is
a bug in the original code. Consider the following code:

> /********* FAN RPM CONVERSIONS ********/
> /* But this chip saturates back at 0, not at 255 like all the other chips.
>    So, 0 means 0 RPM */
> static inline u8 FAN_TO_REG(long rpm, int div)
> {
> 	if (rpm = 0)
> 		return 0;						
> 	rpm = SENSORS_LIMIT(rpm, 1, 1000000);   
> 	return SENSORS_LIMIT((1310720 + rpm * div / 2) / (rpm * div), 1,
>                            255);
> }
> 
> #define MIN_TO_REG(a, b) FAN_TO_REG(a, b)
> #define FAN_FROM_REG(val, div) \
>                  ((val)=0?0:(val)=255?0:1310720/((val)*(div)))

The comment clearly states that the register value will be 0 if the fan
speed is too low to be measured under the currently selected clock
divider. I guess this is true for stopped or missing fan as well (can
you confirm?) Thus there is no reason to consider the register value 255
any differently from other non-zero values, is there? The FAN_TO_REG
function does actually not, but the FAN_FROM_REG macro does, and I
believe this is where the bug is.

Try removing the (val)=255 case in FAN_TO_REG, and I think the driver
will behave like you described above (solution 2).

While you're there, please delete the MIN_TO_REG macro and use
FAN_TO_REG instead.

You could also get rid of the middle SENSORS_LIMIT call in FAN_TO_REG,
providing you use strtoul instead of strtol to read the input value (in
set_fan_min). The lower bound will be handled by strtoul and the = 0
check. The upper bound is redundant with the next SENSORS_LIMIT call.

If you are willing to implement the solution 1, fine with me. This isn't
a requirement for me to accept the driver in Linux 2.6 though.

I will try to review the code further later today. It would be great if
we could integrate this ported driver in Linux 2.6 soon, it has been
around for too long already.

Thanks a lot for your work,
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
+++ linux-2.6.14/drivers/hwmon/vt8231.c	2005-11-02 13:50:57.000000000 +0000
@@ -0,0 +1,783 @@
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
+#define DIV_TO_REG(val) ((val)>4?3:(val)>2?2:(val)=2?1:0)
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
+	return SENSORS_LIMIT((1310720 + rpm * div / 2) / (rpm * div), 1, 255);
+}
+
+#define FAN_FROM_REG(val, div) ((val)=0?0:1310720/((val)*(div)))
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
+	int val = simple_strtoul(buf, NULL, 10);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	return count;
+}
+static ssize_t set_fan_div(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtoul(buf, NULL, 10);
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
