From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:01 +0000
Subject: [lm-sensors] [PATCH] I2C: add kobj_to_i2c_client
Message-Id: <11259567642948@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: add kobj_to_i2c_client

Move the inline function kobj_to_i2c_client() from max6875.c to i2c.h.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a61fc683ae1b7871d8d81ac5025af1a923731547
tree 8b141faa2d84653075b6baea18e64e7302345cbd
parent 5033017c2678df9dc75be0139f19701ff224a498
author bgardner@wabtec.com <bgardner@wabtec.com> Wed, 27 Jul 2005 12:43:03 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:05 -0700

 drivers/i2c/chips/max6875.c |    5 -----
 include/linux/i2c.h         |    5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -131,11 +131,6 @@ exit_up:
 	up(&data->update_lock);
 }
 
-static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
-{
-	return to_i2c_client(container_of(kobj, struct device, kobj));
-}
-
 static ssize_t max6875_read(struct kobject *kobj, char *buf, loff_t off,
 			    size_t count)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -160,6 +160,11 @@ struct i2c_client {
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
+static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
+{
+	return to_i2c_client(container_of(kobj, struct device, kobj));
+}
+
 static inline void *i2c_get_clientdata (struct i2c_client *dev)
 {
 	return dev_get_drvdata (&dev->dev);

