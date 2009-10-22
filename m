From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Oct 2009 13:21:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Check for fan2 and fan3
Message-Id: <20091022152152.36b47c2c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The fan2 and fan3 input and output pins can be used as GPIOs. Check
their function before exposing their sysfs attributes and accessing
their registers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

--- linux-2.6.32-rc5.orig/drivers/hwmon/it87.c	2009-10-22 12:57:00.000000000 +0200
+++ linux-2.6.32-rc5/drivers/hwmon/it87.c	2009-10-22 13:21:48.000000000 +0200
@@ -125,6 +125,7 @@ superio_exit(void)
 
 /* Logical device 7 registers (IT8712F and later) */
 #define IT87_SIO_GPIO3_REG	0x27
+#define IT87_SIO_GPIO5_REG	0x29
 #define IT87_SIO_PINX2_REG	0x2c	/* Pin selection */
 #define IT87_SIO_VID_REG	0xfc	/* VID value */
 
@@ -245,8 +246,9 @@ struct it87_sio_data {
 	/* Values read from Super-I/O config space */
 	u8 revision;
 	u8 vid_value;
+	/* Features skipped based on config or DMI */
 	u8 skip_vid;
-	/* Values set based on DMI strings */
+	u8 skip_fan;
 	u8 skip_pwm;
 };
 
@@ -1042,6 +1044,19 @@ static int __init it87_find(unsigned sho
 		if (reg & 0x0f)
 			sio_data->skip_vid = 1;
 
+		/* Check if fan3 is there or not */
+		if (reg & (1 << 6))
+			sio_data->skip_pwm |= (1 << 2);
+		if (reg & (1 << 7))
+			sio_data->skip_fan |= (1 << 2);
+
+		/* Check if fan2 is there or not */
+		reg = superio_inb(IT87_SIO_GPIO5_REG);
+		if (reg & (1 << 1))
+			sio_data->skip_pwm |= (1 << 1);
+		if (reg & (1 << 2))
+			sio_data->skip_fan |= (1 << 1);
+
 		if ((sio_data->type = it8718 || sio_data->type = it8720)
 		 && !(sio_data->skip_vid))
 			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);
@@ -1365,8 +1380,10 @@ static int __devinit it87_check_pwm(stru
 /* Called when we have found a new IT87. */
 static void __devinit it87_init_device(struct platform_device *pdev)
 {
+	struct it87_sio_data *sio_data = pdev->dev.platform_data;
 	struct it87_data *data = platform_get_drvdata(pdev);
 	int tmp, i;
+	u8 mask;
 
 	/* initialize to sane defaults:
 	 * - if the chip is in manual pwm mode, this will be overwritten with
@@ -1412,10 +1429,11 @@ static void __devinit it87_init_device(s
 	}
 
 	/* Check if tachometers are reset manually or by some reason */
+	mask = 0x70 & ~(sio_data->skip_fan << 4);
 	data->fan_main_ctrl = it87_read_value(data, IT87_REG_FAN_MAIN_CTRL);
-	if ((data->fan_main_ctrl & 0x70) = 0) {
+	if ((data->fan_main_ctrl & mask) = 0) {
 		/* Enable all fan tachometers */
-		data->fan_main_ctrl |= 0x70;
+		data->fan_main_ctrl |= mask;
 		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
 	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
@@ -1438,6 +1456,9 @@ static void __devinit it87_init_device(s
 		}
 	}
 
+	/* Fan input pins may be used for alternative functions */
+	data->has_fan &= ~sio_data->skip_fan;
+
 	/* Set current fan mode registers and the default settings for the
 	 * other mode registers */
 	for (i = 0; i < 3; i++) {

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
