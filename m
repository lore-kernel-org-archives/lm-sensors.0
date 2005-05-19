From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: i2c-core driver-model simplified
Message-Id: <Pine.LNX.4.53.0311292347260.4386@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


In 2.6.0-test10 i2c-core maintains its own list of adapters and drivers.
I think these are unneccessary as the generic driver-model maintains
those too, and it can also detach/attach clients when necessary.

The resulting i2c-core does not yet compile nor work, and I have not yet
reflected these changes to header file. But no changes in adapter or
client code is required at this time.

I could use some leftover hardware for 2.6 test setup. Anyone?


 < ChangeLog >

i2c-core driver-model

	Attempt to fit i2c-core better with driver-model.


patch-1

	Remove list of adapters and drivers in i2c-core. Driver-model
	maintains these for us.

patch-2

	No functional changes, just make it more readable by moving code
	here and there.

patch-3

	Figure out how to make client drivers probe the bus with no
	devices. Register and remove a (dummy) device on the bus with the
	adapter.


-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
-------------- next part --------------
diff -ur lk-2.6.0-test10-lab-2/drivers/i2c/i2c-core.c lk-2.6.0-test10-lab/drivers/i2c/i2c-core.c
--- lk-2.6.0-test10-lab-2/drivers/i2c/i2c-core.c	2003-11-28 21:15:38.000000000 +0200
+++ lk-2.6.0-test10-lab/drivers/i2c/i2c-core.c	2003-11-29 23:33:32.000000000 +0200
@@ -118,6 +118,7 @@
  */
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
+	struct i2c_client *client = &adap->dummy_client;
 	static int nr = 0;
 
 	adap->nr = nr++;
@@ -134,6 +135,7 @@
 	adap->dev.release = &i2c_adapter_dev_release;
 	device_register(&adap->dev);
 	device_create_file(&adap->dev, &dev_attr_name);
+	DEB(dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr));
 
 	/* Add this adapter to the i2c_adapter class */
 	memset(&adap->class_dev, 0x00, sizeof(struct class_device));
@@ -142,13 +144,45 @@
 	strlcpy(adap->class_dev.class_id, adap->dev.bus_id, BUS_ID_SIZE);
 	class_device_register(&adap->class_dev);
 
-	DEB(dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr));
+	/* Add the dummy client on the bus. */	
+	sprintf(client->dev.bus_id, "i2c-%d-probe", adap->nr);
+	client->dev.parent = &adap->dev;
+	client->dev.bus = &i2c_bus_type;
+	client->dev.release = &i2c_client_release;
+	client->adapter = adapter;
+	device_register(&client->dev);
 	return 0;
 }
 
+/* @dev client
+ * @data NULL
+ *
+ * 1. device_unregister(dev)
+ *   
+ *    driver->remove(dev)
+ */
+static int _i2c_device_unregister(struct device *dev, void *data)
+{
+	/* in device_for_each_child(), down_read( &devices_subsys.rwsem ) 
+	 * in device_unregister(),  device_del() : down_write( &devices_subsys.rwsem )
+	 *
+	 * So.. are we stuck here?
+	 */
+	device_unregister(dev);
+}
 
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
+	struct i2c_client *client = &adap->dummy_client;
+
+	/* unregister the dummy client */
+	init_completion(&client->released);
+	device_unregister(&client->dev);
+	wait_for_completion(&client->released);
+
+	/* unregister the real clients */
+	device_for_each_child(&adap->dev, NULL, _i2c_device_unregister);
+
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
 	init_completion(&adap->class_dev_released);
@@ -165,22 +199,6 @@
 }
 
 
-int i2c_add_driver(struct i2c_driver *driver)
-{
-	/* add the driver to the list of i2c drivers in the driver core */
-	driver->driver.name = driver->name;
-	driver->driver.bus = &i2c_bus_type;
-	driver->driver.probe = i2c_driver_probe;
-	driver->driver.remove = i2c_driver_remove;
-
-	return driver_register(&driver->driver);
-}
-
-int i2c_del_driver(struct i2c_driver *driver)
-{
-	return driver_unregister(&driver->driver);
-}
-
 /* A bus has no (client) devices until a (client) driver creates one.
  * With driver-model, a device must exist before the probe will take place. 
  * 
@@ -193,7 +211,8 @@
  *
  * 1. in driver->attach_adapter(adapter)
  * 
- *    i2c_probe(adapter, address_list, device_probe)
+ *    i2c_probe(adapter, address_list, found_proc)
+ *    i2c_replicate_client(dummy, real)
  *
  * 2. in i2c_attach_client(client)
  *
@@ -205,8 +224,12 @@
 {
 	struct i2c_driver *driver = to_i2c_driver(&dev->driver);
 	struct i2c_adapter *adapter = to_i2c_adapter(&dev->parent.dev);
+	
+	driver->attach_adapter(adapter);
 
-	return driver->attach_adapter(adapter);
+	/* Dummy device never binds to any driver */
+	dev->driver = NULL;
+	return -ENODEV;
 }
 
 
