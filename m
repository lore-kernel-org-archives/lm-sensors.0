From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 22:58:15 +0000
Subject: [lm-sensors] [PATCH 05/14] Owner field additions to many i2c
Message-Id: <20051017225835.418f46f4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-owner-field-05-i2c-isa.patch

In function i2c_isa_add_driver, copied driver should inherit the owner
field as well as the name field.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-isa.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-isa.c	2005-10-08 18:20:05.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-isa.c	2005-10-08 18:23:21.000000000 +0200
@@ -92,6 +92,7 @@
 
 	/* Add the driver to the list of i2c drivers in the driver core */
 	driver->driver.name = driver->name;
+	driver->driver.owner = driver->owner;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_isa_device_probe;
 	driver->driver.remove = i2c_isa_device_remove;

-- 
Jean Delvare
