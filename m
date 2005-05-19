From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] i2c documentation update (1/2)
Message-Id: <20040330202442.230dbd1f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is an update to my 2.4 to 2.6 i2c client porting guide. The changes
were inspired by the feedback I got with the drivers that have been
ported so far.

Please apply,
Thanks.

--- linux-2.6.5-rc2/Documentation/i2c/porting-clients.orig	Fri Jan 16 20:10:15 2004
+++ linux-2.6.5-rc2/Documentation/i2c/porting-clients	Tue Mar 30 20:14:41 2004
@@ -1,4 +1,4 @@
-Revision 3, 2003-10-04
+Revision 4, 2004-03-30
 Jean Delvare <khali@linux-fr.org>
 Greg KH <greg@kroah.com>
 
@@ -24,9 +24,10 @@
   #include <linux/slab.h>
   #include <linux/i2c.h>
   #include <linux/i2c-sensor.h>
-  #include <linux/i2c-vid.h>     /* if you need VRM support */
-  #include <asm/io.h>            /* if you have I/O operations */
-  Some extra headers may be required for a given driver.
+  #include <linux/i2c-vid.h>	/* if you need VRM support */
+  #include <asm/io.h>		/* if you have I/O operations */
+  Please respect this inclusion order. Some extra headers may be
+  required for a given driver (e.g. "lm75.h").
 
 * [Addresses] SENSORS_I2C_END becomes I2C_CLIENT_END, SENSORS_ISA_END
   becomes I2C_CLIENT_ISA_END.
@@ -37,9 +38,9 @@
   names for sysfs files (see the Sysctl section below).
 
 * [Function prototypes] The detect functions loses its flags
-  parameter. Sysctl (e.g. lm75_temp) and miscellaneous (e.g.
-  swap_bytes) functions are off the list of prototypes. This
-  usually leaves five prototypes:
+  parameter. Sysctl (e.g. lm75_temp) and miscellaneous functions
+  are off the list of prototypes. This usually leaves five
+  prototypes:
   static int lm75_attach_adapter(struct i2c_adapter *adapter);
   static int lm75_detect(struct i2c_adapter *adapter, int address,
       int kind);
@@ -70,13 +71,14 @@
 * [Detect] As mentioned earlier, the flags parameter is gone.
   The type_name and client_name strings are replaced by a single
   name string, which will be filled with a lowercase, short string
-  (typically the driver name, e.g. "lm75"). The errorN labels are
-  reduced to the number needed. If that number is 2 (i2c-only
-  drivers), it is advised that the labels are named exit and
-  exit_free. For i2c+isa drivers, labels should be named ERROR0,
-  ERROR1 and ERROR2. Don't forget to properly set err before
-  jumping to error labels. By the way, labels should be
-  left-aligned.
+  (typically the driver name, e.g. "lm75").
+  In i2c-only drivers, drop the i2c_is_isa_adapter check, it's
+  useless.
+  The errorN labels are reduced to the number needed. If that number
+  is 2 (i2c-only drivers), it is advised that the labels are named
+  exit and exit_free. For i2c+isa drivers, labels should be named
+  ERROR0, ERROR1 and ERROR2. Don't forget to properly set err before
+  jumping to error labels. By the way, labels should be left-aligned.
   Use memset to fill the client and data area with 0x00.
   Use i2c_set_clientdata to set the client data (as opposed to
   a direct access to client->data).
@@ -85,6 +87,11 @@
   device_create_file. Move the driver initialization before any
   sysfs file creation.
 
+* [Init] Limits must not be set by the driver (can be done later in
+  user-space). Chip should not be reset default (although a module
+  parameter may be used to force is), and initialization should be
+  limited to the strictly necessary steps.
+
 * [Detach] Get rid of data, remove the call to
   i2c_deregister_entry.
 
@@ -92,7 +99,8 @@
   i2c_get_clientdata(client) instead.
 
 * [Interface] Init function should not print anything. Make sure
-  there is a MODULE_LICENSE() line.
+  there is a MODULE_LICENSE() line, at the bottom of the file
+  (after MODULE_AUTHOR() and MODULE_DESCRIPTION(), in this order).
 
 Coding policy:
 
@@ -102,8 +110,7 @@
   can. Calls to printk/pr_debug for debugging purposes are replaced
   by calls to dev_dbg. Here is an example on how to call it (taken
   from lm75_detect):
-  dev_dbg(&adapter->dev,
-          "lm75_detect called for an ISA bus adapter?!?\n");
+  dev_dbg(&client->dev, "Starting lm75 update\n");
   Replace other printk calls with the dev_info, dev_err or dev_warn
   function, as appropriate.
 
@@ -119,3 +126,8 @@
 * [Layout] Avoid extra empty lines between comments and what they
   comment. Respect the coding style (see Documentation/CodingStyle),
   in particular when it comes to placing curly braces.
+
+* [Comments] Make sure that no comment refers to a file that isn't
+  part of the Linux source tree (typically doc/chips/<chip name>),
+  and that remaining comments still match the code. Merging comment
+  lines when possible is encouraged.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