@@ -227,7 +250,40 @@
 	return driver->detach_client(client);
 }
 
+int i2c_add_driver(struct i2c_driver *driver)
+{
+	driver->driver.name = driver->name;
+	driver->driver.bus = &i2c_bus_type;
+	driver->driver.probe = i2c_driver_probe;
+	driver->driver.remove = i2c_driver_remove;
+
+	return driver_register(&driver->driver);
+}
+
+int i2c_del_driver(struct i2c_driver *driver)
+{
+	return driver_unregister(&driver->driver);
+}
+
+
 /* i2c_driver_probe will eventually get here in driver->attach_adapter
+ * 
+ * At this point, i2c_driver has succesfully probed the bus and has 
+ * found a device it can bind to. We give up using the dummy device 
+ * and allocate a real one.
+ *
+ * @dummy  The dummy device
+ * @client The real device 
+ *
+ */
+static int i2c_replicate_client(struct i2c_client *dummy, struct i2c_client *real)
+{
+	memcpy(real, dummy, sizeof(struct i2c_client));
+	return 0;
+}
+
+/* i2c_driver_probe will eventually get here in driver->attach_adapter
+ *
  */
 int i2c_attach_client(struct i2c_client *client)
 {
@@ -250,6 +306,7 @@
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;
 
+	/* The dummy device had these already setup */
 	client->dev.parent = &client->adapter->dev;
 	client->dev.driver = &client->driver->driver;
 	client->dev.bus = &i2c_bus_type;
@@ -336,16 +393,18 @@
 
 /* @dev client
  */ 
-static int _i2c_client_command(struct device *dev, struct _i2c_client_cmd *data)
+static int _i2c_client_command(struct device *dev, void *data)
 {
-	struct i2c_client *client = to_i2c_client(dev); 
+	struct i2c_client *client;
+	struct _i2c_client_cmd *cmd = data:
 
- 	/* Bus has one device template to probe drivers */
-	if (! client) 
+ 	/* We hit the dummy device */
+	if (! dev->driver) 
 	    return 0;
 
+	client = to_i2c_client(dev); 
 	if (NULL != client->driver->command)
-		return client->driver->command(client,data->cmd,data->arg);
+		return client->driver->command(client,cmd->cmd,cmd->arg);
 	
 	return 0;
 }
@@ -355,21 +414,22 @@
 	struct device *dev = &adap->dev;
 	struct _i2c_cmd_data data = { .cmd = cmd, .arg = arg };
 
-	bus_for_each_dev(&i2c_bus_type, &dev->children, &data, _i2c_client_command);
+	device_for_each_child(dev, &data, _i2c_client_command);
 }
 
 /* @dev client
  */ 
