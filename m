From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:31:16 +0000
Subject: [lm-sensors] [patch 1/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212540.426764000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the core of the i2c drivers: it removes .name and
.owner fields from the struct i2c_device and modify various
functions to use struct device fields instead.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/i2c/busses/i2c-isa.c |    4 +---
 drivers/i2c/i2c-core.c       |   18 +++++++++---------
 drivers/i2c/i2c-dev.c        |    6 ++++--
 include/linux/i2c.h          |    5 +++--
 4 files changed, 17 insertions(+), 16 deletions(-)

Index: linux-2.6-mm/drivers/i2c/i2c-core.c
=================================--- linux-2.6-mm.orig/drivers/i2c/i2c-core.c
+++ linux-2.6-mm/drivers/i2c/i2c-core.c
@@ -233,7 +233,8 @@
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
 				dev_err(&adap->dev, "detach_adapter failed "
-					"for driver [%s]\n", driver->name);
+					"for driver [%s]\n",
+					driver->driver.name);
 				goto out_unlock;
 			}
 	}
@@ -293,8 +294,6 @@
 	down(&core_lists);
 
 	/* add the driver to the list of i2c drivers in the driver core */
-	driver->driver.owner = driver->owner;
-	driver->driver.name = driver->name;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_device_probe;
 	driver->driver.remove = i2c_device_remove;
@@ -342,7 +341,8 @@
 		if (driver->detach_adapter) {
 			if ((res = driver->detach_adapter(adap))) {
 				dev_err(&adap->dev, "detach_adapter failed "
-					"for driver [%s]\n", driver->name);
+					"for driver [%s]\n",
+					driver->driver.name);
 				goto out_unlock;
 			}
 		} else {
@@ -473,10 +473,10 @@
 static int i2c_inc_use_client(struct i2c_client *client)
 {
 
-	if (!try_module_get(client->driver->owner))
+	if (!try_module_get(client->driver->driver.owner))
 		return -ENODEV;
 	if (!try_module_get(client->adapter->owner)) {
-		module_put(client->driver->owner);
+		module_put(client->driver->driver.owner);
 		return -ENODEV;
 	}
 
@@ -485,7 +485,7 @@
 
 static void i2c_dec_use_client(struct i2c_client *client)
 {
-	module_put(client->driver->owner);
+	module_put(client->driver->driver.owner);
 	module_put(client->adapter->owner);
 }
 
@@ -537,14 +537,14 @@
 	down(&adap->clist_lock);
 	list_for_each(item,&adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
-		if (!try_module_get(client->driver->owner))
+		if (!try_module_get(client->driver->driver.owner))
 			continue;
 		if (NULL != client->driver->command) {
 			up(&adap->clist_lock);
 			client->driver->command(client,cmd,arg);
 			down(&adap->clist_lock);
 		}
-		module_put(client->driver->owner);
+		module_put(client->driver->driver.owner);
        }
        up(&adap->clist_lock);
 }
Index: linux-2.6-mm/include/linux/i2c.h
=================================--- linux-2.6-mm.orig/include/linux/i2c.h
+++ linux-2.6-mm/include/linux/i2c.h
@@ -105,11 +105,12 @@
  * A driver is capable of handling one or more physical devices present on
  * I2C adapters. This information is used to inform the driver of adapter
  * events.
+ *
+ * The driver.owner field should be set to the module owner of this driver.
+ * The driver.name field should be set to the name of this driver.
  */
 
 struct i2c_driver {
-	struct module *owner;
-	char name[32];
 	int id;
 	unsigned int class;
 	unsigned int flags;		/* div., see below		*/
Index: linux-2.6-mm/drivers/i2c/busses/i2c-isa.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-isa.c
+++ linux-2.6-mm/drivers/i2c/busses/i2c-isa.c
@@ -91,8 +91,6 @@
 	int res;
 
 	/* Add the driver to the list of i2c drivers in the driver core */
-	driver->driver.name = driver->name;
-	driver->driver.owner = driver->owner;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_isa_device_probe;
 	driver->driver.remove = i2c_isa_device_remove;
@@ -123,7 +121,7 @@
 		if ((res = driver->detach_client(client))) {
 			dev_err(&isa_adapter.dev, "Failed, driver "
 				"%s not unregistered!\n",
-				driver->name);
+				driver->driver.name);
 			return res;
 		}
 	}
Index: linux-2.6-mm/drivers/i2c/i2c-dev.c
=================================--- linux-2.6-mm.orig/drivers/i2c/i2c-dev.c
+++ linux-2.6-mm/drivers/i2c/i2c-dev.c
@@ -487,8 +487,10 @@
 }
 
 static struct i2c_driver i2cdev_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "dev_driver",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "dev_driver",
+	},
 	.id		= I2C_DRIVERID_I2CDEV,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= i2cdev_attach_adapter,

--

