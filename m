From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Kill i2c_client.id (5/5)
Message-Id: <20050116204958.1bc0ed5f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050116194653.17c96499.khali@linux-fr.org>
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

> (5/5) Documentation update.

Finally, updates are required to the i2c/writing-client and
i2c/porting-client documents. Remove any reference to i2c_client id and
invite porters to discard that struct member.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.11-rc1.orig/Documentation/i2c/porting-clients linux-2.6.11-rc1/Documentation/i2c/porting-clients
--- linux-2.6.11-rc1.orig/Documentation/i2c/porting-clients	2004-12-24 22:34:27.000000000 +0100
+++ linux-2.6.11-rc1/Documentation/i2c/porting-clients	2005-01-16 18:33:55.000000000 +0100
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
diff -ruN linux-2.6.11-rc1.orig/Documentation/i2c/writing-clients linux-2.6.11-rc1/Documentation/i2c/writing-clients
--- linux-2.6.11-rc1.orig/Documentation/i2c/writing-clients	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.11-rc1/Documentation/i2c/writing-clients	2005-01-16 12:50:29.000000000 +0100
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
 


-- 
Jean Delvare
http://khali.linux-fr.org/