-static int _i2c_check_addr(struct device *dev, int *data)
+static int _i2c_check_addr(struct device *dev, void *data)
 {
 	struct i2c_client*client;
+	int addr = *data;
 
  	/* We hit the dummy device */
 	if (! dev->driver) 
 	    return 0;
 
 	client = to_i2c_client(dev);
-	if (client->addr = *data)
+	if (client->addr = addr)
 		return -EBUSY;
 	else
 		return 0;
@@ -378,7 +438,8 @@
 /* returns -EBUSY if some client on @adapter has address @addr */
 int i2c_check_addr(struct i2c_adapter *adapter, int addr)
 {
-	return bus_for_each_dev(&i2c_bus_type, &adapter->dev.children, &addr, _i2c_check_addr);
+	int data = addr;
+	device_for_each_child(&adapter->dev, &data, _i2c_check_addr);
 }
 
 /* ----------------------------------------------------
@@ -517,26 +578,33 @@
 
 struct _i2c_id_data {
 	struct i2c_adapter *adap;
-	int id;
+	int nr;
 }
 
 /* @dev adapter
  */ 
-static int _i2c_get_adapter_id(struct device *dev, struct _i2c_id_data *data)
+static int _i2c_get_adapter_id(struct device *dev, void *data)
 {	
-	data->adap = to_i2c_adapter(dev);
-	
-	if  ((data->adap->nr = data->id) && get_device(dev))
+	struct i2c_adapter *adap;
+	struct _i2c_id_data *id = data;
+
+ 	/* We may hit the dummy device. Or can we? */
+	if (! dev->driver)
+		return 0;
+
+	adap = to_i2c_adapter(dev);
+	if  ((adap->nr = id->nr) && get_device(dev)) {
+		id->adap = adap;
 		return 1;
-	
+	}	
 	return 0;
 }
 
 struct i2c_adapter* i2c_get_adapter(int id)
 {
-	struct _i2c_id_data data = { .id = id };
+	struct _i2c_id_data data = { .nr = id };
 	
-	if ( bus_for_each_dev(&i2c_bus_type, &i2c_adapter_class->children , &data, _i2c_adapter_id) )
+	if ( device_for_each_child(&i2c_adapter_class->dev, &data, _i2c_get_adapter_id) )
 		return data->adap;
 	else
 		return NULL;
Only in lk-2.6.0-test10-lab/drivers/i2c: i2c-core.c~
-------------- next part --------------
diff -ur lk-2.6.0-test10-lab-1/drivers/i2c/i2c-core.c lk-2.6.0-test10-lab/drivers/i2c/i2c-core.c
--- lk-2.6.0-test10-lab-1/drivers/i2c/i2c-core.c	2003-11-28 20:50:41.000000000 +0200
+++ lk-2.6.0-test10-lab/drivers/i2c/i2c-core.c	2003-11-28 21:06:15.000000000 +0200
@@ -41,12 +41,12 @@
 /**** debug level */
 static int i2c_debug;
 
-int i2c_device_probe(struct device *dev)
+static int i2c_adapter_probe(struct device *dev)
 {
 	return -ENODEV;
 }
 
-int i2c_device_remove(struct device *dev)
+static int i2c_adapter_remove(struct device *dev)
 {
 	return 0;
 }
@@ -60,8 +60,8 @@
 static struct device_driver i2c_adapter_driver = {
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
-	.probe = i2c_device_probe,
-	.remove = i2c_device_remove,
+	.probe = i2c_adapter_probe,
+	.remove = i2c_adapter_remove,
 };
 
 static void i2c_adapter_class_dev_release(struct class_device *dev)
@@ -165,12 +165,6 @@
 }
 
 
-/* -----
- * What follows is the "upwards" interface: commands for talking to clients,
- * which implement the functions to access the physical information of the
- * chips.
- */
-
 int i2c_add_driver(struct i2c_driver *driver)
 {
 	/* add the driver to the list of i2c drivers in the driver core */
@@ -187,27 +181,50 @@
 	return driver_unregister(&driver->driver);
 }
 
-/* @dev client
- */ 
-static int _i2c_check_addr(struct device *dev, int *data)
-{
-	struct i2c_client*client;
+/* A bus has no (client) devices until a (client) driver creates one.
+ * With driver-model, a device must exist before the probe will take place. 
+ * 
+ * With the creation of dummy device, drivers will try to bind with possible
+ * (clients) on this bus. This device will never bind to any driver,
+ * a real device is allocated and registered within driver->probe routines.
+ */
 
- 	/* We hit the dummy device */
-	if (! dev->driver) 
-	    return 0;
+/* @dev The dummy device
+ *
+ * 1. in driver->attach_adapter(adapter)
+ * 
+ *    i2c_probe(adapter, address_list, device_probe)
+ *
+ * 2. in i2c_attach_client(client)
+ *
+ *    adapter->client_register(client)
+ *    device_register(&client->dev)
+ *
+ */
+static int i2c_driver_probe(struct device *dev) 
+{
+	struct i2c_driver *driver = to_i2c_driver(&dev->driver);
+	struct i2c_adapter *adapter = to_i2c_adapter(&dev->parent.dev);
 
-	client = to_i2c_client(dev);
-	if (client->addr = *data)
-		return -EBUSY;
-	else
-		return 0;
+	return driver->attach_adapter(adapter);
 }
 
-/* returns -EBUSY if some client on @adapter has address @addr */
-int i2c_check_addr(struct i2c_adapter *adapter, int addr)
+
+/* @dev client
+ *
+ * 1. driver->detach_client(client)
+ * 
+ * 2. in i2c_detach_client(client)
+ *	adapter->client_unregister(client)
+ *	device_unregister(&client->dev)
+ *
+ */
+static int i2c_driver_remove(struct device *dev)
 {
-	return bus_for_each_dev(&i2c_bus_type, &adapter->dev.children, &addr, _i2c_check_addr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_driver *driver = to_i2c_driver(&dev->driver);
+
+	return driver->detach_client(client);
 }
 
 /* i2c_driver_probe will eventually get here in driver->attach_adapter
@@ -341,194 +358,27 @@
 	bus_for_each_dev(&i2c_bus_type, &dev->children, &data, _i2c_client_command);
 }
 
-/* A bus has no (client) devices until a (client) driver creates one.
- * With driver-model, a device must exist before the probe will take place. 
- * 
- * With the creation of dummy device, drivers will try to bind with possible
- * (clients) on this bus. This device will never bind to any driver,
- * a real device is allocated and registered within driver->probe routines.
- */
-
-/* @dev The dummy device
- *
- * 1. in driver->attach_adapter(adapter)
- * 
- *    i2c_probe(adapter, address_list, device_probe)
- *
- * 2. in i2c_attach_client(client)
- *
- *    adapter->client_register(client)
- *    device_register(&client->dev)
- *
- */
-static int i2c_driver_probe(struct device *dev) 
-{
-	struct i2c_driver *driver = to_i2c_driver(&dev->driver);
-	struct i2c_adapter *adapter = to_i2c_adapter(&dev->parent.dev);
-
-	return driver->attach_adapter(adapter);
-}
-
-
 /* @dev client
- *
- * 1. driver->detach_client(client)
- * 
- * 2. in i2c_detach_client(client)
- *	adapter->client_unregister(client)
- *	device_unregister(&client->dev)
- *
- */
-static int i2c_driver_remove(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct i2c_driver *driver = to_i2c_driver(&dev->driver);
-
-	return driver->detach_client(client);
-}
-
-
-
-
-
-/* match always succeeds, as we want the probe() to tell if we really accept this match */
-static int i2c_device_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
-struct bus_type i2c_bus_type = {
-	.name =		"i2c",
-	.match =	i2c_device_match,
-};
-
-static int __init i2c_init(void)
-{
-	int retval;
-
-	retval = bus_register(&i2c_bus_type);
-	if (retval)
-		return retval;
-	retval = driver_register(&i2c_adapter_driver);
-	if (retval)
-		return retval;
-	return class_register(&i2c_adapter_class);
-}
-
-static void __exit i2c_exit(void)
-{
-	class_unregister(&i2c_adapter_class);
-	driver_unregister(&i2c_adapter_driver);
-	bus_unregister(&i2c_bus_type);
-}
-
-subsys_initcall(i2c_init);
-module_exit(i2c_exit);
-
-/* ----------------------------------------------------
- * the functional interface to the i2c busses.
- * ----------------------------------------------------
- */
-
-int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg msgs[],int num)
-{
-	int ret;
-
-	if (adap->algo->master_xfer) {
- 	 	DEB2(dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num));
-
-		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,msgs,num);
-		up(&adap->bus_lock);
-
-		return ret;
-	} else {
-		DEB2(dev_dbg(&adap->dev, "I2C level transfers not supported\n"));
-		return -ENOSYS;
-	}
-}
-
-int i2c_master_send(struct i2c_client *client,const char *buf ,int count)
+ */ 
+static int _i2c_check_addr(struct device *dev, int *data)
 {
-	int ret;
-	struct i2c_adapter *adap=client->adapter;
-	struct i2c_msg msg;
-
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.len = count;
-		msg.buf = (char *)buf;
-	
-		DEB2(dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
-				count));
-	
-		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus_lock);
-
-		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
-		 * transmitted, else error code.
-		 */
-		return (ret = 1 )? count : ret;
-	} else {
-		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
-	}
-}
+	struct i2c_client*client;
 
