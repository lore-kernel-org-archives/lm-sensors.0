From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: Kill i2c_client.id (5/5)
Message-Id: <11099685942488@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685942662@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2087, 2005/03/02 11:58:29-08:00, khali@linux-fr.org

[PATCH] I2C: Kill i2c_client.id (5/5)

> (5/5) Documentation update.

Finally, updates are required to the i2c/writing-client and
i2c/porting-client documents. Remove any reference to i2c_client id and
invite porters to discard that struct member.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/porting-clients |    6 +++---
 Documentation/i2c/writing-clients |    4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)


diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients	2005-03-04 12:25:58 -08:00
+++ b/Documentation/i2c/porting-clients	2005-03-04 12:25:58 -08:00
@@ -49,9 +49,8 @@
   static void lm75_update_client(struct i2c_client *client);
 
 * [Sysctl] All sysctl stuff is of course gone (defines, ctl_table
-  and functions). Instead, right after the static id definition
-  line, you have to define show and set functions for each sysfs
-  file. Only define set for writable values. Take a look at an
+  and functions). Instead, you have to define show and set functions for
+  each sysfs file. Only define set for writable values. Take a look at an
   existing 2.6 driver for details (lm78 for example). Don't forget
   to define the attributes for each file (this is that step that
   links callback functions). Use the file names specified in
@@ -86,6 +85,7 @@
   Replace the sysctl directory registration by calls to
   device_create_file. Move the driver initialization before any
   sysfs file creation.
+  Drop client->id.
 
 * [Init] Limits must not be set by the driver (can be done later in
   user-space). Chip should not be reset default (although a module
diff -Nru a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients	2005-03-04 12:25:58 -08:00
+++ b/Documentation/i2c/writing-clients	2005-03-04 12:25:58 -08:00
@@ -344,9 +344,6 @@
 
 For now, you can ignore the `flags' parameter. It is there for future use.
 
-  /* Unique ID allocation */
-  static int foo_id = 0;
-
   int foo_detect_client(struct i2c_adapter *adapter, int address, 
                         unsigned short flags, int kind)
   {
@@ -482,7 +479,6 @@
     data->type = kind;
     /* SENSORS ONLY END */
 
-    new_client->id = foo_id++; /* Automatically unique */
     data->valid = 0; /* Only if you use this field */
     init_MUTEX(&data->update_lock); /* Only if you use this field */
 

