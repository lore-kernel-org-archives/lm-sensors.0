From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:34 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 1 of 11
Message-Id: <11365852541748@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 1 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the core of the i2c drivers: it removes .name and
.owner fields from the struct i2c_device and modify various
functions to use struct device fields instead.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 35d8b2e6b8e86b0d5126f36613b5202d4eb978b6
tree 2327c791f10216db39ae5c22235a13a5bc886d1e
parent 482c788ded0aa9710722eaf9cf60886d3b923218
author Laurent Riffard <laurent.riffard at free.fr> Sat, 26 Nov 2005 20:34:05 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:22 -0800

 drivers/i2c/busses/i2c-isa.c |    4 +---
 drivers/i2c/i2c-core.c       |   22 +++++++++++-----------
 drivers/i2c/i2c-dev.c        |    6 ++++--
 include/linux/i2c.h          |    5 +++--
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
index 03672c9..9f93fb8 100644
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -92,8 +92,6 @@ int i2c_isa_add_driver(struct i2c_driver
 	int res;
 
 	/* Add the driver to the list of i2c drivers in the driver core */
-	driver->driver.name = driver->name;
-	driver->driver.owner = driver->owner;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_isa_device_probe;
 	driver->driver.remove = i2c_isa_device_remove;
@@ -124,7 +122,7 @@ int i2c_isa_del_driver(struct i2c_driver
 		if ((res = driver->detach_client(client))) {
 			dev_err(&isa_adapter.dev, "Failed, driver "
 				"%s not unregistered!\n",
-				driver->name);
+				driver->driver.name);
 			return res;
 		}
 	}
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a1c5dff..4ce5f0f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -235,7 +235,8 @@ int i2c_del_adapter(struct i2c_adapter *
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
 				dev_err(&adap->dev, "detach_adapter failed "
-					"for driver [%s]\n", driver->name);
+					"for driver [%s]\n",
+					driver->driver.name);
 				goto out_unlock;
 			}
 	}
@@ -295,8 +296,6 @@ int i2c_add_driver(struct i2c_driver *dr
 	down(&core_lists);
 
 	/* add the driver to the list of i2c drivers in the driver core */
-	driver->driver.owner = driver->owner;
-	driver->driver.name = driver->name;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_device_probe;
 	driver->driver.remove = i2c_device_remove;
@@ -306,7 +305,7 @@ int i2c_add_driver(struct i2c_driver *dr
 		goto out_unlock;
 	
 	list_add_tail(&driver->list,&drivers);
-	pr_debug("i2c-core: driver [%s] registered\n", driver->name);
+	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
 
 	/* now look for instances of driver on our adapters */
 	if (driver->attach_adapter) {
@@ -344,7 +343,8 @@ int i2c_del_driver(struct i2c_driver *dr
 		if (driver->detach_adapter) {
 			if ((res = driver->detach_adapter(adap))) {
 				dev_err(&adap->dev, "detach_adapter failed "
-					"for driver [%s]\n", driver->name);
+					"for driver [%s]\n",
+					driver->driver.name);
 				goto out_unlock;
 			}
 		} else {
@@ -368,7 +368,7 @@ int i2c_del_driver(struct i2c_driver *dr
 
 	driver_unregister(&driver->driver);
 	list_del(&driver->list);
-	pr_debug("i2c-core: driver [%s] unregistered\n", driver->name);
+	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
 
  out_unlock:
 	up(&core_lists);
@@ -473,10 +473,10 @@ int i2c_detach_client(struct i2c_client 
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
 
@@ -485,7 +485,7 @@ static int i2c_inc_use_client(struct i2c
 
 static void i2c_dec_use_client(struct i2c_client *client)
 {
-	module_put(client->driver->owner);
+	module_put(client->driver->driver.owner);
 	module_put(client->adapter->owner);
 }
 
@@ -524,14 +524,14 @@ void i2c_clients_command(struct i2c_adap
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
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 9da51eb..9715217 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -481,8 +481,10 @@ static int i2cdev_command(struct i2c_cli
 }
 
 static struct i2c_driver i2cdev_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "dev_driver",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "dev_driver",
+	},
 	.id		= I2C_DRIVERID_I2CDEV,
 	.attach_adapter	= i2cdev_attach_adapter,
 	.detach_adapter	= i2cdev_detach_adapter,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index a9cea62..75aa18e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -105,11 +105,12 @@ extern s32 i2c_smbus_read_i2c_block_data
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
 


