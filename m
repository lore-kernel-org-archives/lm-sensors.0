From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:32 +0000
Subject: [lm-sensors] [PATCH] I2C: max6875 code cleanup
Message-Id: <11259567651481@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507271243.15212.bgardner@wabtec.com>
In-Reply-To: <200507271243.15212.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: max6875 code cleanup

Remove an unused local variable and change the subclient name.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 17f990c87a1e5addc49b99a53b3d2a2fac9680e9
tree 6e17f13a5ce16299e20122d71450ca3a4c3db997
parent 0283fe6c3bdbe9ca9aefa28b24883ec1dee3ccbd
author bgardner@wabtec.com <bgardner@wabtec.com> Wed, 27 Jul 2005 12:43:14 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:06 -0700

 drivers/i2c/chips/max6875.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -81,7 +81,6 @@ static void max6875_update_slice(struct 
 	struct max6875_data *data = i2c_get_clientdata(client);
 	int i, j, addr;
 	u8 *buf;
-	int retval = 0;
 
 	if (slice >= USER_EEPROM_SLICES)
 		return;
@@ -102,7 +101,6 @@ static void max6875_update_slice(struct 
 		/* select the eeprom address */
 		if (i2c_smbus_write_byte_data(client, addr >> 8, addr & 0xFF)) {
 			dev_err(&client->dev, "address set failed\n");
-			retval = -1;
 			goto exit_up;
 		}
 
@@ -111,14 +109,12 @@ static void max6875_update_slice(struct 
 			if (i2c_smbus_read_i2c_block_data(client,
 							  MAX6875_CMD_BLK_READ,
 							  buf) != SLICE_SIZE) {
-				retval = -1;
 				goto exit_up;
 			}
 		} else {
 			for (i = 0; i < SLICE_SIZE; i++) {
 				j = i2c_smbus_read_byte(client);
 				if (j < 0) {
-					retval = -1;
 					goto exit_up;
 				}
 				buf[i] = j;
@@ -182,7 +178,7 @@ static int max6875_detect(struct i2c_ada
 		i2c_smbus_xfer(adapter, address, 0, 0, 0,
 			       I2C_SMBUS_QUICK, NULL);
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 				     | I2C_FUNC_SMBUS_READ_BYTE))
 		return 0;
 
@@ -218,7 +214,7 @@ static int max6875_detect(struct i2c_ada
 	fake_client->adapter = adapter;
 	fake_client->driver = &max6875_driver;
 	fake_client->flags = 0;
-	strlcpy(fake_client->name, "max6875-dummy", I2C_NAME_SIZE);
+	strlcpy(fake_client->name, "max6875 subclient", I2C_NAME_SIZE);
 
 	/* Prevent 24RF08 corruption (in case of user error) */
 	i2c_smbus_write_quick(real_client, 0);

