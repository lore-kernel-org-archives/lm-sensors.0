From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:19:42 +0000
Subject: [lm-sensors] [PATCH 06/10] hwmon/w83627ehf: Add support for the VID
Message-Id: <20070624111942.117770c3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The W83627EHF and similar chips have 6 VID input pins, add support
for them. The driver changes the input voltage level automatically
if the current setting is not correct for the detected CPU model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83627ehf |    6 ++--
 drivers/hwmon/Kconfig         |    1 
 drivers/hwmon/w83627ehf.c     |   50 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 5 deletions(-)

--- linux-2.6.22-rc5.orig/Documentation/hwmon/w83627ehf	2007-06-24 08:50:37.000000000 +0200
+++ linux-2.6.22-rc5/Documentation/hwmon/w83627ehf	2007-06-24 10:33:39.000000000 +0200
@@ -22,9 +22,9 @@ This driver implements support for the W
 W83627DHG super I/O chips. We will refer to them collectively as Winbond chips.
 
 The chips implement three temperature sensors, five fan rotation
-speed sensors, ten analog voltage sensors (only nine for the 627DHG), alarms
-with beep warnings (control unimplemented), and some automatic fan regulation
-strategies (plus manual fan control mode).
+speed sensors, ten analog voltage sensors (only nine for the 627DHG), one
+VID (6 pins), alarms with beep warnings (control unimplemented), and
+some automatic fan regulation strategies (plus manual fan control mode).
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
--- linux-2.6.22-rc5.orig/drivers/hwmon/Kconfig	2007-06-24 09:32:18.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/Kconfig	2007-06-24 10:33:39.000000000 +0200
@@ -590,6 +590,7 @@ config SENSORS_W83627HF
 
 config SENSORS_W83627EHF
 	tristate "Winbond W83627EHF/DHG"
+	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware
 	  monitoring functionality of the Winbond W83627EHF Super-I/O chip.
--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-24 10:25:18.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-24 10:33:39.000000000 +0200
@@ -45,6 +45,7 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
@@ -68,8 +69,11 @@ static const char * w83627ehf_device_nam
 
 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
+#define SIO_REG_EN_VRM10	0x2C	/* GPIO3, GPIO4 selection */
 #define SIO_REG_ENABLE		0x30	/* Logical device enable */
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
+#define SIO_REG_VID_CTRL	0xF0	/* VID control */
+#define SIO_REG_VID_DATA	0xF1	/* VID data */
 
 #define SIO_W83627EHF_ID	0x8850
 #define SIO_W83627EHG_ID	0x8860
@@ -285,6 +289,9 @@ struct w83627ehf_data {
 
 	u8 fan_min_output[4]; /* minimum fan speed */
 	u8 fan_stop_time[4];
+
+	u8 vid;
+	u8 vrm;
 };
 
 struct w83627ehf_sio_data {
@@ -1127,6 +1134,14 @@ static struct sensor_device_attribute sd
 		    store_fan_min_output, 2),
 };
 
+static ssize_t
+show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w83627ehf_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
 /*
  * Driver and device management
  */
@@ -1165,6 +1180,8 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_temp[i].dev_attr);
 
 	device_remove_file(dev, &dev_attr_name);
+	if (data->vid != 0x3f)
+		device_remove_file(dev, &dev_attr_cpu0_vid);
 }
 
 /* Get the monitoring functions started */
@@ -1196,7 +1213,7 @@ static int __devinit w83627ehf_probe(str
 	struct w83627ehf_sio_data *sio_data = dev->platform_data;
 	struct w83627ehf_data *data;
 	struct resource *res;
-	u8 fan4pin, fan5pin;
+	u8 fan4pin, fan5pin, en_vrm10;
 	int i, err = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -1230,9 +1247,32 @@ static int __devinit w83627ehf_probe(str
 		data->fan_min[i] = w83627ehf_read_value(data,
 				   W83627EHF_REG_FAN_MIN[i]);
 
+	data->vrm = vid_which_vrm();
+	superio_enter(sio_data->sioreg);
+	/* Set VID input sensibility if needed. In theory the BIOS should
+	   have set it, but in practice it's not always the case. */
+	en_vrm10 = superio_inb(sio_data->sioreg, SIO_REG_EN_VRM10);
+	if ((en_vrm10 & 0x08) && data->vrm != 100) {
+		dev_warn(dev, "Setting VID input voltage to TTL\n");
+		superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+			     en_vrm10 & ~0x08);
+	} else if (!(en_vrm10 & 0x08) && data->vrm = 100) {
+		dev_warn(dev, "Setting VID input voltage to VRM10\n");
+		superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+			     en_vrm10 | 0x08);
+	}
+	/* Read VID value */
+	superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
+	if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80)
+		data->vid = superio_inb(sio_data->sioreg, SIO_REG_VID_DATA) & 0x3f;
+	else {
+		dev_info(dev, "VID pins in output mode, CPU VID not "
+			 "available\n");
+		data->vid = 0x3f;
+	}
+
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 
-	superio_enter(sio_data->sioreg);
 	fan5pin = superio_inb(sio_data->sioreg, 0x24) & 0x2;
 	fan4pin = superio_inb(sio_data->sioreg, 0x29) & 0x6;
 	superio_exit(sio_data->sioreg);
@@ -1308,6 +1348,12 @@ static int __devinit w83627ehf_probe(str
 	if (err)
 		goto exit_remove;
 
+	if (data->vid != 0x3f) {
+		err = device_create_file(dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_remove;
+	}
+
 	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
