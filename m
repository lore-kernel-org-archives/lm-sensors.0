From: gregkh@suse.de (gregkh@suse.de)
Date: Thu, 28 Jul 2005 08:28:01 +0000
Subject: [lm-sensors] patch i2c-24rf08-corruption-prevention.patch added to
Message-Id: <1Dy1rZ-426-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: 24RF08 corruption prevention (again)

to my gregkh-2.6 tree.  Its filename is

     i2c-24rf08-corruption-prevention.patch

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


From khali@linux-fr.org Wed Jul 27 12:39:30 2005
Date: Wed, 27 Jul 2005 21:36:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Ben Gardner
 <bgardner@Wabtec.com>
Subject: I2C: 24RF08 corruption prevention (again)
Message-Id: <20050727213617.6d97e251.khali@linux-fr.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/chips/eeprom.c  |    8 +++++---
 drivers/i2c/chips/max6875.c |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/chips/eeprom.c	2005-07-27 23:21:35.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/eeprom.c	2005-07-27 23:21:41.000000000 -0700
@@ -163,6 +163,11 @@
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
@@ -187,9 +192,6 @@
 	new_client->driver = &eeprom_driver;
 	new_client->flags = 0;
 
-	/* prevent 24RF08 corruption */
-	i2c_smbus_write_quick(new_client, 0);
-
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
 	data->valid = 0;
--- gregkh-2.6.orig/drivers/i2c/chips/max6875.c	2005-07-27 23:21:35.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/max6875.c	2005-07-27 23:21:41.000000000 -0700
@@ -173,6 +173,11 @@
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
@@ -211,9 +216,6 @@
 	fake_client->flags = 0;
 	strlcpy(fake_client->name, "max6875 subclient", I2C_NAME_SIZE);
 
-	/* Prevent 24RF08 corruption (in case of user error) */
-	i2c_smbus_write_quick(real_client, 0);
-
 	if ((err = i2c_attach_client(real_client)) != 0)
 		goto exit_kfree2;
 	
