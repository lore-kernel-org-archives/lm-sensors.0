From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Dec 2009 13:17:20 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (smsc47m1) Enable device if needed
Message-Id: <20091206141720.0b0e1653@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If the address is set but the device isn't enabled, attempt to enable
it. If it won't work for any reason (resource conflict, no function
enabled) the initial state is restored. The initial state is also
restored on module unloading.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- linux-2.6.33-rc0.orig/drivers/hwmon/smsc47m1.c	2009-12-06 14:02:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/smsc47m1.c	2009-12-06 14:08:33.000000000 +0100
@@ -136,6 +136,7 @@ struct smsc47m1_data {
 
 struct smsc47m1_sio_data {
 	enum chips type;
+	u8 activate;		/* Remember initial device state */
 };
 
 
@@ -468,17 +469,38 @@ static int __init smsc47m1_find(unsigned
 	superio_select();
 	*addr = (superio_inb(SUPERIO_REG_BASE) << 8)
 	      |  superio_inb(SUPERIO_REG_BASE + 1);
-	val = superio_inb(SUPERIO_REG_ACT);
-	if (*addr = 0 || (val & 0x01) = 0) {
-		pr_info(DRVNAME ": Device is disabled, will not use\n");
+	if (*addr = 0) {
+		pr_info(DRVNAME ": Device address not set, will not use\n");
 		superio_exit();
 		return -ENODEV;
 	}
 
+	/* Enable only if address is set (needed at least on the
+	 * Compaq Presario S4000NX) */
+	sio_data->activate = superio_inb(SUPERIO_REG_ACT);
+	if ((sio_data->activate & 0x01) = 0) {
+		pr_info(DRVNAME ": Enabling device\n");
+		superio_outb(SUPERIO_REG_ACT, sio_data->activate | 0x01);
+	}
+
 	superio_exit();
 	return 0;
 }
 
+/* Restore device to its initial state */
+static void __init smsc47m1_restore(const struct smsc47m1_sio_data *sio_data)
+{
+	if ((sio_data->activate & 0x01) = 0) {
+		superio_enter();
+		superio_select();
+
+		pr_info(DRVNAME ": Disabling device\n");
+		superio_outb(SUPERIO_REG_ACT, sio_data->activate);
+
+		superio_exit();
+	}
+}
+
 #define CHECK		1
 #define REQUEST		2
 #define RELEASE		3
@@ -856,6 +878,7 @@ static int __init sm_smsc47m1_init(void)
 
 exit_device:
 	platform_device_unregister(pdev);
+	smsc47m1_restore(&sio_data);
 exit:
 	return err;
 }
@@ -863,6 +886,7 @@ exit:
 static void __exit sm_smsc47m1_exit(void)
 {
 	platform_driver_unregister(&smsc47m1_driver);
+	smsc47m1_restore(pdev->dev.platform_data);
 	platform_device_unregister(pdev);
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
