From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Wed, 09 Nov 2005 22:17:38 +0000
Subject: [lm-sensors] [PATCH 1/3] call i2c_probe from i2c core
Message-Id: <20051109221431.7fb76362@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add the address_data and detect_client fields to the i2c_driver
structure.  If these are set, i2c core will call i2c_probe directly when
attach_adapter would have been called.  If the i2c_driver class field is
also set, probing will only be done on adapters with an intersecting
class field.

Add probe_data to i2c_adapter. If this is set, i2c core will
probe for chips at the address specified by the adapter. This is
useful when an adapter has exact knowledge of the connected
chips (video cards, platform devices, ...).

The attach_adapter callback will still be called if it is present, but
this makes it unnecessary for almost all in-tree i2c drivers.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

Index: linux-i2c-test/include/linux/i2c.h
=================================--- linux-i2c-test.orig/include/linux/i2c.h	2005-11-09 14:58:25.000000000 +0100
+++ linux-i2c-test/include/linux/i2c.h	2005-11-09 15:09:10.000000000 +0100
@@ -48,6 +48,7 @@ struct i2c_algorithm;
 struct i2c_adapter;
 struct i2c_client;
 struct i2c_driver;
+struct i2c_client_address_data;
 union i2c_smbus_data;
 
 /*
@@ -113,6 +114,7 @@ struct i2c_driver {
 	int id;
 	unsigned int class;
 	unsigned int flags;		/* div., see below		*/
+	struct i2c_client_address_data *address_data;
 
 	/* Notifies the driver that a new bus has appeared. This routine
 	 * can be used by the driver to test if the bus meets its conditions
@@ -130,6 +132,15 @@ struct i2c_driver {
 	 */
 	int (*detach_client)(struct i2c_client *);
 	
+ 	/* Requests that the driver validate an address on a bus and attach a
+ 	 * new client. If this routine is supplied, it will be called for
+ 	 * each device on new buses that appear, provided the bus class
+ 	 * matches the class field and devices exist at the addresses listed
+ 	 * in the address_data field. For most drivers, this mechanism can
+ 	 * be used instead of an attach_adapter routine.
+ 	 */
+ 	int (*detect_client)(struct i2c_adapter *, int addr, int kind);
+
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
 	 */
@@ -206,6 +217,16 @@ struct i2c_algorithm {
 	u32 (*functionality) (struct i2c_adapter *);
 };
 
+/* i2c_adapter_probe_data is the struct for holding the addresses,
+ * driver id and parameter for an automatic probing when an adapter/driver
+ * is added to the system.
+ */
+struct i2c_adapter_probe_data {
+	int id;
+	int address;
+	int kind;
+};
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -236,6 +257,7 @@ struct i2c_adapter {
 	char name[I2C_NAME_SIZE];
 	struct completion dev_released;
 	struct completion class_dev_released;
+	struct i2c_adapter_probe_data *probe_data;
 };
 #define dev_to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 #define class_dev_to_i2c_adapter(d) container_of(d, struct i2c_adapter, class_dev)
Index: linux-i2c-test/drivers/i2c/i2c-core.c
=================================--- linux-i2c-test.orig/drivers/i2c/i2c-core.c	2005-11-09 14:58:15.000000000 +0100
+++ linux-i2c-test/drivers/i2c/i2c-core.c	2005-11-09 15:21:04.000000000 +0100
@@ -39,6 +39,8 @@ static LIST_HEAD(drivers);
 static DECLARE_MUTEX(core_lists);
 static DEFINE_IDR(i2c_adapter_idr);
 
+static void i2c_notify(struct i2c_adapter *adap, struct i2c_driver *driver);
+
 /* match always succeeds, as we want the probe() to tell if we really accept this match */
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -136,7 +138,6 @@ static struct device_attribute dev_attr_
 	.show	= &show_client_name,
 };
 
-
 /* ---------------------------------------------------
  * registering functions 
  * --------------------------------------------------- 
@@ -197,9 +198,14 @@ int i2c_add_adapter(struct i2c_adapter *
 	/* inform drivers of new adapters */
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
-		if (driver->flags & I2C_DF_NOTIFY)
-			/* We ignore the return code; if it fails, too bad */
-			driver->attach_adapter(adap);
+		if (driver->flags & I2C_DF_NOTIFY) {
+			/* We ignore the return codes; if it fails, too bad */
+			if (driver->attach_adapter)
+				driver->attach_adapter(adap);
+
+			if (driver->detect_client)
+				i2c_notify(adap, driver);
+		}
 	}
 
 out_unlock:
