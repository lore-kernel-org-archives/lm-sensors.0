From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:34 +0000
Subject: [lm-sensors] [PATCH 3/30] i2c-dev: Drop the client template
Message-Id: <11593189281219-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-dev: Drop the client template

Drop the i2c-dev client template. This saves about 360 bytes of
memory. I got the idea from a similar cleanup Hans-Frieder Vogt
made to i2c-nforce2 recently.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-dev.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 206e805..2ce0833 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -37,7 +37,7 @@ #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <asm/uaccess.h>
 
-static struct i2c_client i2cdev_client_template;
+static struct i2c_driver i2cdev_driver;
 
 struct i2c_dev {
 	struct list_head list;
@@ -365,12 +365,13 @@ static int i2cdev_open(struct inode *ino
 	if (!adap)
 		return -ENODEV;
 
-	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client) {
 		i2c_put_adapter(adap);
 		return -ENOMEM;
 	}
-	memcpy(client, &i2cdev_client_template, sizeof(*client));
+	snprintf(client->name, I2C_NAME_SIZE, "i2c-dev %d", adap->nr);
+	client->driver = &i2cdev_driver;
 
 	/* registered with adapter, passed as client to user */
 	client->adapter = adap;
@@ -459,12 +460,6 @@ static struct i2c_driver i2cdev_driver  	.detach_client	= i2cdev_detach_client,
 };
 
-static struct i2c_client i2cdev_client_template = {
-	.name		= "I2C /dev entry",
-	.addr		= -1,
-	.driver		= &i2cdev_driver,
-};
-
 static int __init i2c_dev_init(void)
 {
 	int res;
-- 
1.4.2.1


