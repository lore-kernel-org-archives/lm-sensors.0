From: gregkh@suse.de (gregkh@suse.de)
Date: Thu, 28 Jul 2005 08:33:36 +0000
Subject: [lm-sensors] patch i2c-hwmon-lm78-j.patch added to gregkh-2.6 tree
Message-Id: <1Dy1wu-6ZN-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: hwmon: kill client name lm78-j

to my gregkh-2.6 tree.  Its filename is

     i2c-hwmon-lm78-j.patch

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


From khali@linux-fr.org Wed Jul 27 12:34:03 2005
Date: Wed, 27 Jul 2005 21:30:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>
Subject: hwmon: kill client name lm78-j
Message-Id: <20050727213016.6a0d5aed.khali@linux-fr.org>

Drop the separate client name for the LM78-J chip. This is really
only a later revision of the LM78, with almost no difference and
no difference the driver handles in any case.

This was the only client name that had a dash in it, and special care
had to be taken in libsensors because of it. As we plan to write a new
library soon, I'd like to get rid of this exception before we do.

As a nice side effect, it saves 876 bytes in lm78.ko.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 Documentation/hwmon/lm78 |    7 +------
 drivers/hwmon/lm78.c     |   11 ++++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/lm78	2005-07-13 09:44:58.000000000 -0700
+++ gregkh-2.6/Documentation/hwmon/lm78	2005-07-27 23:30:34.000000000 -0700
@@ -2,16 +2,11 @@
 =========
 
 Supported chips:
-  * National Semiconductor LM78
+  * National Semiconductor LM78 / LM78-J
     Prefix: 'lm78'
     Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/
-  * National Semiconductor LM78-J
-    Prefix: 'lm78-j'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
   * National Semiconductor LM79
     Prefix: 'lm79'
     Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
--- gregkh-2.6.orig/drivers/hwmon/lm78.c	2005-07-27 23:26:34.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm78.c	2005-07-27 23:30:34.000000000 -0700
@@ -34,7 +34,7 @@
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_3(lm78, lm78j, lm79);
+SENSORS_INSMOD_2(lm78, lm79);
 
 /* Many LM78 constants specified below */
 
@@ -559,10 +559,9 @@
 	/* Determine the chip type. */
 	if (kind <= 0) {
 		i = lm78_read_value(new_client, LM78_REG_CHIPID);
-		if (i = 0x00 || i = 0x20)
+		if (i = 0x00 || i = 0x20	/* LM78 */
+		 || i = 0x40)			/* LM78-J */
 			kind = lm78;
-		else if (i = 0x40)
-			kind = lm78j;
 		else if ((i & 0xfe) = 0xc0)
 			kind = lm79;
 		else {
@@ -578,8 +577,6 @@
 
 	if (kind = lm78) {
 		client_name = "lm78";
-	} else if (kind = lm78j) {
-		client_name = "lm78-j";
 	} else if (kind = lm79) {
 		client_name = "lm79";
 	}
@@ -788,7 +785,7 @@
 
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
-MODULE_DESCRIPTION("LM78, LM78-J and LM79 driver");
+MODULE_DESCRIPTION("LM78/LM79 driver");
 MODULE_LICENSE("GPL");
 
 module_init(sm_lm78_init);
