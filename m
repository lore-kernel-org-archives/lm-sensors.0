From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jan 2008 20:22:44 +0000
Subject: [lm-sensors] [PATCH] hwmon (w83627ehf) The W83627DHG has 8 VID pins
Message-Id: <20080103212244.12801061@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

While the W83627EHF/EHG has only 6 VID pins, the W83627DHG has 8 VID
pins, to support VRD 11.0. Add support for this.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83627ehf |    5 +++--
 drivers/hwmon/w83627ehf.c     |   18 ++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

--- linux-2.6.24-rc6.orig/Documentation/hwmon/w83627ehf	2007-12-26 11:58:56.000000000 +0100
+++ linux-2.6.24-rc6/Documentation/hwmon/w83627ehf	2007-12-26 14:39:06.000000000 +0100
@@ -23,8 +23,9 @@ W83627DHG super I/O chips. We will refer
 
 The chips implement three temperature sensors, five fan rotation
 speed sensors, ten analog voltage sensors (only nine for the 627DHG), one
-VID (6 pins), alarms with beep warnings (control unimplemented), and
-some automatic fan regulation strategies (plus manual fan control mode).
+VID (6 pins for the 627EHF/EHG, 8 pins for the 627DHG), alarms with beep
+warnings (control unimplemented), and some automatic fan regulation
+strategies (plus manual fan control mode).
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
--- linux-2.6.24-rc6.orig/drivers/hwmon/w83627ehf.c	2007-12-26 14:39:06.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/w83627ehf.c	2007-12-26 14:39:06.000000000 +0100
@@ -1202,8 +1202,7 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_temp[i].dev_attr);
 
 	device_remove_file(dev, &dev_attr_name);
-	if (data->vid != 0x3f)
-		device_remove_file(dev, &dev_attr_cpu0_vid);
+	device_remove_file(dev, &dev_attr_cpu0_vid);
 }
 
 /* Get the monitoring functions started */
@@ -1303,11 +1302,16 @@ static int __devinit w83627ehf_probe(str
 			}
 		}
 
-		data->vid = superio_inb(sio_data->sioreg, SIO_REG_VID_DATA) & 0x3f;
+		data->vid = superio_inb(sio_data->sioreg, SIO_REG_VID_DATA);
+		if (sio_data->kind = w83627ehf) /* 6 VID pins only */
+			data->vid &= 0x3f;
+
+		err = device_create_file(dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_release;
 	} else {
 		dev_info(dev, "VID pins in output mode, CPU VID not "
 			 "available\n");
-		data->vid = 0x3f;
 	}
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
@@ -1390,12 +1394,6 @@ static int __devinit w83627ehf_probe(str
 	if (err)
 		goto exit_remove;
 
-	if (data->vid != 0x3f) {
-		err = device_create_file(dev, &dev_attr_cpu0_vid);
-		if (err)
-			goto exit_remove;
-	}
-
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
