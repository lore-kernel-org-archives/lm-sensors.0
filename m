From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:10 +0000
Subject: [lm-sensors] [PATCH 44/44] [PATCH] I2C: I2C controllers go into
Message-Id: <11510010632165-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: David Brownell <david-b at pacbell.net>

I2C creates some sysfs nodes in the wrong places:  not as children of parent
controllers, but as their peers (!).  This puts them into the right place
always, instead of just when the adapter is on the platform bus.

Signed-off-by: David Brownell <dbrownell at users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-dev.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ed7eed3..58ccddd 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -426,10 +426,7 @@ static int i2cdev_attach_adapter(struct 
 
 	/* register this i2c device with the driver core */
 	i2c_dev->adap = adap;
-	if (adap->dev.parent = &platform_bus)
-		dev = &adap->dev;
-	else
-		dev = adap->dev.parent;
+	dev = &adap->dev;
 	i2c_dev->class_dev = class_device_create(i2c_dev_class, NULL,
 						 MKDEV(I2C_MAJOR, i2c_dev->minor),
 						 dev, "i2c-%d", i2c_dev->minor);
-- 
1.4.0