-int i2c_master_recv(struct i2c_client *client, char *buf ,int count)
-{
-	struct i2c_adapter *adap=client->adapter;
-	struct i2c_msg msg;
-	int ret;
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.flags |= I2C_M_RD;
-		msg.len = count;
-		msg.buf = buf;
+ 	/* We hit the dummy device */
+	if (! dev->driver) 
+	    return 0;
 
-		DEB2(dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
-				count));
-	
-		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus_lock);
-	
-		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
-			ret, count, client->addr));
-	
-		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
-	 	* transmitted, else error code.
-	 	*/
-		return (ret = 1 )? count : ret;
-	} else {
-		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
-	}
+	client = to_i2c_client(dev);
+	if (client->addr = *data)
+		return -EBUSY;
+	else
+		return 0;
 }
 
-
-int i2c_control(struct i2c_client *client,
-	unsigned int cmd, unsigned long arg)
+/* returns -EBUSY if some client on @adapter has address @addr */
+int i2c_check_addr(struct i2c_adapter *adapter, int addr)
 {
-	int ret = 0;
-	struct i2c_adapter *adap = client->adapter;
-
-	DEB2(printk(KERN_DEBUG "i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
-	switch ( cmd ) {
-		case I2C_RETRIES:
-			adap->retries = arg;
-			break;
-		case I2C_TIMEOUT:
-			adap->timeout = arg;
-			break;
-		default:
-			if (adap->algo->algo_control!=NULL)
-				ret = adap->algo->algo_control(adap,cmd,arg);
-	}
-	return ret;
+	return bus_for_each_dev(&i2c_bus_type, &adapter->dev.children, &addr, _i2c_check_addr);
 }
 
 /* ----------------------------------------------------
@@ -697,6 +547,158 @@
 	put_device(&adap->dev);
 }
 
+
+
+
+/* match always succeeds, as we want the probe() to tell if we really accept this match */
+static int i2c_device_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+};
+
+static int __init i2c_init(void)
+{
+	int retval;
+
+	retval = bus_register(&i2c_bus_type);
+	if (retval)
+		return retval;
+	retval = driver_register(&i2c_adapter_driver);
+	if (retval)
+		return retval;
+	return class_register(&i2c_adapter_class);
+}
+
+static void __exit i2c_exit(void)
+{
+	class_unregister(&i2c_adapter_class);
+	driver_unregister(&i2c_adapter_driver);
+	bus_unregister(&i2c_bus_type);
+}
+
+subsys_initcall(i2c_init);
+module_exit(i2c_exit);
+
+/* ----------------------------------------------------
+ * the functional interface to the i2c busses.
+ * ----------------------------------------------------
+ */
+
+/* -----
+ * What follows is the "upwards" interface: commands for talking to clients,
+ * which implement the functions to access the physical information of the
+ * chips.
+ */
+
+
+int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg msgs[],int num)
+{
+	int ret;
+
+	if (adap->algo->master_xfer) {
+ 	 	DEB2(dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num));
+
+		down(&adap->bus_lock);
+		ret = adap->algo->master_xfer(adap,msgs,num);
+		up(&adap->bus_lock);
+
+		return ret;
+	} else {
+		DEB2(dev_dbg(&adap->dev, "I2C level transfers not supported\n"));
+		return -ENOSYS;
+	}
+}
+
+int i2c_master_send(struct i2c_client *client,const char *buf ,int count)
+{
+	int ret;
+	struct i2c_adapter *adap=client->adapter;
+	struct i2c_msg msg;
+
+	if (client->adapter->algo->master_xfer) {
+		msg.addr   = client->addr;
+		msg.flags = client->flags & I2C_M_TEN;
+		msg.len = count;
+		msg.buf = (char *)buf;
+	
+		DEB2(dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
+				count));
+	
+		down(&adap->bus_lock);
+		ret = adap->algo->master_xfer(adap,&msg,1);
+		up(&adap->bus_lock);
+
+		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
+		 * transmitted, else error code.
+		 */
+		return (ret = 1 )? count : ret;
+	} else {
+		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
+		return -ENOSYS;
+	}
+}
+
+int i2c_master_recv(struct i2c_client *client, char *buf ,int count)
+{
+	struct i2c_adapter *adap=client->adapter;
+	struct i2c_msg msg;
+	int ret;
+	if (client->adapter->algo->master_xfer) {
+		msg.addr   = client->addr;
+		msg.flags = client->flags & I2C_M_TEN;
+		msg.flags |= I2C_M_RD;
+		msg.len = count;
+		msg.buf = buf;
+
+		DEB2(dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
+				count));
+	
+		down(&adap->bus_lock);
+		ret = adap->algo->master_xfer(adap,&msg,1);
+		up(&adap->bus_lock);
+	
+		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
+			ret, count, client->addr));
+	
+		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
+	 	* transmitted, else error code.
+	 	*/
+		return (ret = 1 )? count : ret;
+	} else {
+		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
+		return -ENOSYS;
+	}
+}
+
+
+int i2c_control(struct i2c_client *client,
+	unsigned int cmd, unsigned long arg)
+{
+	int ret = 0;
+	struct i2c_adapter *adap = client->adapter;
+
+	DEB2(printk(KERN_DEBUG "i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
+	switch ( cmd ) {
+		case I2C_RETRIES:
+			adap->retries = arg;
+			break;
+		case I2C_TIMEOUT:
+			adap->timeout = arg;
+			break;
+		default:
+			if (adap->algo->algo_control!=NULL)
+				ret = adap->algo->algo_control(adap,cmd,arg);
+	}
+	return ret;
+}
+
+
+
 /* The SMBus parts */
 
 #define POLY    (0x1070U << 3) 
Only in lk-2.6.0-test10-lab/drivers/i2c: i2c-core.c~
-------------- next part --------------
Only in lk-2.6.0-test10-lab/drivers/i2c/chips: lm78-dev-model.c
Only in lk-2.6.0-test10-lab/drivers/i2c/chips: via686a-dev-model.c
diff -ur linux-2.6.0-test10/drivers/i2c/i2c-core.c lk-2.6.0-test10-lab/drivers/i2c/i2c-core.c
--- linux-2.6.0-test10/drivers/i2c/i2c-core.c	2003-11-24 13:33:19.000000000 +0200
+++ lk-2.6.0-test10-lab/drivers/i2c/i2c-core.c	2003-11-28 20:41:20.000000000 +0200
@@ -38,10 +38,6 @@
 #define DEB(x) if (i2c_debug>=1) x;
 #define DEB2(x) if (i2c_debug>=2) x;
 
-static LIST_HEAD(adapters);
-static LIST_HEAD(drivers);
-static DECLARE_MUTEX(core_lists);
-
 /**** debug level */
 static int i2c_debug;
 
@@ -123,16 +119,9 @@
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
 	static int nr = 0;
-	struct list_head   *item;
-	struct i2c_driver  *driver;
-
-	down(&core_lists);
 
 	adap->nr = nr++;
 	init_MUTEX(&adap->bus_lock);
-	init_MUTEX(&adap->clist_lock);
-	list_add_tail(&adap->list,&adapters);
-	INIT_LIST_HEAD(&adap->clients);
 
 	/* Add the adapter to the driver core.
 	 * If the parent pointer is not set up,
@@ -153,15 +142,6 @@
 	strlcpy(adap->class_dev.class_id, adap->dev.bus_id, BUS_ID_SIZE);
 	class_device_register(&adap->class_dev);
 
-	/* inform drivers of new adapters */
-	list_for_each(item,&drivers) {
-		driver = list_entry(item, struct i2c_driver, list);
-		if (driver->flags & I2C_DF_NOTIFY)
-			/* We ignore the return code; if it fails, too bad */
-			driver->attach_adapter(adap);
-	}
-	up(&core_lists);
-
 	DEB(dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr));
 	return 0;
 }
