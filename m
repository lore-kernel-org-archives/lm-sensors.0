From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: I2C documentation in Linux 2.6
Message-Id: <20031109143302.76713452.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

Attached are two updates for inclusion to Documentation/i2c in Linux
2.6.

The first file is the document I wrote (and you reviewed) about porting
client drivers to Linux 2.6. The retained name is "porting-clients" (in
line with writing drivers). I won't commit it to i2c/lm_sensors2 CVS,
since that document is of no use outside of the 2.6 kernel (and I'm
bored keeping files in sync).

The second file is a patch to writing-clients. The current version in
Linux 2.6 still mentions the old module reference counting mechanism.
The patch brings it to the same version we have in i2c CVS, where that
section has been updated.

Please apply to 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Revision 3, 2003-10-04
Jean Delvare <khali@linux-fr.org>
Greg KH <greg@kroah.com>

This is a guide on how to convert I2C chip drivers from Linux 2.4 to
Linux 2.6. I have been using existing drivers (lm75, lm78) as examples.
Then I converted a driver myself (lm83) and updated this document.

There are two sets of points below. The first set concerns technical
changes. The second set concerns coding policy. Both are mandatory.

Although reading this guide will help you porting drivers, I suggest
you keep an eye on an already ported driver while porting your own
driver. This will help you a lot understanding what this guide
exactly means. Choose the chip driver that is the more similar to
yours for best results.

Technical changes:

* [Includes] Get rid of "version.h". Replace <linux/i2c-proc.h> with
  <linux/i2c-sensor.h>. Includes typically look like that:
  #include <linux/module.h>
  #include <linux/init.h>
  #include <linux/slab.h>
  #include <linux/i2c.h>
  #include <linux/i2c-sensor.h>
  #include <linux/i2c-vid.h>     /* if you need VRM support */
  #include <asm/io.h>            /* if you have I/O operations */
  Some extra headers may be required for a given driver.

* [Addresses] SENSORS_I2C_END becomes I2C_CLIENT_END, SENSORS_ISA_END
  becomes I2C_CLIENT_ISA_END.

* [Client data] Get rid of sysctl_id. Try using standard names for
  register values (for example, temp_os becomes temp_max). You're
  still relatively free here, but you *have* to follow the standard
  names for sysfs files (see the Sysctl section below).

* [Function prototypes] The detect functions loses its flags
  parameter. Sysctl (e.g. lm75_temp) and miscellaneous (e.g.
  swap_bytes) functions are off the list of prototypes. This
  usually leaves five prototypes:
  static int lm75_attach_adapter(struct i2c_adapter *adapter);
  static int lm75_detect(struct i2c_adapter *adapter, int address,
      int kind);
  static void lm75_init_client(struct i2c_client *client);
  static int lm75_detach_client(struct i2c_client *client);
  static void lm75_update_client(struct i2c_client *client);

* [Sysctl] All sysctl stuff is of course gone (defines, ctl_table
  and functions). Instead, right after the static id definition
  line, you have to define show and set functions for each sysfs
  file. Only define set for writable values. Take a look at an
  existing 2.6 driver for details (lm78 for example). Don't forget
  to define the attributes for each file (this is that step that
  links callback functions). Use the file names specified in
  Documentation/i2c/sysfs-interface for the individual files. Also
  convert the units these files read and write to the specified ones.
  If you need to add a new type of file, please discuss it on the
  sensors mailing list <sensors@stimpy.netroedge.com> by providing a
  patch to the Documentation/i2c/sysfs-interface file.

* [Attach] For I2C drivers, the attach function should make sure
  that the adapter's class has I2C_ADAP_CLASS_SMBUS, using the
  following construct:
  if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
          return 0;
  ISA-only drivers of course don't need this.

* [Detect] As mentioned earlier, the flags parameter is gone.
  The type_name and client_name strings are replaced by a single
  name string, which will be filled with a lowercase, short string
  (typically the driver name, e.g. "lm75"). The errorN labels are
  reduced to the number needed. If that number is 2 (i2c-only
  drivers), it is advised that the labels are named exit and
  exit_free. For i2c+isa drivers, labels should be named ERROR0,
  ERROR1 and ERROR2. Don't forget to properly set err before
  jumping to error labels. By the way, labels should be
  left-aligned.
  Use memset to fill the client and data area with 0x00.
  Use i2c_set_clientdata to set the client data (as opposed to
  a direct access to client->data).
  Use strlcpy instead of strcpy to copy the client name.
  Replace the sysctl directory registration by calls to
  device_create_file. Move the driver initialization before any
  sysfs file creation.

