From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 15:26:38 +0000
Subject: [lm-sensors] PATCH: hwmon-f71882fg-17-printout-fan-modes.patch
Message-Id: <4946772E.1060303@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050600090102050502090306"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050600090102050502090306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

Print the mode (duty-cycle or RPM) of each fan on driver load (to match the 
documentation from the previous patch which references this mode printout).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks & Regards,

Hans


p.s.

This is the very last patch of the f8000 work, or so I hope :)


--------------050600090102050502090306
Content-Type: text/plain;
 name="hwmon-f71882fg-17-printout-fan-modes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-f71882fg-17-printout-fan-modes.patch"

Print the mode (duty-cycle or RPM) of each fan on driver load.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.16-applied	2008-12-15 16:00:38.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-15 16:20:58.000000000 +0100
@@ -1711,7 +1711,7 @@
 {
 	struct f71882fg_data *data;
 	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
-	int err;
+	int err, i, nr_fans = (sio_data->type == f71882fg) ? 4 : 3;
 	u8 start_reg;
 
 	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
@@ -1735,14 +1735,14 @@
 		goto exit_free;
 	}
 
+	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 	/* If it is a 71862 and the fan / pwm part is enabled sanity check
 	   the pwm settings */
 	if (data->type == f71862fg && (start_reg & 0x02)) {
-		u8 reg = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
-		if ((reg & 0x15) != 0x15) {
+		if ((data->pwm_enable & 0x15) != 0x15) {
 			dev_err(&pdev->dev,
 				"Invalid (reserved) pwm settings: 0x%02x\n",
-				(unsigned int)reg);
+				(unsigned int)data->pwm_enable);
 			err = -ENODEV;
 			goto exit_free;
 		}
@@ -1802,6 +1802,11 @@
 		}
 		if (err)
 			goto exit_unregister_sysfs;
+
+		for (i = 0; i < nr_fans; i++)
+			dev_info(&pdev->dev, "Fan: %d is in %s mode\n", i + 1,
+				 (data->pwm_enable & (1 << 2 * i)) ?
+				 "duty-cycle" : "RPM");
 	}
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);

--------------050600090102050502090306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050600090102050502090306--
