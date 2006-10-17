From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 17 Oct 2006 18:28:02 +0000
Subject: [lm-sensors] patch hwmon-let-w83781d-and-lm78-load-again.patch
Message-Id: <20061017182901.975E295C97D@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: hwmon: Let w83781d and lm78 load again

to my gregkh-2.6 tree.  Its filename is

     hwmon-let-w83781d-and-lm78-load-again.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Fri Oct 13 07:56:33 2006
Date: Fri, 13 Oct 2006 16:56:28 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: hwmon: Let w83781d and lm78 load again
Message-Id: <20061013165628.b258f035.khali at linux-fr.org>

Let the w83781d and lm78 hardware monitoring drivers load even when
no chip was detected at the ISA address. There can still be supported
chips connected to an I2C bus or SMBus.

This fixes bug #7293.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>


---
 drivers/hwmon/lm78.c         |   12 ++++++------
 drivers/hwmon/w83781d.c      |   12 ++++++------
 drivers/i2c/busses/i2c-isa.c |    2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/lm78.c
+++ gregkh-2.6/drivers/hwmon/lm78.c
@@ -815,18 +815,18 @@ static int __init sm_lm78_init(void)
 	if (res)
 		return res;
 
-	res = i2c_isa_add_driver(&lm78_isa_driver);
-	if (res) {
-		i2c_del_driver(&lm78_driver);
-		return res;
-	}
+	/* Don't exit if this one fails, we still want the I2C variants
+	   to work! */
+	if (i2c_isa_add_driver(&lm78_isa_driver))
+		isa_address = 0;
 
 	return 0;
 }
 
 static void __exit sm_lm78_exit(void)
 {
-	i2c_isa_del_driver(&lm78_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&lm78_isa_driver);
 	i2c_del_driver(&lm78_driver);
 }
 
--- gregkh-2.6.orig/drivers/hwmon/w83781d.c
+++ gregkh-2.6/drivers/hwmon/w83781d.c
@@ -1685,11 +1685,10 @@ sensors_w83781d_init(void)
 	if (res)
 		return res;
 
-	res = i2c_isa_add_driver(&w83781d_isa_driver);
-	if (res) {
-		i2c_del_driver(&w83781d_driver);
-		return res;
-	}
+	/* Don't exit if this one fails, we still want the I2C variants
+	   to work! */
+	if (i2c_isa_add_driver(&w83781d_isa_driver))
+		isa_address = 0;
 
 	return 0;
 }
@@ -1697,7 +1696,8 @@ sensors_w83781d_init(void)
 static void __exit
 sensors_w83781d_exit(void)
 {
-	i2c_isa_del_driver(&w83781d_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&w83781d_isa_driver);
 	i2c_del_driver(&w83781d_driver);
 }
 
--- gregkh-2.6.orig/drivers/i2c/busses/i2c-isa.c
+++ gregkh-2.6/drivers/i2c/busses/i2c-isa.c
@@ -91,7 +91,7 @@ int i2c_isa_add_driver(struct i2c_driver
 	/* Now look for clients */
 	res = driver->attach_adapter(&isa_adapter);
 	if (res) {
-		dev_err(&isa_adapter.dev,
+		dev_dbg(&isa_adapter.dev,
 			"Driver %s failed to attach adapter, unregistering\n",
 			driver->driver.name);
 		driver_unregister(&driver->driver);


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-documentation-typos.patch
i2c/hwmon-k8temp-documentation-update.patch
i2c/hwmon-smsc47m112-documentation.patch
i2c/hwmon-unchecked-return-status-fixes-w83791d.patch
i2c/hwmon-update-Grant-Coady-email-address.patch
i2c/hwmon-w83627ehf-fix-fan5-detection.patch
i2c/i2c-scx200_acb-handle-pci-errors.patch
i2c/hwmon-fix-debug-messages-in-w83781d.patch
i2c/hwmon-let-w83781d-and-lm78-load-again.patch
driver-class/i2c-dev-device.patch
driver-class/i2c-dev-device.old.patch