* [Detach] Get rid of data, remove the call to
  i2c_deregister_entry.

* [Update] Don't access client->data directly, use
  i2c_get_clientdata(client) instead.

* [Interface] Init function should not print anything. Make sure
  there is a MODULE_LICENSE() line.

Coding policy:

* [Copyright] Use (C), not (c), for copyright.

* [Debug/log] Get rid of #ifdef DEBUG/#endif constructs whenever you
  can. Calls to printk/pr_debug for debugging purposes are replaced
  by calls to dev_dbg. Here is an example on how to call it (taken
  from lm75_detect):
  dev_dbg(&adapter->dev,
          "lm75_detect called for an ISA bus adapter?!?\n");
  Replace other printk calls with the dev_info, dev_err or dev_warn
  function, as appropriate.

* [Constants] Constants defines (registers, conversions, initial
  values) should be aligned. This greatly improves readability.
  Same goes for variables declarations. Alignments are achieved by the
  means of tabs, not spaces. Remember that tabs are set to 8 in the
  Linux kernel code.

* [Structure definition] The name field should be standardized. All
  lowercase and as simple as the driver name itself (e.g. "lm75").

* [Layout] Avoid extra empty lines between comments and what they
  comment. Respect the coding style (see Documentation/CodingStyle),
  in particular when it comes to placing curly braces.
-------------- next part --------------
--- linux-2.6.0-test9/Documentation/i2c/writing-clients.orig	Sun Nov  9 14:17:53 2003
+++ linux-2.6.0-test9/Documentation/i2c/writing-clients	Sun Nov  9 14:19:12 2003
@@ -24,16 +24,14 @@
 routines, a client structure specific information like the actual I2C
 address.
 
-  struct i2c_driver foo_driver
-  {  
-    /* name           */  "Foo version 2.3 and later driver",
-    /* id             */  I2C_DRIVERID_FOO,
-    /* flags          */  I2C_DF_NOTIFY,
-    /* attach_adapter */  &foo_attach_adapter,
-    /* detach_client  */  &foo_detach_client,
-    /* command        */  &foo_command,   /* May be NULL */
-    /* inc_use        */  &foo_inc_use,   /* May be NULL */
-    /* dec_use        */  &foo_dec_use    /* May be NULL */
+  static struct i2c_driver foo_driver = {
+    .owner          = THIS_MODULE,
+    .name           = "Foo version 2.3 driver",
+    .id             = I2C_DRIVERID_FOO, /* usually from i2c-id.h */
+    .flags          = I2C_DF_NOTIFY,
+    .attach_adapter = &foo_attach_adapter,
+    .detach_client  = &foo_detach_client,
+    .command        = &foo_command /* may be NULL */
   }
  
 The name can be chosen freely, and may be upto 40 characters long. Please
@@ -50,43 +48,8 @@
 All other fields are for call-back functions which will be explained 
 below.
 
-
-Module usage count
-=========
-
-If your driver can also be compiled as a module, there are moments at 
-which the module can not be removed from memory. For example, when you
-are doing a lengthy transaction, or when you create a /proc directory,
-and some process has entered that directory (this last case is the
-main reason why these call-backs were introduced).
-
-To increase or decrease the module usage count, you can use the
-MOD_{INC,DEC}_USE_COUNT macros. They must be called from the module
-which needs to get its usage count changed; that is why each driver
-module has to implement its own callback.
-
-  void foo_inc_use (struct i2c_client *client)
-  {
-  #ifdef MODULE
-    MOD_INC_USE_COUNT;
-  #endif
-  }
-
-  void foo_dec_use (struct i2c_client *client)
-  {
-  #ifdef MODULE
-    MOD_DEC_USE_COUNT;
-  #endif
-  }
-
-Do not call these call-back functions directly; instead, use one of the
-following functions defined in i2c.h:
-  void i2c_inc_use_client(struct i2c_client *);
-  void i2c_dec_use_client(struct i2c_client *);
-
-You should *not* increase the module count just because a device is
-detected and a client created. This would make it impossible to remove
-an adapter driver! 
+There use to be two additional fields in this structure, inc_use et dec_use,
+for module usage count, but these fields were obsoleted and removed.
 
 
 Extra client data
