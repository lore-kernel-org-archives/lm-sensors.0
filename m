From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:27 +0000
Subject: [lm-sensors] [PATCH] I2C: Separate non-i2c hwmon drivers from
Message-Id: <1125956766333@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567663617@kroah.com>
In-Reply-To: <11259567663617@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Separate non-i2c hwmon drivers from i2c-core (3/9)

Convert the 10 ISA hardware monitoring drivers (it87, lm78, pc87360,
sis5595, smsc47b397, smsc47m1, via686a, w83627hf, w83627ehf, w83781d) to
explicitely register with i2c-isa. For hybrid drivers (it87, lm78,
w83781d), we now have two separate instances of i2c_driver, one for the
I2C interface of the chip, and one for ISA interface. In the long run,
the one for ISA will be replaced with a different driver type.

At this point, all drivers are working again, except for missing
dependencies in Kconfig.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit fde0950903ce8cc38a91dd095280decceda2ff82
tree 5a970459793ac46ad7082f0d722616730b0589c2
parent 400c455eaa0d0819d18cd42a74070e0e238a73dc
author Jean Delvare <khali@linux-fr.org> Tue, 19 Jul 2005 23:51:07 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:09 -0700

 drivers/hwmon/it87.c       |   29 +++++++++++++++++++++++++----
 drivers/hwmon/lm78.c       |   29 ++++++++++++++++++++++++++---
 drivers/hwmon/pc87360.c    |    5 +++--
 drivers/hwmon/sis5595.c    |    5 +++--
 drivers/hwmon/smsc47b397.c |    5 +++--
 drivers/hwmon/smsc47m1.c   |    5 +++--
 drivers/hwmon/via686a.c    |    5 +++--
 drivers/hwmon/w83627ehf.c  |    5 +++--
 drivers/hwmon/w83627hf.c   |    5 +++--
 drivers/hwmon/w83781d.c    |   28 +++++++++++++++++++++++++---
 10 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon-sysfs.h>
@@ -242,6 +243,14 @@ static struct i2c_driver it87_driver = {
 	.detach_client	= it87_detach_client,
 };
 
+static struct i2c_driver it87_isa_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "it87-isa",
+	.attach_adapter	= it87_attach_adapter,
+	.detach_client	= it87_detach_client,
+};
+
+
 static ssize_t show_in(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -741,7 +750,7 @@ int it87_detect(struct i2c_adapter *adap
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, IT87_EXTENT, it87_driver.name))
+		if (!request_region(address, IT87_EXTENT, it87_isa_driver.name))
 			goto ERROR0;
 
 	/* Probe whether there is anything available on this address. Already
@@ -787,7 +796,7 @@ int it87_detect(struct i2c_adapter *adap
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &it87_driver;
+	new_client->driver = is_isa ? &it87_isa_driver : &it87_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
@@ -1172,16 +1181,28 @@ static struct it87_data *it87_update_dev
 
 static int __init sm_it87_init(void)
 {
-	int addr;
+	int addr, res;
 
 	if (!it87_find(&addr)) {
 		normal_isa[0] = addr;
 	}
-	return i2c_add_driver(&it87_driver);
+
+	res = i2c_add_driver(&it87_driver);
+	if (res)
+		return res;
+
+	res = i2c_isa_add_driver(&it87_isa_driver);
+	if (res) {
+		i2c_del_driver(&it87_driver);
+		return res;
+	}
+
+	return 0;
 }
 
 static void __exit sm_it87_exit(void)
 {
+	i2c_isa_del_driver(&it87_isa_driver);
 	i2c_del_driver(&it87_driver);
 }
 
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -177,6 +178,14 @@ static struct i2c_driver lm78_driver = {
 	.detach_client	= lm78_detach_client,
 };
 
+static struct i2c_driver lm78_isa_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "lm78-isa",
+	.attach_adapter	= lm78_attach_adapter,
+	.detach_client	= lm78_detach_client,
+};
+
+
 /* 7 Voltages */
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
@@ -488,7 +497,8 @@ int lm78_detect(struct i2c_adapter *adap
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, LM78_EXTENT, lm78_driver.name)) {
+		if (!request_region(address, LM78_EXTENT,
+				    lm78_isa_driver.name)) {
 			err = -EBUSY;
 			goto ERROR0;
 		}
@@ -543,7 +553,7 @@ int lm78_detect(struct i2c_adapter *adap
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &lm78_driver;
+	new_client->driver = is_isa ? &lm78_isa_driver : &lm78_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
@@ -788,11 +798,24 @@ static struct lm78_data *lm78_update_dev
 
 static int __init sm_lm78_init(void)
 {
-	return i2c_add_driver(&lm78_driver);
+	int res;
+
+	res = i2c_add_driver(&lm78_driver);
+	if (res)
+		return res;
+
+	res = i2c_isa_add_driver(&lm78_isa_driver);
+	if (res) {
+		i2c_del_driver(&lm78_driver);
+		return res;
+	}
+
+	return 0;
 }
 
 static void __exit sm_lm78_exit(void)
 {
+	i2c_isa_del_driver(&lm78_isa_driver);
 	i2c_del_driver(&lm78_driver);
 }
 
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
@@ -1344,12 +1345,12 @@ static int __init pc87360_init(void)
 		return -ENODEV;
 	}
 
-	return i2c_add_driver(&pc87360_driver);
+	return i2c_isa_add_driver(&pc87360_driver);
 }
 
 static void __exit pc87360_exit(void)
 {
-	i2c_del_driver(&pc87360_driver);
+	i2c_isa_del_driver(&pc87360_driver);
 }
 
 
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -55,6 +55,7 @@
 #include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -790,7 +791,7 @@ static int __devinit sis5595_pci_probe(s
 	normal_isa[0] = addr;
 
 	s_bridge = pci_dev_get(dev);
