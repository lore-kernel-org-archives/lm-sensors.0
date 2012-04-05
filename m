From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 05 Apr 2012 21:52:05 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (smsc47m1) Fix compiler warning
Message-Id: <1333662725-24514-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some configurations produce the following compiler warning:

drivers/hwmon/smsc47m1.c: In function 'sm_smsc47m1_init':
drivers/hwmon/smsc47m1.c:938: warning: 'address' may be used uninitialized in this function

While this is a false positive, it can easily be fixed by overloading the return
value from smsc47m1_find with both address and error return code (the address
is an unsigned short and thus never negative). This also reduces module size by
a few bytes (46 bytes for x86_64).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Don't assign an integer return value to an unsigned

 drivers/hwmon/smsc47m1.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index c590c14..b5aa38d 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -491,10 +491,10 @@ static const struct attribute_group smsc47m1_group = {
 	.attrs = smsc47m1_attributes,
 };
 
-static int __init smsc47m1_find(unsigned short *addr,
-				struct smsc47m1_sio_data *sio_data)
+static int __init smsc47m1_find(struct smsc47m1_sio_data *sio_data)
 {
 	u8 val;
+	unsigned short addr;
 
 	superio_enter();
 	val = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
@@ -546,9 +546,9 @@ static int __init smsc47m1_find(unsigned short *addr,
 	}
 
 	superio_select();
-	*addr = (superio_inb(SUPERIO_REG_BASE) << 8)
+	addr = (superio_inb(SUPERIO_REG_BASE) << 8)
 	      |  superio_inb(SUPERIO_REG_BASE + 1);
-	if (*addr = 0) {
+	if (addr = 0) {
 		pr_info("Device address not set, will not use\n");
 		superio_exit();
 		return -ENODEV;
@@ -565,7 +565,7 @@ static int __init smsc47m1_find(unsigned short *addr,
 	}
 
 	superio_exit();
-	return 0;
+	return addr;
 }
 
 /* Restore device to its initial state */
@@ -938,13 +938,15 @@ static int __init sm_smsc47m1_init(void)
 	unsigned short address;
 	struct smsc47m1_sio_data sio_data;
 
-	if (smsc47m1_find(&address, &sio_data))
-		return -ENODEV;
+	err = smsc47m1_find(&sio_data);
+	if (err < 0)
+		return err;
+	address = err;
 
 	/* Sets global pdev as a side effect */
 	err = smsc47m1_device_add(address, &sio_data);
 	if (err)
-		goto exit;
+		return err;
 
 	err = platform_driver_probe(&smsc47m1_driver, smsc47m1_probe);
 	if (err)
@@ -955,7 +957,6 @@ static int __init sm_smsc47m1_init(void)
 exit_device:
 	platform_device_unregister(pdev);
 	smsc47m1_restore(&sio_data);
-exit:
 	return err;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
