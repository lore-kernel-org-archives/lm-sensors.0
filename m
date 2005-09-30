From: laurent.riffard@free.fr (Laurent Riffard)
Date: Fri, 30 Sep 2005 16:52:38 +0000
Subject: [lm-sensors] [PATCH 2.6-mm 5/5] i2c: make i2c-isa drivers inherits
Message-Id: <433D50FC.30907@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In function i2c_isa_add_driver, copied driver should inherit the owner field
as well as the name field.


Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---

Index: linux-2.6-mm/drivers/i2c/busses/i2c-isa.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-isa.c      2005-09-30 16:27:50.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-isa.c   2005-09-30 16:34:00.903153000 +0200
@@ -92,6 +92,7 @@

        /* Add the driver to the list of i2c drivers in the driver core */
        driver->driver.name = driver->name;
+       driver->driver.owner = driver->owner;
        driver->driver.bus = &i2c_bus_type;
        driver->driver.probe = i2c_isa_device_probe;
        driver->driver.remove = i2c_isa_device_remove;



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050930/d6b71bde/signature.bin
