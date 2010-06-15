From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Jun 2010 09:59:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Export labels for internal
Message-Id: <20100615115956.1e12f5bb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some voltage sensors can be wired internally to the IT87xxF chip's own
power supply channels. In that case, we can inform user-space that the
wiring is known by exporting proper labels for these sensors.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
I couldn't test this patch, so anyone with a recent IT87xxF chip is
welcome to test and report. A stand-alone driver is also available for
easier testing, at:
  http://khali.linux-fr.org/devel/misc/it87/

 drivers/hwmon/it87.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

--- linux-2.6.35-rc3.orig/drivers/hwmon/it87.c	2010-05-17 18:51:21.000000000 +0200
+++ linux-2.6.35-rc3/drivers/hwmon/it87.c	2010-06-15 11:08:44.000000000 +0200
@@ -252,6 +252,7 @@ struct it87_sio_data {
 	u8 revision;
 	u8 vid_value;
 	u8 beep_pin;
+	u8 internal;	/* Internal sensors can be labeled */
 	/* Features skipped based on config or DMI */
 	u8 skip_vid;
 	u8 skip_fan;
@@ -1187,6 +1188,23 @@ static ssize_t show_vid_reg(struct devic
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
+
+static ssize_t show_label(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	static const char *labels[] = {
+		"+5V",
+		"5VSB",
+		"Vbat",
+	};
+	int nr = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%s\n", labels[nr]);
+}
+static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL, 0);
+static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, show_label, NULL, 2);
+
 static ssize_t show_name(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
 {
@@ -1427,6 +1445,17 @@ static const struct attribute_group it87
 	.attrs = it87_attributes_vid,
 };
 
+static struct attribute *it87_attributes_label[] = {
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in7_label.dev_attr.attr,
+	&sensor_dev_attr_in8_label.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group it87_group_label = {
+	.attrs = it87_attributes_vid,
+};
+
 /* SuperIO detection - will change isa_address if a chip is found */
 static int __init it87_find(unsigned short *address,
 	struct it87_sio_data *sio_data)
@@ -1480,6 +1509,9 @@ static int __init it87_find(unsigned sho
 	pr_info("it87: Found IT%04xF chip at 0x%x, revision %d\n",
 		chip_type, *address, sio_data->revision);
 
+	/* in8 (Vbat) is always internal */
+	sio_data->internal = (1 << 2);
+
 	/* Read GPIO config and VID value from LDN 7 (GPIO) */
 	if (sio_data->type = it87) {
 		/* The IT8705F doesn't have VID pins at all */
@@ -1518,9 +1550,9 @@ static int __init it87_find(unsigned sho
 
 		reg = superio_inb(IT87_SIO_PINX2_REG);
 		if (reg & (1 << 0))
-			pr_info("it87: in3 is VCC (+5V)\n");
+			sio_data->internal |= (1 << 0);
 		if (reg & (1 << 1))
-			pr_info("it87: in7 is VCCH (+5V Stand-By)\n");
+			sio_data->internal |= (1 << 1);
 
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	}
@@ -1578,6 +1610,7 @@ static void it87_remove_files(struct dev
 	}
 	if (!sio_data->skip_vid)
 		sysfs_remove_group(&dev->kobj, &it87_group_vid);
+	sysfs_remove_group(&dev->kobj, &it87_group_label);
 }
 
 static int __devinit it87_probe(struct platform_device *pdev)
@@ -1702,6 +1735,16 @@ static int __devinit it87_probe(struct p
 		if (err)
 			goto ERROR4;
 	}
+
+	/* Export labels for internal sensors */
+	for (i = 0; i < 3; i++) {
+		if (!(sio_data->internal & (1 << i)))
+			continue;
+		err = sysfs_create_file(&dev->kobj,
+					it87_attributes_label[i]);
+		if (err)
+			goto ERROR4;
+	}
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
