From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2008 11:42:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm75) Fix an incorrect comment
Message-Id: <20080219124258.2917de6e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

High-byte first is not opposite to the usual practice - that's what
almost all hardware monitoring drivers do. It is opposite to the SMBus
standard though.

Also delete a duplicate comment.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm75.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.25-rc2.orig/drivers/hwmon/lm75.c	2008-02-19 11:34:35.000000000 +0100
+++ linux-2.6.25-rc2/drivers/hwmon/lm75.c	2008-02-19 12:37:10.000000000 +0100
@@ -248,7 +248,7 @@ static int lm75_detach_client(struct i2c
 
 /* All registers are word-sized, except for the configuration register.
    LM75 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
+   the SMBus standard. */
 static int lm75_read_value(struct i2c_client *client, u8 reg)
 {
 	if (reg = LM75_REG_CONF)
@@ -257,9 +257,6 @@ static int lm75_read_value(struct i2c_cl
 		return swab16(i2c_smbus_read_word_data(client, reg));
 }
 
-/* All registers are word-sized, except for the configuration register.
-   LM75 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
 	if (reg = LM75_REG_CONF)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
