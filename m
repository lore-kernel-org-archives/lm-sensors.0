From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 08 Feb 2006 19:38:29 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop outdated probe/remove code in i2c-isa
Message-Id: <20060208203829.694cd90b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I guess this should be pushed to Linus before 2.6.16?

Thanks.

* * * * *

Probe and remove methods are now defined at bus level. No more need to
redefine them at driver level in i2c-isa.

This lets us get rid of these annoying messages:
Driver 'it87-isa' needs updating - please use bus_type methods

Thanks to Nicolas Mailhot for reporting the problem and testing the fix.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-isa.c |   12 ------------
 1 file changed, 12 deletions(-)

--- linux-2.6.16-rc2.orig/drivers/i2c/busses/i2c-isa.c	2006-02-07 09:15:08.000000000 +0100
+++ linux-2.6.16-rc2/drivers/i2c/busses/i2c-isa.c	2006-02-07 18:22:46.000000000 +0100
@@ -72,16 +72,6 @@
 }
 static DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
 
-static int i2c_isa_device_probe(struct device *dev)
-{
-	return -ENODEV;
-}
-
-static int i2c_isa_device_remove(struct device *dev)
-{
-	return 0;
-}
-
 
 /* We implement an interface which resembles i2c_{add,del}_driver,
    but for i2c-isa drivers. We don't have to remember and handle lists
@@ -93,8 +83,6 @@
 
 	/* Add the driver to the list of i2c drivers in the driver core */
 	driver->driver.bus = &i2c_bus_type;
-	driver->driver.probe = i2c_isa_device_probe;
-	driver->driver.remove = i2c_isa_device_remove;
 	res = driver_register(&driver->driver);
 	if (res)
 		return res;


-- 
Jean Delvare

