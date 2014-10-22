From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 22 Oct 2014 09:13:21 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (i5500_temp) Don't bind to disabled sensors
Message-Id: <20141022111321.22ab7122@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On many motherboards, for an unknown reason, the thermal sensor seems
to be disabled and will return a constant temperature value of 36.5
degrees Celsius. Don't bind to the device in that case, so that we
don't report this bogus value to userspace.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Romain Dolbeau <romain@dolbeau.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
As suggested by Guenter.

 drivers/hwmon/i5500_temp.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-3.17.orig/drivers/hwmon/i5500_temp.c	2014-10-22 10:22:18.526856485 +0200
+++ linux-3.17/drivers/hwmon/i5500_temp.c	2014-10-22 10:55:22.700413828 +0200
@@ -121,6 +121,7 @@ static int i5500_temp_probe(struct pci_d
 {
 	int err;
 	struct device *hwmon_dev;
+	s8 tsfsc;
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -128,6 +129,12 @@ static int i5500_temp_probe(struct pci_d
 		return err;
 	}
 
+	pci_read_config_byte(pdev, REG_TSFSC, &tsfsc);
+	if (tsfsc = 0x7F) {
+		dev_warn(&pdev->dev, "Sensor seems to be disabled\n");
+		return -ENODEV;
+	}
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
 							   "intel5500", NULL,
 							   i5500_temp_groups);


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