@@ -169,59 +149,19 @@
 
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item, *_n;
-	struct i2c_driver *driver;
-	struct i2c_client *client;
-	int res = 0;
-
-	down(&core_lists);
-
-	list_for_each(item,&drivers) {
-		driver = list_entry(item, struct i2c_driver, list);
-		if (driver->detach_adapter)
-			if ((res = driver->detach_adapter(adap))) {
-				dev_warn(&adap->dev, "can't detach adapter"
-					 "while detaching driver %s: driver not "
-					 "detached!", driver->name);
-				goto out_unlock;
-			}
-	}
-
-	/* detach any active clients. This must be done first, because
-	 * it can fail; in which case we give upp. */
-	list_for_each_safe(item, _n, &adap->clients) {
-		client = list_entry(item, struct i2c_client, list);
-
-		/* detaching devices is unconditional of the set notify
-		 * flag, as _all_ clients that reside on the adapter
-		 * must be deleted, as this would cause invalid states.
-		 */
-		if ((res=client->driver->detach_client(client))) {
-			dev_err(&adap->dev, "adapter not "
-				"unregistered, because client at "
-				"address %02x can't be detached. ",
-				client->addr);
-			goto out_unlock;
-		}
-	}
-
 	/* clean up the sysfs representation */
 	init_completion(&adap->dev_released);
 	init_completion(&adap->class_dev_released);
 	class_device_unregister(&adap->class_dev);
 	device_remove_file(&adap->dev, &dev_attr_name);
 	device_unregister(&adap->dev);
