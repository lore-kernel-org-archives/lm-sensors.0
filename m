From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH 2.6] I2C: Cleanups to the eeprom driver
Message-Id: <20050112215449.2c699efc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a cleanup patch to the i2c eeprom client driver:

* Get rid of the unused i2c_client client_id.
* Get rid of the redundant non-ISA bus check.
* Fix the adapter capability check. We were previously using
  capabilities without checking if they were supported. Document
  which capabilities are required and which are optional.
* Reorder things a bit. In particular, wait to have a valid client
  before we bother checking if this is a Vaio EEPROM.
* Use strlcpy instead of strncpy, because I Heard It Was Better (TM) and
  all other chip drivers use it.
* Take benefit of the auto-increment feature of EEPROMs to speed up the
  Vaio check.
* Display an information message when a Vaio EEPROM is detected.

Tested successfully on my laptop, which happens to be a Vaio.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc1/drivers/i2c/chips/eeprom.c.orig	2005-01-12 19:52:18.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/eeprom.c	2005-01-12 21:33:21.000000000 +0100
@@ -78,8 +78,6 @@
 	.detach_client	= eeprom_detach_client,
 };
 
-static int eeprom_id;
-
 static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {
 	struct eeprom_data *data = i2c_get_clientdata(client);
@@ -165,16 +163,14 @@
 	struct eeprom_data *data;
 	int err = 0;
 
-	/* Make sure we aren't probing the ISA bus!! This is just a safety check
-	   at this moment; i2c_detect really won't call us. */
-#ifdef DEBUG
-	if (i2c_is_isa_adapter(adapter)) {
-		dev_dbg(&adapter->dev, " eeprom_detect called for an ISA bus adapter?!?\n");
-		return 0;
-	}
-#endif
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+	/* There are three ways we can read the EEPROM data:
+	   (1) I2C block reads (faster, but unsupported by most adapters)
+	   (2) Consecutive byte reads (100% overhead)
+	   (3) Regular byte data reads (200% overhead)
+	   The third method is not implemented by this driver because all
+	   known adapters support at least the second. */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA
+					    | I2C_FUNC_SMBUS_BYTE))
 		goto exit;
 
 	/* OK. For now, we presume we have a valid client. We now create the
@@ -197,27 +193,28 @@
 	/* prevent 24RF08 corruption */
 	i2c_smbus_write_quick(new_client, 0);
 
-	data->nature = UNKNOWN;
-	/* Detect the Vaio nature of EEPROMs.
-	   We use the "PCG-" prefix as the signature. */
-	if (address = 0x57) {
-		if (i2c_smbus_read_byte_data(new_client, 0x80) = 'P' && 
-		    i2c_smbus_read_byte_data(new_client, 0x81) = 'C' && 
-		    i2c_smbus_read_byte_data(new_client, 0x82) = 'G' &&
-		    i2c_smbus_read_byte_data(new_client, 0x83) = '-')
-			data->nature = VAIO;
-	}
-
 	/* Fill in the remaining client fields */
-	strncpy(new_client->name, "eeprom", I2C_NAME_SIZE);
-	new_client->id = eeprom_id++;
+	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
+	data->nature = UNKNOWN;
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_kfree;
 
+	/* Detect the Vaio nature of EEPROMs.
+	   We use the "PCG-" prefix as the signature. */
+	if (address = 0x57) {
+		if (i2c_smbus_read_byte_data(new_client, 0x80) = 'P'
+		 && i2c_smbus_read_byte(new_client) = 'C'
+		 && i2c_smbus_read_byte(new_client) = 'G'
+		 && i2c_smbus_read_byte(new_client) = '-')
+			dev_info(&new_client->dev, "Vaio EEPROM detected, "
+				"enabling password protection\n");
+			data->nature = VAIO;
+	}
+
 	/* create the sysfs eeprom file */
 	sysfs_create_bin_file(&new_client->dev.kobj, &eeprom_attr);
 


-- 
Jean Delvare
http://khali.linux-fr.org/
