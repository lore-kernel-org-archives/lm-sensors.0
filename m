From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 29 May 2009 09:06:00 +0000
Subject: [lm-sensors] PATCH [2/4]: hwmon: f71882fg sanity check f8000 pwm
Message-Id: <4A1FA578.4010801@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060006050205000109050203"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060006050205000109050203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We depend up on the pwm_enable register (0x96) not containing any reserved
settings in various places. We were already checking to make sure there
were no reserved settings in the register for the f71862fg, this patch adds
the same checking for the f8000, while at it it also moves the code to
a more apropriate place so we don't need to check if the fan/pwm part
of the IC is enabled twice.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------060006050205000109050203
Content-Type: text/plain; name="hwmon-f71882fg-02-f8000-sanity-check-pwm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hwmon-f71882fg-02-f8000-sanity-check-pwm.patch"

hwmon: f71882fg sanity check f8000 pwm settings

We depend up on the pwm_enable register (0x96) not containing any reserved
settings in various places. We were already checking to make sure there
were no reserved settings in the register for the f71862fg, this patch adds
the same checking for the f8000, while at it it also moves the code to
a more apropriate place so we don't need to check if the fan/pwm part
of the IC is enabled twice.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.orig2	2009-05-28 20:51:01.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2009-05-28 21:21:34.000000000 +0200
@@ -1735,19 +1735,6 @@ static int __devinit f71882fg_probe(stru
 		goto exit_free;
 	}
 
-	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
-	/* If it is a 71862 and the fan / pwm part is enabled sanity check
-	   the pwm settings */
-	if (data->type == f71862fg && (start_reg & 0x02)) {
-		if ((data->pwm_enable & 0x15) != 0x15) {
-			dev_err(&pdev->dev,
-				"Invalid (reserved) pwm settings: 0x%02x\n",
-				(unsigned int)data->pwm_enable);
-			err = -ENODEV;
-			goto exit_free;
-		}
-	}
-
 	/* Register sysfs interface files */
 	err = device_create_file(&pdev->dev, &dev_attr_name);
 	if (err)
@@ -1778,6 +1765,29 @@ static int __devinit f71882fg_probe(stru
 	}
 
 	if (start_reg & 0x02) {
+		data->pwm_enable =
+			f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
+
+		/* Sanity check the pwm settings */
+		switch (data->type) {
+		case f71862fg:
+			err = (data->pwm_enable & 0x15) != 0x15;
+			break;
+		case f71882fg:
+			err = 0;
+			break;
+		case f8000:
+			err = data->pwm_enable & 0x20;
+			break;
+		}
+		if (err) {
+			dev_err(&pdev->dev,
+				"Invalid (reserved) pwm settings: 0x%02x\n",
+				(unsigned int)data->pwm_enable);
+			err = -ENODEV;
+			goto exit_unregister_sysfs;
+		}
+
 		err = f71882fg_create_sysfs_files(pdev, fxxxx_fan_attr,
 					ARRAY_SIZE(fxxxx_fan_attr));
 		if (err)

--------------060006050205000109050203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060006050205000109050203--
