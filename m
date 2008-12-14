From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 14 Dec 2008 14:35:14 +0000
Subject: [lm-sensors] PATCH: f71882g: check for hwmon powerdown state [2/4]
Message-Id: <494519A2.3000204@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030403060707070705050404"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030403060707070705050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

More f8000 prep work. Take over the checking if the hwmon part is not
powered down from the standalone f8000 driver.

This check is valid for all supported models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks & Regards,

Hans

--------------030403060707070705050404
Content-Type: text/plain;
 name="hwmon-f71882fg-10-check-for-powerdown.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-f71882fg-10-check-for-powerdown.patch"

More f8000 prep work. Take over the checking if the hwmon part is not
powered down from the standalone f8000 driver.

This check is valid for all supported models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.09-applied	2008-12-14 15:23:07.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-14 15:23:46.000000000 +0100
@@ -1500,6 +1500,11 @@
 	platform_set_drvdata(pdev, data);
 
 	start_reg = f71882fg_read8(data, F71882FG_REG_START);
+	if (start_reg & 0x04) {
+		dev_warn(&pdev->dev, "Hardware monitor is powered down\n");
+		err = -ENODEV;
+		goto exit_free;
+	}
 	if (!(start_reg & 0x03)) {
 		dev_warn(&pdev->dev, "Hardware monitoring not activated\n");
 		err = -ENODEV;

--------------030403060707070705050404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030403060707070705050404--
