From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <20040413225651.6aa07f6a.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Apr 2004 20:42:06 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > Yep.
> > Attached.
> 
> -EDOESNTAPPLY
> 
> Please checkout the latest CVS version of the file and provide a patch
> that applies against that.

Done.

> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
-------------- next part --------------
--- kernel/chips/lm92.c.orig	Tue Apr 13 22:54:31 2004
+++ kernel/chips/lm92.c	Tue Apr 13 22:54:51 2004
@@ -107,7 +107,7 @@
 
 /* addresses to scan */
 static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4b, SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
 static unsigned int normal_isa[] = { SENSORS_ISA_END };
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
@@ -126,7 +126,7 @@
 	if (tmp < 0) return (-EIO);
 
 	/* convert the data to little endian format */
-	*value = swab16((u16) tmp);
+	*value = ((u16) tmp >> 8) | (u16) ((u16) tmp << 8);
 
 	return (0);
 }
@@ -134,10 +134,8 @@
 static inline int lm92_write16 (struct i2c_client *client,u8 reg,u16 value)
 {
 	/* convert the data to big endian format */
-	if (i2c_smbus_write_word_data(client, reg, swab16(value)) < 0)
-		return -EIO;
-
-	return 0;
+	u16 be = (value >> 8) | (u16) (value << 8);
+	return (i2c_smbus_write_word_data (client,reg,be) < 0 ? -EIO : 0);
 }
 
 static int lm92_read (struct i2c_client *client)
@@ -231,6 +229,49 @@
 	}
 }
 
+static int max6635_check(struct i2c_client *client)
+{
+	lm92_t *data = (lm92_t *) client->data;
+	int i, cn = 8;
+	u16 temp_low, temp_high, temp_hyst, temp_max;
+
+	temp_low 	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_LOW);
+	temp_high	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_HIGH);
+	temp_hyst	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_HYSTERESIS);
+	temp_max	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_CRITICAL);
+	
+	if (!(!(temp_low & 0x7f00) && !(temp_high & 0x7f00) && !(temp_hyst & 0x7f00) && !(temp_max & 0x7f00)))
+		return 0;
+
+	for (i=0; i<32; ++i)
+	{
+		if ((i % 2 = 0) && (i < 16))
+		{
+			if ((i2c_smbus_read_word_data(client, LM92_REG_TRIP_LOW + i*cn) != temp_low) ||
+				(temp_high != i2c_smbus_read_word_data(client, LM92_REG_TRIP_HIGH + i*cn)) ||
+				(temp_hyst != i2c_smbus_read_word_data(client, LM92_REG_TRIP_HYSTERESIS + i*cn)) ||
+				(temp_max != i2c_smbus_read_word_data(client, LM92_REG_TRIP_CRITICAL + i*cn)))
+				return 0;
+		}
+		else
+		{
+			if ((i2c_smbus_read_word_data(client, LM92_REG_TRIP_LOW + i*cn) != 0) ||
+				(0 != i2c_smbus_read_word_data(client, LM92_REG_TRIP_HIGH + i*cn)) ||
+				(0 != i2c_smbus_read_word_data(client, LM92_REG_TRIP_HYSTERESIS + i*cn)) ||
+				(0 != i2c_smbus_read_word_data(client, LM92_REG_TRIP_CRITICAL + i*cn)))
+				return 0;
+		}
+	}
+	
+	data->temp.low 	= swab16(temp_low);
+	data->temp.high = swab16(temp_high);
+	data->temp.crit	= swab16(temp_max);
+	data->temp.hyst = swab16(temp_hyst);
+	data->temp.low 	= swab16(i2c_smbus_read_word_data(client, LM92_REG_TEMPERATURE));
+
+	return 1;
+}
+
 static int lm92_init_client (struct i2c_client *client)
 {
 	lm92_t *data = (lm92_t *) client->data;
@@ -294,20 +335,25 @@
 		return (-ERESTARTSYS);
 	}
 
-	if ((kind < 0 && lm92_read16 (client,LM92_REG_MANUFACTURER,&manufacturer) < 0) ||
-		manufacturer != LM92_MANUFACTURER_ID) {
-		kfree (client);
-		up (&mutex);
-		return (-ENODEV);
-	}
-
 	if ((result = i2c_attach_client (client))) {
 		kfree (client);
 		up (&mutex);
 		return (result);
 	}
 
-	if ((result = i2c_register_entry (client,client->name,lm92_dir_table)) < 0) {
+	if ((kind < 0 && lm92_read16 (client,LM92_REG_MANUFACTURER,&manufacturer) < 0) ||
+		manufacturer != LM92_MANUFACTURER_ID) {
+
+		if (!max6635_check(client))
+		{
+			i2c_detach_client (client);
+			kfree (client);
+			up (&mutex);
+			return (-ENODEV);
+		}
+	}
+
+	if ((result = i2c_register_entry (client,client->name,lm92_dir_table, THIS_MODULE)) < 0) {
 		i2c_detach_client (client);
 		kfree (client);
 		up (&mutex);
@@ -365,9 +411,7 @@
 
 
 static struct i2c_driver lm92_driver = {
-	.owner		= THIS_MODULE,
 	.name		= "lm92",
-	.id		= I2C_DRIVERID_LM92,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm92_attach_adapter,
 	.detach_client	= lm92_detach_client,