-	if (i2c_add_driver(&sis5595_driver)) {
+	if (i2c_isa_add_driver(&sis5595_driver)) {
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
@@ -817,7 +818,7 @@ static void __exit sm_sis5595_exit(void)
 {
 	pci_unregister_driver(&sis5595_pci_driver);
 	if (s_bridge != NULL) {
-		i2c_del_driver(&sis5595_driver);
+		i2c_isa_del_driver(&sis5595_driver);
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -350,12 +351,12 @@ static int __init smsc47b397_init(void)
 	if ((ret = smsc47b397_find(normal_isa)))
 		return ret;
 
-	return i2c_add_driver(&smsc47b397_driver);
+	return i2c_isa_add_driver(&smsc47b397_driver);
 }
 
 static void __exit smsc47b397_exit(void)
 {
-	i2c_del_driver(&smsc47b397_driver);
+	i2c_isa_del_driver(&smsc47b397_driver);
 }
 
 MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -30,6 +30,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -592,12 +593,12 @@ static int __init sm_smsc47m1_init(void)
 		return -ENODEV;
 	}
 
-	return i2c_add_driver(&smsc47m1_driver);
+	return i2c_isa_add_driver(&smsc47m1_driver);
 }
 
 static void __exit sm_smsc47m1_exit(void)
 {
-	i2c_del_driver(&smsc47m1_driver);
+	i2c_isa_del_driver(&smsc47m1_driver);
 }
 
 MODULE_AUTHOR("Mark D. Studebaker <mdsxyz123@yahoo.com>");
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -846,7 +847,7 @@ static int __devinit via686a_pci_probe(s
 	normal_isa[0] = addr;
 
 	s_bridge = pci_dev_get(dev);
-	if (i2c_add_driver(&via686a_driver)) {
+	if (i2c_isa_add_driver(&via686a_driver)) {
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
@@ -873,7 +874,7 @@ static void __exit sm_via686a_exit(void)
 {
 	pci_unregister_driver(&via686a_pci_driver);
 	if (s_bridge != NULL) {
-		i2c_del_driver(&via686a_driver);
+		i2c_isa_del_driver(&via686a_driver);
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -40,6 +40,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -847,12 +848,12 @@ static int __init sensors_w83627ehf_init
 	 && w83627ehf_find(0x4e, &normal_isa[0]))
 		return -ENODEV;
 
-	return i2c_add_driver(&w83627ehf_driver);
+	return i2c_isa_add_driver(&w83627ehf_driver);
 }
 
 static void __exit sensors_w83627ehf_exit(void)
 {
-	i2c_del_driver(&w83627ehf_driver);
+	i2c_isa_del_driver(&w83627ehf_driver);
 }
 
 MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -42,6 +42,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
@@ -1507,12 +1508,12 @@ static int __init sensors_w83627hf_init(
 	}
 	normal_isa[0] = addr;
 
-	return i2c_add_driver(&w83627hf_driver);
+	return i2c_isa_add_driver(&w83627hf_driver);
 }
 
 static void __exit sensors_w83627hf_exit(void)
 {
-	i2c_del_driver(&w83627hf_driver);
+	i2c_isa_del_driver(&w83627hf_driver);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
@@ -276,6 +277,14 @@ static struct i2c_driver w83781d_driver 
 	.detach_client = w83781d_detach_client,
 };
 
+static struct i2c_driver w83781d_isa_driver = {
+	.owner = THIS_MODULE,
+	.name = "w83781d-isa",
+	.attach_adapter = w83781d_attach_adapter,
+	.detach_client = w83781d_detach_client,
+};
+
+
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
@@ -1002,7 +1011,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT,
-				    w83781d_driver.name)) {
+				    w83781d_isa_driver.name)) {
 			dev_dbg(&adapter->dev, "Request of region "
 				"0x%x-0x%x for w83781d failed\n", address,
 				address + W83781D_EXTENT - 1);
@@ -1060,7 +1069,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	new_client->addr = address;
 	init_MUTEX(&data->lock);
 	new_client->adapter = adapter;
-	new_client->driver = &w83781d_driver;
+	new_client->driver = is_isa ? &w83781d_isa_driver : &w83781d_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
@@ -1636,12 +1645,25 @@ static struct w83781d_data *w83781d_upda
 static int __init
 sensors_w83781d_init(void)
 {
-	return i2c_add_driver(&w83781d_driver);
+	int res;
+
+	res = i2c_add_driver(&w83781d_driver);
+	if (res)
+		return res;
+
+	res = i2c_isa_add_driver(&w83781d_isa_driver);
+	if (res) {
+		i2c_del_driver(&w83781d_driver);
+		return res;
+	}
+
+	return 0;
 }
 
 static void __exit
 sensors_w83781d_exit(void)
 {
+	i2c_isa_del_driver(&w83781d_isa_driver);
 	i2c_del_driver(&w83781d_driver);
 }
 

