From: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Date: Wed, 24 Oct 2007 12:59:09 +0000
Subject: [lm-sensors] [PATCH] Hardware Monitor LM70: Convert semaphore to
Message-Id: <20071024125909.GA9095@traven>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mhoffman@lightlink.com, Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Hardware Monitor LM70: Convert the semaphore lm70->sem to the mutex
API

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

--

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index dd36688..d435f00 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -31,14 +31,15 @@
 #include <linux/err.h>
 #include <linux/sysfs.h>
 #include <linux/hwmon.h>
+#include <linux/mutex.h>
 #include <linux/spi/spi.h>
-#include <asm/semaphore.h>
+
 
 #define DRVNAME		"lm70"
 
 struct lm70 {
 	struct device *hwmon_dev;
-	struct semaphore sem;
+	struct mutex lock;
 };
 
 /* sysfs hook function */
@@ -51,7 +52,7 @@ static ssize_t lm70_sense_temp(struct device *dev,
 	s16 raw=0;
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
 
-	if (down_interruptible(&p_lm70->sem))
+	if (mutex_lock_interruptible(&p_lm70->lock))
 		return -ERESTARTSYS;
 
 	/*
@@ -83,7 +84,7 @@ static ssize_t lm70_sense_temp(struct device *dev,
 	val = ((int)raw/32) * 250;
 	status = sprintf(buf, "%d\n", val); /* millidegrees Celsius */
 out:
-	up(&p_lm70->sem);
+	mutex_unlock(&p_lm70->lock);
 	return status;
 }
 
@@ -112,7 +113,7 @@ static int __devinit lm70_probe(struct spi_device *spi)
 	if (!p_lm70)
 		return -ENOMEM;
 
-	init_MUTEX(&p_lm70->sem);
+	mutex_init(&p_lm70->lock);
 
 	/* sysfs hook */
 	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
 
-- 
Matthias Kaehlcke
Linux Application Developer
Barcelona

              We build too many walls and not enough bridges
                             (Isaac Newton)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
