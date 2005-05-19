From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Conversion guide for i2c chip drivers
Message-Id: <20030927122451.191bb291.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

I'm in the process of writting a conversion guide for i2c chip drivers.
First version attached. Please tell me what you think about it. There's
at least two things I'd like explanations on:

In the detect function, why is memset called on client data before it is
filled?

Why is client data handled with i2c_set_clientdata and
i2c_get_clientdata instead of direct access?

I'd need to explain that in my guide, but don't understand it myself.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
2003-09-27, Jean Delvare <khali@linux-fr.org>

This is a guide on how to convert I2C chip drivers from Linux 2.4 to
Linux 2.6. I have been using the simple lm75 driver as an example.

There are two sets of points below. The first set concerns technical
points and are mandatory. The second set concerns coding policy, you
are strongly invited to follow them.

Mandatory:

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

* [Client data] Get rid of sysctl_id. Use standard names for register
  values (for example, temp becomes temp_input, temp_os becomes
  temp_max).

* [Function prototypes] The detect functions loses its flags
  parameter. Sysctl (e.g. lm75_temp) and miscellaneous (e.g.
  swap_bytes) functions are off the list of prototypes.

* [Sysctl] All sysctl stuff is of course gone (defines, ctl_table
  and functions). Instead, right after the static id definition
  line, you have to define show and set functions for each sysfs
  file. Only define set for writable values. You may want to create
  two macros first, because the functions are always the same. Take
  a look at an existing 2.6 driver for details (lm75 is a a good one
  because it is simple). Don't forget to define the attributes for
  each file (this is that step that links callback functions).

* [Attach] The attach function should make sure that the adapter's
  class is I2C_ADAP_CLASS_SMBUS, using the following construct:
  if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
          return 0;

* [Detect] As mentioned earlier, the flags parameter is gone.
  The type_name and client_name strings are replaced by a single
  name string, which will be filled with a lowercase, short string
  (typically the driver name, e.g. "lm75). The errorN labels are
  reduced to the number needed. If that number is 2 (i2c-only
  drivers), it is advised that the labels are named exit and
  exit_free. For i2c+isa drivers, labels should be named ERROR0,
  ERROR1 and ERROR2. Don't forget to properly set err before
  jumping to error labels. By the way, labels should be
  left-aligned.
  i2c_set_clientdata ?
  Use strlcpy instead of strcpy to copy the client name.
  Replace the sysctl directory registration by calls to
  device_create_file.

* [Detach] Get rid of data, remove call to deregister_entry.

* [Update] Don't access client->data directly, use
  i2c_get_clientdata(client) instead.

* [Interface] Use standard names for init and exit functions
  (e.g. sensors_lm75_init and sensors_lm75_exit). Init function
  should not print anything. Make sure that MODULE_LICENSE is
  called.

Recommended:

* [Debug] Debug code should be placed inside #ifdef DEBUG/#endif
  constructs. A commented line to define DEBUG should be provided
  near the top of the script. Calls to printk/pr_debug for debugging
  purposes are replaced by calls to dev_dbg. Here is an example on
  how to call it (taken from lm75_detect):
  dev_dbg(&adapter->dev,
          "lm75_detect called for an ISA bus adapter?!?\n");
  For other prink calls, don't forget the KERN_* prefix.

* [Constants] Constants defines (registers, conversions, initial
  values) should be aligned. This greatly improves readability.
  Same goes for variables declarations.

* [Structure definition] The name field should be standardized. All
  lowercase and as simple as the driver name itself (e.g. "lm75").
