From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 May 2012 02:31:52 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (it87) Create voltage attributes only if voltage is enabled
Message-Id: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On IT8782F and IT8783F, some voltage input pins may be disabled. Don't create
sysfs attribute files if that is the case.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |  146 ++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 113 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index aebac13..baf4173 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -234,6 +234,7 @@ struct it87_sio_data {
 	u8 beep_pin;
 	u8 internal;	/* Internal sensors can be labeled */
 	/* Features skipped based on config or DMI */
+	u16 skip_in;
 	u8 skip_vid;
 	u8 skip_fan;
 	u8 skip_pwm;
@@ -1371,41 +1372,73 @@ static ssize_t show_name(struct device *dev, struct device_attribute
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static struct attribute *it87_attributes[] = {
+static struct attribute *it87_attributes_in[9][5] = {
+{
 	&sensor_dev_attr_in0_input.dev_attr.attr,
-	&sensor_dev_attr_in1_input.dev_attr.attr,
-	&sensor_dev_attr_in2_input.dev_attr.attr,
-	&sensor_dev_attr_in3_input.dev_attr.attr,
-	&sensor_dev_attr_in4_input.dev_attr.attr,
-	&sensor_dev_attr_in5_input.dev_attr.attr,
-	&sensor_dev_attr_in6_input.dev_attr.attr,
-	&sensor_dev_attr_in7_input.dev_attr.attr,
-	&sensor_dev_attr_in8_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
-	&sensor_dev_attr_in1_min.dev_attr.attr,
-	&sensor_dev_attr_in2_min.dev_attr.attr,
-	&sensor_dev_attr_in3_min.dev_attr.attr,
-	&sensor_dev_attr_in4_min.dev_attr.attr,
-	&sensor_dev_attr_in5_min.dev_attr.attr,
-	&sensor_dev_attr_in6_min.dev_attr.attr,
-	&sensor_dev_attr_in7_min.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
-	&sensor_dev_attr_in1_max.dev_attr.attr,
-	&sensor_dev_attr_in2_max.dev_attr.attr,
-	&sensor_dev_attr_in3_max.dev_attr.attr,
-	&sensor_dev_attr_in4_max.dev_attr.attr,
-	&sensor_dev_attr_in5_max.dev_attr.attr,
-	&sensor_dev_attr_in6_max.dev_attr.attr,
-	&sensor_dev_attr_in7_max.dev_attr.attr,
 	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
 	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
 	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
 	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
 	&sensor_dev_attr_in6_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in7_min.dev_attr.attr,
+	&sensor_dev_attr_in7_max.dev_attr.attr,
 	&sensor_dev_attr_in7_alarm.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	NULL
+} };
 
+static const struct attribute_group it87_group_in[9] = {
+	{ .attrs = it87_attributes_in[0] },
+	{ .attrs = it87_attributes_in[1] },
+	{ .attrs = it87_attributes_in[2] },
+	{ .attrs = it87_attributes_in[3] },
+	{ .attrs = it87_attributes_in[4] },
+	{ .attrs = it87_attributes_in[5] },
+	{ .attrs = it87_attributes_in[6] },
+	{ .attrs = it87_attributes_in[7] },
+	{ .attrs = it87_attributes_in[8] },
+};
+
+static struct attribute *it87_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
@@ -1432,7 +1465,7 @@ static const struct attribute_group it87_group = {
 	.attrs = it87_attributes,
 };
 
-static struct attribute *it87_attributes_beep[] = {
+static struct attribute *it87_attributes_in_beep[] = {
 	&sensor_dev_attr_in0_beep.dev_attr.attr,
 	&sensor_dev_attr_in1_beep.dev_attr.attr,
 	&sensor_dev_attr_in2_beep.dev_attr.attr,
@@ -1441,7 +1474,10 @@ static struct attribute *it87_attributes_beep[] = {
 	&sensor_dev_attr_in5_beep.dev_attr.attr,
 	&sensor_dev_attr_in6_beep.dev_attr.attr,
 	&sensor_dev_attr_in7_beep.dev_attr.attr,
+	NULL
+};
 
+static struct attribute *it87_attributes_beep[] = {
 	&sensor_dev_attr_temp1_beep.dev_attr.attr,
 	&sensor_dev_attr_temp2_beep.dev_attr.attr,
 	&sensor_dev_attr_temp3_beep.dev_attr.attr,
@@ -1725,18 +1761,31 @@ static int __init it87_find(unsigned short *address,
 
 		/* VIN5 */
 		if ((reg27 & (1 << 0)) || uart6)
-			; /* No VIN5 */
+			sio_data->skip_in |= (1 << 5); /* No VIN5 */
 
 		/* VIN6 */
 		if ((reg27 & (1 << 1)) || uart6)
-			; /* No VIN6 */
+			sio_data->skip_in |= (1 << 6); /* No VIN6 */
 
 		/*
 		 * VIN7
 		 * Does not depend on bit 2 of Reg2C, contrary to datasheet.
 		 */
-		if (reg27 & (1 << 2))
-			; /* No VIN7 (unless internal) */
+		if (reg27 & (1 << 2)) {
+			/*
+			 * The data sheet is a bit uncear regarding the internal
+			 * voltage divider for VCCH5V. It says
+			 * "This bit enables and switches VIN7 (pin91) to the
+			 * internal voltage divider for VCCH5V".
+			 * This is different to other chips, where the internal
+			 * voltage divider would connect VIN7 to an internal
+			 * voltage source. Maybe that is the case here as well,
+			 * but at least for now follow the data sheet and assume
+			 * that there is no VIN7 if pin 91 is not configured as
+			 * VIN7 input.
+			 */
+			sio_data->skip_in |= (1 << 7);
+		}
 
 		if (reg2C & (1 << 0))
 			sio_data->internal |= (1 << 0);
@@ -1747,6 +1796,7 @@ static int __init it87_find(unsigned short *address,
 
 	} else {
 		int reg;
+		bool uart6;
 
 		superio_select(GPIO);
 
@@ -1784,6 +1834,9 @@ static int __init it87_find(unsigned short *address,
 			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);
 
 		reg = superio_inb(IT87_SIO_PINX2_REG);
+
+		uart6 = sio_data->type = it8782 && (reg & (1 << 2));
+
 		/*
 		 * The IT8720F has no VIN7 pin, so VCCH should always be
 		 * routed internally to VIN7 with an internal divider.
@@ -1795,11 +1848,10 @@ static int __init it87_find(unsigned short *address,
 		 * setting. So we force the internal routing in this case.
 		 *
 		 * On IT8782F, VIN7 is multiplexed with one of the UART6 pins.
-		 * If UART6 is enabled, re-route VIN7 to the internal divider.
+		 * If UART6 is enabled, re-route VIN7 to the internal divider
+		 * if that is not already the case.
 		 */
-		if ((sio_data->type = it8720 ||
-		    (sio_data->type = it8782 && (reg & (1 << 2))))
-		    && !(reg & (1 << 1))) {
+		if ((sio_data->type = it8720 || uart6) && !(reg & (1 << 1))) {
 			reg |= (1 << 1);
 			superio_outb(IT87_SIO_PINX2_REG, reg);
 			pr_notice("Routing internal VCCH to in7\n");
@@ -1810,6 +1862,14 @@ static int __init it87_find(unsigned short *address,
 		    sio_data->type = it8728)
 			sio_data->internal |= (1 << 1);
 
+		/*
+		 * On IT8782F, UART6 pins overlap with VIN5, VIN6, and VIN7.
+		 * While VIN7 can be routed to the internal voltage divider,
+		 * VIN5 and VIN6 are not available if UART6 is enabled.
+		 */
+		if (uart6)
+			sio_data->skip_in |= (1 << 5) | (1 << 6);
+
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	}
 	if (sio_data->beep_pin)
@@ -1847,6 +1907,12 @@ static void it87_remove_files(struct device *dev)
 	int i;
 
 	sysfs_remove_group(&dev->kobj, &it87_group);
+	for (i = 0; i < 9; i++) {
+		sysfs_remove_group(&dev->kobj, &it87_group_in[i]);
+		if (it87_attributes_in_beep[i])
+			sysfs_remove_file(&dev->kobj,
+					  it87_attributes_in_beep[i]);
+	}
 	if (sio_data->beep_pin)
 		sysfs_remove_group(&dev->kobj, &it87_group_beep);
 	for (i = 0; i < 5; i++) {
@@ -1945,9 +2011,23 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	it87_init_device(pdev);
 
 	/* Register sysfs hooks */
+	for (i = 0; i < 9; i++) {
+		if (sio_data->skip_in & (1 << i))
+			continue;
+		err = sysfs_create_group(&dev->kobj, &it87_group_in[i]);
+		if (err)
+			goto ERROR4;
+		if (sio_data->beep_pin && it87_attributes_in_beep[i]) {
+			err = sysfs_create_file(&dev->kobj,
+						it87_attributes_in_beep[i]);
+			if (err)
+				goto ERROR4;
+		}
+	}
+
 	err = sysfs_create_group(&dev->kobj, &it87_group);
 	if (err)
-		goto ERROR2;
+		goto ERROR4;
 
 	if (sio_data->beep_pin) {
 		err = sysfs_create_group(&dev->kobj, &it87_group_beep);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
