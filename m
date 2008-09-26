From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Sep 2008 08:11:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Prevent power-off on Shuttle
Message-Id: <20080926101121.3cf8e83a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On the Shuttle SN68PT, FAN_CTL2 is apparently not connected to a fan,
but to something else. One user has reported instant system power-off
when changing the PWM2 duty cycle, so we disable it.

I use the board name string as the trigger in case the same board is
ever used in other systems.

This closes lm-sensors ticket #2349:
pwmconfig causes a hard poweroff
http://www.lm-sensors.org/ticket/2349

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   70 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 19 deletions(-)

--- linux-2.6.27-rc7.orig/drivers/hwmon/it87.c	2008-09-26 08:42:04.000000000 +0200
+++ linux-2.6.27-rc7/drivers/hwmon/it87.c	2008-09-26 09:50:16.000000000 +0200
@@ -46,6 +46,8 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/string.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 
 #define DRVNAME "it87"
@@ -236,6 +238,8 @@ struct it87_sio_data {
 	/* Values read from Super-I/O config space */
 	u8 revision;
 	u8 vid_value;
+	/* Values set based on DMI strings */
+	u8 skip_pwm;
 };
 
 /* For each registered chip, we need to keep some data in memory.
@@ -964,6 +968,7 @@ static int __init it87_find(unsigned sho
 {
 	int err = -ENODEV;
 	u16 chip_type;
+	const char *board_vendor, *board_name;
 
 	superio_enter();
 	chip_type = force_id ? force_id : superio_inw(DEVID);
@@ -1022,6 +1027,24 @@ static int __init it87_find(unsigned sho
 			pr_info("it87: in7 is VCCH (+5V Stand-By)\n");
 	}
 
+	/* Disable specific features based on DMI strings */
+	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+	board_name = dmi_get_system_info(DMI_BOARD_NAME);
+	if (board_vendor && board_name) {
+		if (strcmp(board_vendor, "nVIDIA") = 0
+		 && strcmp(board_name, "FN68PT") = 0) {
+			/* On the Shuttle SN68PT, FAN_CTL2 is apparently not
+			   connected to a fan, but to something else. One user
+			   has reported instant system power-off when changing
+			   the PWM2 duty cycle, so we disable it.
+			   I use the board name string as the trigger in case
+			   the same board is ever used in other systems. */
+			pr_info("it87: Disabling pwm2 due to "
+				"hardware constraints\n");
+			sio_data->skip_pwm = (1 << 1);
+		}
+	}
+
 exit:
 	superio_exit();
 	return err;
@@ -1168,25 +1191,33 @@ static int __devinit it87_probe(struct p
 	}
 
 	if (enable_pwm_interface) {
-		if ((err = device_create_file(dev,
-		     &sensor_dev_attr_pwm1_enable.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm2_enable.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm3_enable.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm1.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm2.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm3.dev_attr))
-		 || (err = device_create_file(dev,
-		     &dev_attr_pwm1_freq))
-		 || (err = device_create_file(dev,
-		     &dev_attr_pwm2_freq))
-		 || (err = device_create_file(dev,
-		     &dev_attr_pwm3_freq)))
-			goto ERROR4;
+		if (!(sio_data->skip_pwm & (1 << 0))) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm1_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm1.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm1_freq)))
+				goto ERROR4;
+		}
+		if (!(sio_data->skip_pwm & (1 << 1))) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm2_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm2.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm2_freq)))
+				goto ERROR4;
+		}
+		if (!(sio_data->skip_pwm & (1 << 2))) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm3_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm3.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm3_freq)))
+				goto ERROR4;
+		}
 	}
 
 	if (data->type = it8712 || data->type = it8716
@@ -1546,6 +1577,7 @@ static int __init sm_it87_init(void)
 	unsigned short isa_address=0;
 	struct it87_sio_data sio_data;
 
+	memset(&sio_data, 0, sizeof(struct it87_sio_data));
 	err = it87_find(&isa_address, &sio_data);
 	if (err)
 		return err;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
