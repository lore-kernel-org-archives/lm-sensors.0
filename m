From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Oct 2011 14:43:14 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (w83627ehf) Move fan pins check to
Message-Id: <20111013164314.15a0d872@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move the check of fan pin usage to a separate function. This improves
readability, and will make it easier to integrate chip-specific
conditions.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |  120 +++++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 53 deletions(-)

--- linux-2.6.39-rc0.orig/drivers/hwmon/w83627ehf.c	2011-03-18 16:25:29.000000000 +0100
+++ linux-2.6.39-rc0/drivers/hwmon/w83627ehf.c	2011-03-18 16:39:40.000000000 +0100
@@ -1784,13 +1784,78 @@ static void w82627ehf_swap_tempreg(struc
 	data->reg_temp_config[r2] = tmp;
 }
 
+static void __devinit
+w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
+			   struct w83627ehf_data *data)
+{
+	int fan3pin, fan4pin, fan4min, fan5pin, regval;
+
+	superio_enter(sio_data->sioreg);
+
+	/* fan4 and fan5 share some pins with the GPIO and serial flash */
+	if (sio_data->kind = nct6775) {
+		/* On NCT6775, fan4 shares pins with the fdc interface */
+		fan3pin = 1;
+		fan4pin = !(superio_inb(sio_data->sioreg, 0x2A) & 0x80);
+		fan4min = 0;
+		fan5pin = 0;
+	} else if (sio_data->kind = nct6776) {
+		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
+		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
+		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
+		fan4min = fan4pin;
+	} else if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b) {
+		fan3pin = 1;
+		fan4pin = superio_inb(sio_data->sioreg, 0x27) & 0x40;
+		fan5pin = superio_inb(sio_data->sioreg, 0x27) & 0x20;
+		fan4min = fan4pin;
+	} else {
+		fan3pin = 1;
+		fan4pin = !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
+		fan5pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
+		fan4min = fan4pin;
+	}
+
+	superio_exit(sio_data->sioreg);
+
+	data->has_fan = data->has_fan_min = 0x03; /* fan1 and fan2 */
+	data->has_fan |= (fan3pin << 2);
+	data->has_fan_min |= (fan3pin << 2);
+
+	if (sio_data->kind = nct6775 || sio_data->kind = nct6776) {
+		/*
+		 * NCT6775F and NCT6776F don't have the W83627EHF_REG_FANDIV1
+		 * register
+		 */
+		data->has_fan |= (fan4pin << 3) | (fan5pin << 4);
+		data->has_fan_min |= (fan4min << 3) | (fan5pin << 4);
+	} else {
+		/*
+		 * It looks like fan4 and fan5 pins can be alternatively used
+		 * as fan on/off switches, but fan5 control is write only :/
+		 * We assume that if the serial interface is disabled, designers
+		 * connected fan5 as input unless they are emitting log 1, which
+		 * is not the default.
+		 */
+		regval = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
+		if ((regval & (1 << 2)) && fan4pin) {
+			data->has_fan |= (1 << 3);
+			data->has_fan_min |= (1 << 3);
+		}
+		if (!(regval & (1 << 1)) && fan5pin) {
+			data->has_fan |= (1 << 4);
+			data->has_fan_min |= (1 << 4);
+		}
+	}
+}
+
 static int __devinit w83627ehf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct w83627ehf_sio_data *sio_data = dev->platform_data;
 	struct w83627ehf_data *data;
 	struct resource *res;
-	u8 fan3pin, fan4pin, fan4min, fan5pin, en_vrm10;
+	u8 en_vrm10;
 	int i, err = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -2075,30 +2140,6 @@ static int __devinit w83627ehf_probe(str
 		}
 	}
 
-	/* fan4 and fan5 share some pins with the GPIO and serial flash */
-	if (sio_data->kind = nct6775) {
-		/* On NCT6775, fan4 shares pins with the fdc interface */
-		fan3pin = 1;
-		fan4pin = !(superio_inb(sio_data->sioreg, 0x2A) & 0x80);
-		fan4min = 0;
-		fan5pin = 0;
-	} else if (sio_data->kind = nct6776) {
-		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
-		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
-		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
-		fan4min = fan4pin;
-	} else if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b) {
-		fan3pin = 1;
-		fan4pin = superio_inb(sio_data->sioreg, 0x27) & 0x40;
-		fan5pin = superio_inb(sio_data->sioreg, 0x27) & 0x20;
-		fan4min = fan4pin;
-	} else {
-		fan3pin = 1;
-		fan4pin = !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
-		fan5pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
-		fan4min = fan4pin;
-	}
-
 	if (fan_debounce &&
 	    (sio_data->kind = nct6775 || sio_data->kind = nct6776)) {
 		u8 tmp;
@@ -2116,34 +2157,7 @@ static int __devinit w83627ehf_probe(str
 
 	superio_exit(sio_data->sioreg);
 
-	/* It looks like fan4 and fan5 pins can be alternatively used
-	   as fan on/off switches, but fan5 control is write only :/
-	   We assume that if the serial interface is disabled, designers
-	   connected fan5 as input unless they are emitting log 1, which
-	   is not the default. */
-
-	data->has_fan = data->has_fan_min = 0x03; /* fan1 and fan2 */
-
-	data->has_fan |= (fan3pin << 2);
-	data->has_fan_min |= (fan3pin << 2);
-
-	/*
-	 * NCT6775F and NCT6776F don't have the W83627EHF_REG_FANDIV1 register
-	 */
-	if (sio_data->kind = nct6775 || sio_data->kind = nct6776) {
-		data->has_fan |= (fan4pin << 3) | (fan5pin << 4);
-		data->has_fan_min |= (fan4min << 3) | (fan5pin << 4);
-	} else {
-		i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
-		if ((i & (1 << 2)) && fan4pin) {
-			data->has_fan |= (1 << 3);
-			data->has_fan_min |= (1 << 3);
-		}
-		if (!(i & (1 << 1)) && fan5pin) {
-			data->has_fan |= (1 << 4);
-			data->has_fan_min |= (1 << 4);
-		}
-	}
+	w83627ehf_check_fan_inputs(sio_data, data);
 
 	/* Read fan clock dividers immediately */
 	w83627ehf_update_fan_div_common(dev, data);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
