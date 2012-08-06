From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Aug 2012 14:22:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71882fg) Fix build warning
Message-Id: <1344262974-26914-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:

warning: 'address' may be used uninitialized in this function [-Wuninitialized]

While this is a false warning, the patch reduces module size on x86_64 by
approximately 175 bytes, so it is still worth the effort.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f71882fg.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 6d12263..bc1b205 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2532,10 +2532,10 @@ static int f71882fg_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init f71882fg_find(int sioaddr, unsigned short *address,
-	struct f71882fg_sio_data *sio_data)
+static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 {
 	u16 devid;
+	unsigned short address;
 	int err = superio_enter(sioaddr);
 	if (err)
 		return err;
@@ -2603,17 +2603,17 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 		goto exit;
 	}
 
-	*address = superio_inw(sioaddr, SIO_REG_ADDR);
-	if (*address = 0) {
+	address = superio_inw(sioaddr, SIO_REG_ADDR);
+	if (address = 0) {
 		pr_warn("Base address not set\n");
 		err = -ENODEV;
 		goto exit;
 	}
-	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
+	address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
-	err = 0;
+	err = address;
 	pr_info("Found %s chip at %#x, revision %d\n",
-		f71882fg_names[sio_data->type],	(unsigned int)*address,
+		f71882fg_names[sio_data->type],	(unsigned int)address,
 		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
 exit:
 	superio_exit(sioaddr);
@@ -2674,13 +2674,15 @@ static int __init f71882fg_init(void)
 
 	memset(&sio_data, 0, sizeof(sio_data));
 
-	if (f71882fg_find(0x2e, &address, &sio_data) &&
-	    f71882fg_find(0x4e, &address, &sio_data))
-		goto exit;
+	address = f71882fg_find(0x2e, &sio_data);
+	if (address < 0)
+		address = f71882fg_find(0x4e, &sio_data);
+	if (address < 0)
+		return address;
 
 	err = platform_driver_register(&f71882fg_driver);
 	if (err)
-		goto exit;
+		return err;
 
 	err = f71882fg_device_add(address, &sio_data);
 	if (err)
@@ -2690,7 +2692,6 @@ static int __init f71882fg_init(void)
 
 exit_driver:
 	platform_driver_unregister(&f71882fg_driver);
-exit:
 	return err;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