@@ -312,7 +318,11 @@ int i2c_add_driver(struct i2c_driver *dr
 	if (driver->flags & I2C_DF_NOTIFY) {
 		list_for_each(item,&adapters) {
 			adapter = list_entry(item, struct i2c_adapter, list);
-			driver->attach_adapter(adapter);
+			if (driver->attach_adapter)
+				driver->attach_adapter(adapter);
+
+			if (driver->detect_client)
+                                i2c_notify(adapter, driver);
 		}
 	}
 
@@ -798,6 +808,31 @@ int i2c_probe(struct i2c_adapter *adapte
 	return 0;
 }
 
+static
+void i2c_notify(struct i2c_adapter *adap, struct i2c_driver *driver)
+{
+	/* Probe devices if the driver provided the necessary
+	 * information (detect_client and address_data)
+	 */
+	if (driver->address_data &&
+		((driver->class & adap->class) || driver->class = 0))
+		i2c_probe(adap, driver->address_data, driver->detect_client);
+
+	/* Probe devices using adapter specified addresses
+	 * and driver ids.
+	 */
+	if (adap->probe_data && driver->id) {
+		int i;
+		for (i = 0; adap->probe_data[i].id != 0; i++)
+			if (adap->probe_data[i].id = driver->id)
+				i2c_probe_address(adap,
+					adap->probe_data[i].address,
+					adap->probe_data[i].kind,
+					driver->detect_client);
+	}
+}
+
+
 struct i2c_adapter* i2c_get_adapter(int id)
 {
 	struct i2c_adapter *adapter;
Index: linux-i2c-test/Documentation/i2c/writing-clients
=================================--- linux-i2c-test.orig/Documentation/i2c/writing-clients	2005-11-09 14:58:11.000000000 +0100
+++ linux-i2c-test/Documentation/i2c/writing-clients	2005-11-09 15:09:10.000000000 +0100
@@ -27,8 +27,10 @@ address.
 static struct i2c_driver foo_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "Foo version 2.3 driver",
+	.class		= I2C_CLASS_HWMON,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= &foo_attach_adapter,
+	.address_data	= &addr_data,
+	.detect_client	= &foo_detect_client,
 	.detach_client	= &foo_detach_client,
 	.command	= &foo_command /* may be NULL */
 }
@@ -145,8 +147,8 @@ are defined to help determine what addre
 are defined in i2c.h to help you support them, as well as a generic
 detection algorithm.
 
-You do not have to use this parameter interface; but don't try to use
-function i2c_probe() if you don't.
+You do not have to use this parameter interface; but then the i2c core won't
+be able to probe for devices for you.
 
 NOTE: If you want to write a `sensors' driver, the interface is slightly
       different! See below.
@@ -205,35 +207,49 @@ Attaching to an adapter
 -----------------------
 
 Whenever a new adapter is inserted, or for all adapters if the driver is
-being registered, the callback attach_adapter() is called. Now is the
-time to determine what devices are present on the adapter, and to register
-a client for each of them.
-
-The attach_adapter callback is really easy: we just call the generic
-detection function. This function will scan the bus for us, using the
-information as defined in the lists explained above. If a device is
-detected at a specific address, another callback is called.
+being registered, your driver may be notified through one of two
+callbacks, depending on the degree of control you need to exercise over
+the probing process. This is the time to determine what devices are
+present on the adapter and to register a client for each device your
+driver supports.
+
+The easiest way to handle the probing process is to simply set the `class',
+`address_data', and `detect_client' fields in the i2c_driver structure.
+The `class' field is a bitmask of all the adapter classes which should be
+probed for devices supported by this driver. Typically you would just set
+this to I2C_CLASS_HWMON, which is appropriate for `sensors' drivers.  The
+`address_data' field should be set to `&addr_data', which is defined by the
+macros explained above, so you do not have to define it yourself.  When a
+new adapter is attached, the bus is scanned for the addresses defined in
+the lists above, and the detect_client callback gets called when a device
+is detected at a specific address.
+
+If you prefer, you can omit the `class', `address_data', and
+`detect_client' fields from your i2c_driver structure, and instead set
+`attach_adapter'.  The `attach_adapter' callback gets called every time a
+new adapter is attached and the bus needs to be scanned, so if you need to
+perform any special checks or configuration before you scan a bus for
+devices, you should use attach_adapter. If the bus is suitable, you can
+then call the generic i2c_probe function to scan for the addresses in the
+lists explained above, and the callback passed in the third parameter will
+get called for each device detected.
 
   int foo_attach_adapter(struct i2c_adapter *adapter)
   {
     return i2c_probe(adapter,&addr_data,&foo_detect_client);
   }
 
-Remember, structure `addr_data' is defined by the macros explained above,
-so you do not have to define it yourself.
-
-The i2c_probe function will call the foo_detect_client
-function only for those i2c addresses that actually have a device on
-them (unless a `force' parameter was used). In addition, addresses that
-are already in use (by some other registered client) are skipped.
+With either mechanism, addresses that are already in use (by some other
+registered client) are skipped.
 
 
 The detect client function
 --------------------------
 
-The detect client function is called by i2c_probe. The `kind' parameter
-contains -1 for a probed detection, 0 for a forced detection, or a positive
-number for a forced detection with a chip type forced.
+The detect client function is called by the address probing mechanism.
+The `kind' parameter contains -1 for a probed detection, 0 for a forced
+detection, or a positive number for a forced detection with a chip type
+forced.
 
 Below, some things are only needed if this is a `sensors' driver. Those
 parts are between /* SENSORS ONLY START */ and /* SENSORS ONLY END */
Index: linux-i2c-test/Documentation/i2c/porting-clients
=================================--- linux-i2c-test.orig/Documentation/i2c/porting-clients	2005-11-09 14:58:11.000000000 +0100
+++ linux-i2c-test/Documentation/i2c/porting-clients	2005-11-09 15:09:10.000000000 +0100
@@ -92,6 +92,9 @@ Technical changes:
   Drop client->id.
   Drop any 24RF08 corruption prevention you find, as this is now done
   at the i2c-core level, and doing it twice voids it.
+  If you want auto probing of your driver, use driver->addr_data
+  (this is strongly encouraged if your attach_adapter is a one-liner
+  which calls i2c_probe).
 
 * [Init] Limits must not be set by the driver (can be done later in
   user-space). Chip should not be reset default (although a module


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

