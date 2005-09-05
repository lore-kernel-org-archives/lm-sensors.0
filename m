From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:36 +0000
Subject: [lm-sensors] [PATCH] I2C: Improve core debugging messages
Message-Id: <11259567682795@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Improve core debugging messages

The debugging messages in i2c-core are more confusing than helpful. Some
lack their trailing newline, some lack a prefix, some are redundant,
some lack precious information. Here is my attempt to introduce some
standardization in there.

I also changed two messages in i2c-dev to make it clear they come from
i2c-dev.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b6d7b3d1b5a388b7e9af2629a9ecccedee064078
tree 8961c6ee76ddf00c613308322472346c886a27e6
parent 014e45380a3b96f2ebd8ff0d115b7a33c06d06d1
author Jean Delvare <khali@linux-fr.org> Sun, 31 Jul 2005 19:02:53 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:16 -0700

 drivers/i2c/i2c-core.c |   63 ++++++++++++++++++++----------------------------
 drivers/i2c/i2c-dev.c  |    5 ++--
 2 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -188,6 +188,8 @@ int i2c_add_adapter(struct i2c_adapter *
 	strlcpy(adap->class_dev.class_id, adap->dev.bus_id, BUS_ID_SIZE);
 	class_device_register(&adap->class_dev);
 
+	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
+
 	/* inform drivers of new adapters */
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
@@ -196,8 +198,6 @@ int i2c_add_adapter(struct i2c_adapter *
 			driver->attach_adapter(adap);
 	}
 
-	dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr);
-
 out_unlock:
 	up(&core_lists);
 	return res;
@@ -220,8 +220,8 @@ int i2c_del_adapter(struct i2c_adapter *
 			break;
 	}
 	if (adap_from_list != adap) {
-		pr_debug("I2C: Attempting to delete an unregistered "
-			 "adapter\n");
+		pr_debug("i2c-core: attempting to delete unregistered "
+			 "adapter [%s]\n", adap->name);
 		res = -EINVAL;
 		goto out_unlock;
 	}
@@ -230,9 +230,8 @@ int i2c_del_adapter(struct i2c_adapter *
 		driver = list_entry(item, struct i2c_driver, list);
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
-				dev_warn(&adap->dev, "can't detach adapter "
-					 "while detaching driver %s: driver "
-					 "not detached!\n", driver->name);
+				dev_err(&adap->dev, "detach_adapter failed "
+					"for driver [%s]\n", driver->name);
 				goto out_unlock;
 			}
 	}
@@ -247,9 +246,8 @@ int i2c_del_adapter(struct i2c_adapter *
 		 * must be deleted, as this would cause invalid states.
 		 */
 		if ((res=client->driver->detach_client(client))) {
-			dev_err(&adap->dev, "adapter not "
-				"unregistered, because client at "
-				"address %02x can't be detached. ",
+			dev_err(&adap->dev, "detach_client failed for client "
+				"[%s] at address 0x%02x\n", client->name,
 				client->addr);
 			goto out_unlock;
 		}
@@ -270,7 +268,7 @@ int i2c_del_adapter(struct i2c_adapter *
 	/* free dynamically allocated bus id */
 	idr_remove(&i2c_adapter_idr, adap->nr);
 
-	dev_dbg(&adap->dev, "adapter unregistered\n");
+	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
  out_unlock:
 	up(&core_lists);
@@ -303,7 +301,7 @@ int i2c_add_driver(struct i2c_driver *dr
 		goto out_unlock;
 	
 	list_add_tail(&driver->list,&drivers);
-	pr_debug("i2c-core: driver %s registered.\n", driver->name);
+	pr_debug("i2c-core: driver [%s] registered\n", driver->name);
 
 	/* now look for instances of driver on our adapters */
 	if (driver->flags & I2C_DF_NOTIFY) {
@@ -331,21 +329,17 @@ int i2c_del_driver(struct i2c_driver *dr
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
-	 */
-	pr_debug("i2c-core: unregister_driver - looking for clients.\n");
-	/* removing clients does not depend on the notify flag, else 
+	 *
+	 * Removing clients does not depend on the notify flag, else
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
 	 */
 	list_for_each(item1,&adapters) {
 		adap = list_entry(item1, struct i2c_adapter, list);
-		dev_dbg(&adap->dev, "examining adapter\n");
 		if (driver->detach_adapter) {
 			if ((res = driver->detach_adapter(adap))) {
-				dev_warn(&adap->dev, "while unregistering "
-				       "dummy driver %s, adapter could "
-				       "not be detached properly; driver "
-				       "not unloaded!",driver->name);
+				dev_err(&adap->dev, "detach_adapter failed "
+					"for driver [%s]\n", driver->name);
 				goto out_unlock;
 			}
 		} else {
@@ -353,16 +347,13 @@ int i2c_del_driver(struct i2c_driver *dr
 				client = list_entry(item2, struct i2c_client, list);
 				if (client->driver != driver)
 					continue;
-				pr_debug("i2c-core.o: detaching client %s:\n", client->name);
+				dev_dbg(&adap->dev, "detaching client [%s] "
+					"at 0x%02x\n", client->name,
+					client->addr);
 				if ((res = driver->detach_client(client))) {
-					dev_err(&adap->dev, "while "
-						"unregistering driver "
-						"`%s', the client at "
-						"address %02x of "
-						"adapter could not "
-						"be detached; driver "
-						"not unloaded!",
-						driver->name,
+					dev_err(&adap->dev, "detach_client "
+						"failed for client [%s] at "
+						"0x%02x\n", client->name,
 						client->addr);
 					goto out_unlock;
 				}
@@ -372,7 +363,7 @@ int i2c_del_driver(struct i2c_driver *dr
 
 	driver_unregister(&driver->driver);
 	list_del(&driver->list);
-	pr_debug("i2c-core: driver unregistered: %s\n", driver->name);
+	pr_debug("i2c-core: driver [%s] unregistered\n", driver->name);
 
  out_unlock:
 	up(&core_lists);
@@ -417,15 +408,12 @@ int i2c_attach_client(struct i2c_client 
 	
 	if (adapter->client_register)  {
 		if (adapter->client_register(client))  {
-			dev_warn(&adapter->dev, "warning: client_register "
-				"seems to have failed for client %02x\n",
-				client->addr);
+			dev_dbg(&adapter->dev, "client_register "
+				"failed for client [%s] at 0x%02x\n",
+				client->name, client->addr);
 		}
 	}
 
-	dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
-		client->name);
-
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;
 
@@ -436,7 +424,8 @@ int i2c_attach_client(struct i2c_client 
 	
 	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
-	pr_debug("registering %s\n", client->dev.bus_id);
+	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
+		client->name, client->dev.bus_id);
 	device_register(&client->dev);
 	device_create_file(&client->dev, &dev_attr_client_name);
 	
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -434,7 +434,8 @@ static int i2cdev_attach_adapter(struct 
 
 	devfs_mk_cdev(MKDEV(I2C_MAJOR, i2c_dev->minor),
 			S_IFCHR|S_IRUSR|S_IWUSR, "i2c/%d", i2c_dev->minor);
-	dev_dbg(&adap->dev, "Registered as minor %d\n", i2c_dev->minor);
+	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
+		 adap->name, i2c_dev->minor);
 
 	/* register this i2c device with the driver core */
 	i2c_dev->adap = adap;
@@ -471,7 +472,7 @@ static int i2cdev_detach_adapter(struct 
 	wait_for_completion(&i2c_dev->released);
 	kfree(i2c_dev);
 
-	dev_dbg(&adap->dev, "Adapter unregistered\n");
+	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
 	return 0;
 }
 

