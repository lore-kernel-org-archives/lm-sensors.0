From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:36 +0000
Subject: [lm-sensors] [PATCH] I2C: Make i2c_add_driver automatically set the
Message-Id: <1136585256316@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Make i2c_add_driver automatically set the proper module owner

This prevents i2c drivers from messing up and forgetting to set the
module owner of their driver.  It also reduces the size of their drivers
by one line :)

Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
Cc: Jean Delvare <khali at linux-fr.org>

---
commit de59cf9ed44f64991e52a9de6094729537f0420c
tree 038f6fb83228d09812f729d19fb7bdc8a324dd55
parent e1c489b0e4fbb1687f8227fe78b4769c123768c1
author Greg Kroah-Hartman <gregkh at suse.de> Tue, 06 Dec 2005 15:33:15 -0800
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:24 -0800

 drivers/i2c/i2c-core.c |    5 +++--
 include/linux/i2c.h    |    7 ++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 4ce5f0f..c23443e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -287,7 +287,7 @@ int i2c_del_adapter(struct i2c_adapter *
  * chips.
  */
 
-int i2c_add_driver(struct i2c_driver *driver)
+int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
 {
 	struct list_head   *item;
 	struct i2c_adapter *adapter;
@@ -296,6 +296,7 @@ int i2c_add_driver(struct i2c_driver *dr
 	down(&core_lists);
 
 	/* add the driver to the list of i2c drivers in the driver core */
+	driver->driver.owner = owner;
 	driver->driver.bus = &i2c_bus_type;
 	driver->driver.probe = i2c_device_probe;
 	driver->driver.remove = i2c_device_remove;
@@ -319,6 +320,7 @@ int i2c_add_driver(struct i2c_driver *dr
 	up(&core_lists);
 	return res;
 }
+EXPORT_SYMBOL(i2c_register_driver);
 
 int i2c_del_driver(struct i2c_driver *driver)
 {
@@ -1132,7 +1134,6 @@ EXPORT_SYMBOL_GPL(i2c_bus_type);
 
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
-EXPORT_SYMBOL(i2c_add_driver);
 EXPORT_SYMBOL(i2c_del_driver);
 EXPORT_SYMBOL(i2c_attach_client);
 EXPORT_SYMBOL(i2c_detach_client);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 75aa18e..7863a59 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -291,9 +291,14 @@ struct i2c_client_address_data {
 extern int i2c_add_adapter(struct i2c_adapter *);
 extern int i2c_del_adapter(struct i2c_adapter *);
 
-extern int i2c_add_driver(struct i2c_driver *);
+extern int i2c_register_driver(struct module *, struct i2c_driver *);
 extern int i2c_del_driver(struct i2c_driver *);
 
+static inline int i2c_add_driver(struct i2c_driver *driver)
+{
+	return i2c_register_driver(THIS_MODULE, driver);
+}
+
 extern int i2c_attach_client(struct i2c_client *);
 extern int i2c_detach_client(struct i2c_client *);
 


