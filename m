From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Conversion guide for i2c chip drivers
Message-Id: <20030928151507.77cbd250.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030927122451.191bb291.khali@linux-fr.org>
In-Reply-To: <20030927122451.191bb291.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > In the detect function, why is memset called on client data before
> > it is filled?
> 
> Because the struct device burried in that structure needs to be set to
> 0 before the register function is called.

This doesn't answer my question. I know what memset does. What I don't
know is why this is done, or, to make my question more precise, why it
is done in 2.6 and wasn't in 2.4.

> > Why is client data handled with i2c_set_clientdata and
> > i2c_get_clientdata instead of direct access?
> 
> Because it's easier that way :)
> This way a driver will work with both 2.4 and 2.6 without having to
> figure out exactly where to store it's private data.  It's much
> cleaner that way.

I don't follow you here either. Each chip driver is allocating the data
space by itself anyway, and the same way as in 2.4. What's more, 2.4
doesn't have i2c_set_clientdata. After reading what the function does,
it turns out that the main (well, unique) goal is to provide a standard
way to retrieve any driver's data pointer using dev_get_drvdata. So I
don't really get why we are not using dev_set_drvdata directly. Oh well,
this may simply be over me.

(some times after)

Mmm, maybe I get it now. You plan to introduce an i2c_set_clientdata
function in 2.4, which will access client->data instead of client->dev
as it is the case in 2.6. Is that it?

OK, I've made the requested changes, plus some others. Document
attached.

I will now be using my own guide to convert some drivers. That way, I'll
see if it is correct or not ;) After that, we'll consider releasing the
document.

Thanks a lot Greg for the comments.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Revision 2, 2003-09-28
Jean Delvare <khali@linux-fr.org>
Greg KH <greg@kroah.com>

This is a guide on how to convert I2C chip drivers from Linux 2.4 to
Linux 2.6. I have been using the simple lm75 driver as an example.

There are two sets of points below. The first set concerns technical
points and are mandatory. The second set concerns coding policy, you
are strongly invited to follow them.

Although reading this guide will help you porting drivers, I suggest
you generate a diff between the original and ported version of an
already ported driver (lm75 for a simple, temperature only chip,
lm78 for a more complex one) and use it as a base. Use the chip
driver that is the more similar to yours for best results.

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
  temp_max). Use the file names specified in
  Documentation/i2c/sysfs-interface for the individual files. Also
  convert the units these files read and write to the specified ones.
  If you need to add a new type of file, please discuss it on the
  sensors mailing list <sensors@stimpy.netroedge.com> by providing a
  patch to the Documentation/i2c/sysfs-interface file.

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

* [Attach] For I2C drivers, the attach function should make sure
  that the adapter's class has I2C_ADAP_CLASS_SMBUS, using the
  following construct:
  if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
          return 0;
  ISA-only drivers of course don't need this.

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
  Use memset to fill the client and data area with 0x00.
  Use i2c_set_clientdata to set the client data (as opposed to
  a direct access to client->data).
  Use strlcpy instead of strcpy to copy the client name.
  Replace the sysctl directory registration by calls to
  device_create_file.

* [Detach] Get rid of data, remove call to deregister_entry.

* [Update] Don't access client->data directly, use
  i2c_get_clientdata(client) instead.

* [Interface] Use standard names for init and exit functions
  (e.g. sensors_lm75_init and sensors_lm75_exit). Init function
  should not print anything. Make sure there is a MODULE_LICENSE()
  line.

Recommended:

* [Debug/log] Get it of #ifdef DEBUG/#endif constructs whenever you
  can. Calls to printk/pr_debug for debugging purposes are replaced
  by calls to dev_dbg. Here is an example on how to call it (taken
  from lm75_detect):
  dev_dbg(&adapter->dev,
          "lm75_detect called for an ISA bus adapter?!?\n");
  Replace other prink calls with the dev_info, dev_err or dev_warn
  function, as appropriate.

* [Constants] Constants defines (registers, conversions, initial
  values) should be aligned. This greatly improves readability.
  Same goes for variables declarations.

* [Structure definition] The name field should be standardized. All
  lowercase and as simple as the driver name itself (e.g. "lm75").
