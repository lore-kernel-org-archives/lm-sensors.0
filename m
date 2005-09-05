From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:49 +0000
Subject: [lm-sensors] [PATCH] I2C: Separate non-i2c hwmon drivers from
Message-Id: <11259567663617@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Separate non-i2c hwmon drivers from i2c-core (1/9)

Temporarily export a few structures and functions from i2c-core, because we
will soon need them in i2c-isa.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit efde723fdac02111872bff606ef362074fc1efa8
tree 31e5cff31af33f38dfdcaa65cebd935f2a3f7fdc
parent 943b0830cebe4711354945ed3cb44e84152aaca0
author Jean Delvare <khali@linux-fr.org> Wed, 20 Jul 2005 23:03:50 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:09 -0700

 drivers/i2c/i2c-core.c |   14 ++++++++++----
 include/linux/i2c.h    |    7 +++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -61,7 +61,7 @@ static int i2c_bus_resume(struct device 
 	return rc;
 }
 
-static struct bus_type i2c_bus_type = {
+struct bus_type i2c_bus_type = {
 	.name =		"i2c",
 	.match =	i2c_device_match,
 	.suspend =      i2c_bus_suspend,
@@ -78,13 +78,13 @@ static int i2c_device_remove(struct devi
 	return 0;
 }
 
-static void i2c_adapter_dev_release(struct device *dev)
+void i2c_adapter_dev_release(struct device *dev)
 {
 	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
 	complete(&adap->dev_released);
 }
 
-static struct device_driver i2c_adapter_driver = {
+struct device_driver i2c_adapter_driver = {
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
 	.probe = i2c_device_probe,
@@ -97,7 +97,7 @@ static void i2c_adapter_class_dev_releas
 	complete(&adap->class_dev_released);
 }
 
-static struct class i2c_adapter_class = {
+struct class i2c_adapter_class = {
 	.name =		"i2c-adapter",
 	.release =	&i2c_adapter_class_dev_release,
 };
@@ -1171,6 +1171,12 @@ s32 i2c_smbus_xfer(struct i2c_adapter * 
 }
 
 
+/* Next four are needed by i2c-isa */
+EXPORT_SYMBOL_GPL(i2c_adapter_dev_release);
+EXPORT_SYMBOL_GPL(i2c_adapter_driver);
+EXPORT_SYMBOL_GPL(i2c_adapter_class);
+EXPORT_SYMBOL_GPL(i2c_bus_type);
+
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -34,6 +34,13 @@
 #include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
 
+/* --- For i2c-isa ---------------------------------------------------- */
+
+extern void i2c_adapter_dev_release(struct device *dev);
+extern struct device_driver i2c_adapter_driver;
+extern struct class i2c_adapter_class;
+extern struct bus_type i2c_bus_type;
+
 /* --- General options ------------------------------------------------	*/
 
 struct i2c_msg;

