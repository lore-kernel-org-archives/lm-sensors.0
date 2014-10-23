From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 23 Oct 2014 09:40:47 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (i5500_temp) Don't bind to disabled sensors
Message-Id: <20141023114047.3be4ca6b@endymion.delvare>
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1:
* Also check the value of register TSTIMER, to improve the reliability
  of the heuristic.

 drivers/hwmon/i5500_temp.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-3.17.orig/drivers/hwmon/i5500_temp.c	2014-10-23 11:21:54.204198524 +0200
+++ linux-3.17/drivers/hwmon/i5500_temp.c	2014-10-23 11:31:20.376347502 +0200
@@ -121,6 +121,8 @@ static int i5500_temp_probe(struct pci_d
 {
 	int err;
 	struct device *hwmon_dev;
+	u32 tstimer;
+	s8 tsfsc;
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -128,6 +130,13 @@ static int i5500_temp_probe(struct pci_d
 		return err;
 	}
 
+	pci_read_config_byte(pdev, REG_TSFSC, &tsfsc);
+	pci_read_config_dword(pdev, REG_TSTIMER, &tstimer);
+	if (tsfsc = 0x7F && tstimer = 0x07D30D40) {
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
