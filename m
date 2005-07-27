From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 21:30:38 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: kill client name lm78-j
Message-Id: <20050727213016.6a0d5aed.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Drop the separate client name for the LM78-J chip. This is really
only a later revision of the LM78, with almost no difference and
no difference the driver handles in any case.

This was the only client name that had a dash in it, and special care
had to be taken in libsensors because of it. As we plan to write a new
library soon, I'd like to get rid of this exception before we do.

As a nice side effect, it saves 876 bytes in lm78.ko.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/hwmon/lm78 |    7 +------
 drivers/hwmon/lm78.c     |   11 ++++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

--- linux-2.6.13-rc3.orig/Documentation/hwmon/lm78	2005-07-24 14:45:59.000000000 +0200
+++ linux-2.6.13-rc3/Documentation/hwmon/lm78	2005-07-24 15:01:18.000000000 +0200
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
--- linux-2.6.13-rc3.orig/drivers/hwmon/lm78.c	2005-07-24 14:45:59.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm78.c	2005-07-24 15:13:04.000000000 +0200
@@ -37,7 +37,7 @@
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
-SENSORS_INSMOD_3(lm78, lm78j, lm79);
+SENSORS_INSMOD_2(lm78, lm79);
 
 /* Many LM78 constants specified below */
 
@@ -578,10 +578,9 @@
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
@@ -597,8 +596,6 @@
 
 	if (kind = lm78) {
 		client_name = "lm78";
-	} else if (kind = lm78j) {
-		client_name = "lm78-j";
 	} else if (kind = lm79) {
 		client_name = "lm79";
 	}
@@ -831,7 +828,7 @@
 
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
-MODULE_DESCRIPTION("LM78, LM78-J and LM79 driver");
+MODULE_DESCRIPTION("LM78/LM79 driver");
 MODULE_LICENSE("GPL");
 
 module_init(sm_lm78_init);


-- 
Jean Delvare