-	list_del(&adap->list);
 
 	/* wait for sysfs to drop all references */
 	wait_for_completion(&adap->dev_released);
 	wait_for_completion(&adap->class_dev_released);
 
 	DEB(dev_dbg(&adap->dev, "adapter unregistered\n"));
-
- out_unlock:
-	up(&core_lists);
-	return res;
+	return 0;
 }
 
 
@@ -233,136 +173,51 @@
 
 int i2c_add_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item;
-	struct i2c_adapter *adapter;
-	int res = 0;
-
-	down(&core_lists);
-
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.name = driver->name;
 	driver->driver.bus = &i2c_bus_type;
-	driver->driver.probe = i2c_device_probe;
-	driver->driver.remove = i2c_device_remove;
-
-	res = driver_register(&driver->driver);
-	if (res)
-		goto out_unlock;
-	
-	list_add_tail(&driver->list,&drivers);
-	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
-
-	/* now look for instances of driver on our adapters */
-	if (driver->flags & I2C_DF_NOTIFY) {
-		list_for_each(item,&adapters) {
-			adapter = list_entry(item, struct i2c_adapter, list);
-			driver->attach_adapter(adapter);
-		}
-	}
+	driver->driver.probe = i2c_driver_probe;
+	driver->driver.remove = i2c_driver_remove;
 
- out_unlock:
-	up(&core_lists);
-	return res;
+	return driver_register(&driver->driver);
 }
 
 int i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item1, *item2, *_n;
