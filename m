From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 14:24:43 +0000
Subject: [lm-sensors] PATCH: f71882fg move some io access from the detect to
Message-Id: <48FDE62B.7020607@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040001050304070307080809"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040001050304070307080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The f71882fg driver did some io to ioports it hadn't reserved yet in its
find (detect) function, this patches moves this io to the probe function
where these ports are reserved and this io belongs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------040001050304070307080809
Content-Type: text/plain;
 name="f71882fg-no-io-to-unreserverd-ports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="f71882fg-no-io-to-unreserverd-ports.patch"

The f71882fg driver did some io to ioports it hadn't reserved yet in its
find (detect) function, this patches moves this io to the probe function
where these ports are reserved and this io belongs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.f71862fg	2008-10-21 15:34:41.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2008-10-21 15:50:34.000000000 +0200
@@ -1495,7 +1495,7 @@
 {
 	struct f71882fg_data *data;
 	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
-	int err;
+	int err = 0;
 	u8 start_reg;
 
 	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
@@ -1507,12 +1507,31 @@
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
+	start_reg = f71882fg_read8(data, F71882FG_REG_START);
+	if (!(start_reg & 0x03)) {
+		printk(KERN_WARNING DRVNAME
+			": Hardware monitoring not activated\n");
+		goto exit_free;
+	}
+
+	/* If it is a 71862 and the fan / pwm part is enabled sanity check
+	   the pwm settings */
+	if (data->type == f71862fg && (start_reg & 0x02)) {
+		u8 reg = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
+		if ((reg & 0x15) != 0x15) {
+			printk(KERN_ERR DRVNAME
+				": Invalid (reserved) pwm settings: 0x%02x\n",
+				(unsigned int)reg);
+			err = -EIO;
+			goto exit_free;
+		}
+	}
+
 	/* Register sysfs interface files */
 	err = device_create_file(&pdev->dev, &dev_attr_name);
 	if (err)
 		goto exit_unregister_sysfs;
 
-	start_reg = f71882fg_read8(data, F71882FG_REG_START);
 	if (start_reg & 0x01) {
 		err = f71882fg_create_sysfs_files(pdev, f718x2fg_in_temp_attr,
 					ARRAY_SIZE(f718x2fg_in_temp_attr));
@@ -1558,7 +1577,9 @@
 
 exit_unregister_sysfs:
 	f71882fg_remove(pdev); /* Will unregister the sysfs files for us */
-
+	return err; /* f71882fg_remove() also frees our data */
+exit_free:
+	kfree(data);
 	return err;
 }
 
@@ -1600,8 +1621,6 @@
 {
 	int err = -ENODEV;
 	u16 devid;
-	u8 reg;
-	struct f71882fg_data data;
 
 	superio_enter(sioaddr);
 
@@ -1638,25 +1657,6 @@
 	}
 	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
-	data.addr = *address;
-	reg = f71882fg_read8(&data, F71882FG_REG_START);
-	if (!(reg & 0x03)) {
-		printk(KERN_WARNING DRVNAME
-			": Hardware monitoring not activated\n");
-		goto exit;
-	}
-
-	/* If it is a 71862 and the fan / pwm part is enabled sanity check
-	   the pwm settings */
-	if (sio_data->type == f71862fg && (reg & 0x02)) {
-		reg = f71882fg_read8(&data, F71882FG_REG_PWM_ENABLE);
-		if ((reg & 0x15) != 0x15) {
-			printk(KERN_ERR DRVNAME
-				": Invalid (reserved) pwm settings: 0x%02x\n",
-				(unsigned int)reg);
-			goto exit;
-		}
-	}
 	err = 0;
 	printk(KERN_INFO DRVNAME ": Found %s chip at %#x, revision %d\n",
 		f71882fg_names[sio_data->type],	(unsigned int)*address,

--------------040001050304070307080809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040001050304070307080809--
