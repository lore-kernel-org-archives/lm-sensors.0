From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 22:54:26 +0000
Subject: [lm-sensors] [PATCH 04/14] Owner field additions to many i2c
Message-Id: <20051017225445.60bd4297.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-owner-field-04-i2c-core.patch

This patch updates the .owner field for the i2c core struct xxxx_driver
variables. 

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/i2c-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.14-rc3.orig/drivers/i2c/i2c-core.c	2005-10-07 21:35:59.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/i2c-core.c	2005-10-08 18:07:52.000000000 +0200
@@ -85,6 +85,7 @@
 }
 
 struct device_driver i2c_adapter_driver = {
+	.owner = THIS_MODULE,
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
 	.probe = i2c_device_probe,
@@ -98,6 +99,7 @@
 }
 
 struct class i2c_adapter_class = {
+	.owner =	THIS_MODULE,
 	.name =		"i2c-adapter",
 	.release =	&i2c_adapter_class_dev_release,
 };
@@ -291,6 +293,7 @@
 	down(&core_lists);
 
 	/* add the driver to the list of i2c drivers in the driver core */
+	driver->driver.owner = driver->owner;
 	driver->driver.name = driver->name;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_device_probe;

-- 
Jean Delvare