-	struct i2c_client  *client;
-	struct i2c_adapter *adap;
-	
-	int res = 0;
-
-	down(&core_lists);
-
-	/* Have a look at each adapter, if clients of this driver are still
-	 * attached. If so, detach them to be able to kill the driver 
-	 * afterwards.
-	 */
-	DEB2(printk(KERN_DEBUG "i2c-core.o: unregister_driver - looking for clients.\n"));
-	/* removing clients does not depend on the notify flag, else 
-	 * invalid operation might (will!) result, when using stale client
-	 * pointers.
-	 */
-	list_for_each(item1,&adapters) {
-		adap = list_entry(item1, struct i2c_adapter, list);
-		DEB2(dev_dbg(&adap->dev, "examining adapter\n"));
-		if (driver->detach_adapter) {
-			if ((res = driver->detach_adapter(adap))) {
-				dev_warn(&adap->dev, "while unregistering "
-				       "dummy driver %s, adapter could "
-				       "not be detached properly; driver "
-				       "not unloaded!",driver->name);
-				goto out_unlock;
-			}
-		} else {
-			list_for_each_safe(item2, _n, &adap->clients) {
-				client = list_entry(item2, struct i2c_client, list);
-				if (client->driver != driver)
-					continue;
-				DEB2(printk(KERN_DEBUG "i2c-core.o: "
-					    "detaching client %s:\n",
-					    client->name));
-				if ((res = driver->detach_client(client))) {
-					dev_err(&adap->dev, "while "
-						"unregistering driver "
-						"`%s', the client at "
-						"address %02x of "
-						"adapter could not "
-						"be detached; driver "
-						"not unloaded!",
-						driver->name,
-						client->addr);
-					goto out_unlock;
-				}
-			}
-		}
-	}
-
-	driver_unregister(&driver->driver);
-	list_del(&driver->list);
-	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
-
- out_unlock:
-	up(&core_lists);
-	return 0;
+	return driver_unregister(&driver->driver);
 }
 
-static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
+/* @dev client
+ */ 
+static int _i2c_check_addr(struct device *dev, int *data)
 {
-	struct list_head   *item;
-	struct i2c_client  *client;
+	struct i2c_client*client;
 
-	list_for_each(item,&adapter->clients) {
-		client = list_entry(item, struct i2c_client, list);
-		if (client->addr = addr)
-			return -EBUSY;
-	}
-	return 0;
+ 	/* We hit the dummy device */
+	if (! dev->driver) 
+	    return 0;
+
+	client = to_i2c_client(dev);
+	if (client->addr = *data)
+		return -EBUSY;
+	else
+		return 0;
 }
 
+/* returns -EBUSY if some client on @adapter has address @addr */
 int i2c_check_addr(struct i2c_adapter *adapter, int addr)
 {
-	int rval;
-
-	down(&adapter->clist_lock);
-	rval = __i2c_check_addr(adapter, addr);
-	up(&adapter->clist_lock);
-
-	return rval;
+	return bus_for_each_dev(&i2c_bus_type, &adapter->dev.children, &addr, _i2c_check_addr);
 }
 
+/* i2c_driver_probe will eventually get here in driver->attach_adapter
+ */
 int i2c_attach_client(struct i2c_client *client)
 {
-	struct i2c_adapter *adapter = client->adapter;
-
-	down(&adapter->clist_lock);
-	if (__i2c_check_addr(client->adapter, client->addr)) {
-		up(&adapter->clist_lock);
+	int res = 0;
+	if (i2c_check_addr(adapter, client->addr) ) {
 		return -EBUSY;
 	}
-	list_add_tail(&client->list,&adapter->clients);
-	up(&adapter->clist_lock);
 	
 	if (adapter->client_register)  {
 		if (adapter->client_register(client))  {
@@ -392,7 +247,7 @@
 	return 0;
 }
 
-
+/* i2c_driver_remove will eventually get here in driver->detach_client */
 int i2c_detach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -407,44 +262,21 @@
 			printk(KERN_ERR
 			       "i2c-core.o: client_unregister [%s] failed, "
 			       "client not detached", client->name);
-			goto out;
+			return res;
 		}
 	}
 
-	down(&adapter->clist_lock);
-	list_del(&client->list);
 	init_completion(&client->released);
 	device_remove_file(&client->dev, &dev_attr_client_name);
 	device_unregister(&client->dev);
-	up(&adapter->clist_lock);
 	wait_for_completion(&client->released);
 
- out:
 	return res;
 }
 
-static int i2c_inc_use_client(struct i2c_client *client)
-{
-
-	if (!try_module_get(client->driver->owner))
-		return -ENODEV;
-	if (!try_module_get(client->adapter->owner)) {
-		module_put(client->driver->owner);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static void i2c_dec_use_client(struct i2c_client *client)
-{
-	module_put(client->driver->owner);
-	module_put(client->adapter->owner);
-}
-
 int i2c_use_client(struct i2c_client *client)
 {
-	if (!i2c_inc_use_client(client))
+	if (! get_device(&client->dev))
 		return -ENODEV;
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE) {
@@ -457,8 +289,9 @@
 	}
 
 	return 0;
+
  busy:
-	i2c_dec_use_client(client);
+	put_device(&client->dev);
 	return -EBUSY;
 }
 
@@ -474,32 +307,90 @@
 		}
 	}
 	
