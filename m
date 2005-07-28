From: gregkh@suse.de (gregkh@suse.de)
Date: Thu, 28 Jul 2005 08:33:49 +0000
Subject: [lm-sensors] patch i2c-hwmon-tag-superio-functions-__init.patch
Message-Id: <1Dy1wv-6nE-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: hwmon: tag super-i/o find functions __init

to my gregkh-2.6 tree.  Its filename is

     i2c-hwmon-tag-superio-functions-__init.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-missing-space.patch
i2c/i2c-nforce2-cleanup.patch
i2c/i2c-hwmon-split-01.patch
i2c/i2c-hwmon-split-02.patch
i2c/i2c-hwmon-split-03.patch
i2c/i2c-hwmon-split-04.patch
i2c/i2c-hwmon-split-05.patch
i2c/i2c-hwmon-split-06.patch
i2c/i2c-hwmon-split-07.patch
i2c/i2c-hwmon-split-08.patch
i2c/i2c-hwmon-split-09.patch
i2c/i2c-max6875-cleanup.patch
i2c/i2c-max6875-documentation-cleanup.patch
i2c/i2c-max6875-kobj_to_i2c_client.patch
i2c/i2c-24rf08-corruption-prevention.patch
i2c/i2c-missing-newlines.patch
i2c/i2c-refactor-message.patch
i2c/i2c-use-time_after.patch
i2c/i2c-hwmon-document-w83627ehg.patch
i2c/i2c-hwmon-lm78-j.patch
i2c/i2c-hwmon-soften-lm75.patch
i2c/i2c-hwmon-tag-superio-functions-__init.patch


From khali@linux-fr.org Wed Jul 27 12:34:10 2005
Date: Wed, 27 Jul 2005 21:32:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>
Subject: hwmon: tag super-i/o find functions __init
Message-Id: <20050727213202.423a4342.khali@linux-fr.org>

Super-I/O find functions in hardware monitoring drivers can be tagged
__init as they are only called from functions themselves tagged __init.
Two of them (smsc47b397 and w83627ehf) already do, but the other four
of them (it87, pc87360, smsc47m1 and w83627hf) did not.

This saves a few bytes of memory after the drivers are loaded, 192 in
the case of the it87 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.13-rc3.orig/drivers/hwmon/it87.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/it87.c	2005-07-24 15:22:39.000000000 +0200
@@ -707,7 +707,7 @@
 }
 
 /* SuperIO detection - will change isa_address if a chip is found */
-static int it87_find(int *address)
+static int __init it87_find(int *address)
 {
 	int err = -ENODEV;
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/pc87360.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/pc87360.c	2005-07-24 15:22:39.000000000 +0200
@@ -626,7 +626,7 @@
  * Device detection, registration and update
  */
 
-static int pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
+static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
 {
 	u16 val;
 	int i;
--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47m1.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47m1.c	2005-07-24 15:22:39.000000000 +0200
@@ -345,7 +345,7 @@
 
 static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
 
-static int smsc47m1_find(unsigned short *addr)
+static int __init smsc47m1_find(unsigned short *addr)
 {
 	u8 val;
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627hf.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627hf.c	2005-07-24 15:22:39.000000000 +0200
@@ -958,7 +958,7 @@
 } while (0)
 
 
-static int w83627hf_find(int sioaddr, unsigned short *addr)
+static int __init w83627hf_find(int sioaddr, unsigned short *addr)
 {
 	u16 val;
 


-- 
Jean Delvare

