From: laurent.riffard@free.fr (Laurent Riffard)
Date: Fri, 30 Sep 2005 16:52:36 +0000
Subject: [lm-sensors] [PATCH 2.6-mm 4/5] i2c: update .owner field for i2c
Message-Id: <433D50EC.1070305@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch updates the .owner field for the i2c core struct xxxx_driver
variables. 


Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---

Index: linux-2.6-mm/drivers/i2c/i2c-core.c
=================================--- linux-2.6-mm.orig/drivers/i2c/i2c-core.c	2005-09-08 16:47:36.789310500 +0200
+++ linux-2.6-mm/drivers/i2c/i2c-core.c	2005-09-10 10:49:14.855249500 +0200
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




-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050930/38e8947b/signature-0001.bin