-	i2c_dec_use_client(client);
+	put_device(&client->dev);
+	
+	return 0;
+}
+
+struct _i2c_client_cmd {
+	unsigned int cmd;
+	void * arg;
+};
+
+/* @dev client
+ */ 
+static int _i2c_client_command(struct device *dev, struct _i2c_client_cmd *data)
+{
+	struct i2c_client *client = to_i2c_client(dev); 
+
+ 	/* Bus has one device template to probe drivers */
+	if (! client) 
+	    return 0;
+
+	if (NULL != client->driver->command)
+		return client->driver->command(client,data->cmd,data->arg);
 	
 	return 0;
 }
 
 void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void *arg)
 {
-	struct list_head  *item;
-	struct i2c_client *client;
+	struct device *dev = &adap->dev;
+	struct _i2c_cmd_data data = { .cmd = cmd, .arg = arg };
 
-	down(&adap->clist_lock);
-	list_for_each(item,&adap->clients) {
-		client = list_entry(item, struct i2c_client, list);
-		if (!try_module_get(client->driver->owner))
-			continue;
-		if (NULL != client->driver->command) {
-			up(&adap->clist_lock);
-			client->driver->command(client,cmd,arg);
-			down(&adap->clist_lock);
-		}
-		module_put(client->driver->owner);
-       }
-       up(&adap->clist_lock);
+	bus_for_each_dev(&i2c_bus_type, &dev->children, &data, _i2c_client_command);
+}
+
+/* A bus has no (client) devices until a (client) driver creates one.
+ * With driver-model, a device must exist before the probe will take place. 
+ * 
+ * With the creation of dummy device, drivers will try to bind with possible
+ * (clients) on this bus. This device will never bind to any driver,
+ * a real device is allocated and registered within driver->probe routines.
+ */
+
+/* @dev The dummy device
+ *
+ * 1. in driver->attach_adapter(adapter)
+ * 
+ *    i2c_probe(adapter, address_list, device_probe)
+ *
+ * 2. in i2c_attach_client(client)
+ *
+ *    adapter->client_register(client)
+ *    device_register(&client->dev)
+ *
+ */
+static int i2c_driver_probe(struct device *dev) 
+{
+	struct i2c_driver *driver = to_i2c_driver(&dev->driver);
+	struct i2c_adapter *adapter = to_i2c_adapter(&dev->parent.dev);
+
+	return driver->attach_adapter(adapter);
 }
 
 
+/* @dev client
+ *
+ * 1. driver->detach_client(client)
+ * 
+ * 2. in i2c_detach_client(client)
+ *	adapter->client_unregister(client)
+ *	device_unregister(&client->dev)
+ *
+ */
+static int i2c_driver_remove(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_driver *driver = to_i2c_driver(&dev->driver);
+
+	return driver->detach_client(client);
+}
+
+
+
+
+
 /* match always succeeds, as we want the probe() to tell if we really accept this match */
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -774,27 +665,36 @@
 	return adap->nr;
 }
 
+struct _i2c_id_data {
+	struct i2c_adapter *adap;
+	int id;
+}
+
+/* @dev adapter
+ */ 
+static int _i2c_get_adapter_id(struct device *dev, struct _i2c_id_data *data)
+{	
+	data->adap = to_i2c_adapter(dev);
+	
+	if  ((data->adap->nr = data->id) && get_device(dev))
+		return 1;
+	
+	return 0;
+}
+
 struct i2c_adapter* i2c_get_adapter(int id)
 {
-	struct list_head   *item;
-	struct i2c_adapter *adapter;
+	struct _i2c_id_data data = { .id = id };
 	
-	down(&core_lists);
-	list_for_each(item,&adapters) {
-		adapter = list_entry(item, struct i2c_adapter, list);
-		if (id = adapter->nr &&
-		    try_module_get(adapter->owner)) {
-			up(&core_lists);
-			return adapter;
-		}
-	}
-	up(&core_lists);
-	return NULL;
+	if ( bus_for_each_dev(&i2c_bus_type, &i2c_adapter_class->children , &data, _i2c_adapter_id) )
+		return data->adap;
+	else
+		return NULL;
 }
 
 void i2c_put_adapter(struct i2c_adapter *adap)
 {
-	module_put(adap->owner);
+	put_device(&adap->dev);
 }
 
 /* The SMBus parts */
