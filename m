From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:32:18 +0000
Subject: [lm-sensors] [PATCH] Owner field additions to many i2c drivers,
Message-Id: <11305336611836@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11305336621501@kroah.com>
In-Reply-To: <11305336621501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] Owner field additions to many i2c drivers, 5 of 5

In function i2c_isa_add_driver, copied driver should inherit the owner
field as well as the name field.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1747ef1b8c9b7b9c6a9aae3543a9b99acabb7e10
tree 3f436cabbffd56f103ea9464f5056597b474ebd9
parent 6586bcd7b2bbe255110b2db772da4415c7865a2a
author Laurent Riffard <laurent.riffard@free.fr> Mon, 17 Oct 2005 22:58:35 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:11 -0700

 drivers/i2c/busses/i2c-isa.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
index bdc6806..4fdc024 100644
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -92,6 +92,7 @@ int i2c_isa_add_driver(struct i2c_driver
 
 	/* Add the driver to the list of i2c drivers in the driver core */
 	driver->driver.name = driver->name;
+	driver->driver.owner = driver->owner;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_isa_device_probe;
 	driver->driver.remove = i2c_isa_device_remove;

