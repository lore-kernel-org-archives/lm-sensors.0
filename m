From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 21:36:11 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: 24RF08 corruption prevention (again)
Message-Id: <20050727213617.6d97e251.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

The 24RF08 corruption prevention in the eeprom and max6875 drivers wasn't
complete. For one thing, the additional quick write should happen as soon
as possible and unconditionally, while both drivers had error paths before.
For another, when a given chip is forced, the core does not emit a quick
write, so a second quick write would cause the corruption rather than
prevent it.

I plan to move the corruption prevention in the core in the long run, so
that individual drivers don't have to care anymore. But I need to merge
i2c_probe and i2c_detect before I do (work in progress).

Note that this patch should be applied after all Ben Gardner's max6875
patches.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/eeprom.c  |    8 +++++---
 drivers/i2c/chips/max6875.c |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/i2c/chips/eeprom.c	2005-07-27 20:26:36.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/chips/eeprom.c	2005-07-27 20:30:04.000000000 +0200
@@ -162,6 +162,11 @@
 	struct eeprom_data *data;
 	int err = 0;
 
+	/* prevent 24RF08 corruption */
+	if (kind < 0)
+		i2c_smbus_xfer(adapter, address, 0, 0, 0,
+			       I2C_SMBUS_QUICK, NULL);
+
 	/* There are three ways we can read the EEPROM data:
 	   (1) I2C block reads (faster, but unsupported by most adapters)
 	   (2) Consecutive byte reads (100% overhead)
@@ -186,9 +191,6 @@
 	new_client->driver = &eeprom_driver;
 	new_client->flags = 0;
 
-	/* prevent 24RF08 corruption */
-	i2c_smbus_write_quick(new_client, 0);
-
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
 	data->valid = 0;
--- linux-2.6.13-rc3.orig/drivers/i2c/chips/max6875.c	2005-07-27 20:28:21.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/chips/max6875.c	2005-07-27 20:30:34.000000000 +0200
@@ -172,6 +172,11 @@
 	struct max6875_data *data;
 	int err = 0;
 
+	/* Prevent 24RF08 corruption (in case of user error) */
+	if (kind < 0)
+		i2c_smbus_xfer(adapter, address, 0, 0, 0,
+			       I2C_SMBUS_QUICK, NULL);
+
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 				     | I2C_FUNC_SMBUS_READ_BYTE))
 		return 0;
@@ -210,9 +215,6 @@
 	fake_client->flags = 0;
 	strlcpy(fake_client->name, "max6875 subclient", I2C_NAME_SIZE);
 
-	/* Prevent 24RF08 corruption (in case of user error) */
-	i2c_smbus_write_quick(real_client, 0);
-
 	if ((err = i2c_attach_client(real_client)) != 0)
 		goto exit_kfree2;
 


-- 
Jean Delvare
