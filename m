From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Aug 2011 11:38:35 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm90) Fix warnings
Message-Id: <20110829133835.3b8fb7f2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With some configuration option combinations, we get the following
warnings:

drivers/hwmon/lm90.c: In function 'lm90_detect':
drivers/hwmon/lm90.c:1114: warning: 'chip_id' may be used uninitialized
in this function
drivers/hwmon/lm90.c:1114: warning: 'reg_config1' may be used
uninitialized in this function
drivers/hwmon/lm90.c:1114: warning: 'reg_convrate' may be used
uninitialized in this function
drivers/hwmon/lm90.c:1187: warning: 'reg_emerg2' may be used
uninitialized in this function
drivers/hwmon/lm90.c:1187: warning: 'reg_status2' may be used
uninitialized in this function

We can solve these easily by reading the register values first and
checking for errors later. These errors should be very rare, even in
the case of failed detection, so this change has no impact on
performance. And this makes checkpatch.pl happier.

Reported-by: Guenter Roeck <guenter.roeck@ericsson.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm90.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--- linux-3.1-rc3.orig/drivers/hwmon/lm90.c	2011-08-29 11:13:19.000000000 +0200
+++ linux-3.1-rc3/drivers/hwmon/lm90.c	2011-08-29 11:28:42.000000000 +0200
@@ -1117,14 +1117,12 @@ static int lm90_detect(struct i2c_client
 		return -ENODEV;
 
 	/* detection and identification */
-	if ((man_id = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_MAN_ID)) < 0
-	 || (chip_id = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CHIP_ID)) < 0
-	 || (reg_config1 = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CONFIG1)) < 0
-	 || (reg_convrate = i2c_smbus_read_byte_data(new_client,
-						LM90_REG_R_CONVRATE)) < 0)
+	man_id = i2c_smbus_read_byte_data(new_client, LM90_REG_R_MAN_ID);
+	chip_id = i2c_smbus_read_byte_data(new_client, LM90_REG_R_CHIP_ID);
+	reg_config1 = i2c_smbus_read_byte_data(new_client, LM90_REG_R_CONFIG1);
+	reg_convrate = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_CONVRATE);
+	if (man_id < 0 || chip_id < 0 || reg_config1 < 0 || reg_convrate < 0)
 		return -ENODEV;
 
 	if (man_id = 0x01 || man_id = 0x5C || man_id = 0x41) {
@@ -1192,13 +1190,16 @@ static int lm90_detect(struct i2c_client
 		 * exists, both readings will reflect the same value. Otherwise,
 		 * the readings will be different.
 		 */
-		if ((reg_emerg = i2c_smbus_read_byte_data(new_client,
-						MAX6659_REG_R_REMOTE_EMERG)) < 0
-		 || i2c_smbus_read_byte_data(new_client, LM90_REG_R_MAN_ID) < 0
-		 || (reg_emerg2 = i2c_smbus_read_byte_data(new_client,
-						MAX6659_REG_R_REMOTE_EMERG)) < 0
-		 || (reg_status2 = i2c_smbus_read_byte_data(new_client,
-						MAX6696_REG_R_STATUS2)) < 0)
+		reg_emerg = i2c_smbus_read_byte_data(new_client,
+						  MAX6659_REG_R_REMOTE_EMERG);
+		man_id = i2c_smbus_read_byte_data(new_client,
+						  LM90_REG_R_MAN_ID);
+		reg_emerg2 = i2c_smbus_read_byte_data(new_client,
+						  MAX6659_REG_R_REMOTE_EMERG);
+		reg_status2 = i2c_smbus_read_byte_data(new_client,
+						       MAX6696_REG_R_STATUS2);
+		if (reg_emerg < 0 || man_id < 0 || reg_emerg2 < 0
+		 || reg_status2 < 0)
 			return -ENODEV;
 
 		/*


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
