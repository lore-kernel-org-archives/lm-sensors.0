From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:16:21 +0000
Subject: [lm-sensors] [PATCH] Owner field additions to many i2c drivers,
Message-Id: <11305336614074@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11305336621501@kroah.com>
In-Reply-To: <11305336621501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] Owner field additions to many i2c drivers, 4 of 5

This patch updates the .owner field for the i2c core struct xxxx_driver
variables.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6586bcd7b2bbe255110b2db772da4415c7865a2a
tree 0f5b10ccc7656fef1817c8fb7489aff51389de54
parent e78f857cc5299c3f6b3d046084696ef205948837
author Laurent Riffard <laurent.riffard@free.fr> Mon, 17 Oct 2005 22:54:45 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:11 -0700

 drivers/i2c/i2c-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 1535417..0040981 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -85,6 +85,7 @@ void i2c_adapter_dev_release(struct devi
 }
 
 struct device_driver i2c_adapter_driver = {
+	.owner = THIS_MODULE,
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
 	.probe = i2c_device_probe,
@@ -98,6 +99,7 @@ static void i2c_adapter_class_dev_releas
 }
 
 struct class i2c_adapter_class = {
+	.owner =	THIS_MODULE,
 	.name =		"i2c-adapter",
 	.release =	&i2c_adapter_class_dev_release,
 };
@@ -291,6 +293,7 @@ int i2c_add_driver(struct i2c_driver *dr
 	down(&core_lists);
 
 	/* add the driver to the list of i2c drivers in the driver core */
+	driver->driver.owner = driver->owner;
 	driver->driver.name = driver->name;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_device_probe;

