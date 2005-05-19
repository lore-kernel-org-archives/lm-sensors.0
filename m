From: bunk@stusta.de (Adrian Bunk)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [2.6 patch] i2c-core.c: make some code static
Message-Id: <20050131185955.GA18316@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com, phil@netroedge.com
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/i2c/i2c-core.c |   79 ++++++++++++++++++++---------------------
 include/linux/i2c.h    |    2 -
 2 files changed, 39 insertions(+), 42 deletions(-)

--- linux-2.6.11-rc2-mm2-full/include/linux/i2c.h.old	2005-01-31 19:16:45.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/i2c.h	2005-01-31 19:16:52.000000000 +0100
@@ -134,8 +134,6 @@
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-extern struct bus_type i2c_bus_type;
-
 #define I2C_NAME_SIZE	50
 
 /*
--- linux-2.6.11-rc2-mm2-full/drivers/i2c/i2c-core.c.old	2005-01-31 19:17:00.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/i2c/i2c-core.c	2005-01-31 19:20:45.000000000 +0100
@@ -38,12 +38,43 @@
 static DECLARE_MUTEX(core_lists);
 static DEFINE_IDR(i2c_adapter_idr);
 
-int i2c_device_probe(struct device *dev)
+/* match always succeeds, as we want the probe() to tell if we really accept this match */
+static int i2c_device_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int i2c_bus_suspend(struct device * dev, pm_message_t state)
+{
+	int rc = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		rc = dev->driver->suspend(dev,state,0);
+	return rc;
+}
+
+static int i2c_bus_resume(struct device * dev)
+{
+	int rc = 0;
+	
+	if (dev->driver && dev->driver->resume)
+		rc = dev->driver->resume(dev,0);
+	return rc;
+}
+
+static struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+	.suspend =      i2c_bus_suspend,
+	.resume =       i2c_bus_resume,
+};
+
+static int i2c_device_probe(struct device *dev)
 {
 	return -ENODEV;
 }
 
-int i2c_device_remove(struct device *dev)
+static int i2c_device_remove(struct device *dev)
 {
 	return 0;
 }
@@ -523,38 +554,6 @@
        up(&adap->clist_lock);
 }
 
-
-/* match always succeeds, as we want the probe() to tell if we really accept this match */
-static int i2c_device_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
-static int i2c_bus_suspend(struct device * dev, pm_message_t state)
-{
-	int rc = 0;
-
-	if (dev->driver && dev->driver->suspend)
-		rc = dev->driver->suspend(dev,state,0);
-	return rc;
-}
-
-static int i2c_bus_resume(struct device * dev)
-{
-	int rc = 0;
-	
-	if (dev->driver && dev->driver->resume)
-		rc = dev->driver->resume(dev,0);
-	return rc;
-}
-
-struct bus_type i2c_bus_type = {
-	.name =		"i2c",
-	.match =	i2c_device_match,
-	.suspend =      i2c_bus_suspend,
-	.resume =       i2c_bus_resume,
-};
-
 static int __init i2c_init(void)
 {
 	int retval;
@@ -860,7 +859,7 @@
 /* CRC over count bytes in the first array plus the bytes in the rest
    array if it is non-null. rest[0] is the (length of rest) - 1
    and is included. */
-u8 i2c_smbus_partial_pec(u8 crc, int count, u8 *first, u8 *rest)
+static u8 i2c_smbus_partial_pec(u8 crc, int count, u8 *first, u8 *rest)
 {
 	int i;
 
@@ -872,7 +871,7 @@
 	return crc;
 }
 
-u8 i2c_smbus_pec(int count, u8 *first, u8 *rest)
+static u8 i2c_smbus_pec(int count, u8 *first, u8 *rest)
 {
 	return i2c_smbus_partial_pec(0, count, first, rest);
 }
@@ -880,8 +879,8 @@
 /* Returns new "size" (transaction type)
    Note that we convert byte to byte_data and byte_data to word_data
    rather than invent new xxx_PEC transactions. */
-int i2c_smbus_add_pec(u16 addr, u8 command, int size,
-                      union i2c_smbus_data *data)
+static int i2c_smbus_add_pec(u16 addr, u8 command, int size,
+			     union i2c_smbus_data *data)
 {
 	u8 buf[3];
 
@@ -910,8 +909,8 @@
 	return size;	
 }
 
-int i2c_smbus_check_pec(u16 addr, u8 command, int size, u8 partial,
-                        union i2c_smbus_data *data)
+static int i2c_smbus_check_pec(u16 addr, u8 command, int size, u8 partial,
+			       union i2c_smbus_data *data)
 {
 	u8 buf[3], rpec, cpec;
 
