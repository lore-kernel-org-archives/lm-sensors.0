From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 May 2007 07:07:05 +0000
Subject: [lm-sensors] [PATCH] hwmon/lm90: Spelling fix: explicitly
Message-Id: <20070511090705.3f79f1f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm90 |    2 +-
 drivers/hwmon/lm90.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.21-git.orig/Documentation/hwmon/lm90	2007-05-10 09:43:48.000000000 +0200
+++ linux-2.6.21-git/Documentation/hwmon/lm90	2007-05-10 09:52:50.000000000 +0200
@@ -141,7 +141,7 @@ SMBus Read Byte, and PEC will work prope
 Additionally, the ADM1032 doesn't support SMBus Send Byte with PEC.
 Instead, it will try to write the PEC value to the register (because the
 SMBus Send Byte transaction with PEC is similar to a Write Byte transaction
-without PEC), which is not what we want. Thus, PEC is explicitely disabled
+without PEC), which is not what we want. Thus, PEC is explicitly disabled
 on SMBus Send Byte transactions in the lm90 driver.
 
 PEC on byte data transactions represents a significant increase in bandwidth
--- linux-2.6.21-git.orig/drivers/hwmon/lm90.c	2007-05-10 09:43:49.000000000 +0200
+++ linux-2.6.21-git/drivers/hwmon/lm90.c	2007-05-11 09:00:43.000000000 +0200
@@ -429,7 +429,7 @@ static DEVICE_ATTR(pec, S_IWUSR | S_IRUG
  */
 
 /* The ADM1032 supports PEC but not on write byte transactions, so we need
-   to explicitely ask for a transaction without PEC. */
+   to explicitly ask for a transaction without PEC. */
 static inline s32 adm1032_write_byte(struct i2c_client *client, u8 value)
 {
 	return i2c_smbus_xfer(client->adapter, client->addr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
