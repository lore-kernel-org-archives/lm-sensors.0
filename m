From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:09 +0000
Subject: [lm-sensors] [PATCH] hwmon: kill client name lm78-j
Message-Id: <11259567652443@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: kill client name lm78-j

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
commit 27fe048eb3787d29bf9cf9d6d12077bb8af869a6
tree 8207b9c242c9c15e2fe7887e715668b180e9e775
parent e647ecf15e365679f0528d7815ab4db0d4802918
author Jean Delvare <khali@linux-fr.org> Wed, 27 Jul 2005 21:30:16 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:06 -0700

 Documentation/hwmon/lm78 |    7 +------
 drivers/hwmon/lm78.c     |   11 ++++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/lm78 b/Documentation/hwmon/lm78
--- a/Documentation/hwmon/lm78
+++ b/Documentation/hwmon/lm78
@@ -2,16 +2,11 @@ Kernel driver lm78
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
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -34,7 +34,7 @@ static unsigned short normal_i2c[] = { 0
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_3(lm78, lm78j, lm79);
+SENSORS_INSMOD_2(lm78, lm79);
 
 /* Many LM78 constants specified below */
 
@@ -559,10 +559,9 @@ int lm78_detect(struct i2c_adapter *adap
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
@@ -578,8 +577,6 @@ int lm78_detect(struct i2c_adapter *adap
 
 	if (kind = lm78) {
 		client_name = "lm78";
-	} else if (kind = lm78j) {
-		client_name = "lm78-j";
 	} else if (kind = lm79) {
 		client_name = "lm79";
 	}
@@ -788,7 +785,7 @@ static void __exit sm_lm78_exit(void)
 
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
-MODULE_DESCRIPTION("LM78, LM78-J and LM79 driver");
+MODULE_DESCRIPTION("LM78/LM79 driver");
 MODULE_LICENSE("GPL");
 
 module_init(sm_lm78_init);

