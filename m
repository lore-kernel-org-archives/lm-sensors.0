From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814531232@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814521837@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.25, 2004/04/12 15:16:08-07:00, khali@linux-fr.org

[PATCH] I2C: pwm support in w83781d.c

Here is a general pwm support cleanup patch for the w83781d chip driver.
Featuring:

* Don't pretend that we handle PWM on AS99127F chips. We don't know how
it works, and one of the register we are accessing for now is clearly
not a PWM register, and changing its value usually breaks temperature
readings.

* Discard irrelevant comments.

* Rewrite show_pwmenable_reg. It was obviously taken from the 2.4
driver, with unneeded tests and the code was much too complicated
anyway. And now we handle errors correctly.

* Initialize pwm_enable at load time. So far it was done conditionally
(if init=1) while it should always be done. And pwm2_enable wasn't read
from the chip, while it should.

I could test that my AS99127F doesn't expose pwm files through ssysfs
anymore. Which means that I couldn't test the rest of the pwm changes,
unfortunately.

I've applied similar changes to our 2.4/CVS repository.


 drivers/i2c/chips/w83781d.c |   67 +++++++++++++++++---------------------------
 1 files changed, 26 insertions(+), 41 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:12:45 2004
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:12:45 2004
@@ -24,7 +24,7 @@
     Supports following chips:
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    as99127f	7	3	1?	3	0x31	0x12c3	yes	no
+    as99127f	7	3	0	3	0x31	0x12c3	yes	no
     as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
     w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
@@ -670,7 +670,6 @@
 device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
 } while (0)
 
-/* w83697hf only has two fans */
 static ssize_t
 show_pwm_reg(struct device *dev, char *buf, int nr)
 {
@@ -678,7 +677,6 @@
 	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr - 1]));
 }
 
-/* w83697hf only has two fans */
 static ssize_t
 show_pwmenable_reg(struct device *dev, char *buf, int nr)
 {
@@ -706,38 +704,26 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 val, j, k;
+	u32 val, reg;
 
 	val = simple_strtoul(buf, NULL, 10);
 
-	/* only PWM2 can be enabled/disabled */
-	if (nr = 2) {
-		j = w83781d_read_value(client, W83781D_REG_PWMCLK12);
-		k = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
-
-		if (val > 0) {
-			if (!(j & 0x08))
-				w83781d_write_value(client,
-						    W83781D_REG_PWMCLK12,
-						    j | 0x08);
-			if (k & 0x10)
-				w83781d_write_value(client,
-						    W83781D_REG_BEEP_CONFIG,
-						    k & 0xef);
+	switch (val) {
+	case 0:
+	case 1:
+		reg = w83781d_read_value(client, W83781D_REG_PWMCLK12);
+		w83781d_write_value(client, W83781D_REG_PWMCLK12,
+				    (reg & 0xf7) | (val << 3));
+
+		reg = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
+		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG,
+				    (reg & 0xef) | (!val << 4));
 
-			data->pwmenable[1] = 1;
-		} else {
-			if (j & 0x08)
-				w83781d_write_value(client,
-						    W83781D_REG_PWMCLK12,
-						    j & 0xf7);
-			if (!(k & 0x10))
-				w83781d_write_value(client,
-						    W83781D_REG_BEEP_CONFIG,
-						    j | 0x10);
+		data->pwmenable[nr - 1] = val;
+		break;
 
-			data->pwmenable[1] = 0;
-		}
+	default:
+		return -EINVAL;
 	}
 
 	return count;
@@ -1250,6 +1236,9 @@
 		data->fan_min[i - 1] = w83781d_read_value(new_client,
 					W83781D_REG_FAN_MIN(i));
 	}
+	if (kind != w83781d && kind != as99127f)
+		for (i = 0; i < 4; i++)
+			data->pwmenable[i] = 1;
 
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
@@ -1290,7 +1279,7 @@
 
 	device_create_file_beep(new_client);
 
-	if (kind != w83781d) {
+	if (kind != w83781d && kind != as99127f) {
 		device_create_file_pwm(new_client, 1);
 		device_create_file_pwm(new_client, 2);
 		device_create_file_pwmenable(new_client, 2);
@@ -1578,9 +1567,6 @@
 			if (!(i & 0x40))
 				w83781d_write_value(client, W83781D_REG_IRQ,
 						    i | 0x40);
-
-			for (i = 0; i < 3; i++)
-				data->pwmenable[i] = 1;
 		}
 	}
 
@@ -1624,20 +1610,19 @@
 			data->fan_min[i - 1]  			    w83781d_read_value(client, W83781D_REG_FAN_MIN(i));
 		}
-		if (data->type != w83781d) {
+		if (data->type != w83781d && data->type != as99127f) {
 			for (i = 1; i <= 4; i++) {
 				data->pwm[i - 1]  				    w83781d_read_value(client,
 						       W83781D_REG_PWM(i));
-				if (((data->type = w83783s)
-				     || (data->type = w83627hf)
-				     || (data->type = as99127f)
-				     || (data->type = w83697hf)
-				     || ((data->type = w83782d)
-					 && i2c_is_isa_client(client)))
+				if ((data->type != w83782d
+				     || i2c_is_isa_client(client))
 				    && i = 2)
 					break;
 			}
+			/* Only PWM2 can be disabled */
+			data->pwmenable[1] = (w83781d_read_value(client,
+					      W83781D_REG_PWMCLK12) & 0x08) >> 3;
 		}
 
 		data->temp = w83781d_read_value(client, W83781D_REG_TEMP(1));

