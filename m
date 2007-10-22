From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2007 15:45:08 +0000
Subject: [lm-sensors] [PATCH] hwmon: (gl518sm) Various cleanups
Message-Id: <20071022174508.5eb9170a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

* Drop history, it doesn't belong there
* Drop unused struct member
* Drop bogus struct member comment
* Drop unused driver ID
* Rename new_client to client
* Drop redundant initializations to 0
* Drop useless cast
* Drop trailing space
* Fix comment
* Drop duplicate comment

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl518sm.c |   49 ++++++++++++++++++-------------------------=
----
 include/linux/i2c-id.h  |    1=20
 2 files changed, 19 insertions(+), 31 deletions(-)

--- linux-2.6.24-rc0.orig/drivers/hwmon/gl518sm.c	2007-10-21 11:38:12.00000=
0000 +0200
+++ linux-2.6.24-rc0/drivers/hwmon/gl518sm.c	2007-10-21 22:38:40.000000000 =
+0200
@@ -30,10 +30,6 @@
  * We did not keep that part of the original driver in the Linux 2.6
  * version, since it was making the driver significantly more complex
  * with no real benefit.
- *
- * History:
- * 2004-01-28  Original port. (Hong-Gunn Chew)
- * 2004-01-31  Code review and approval. (Jean Delvare)
  */
=20
 #include <linux/module.h>
@@ -129,7 +125,6 @@ struct gl518_data {
 	u8 voltage_in[4];	/* Register values; [0] =3D VDD */
 	u8 voltage_min[4];	/* Register values; [0] =3D VDD */
 	u8 voltage_max[4];	/* Register values; [0] =3D VDD */
-	u8 iter_voltage_in[4];	/* Register values; [0] =3D VDD */
 	u8 fan_in[2];
 	u8 fan_min[2];
 	u8 fan_div[2];		/* Register encoding, shifted right */
@@ -138,7 +133,7 @@ struct gl518_data {
 	u8 temp_max;		/* Register values */
 	u8 temp_hyst;		/* Register values */
 	u8 alarms;		/* Register value */
-	u8 alarm_mask;		/* Register value */
+	u8 alarm_mask;
 	u8 beep_mask;		/* Register value */
 	u8 beep_enable;		/* Boolean */
 };
@@ -156,7 +151,6 @@ static struct i2c_driver gl518_driver =3D=20
 	.driver =3D {
 		.name	=3D "gl518sm",
 	},
-	.id		=3D I2C_DRIVERID_GL518,
 	.attach_adapter	=3D gl518_attach_adapter,
 	.detach_client	=3D gl518_detach_client,
 };
@@ -391,7 +385,7 @@ static int gl518_attach_adapter(struct i
 static int gl518_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct gl518_data *data;
 	int err =3D 0;
=20
@@ -408,25 +402,24 @@ static int gl518_detect(struct i2c_adapt
 		goto exit;
 	}
=20
-	new_client =3D &data->client;
-	i2c_set_clientdata(new_client, data);
+	client =3D &data->client;
+	i2c_set_clientdata(client, data);
=20
-	new_client->addr =3D address;
-	new_client->adapter =3D adapter;
-	new_client->driver =3D &gl518_driver;
-	new_client->flags =3D 0;
+	client->addr =3D address;
+	client->adapter =3D adapter;
+	client->driver =3D &gl518_driver;
=20
 	/* Now, we do the remaining detection. */
=20
 	if (kind < 0) {
-		if ((gl518_read_value(new_client, GL518_REG_CHIP_ID) !=3D 0x80)
-		 || (gl518_read_value(new_client, GL518_REG_CONF) & 0x80))
+		if ((gl518_read_value(client, GL518_REG_CHIP_ID) !=3D 0x80)
+		 || (gl518_read_value(client, GL518_REG_CONF) & 0x80))
 			goto exit_free;
 	}
=20
 	/* Determine the chip type. */
 	if (kind <=3D 0) {
-		i =3D gl518_read_value(new_client, GL518_REG_REVISION);
+		i =3D gl518_read_value(client, GL518_REG_REVISION);
 		if (i =3D 0x00) {
 			kind =3D gl518sm_r00;
 		} else if (i =3D 0x80) {
@@ -442,25 +435,24 @@ static int gl518_detect(struct i2c_adapt
 	}
=20
 	/* Fill in the remaining client fields */
-	strlcpy(new_client->name, "gl518sm", I2C_NAME_SIZE);
+	strlcpy(client->name, "gl518sm", I2C_NAME_SIZE);
 	data->type =3D kind;
-	data->valid =3D 0;
 	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
-	if ((err =3D i2c_attach_client(new_client)))
+	if ((err =3D i2c_attach_client(client)))
 		goto exit_free;
=20
 	/* Initialize the GL518SM chip */
 	data->alarm_mask =3D 0xff;
 	data->voltage_in[0]=DAta->voltage_in[1]=DAta->voltage_in[2]=3D0;
-	gl518_init_client((struct i2c_client *) new_client);
+	gl518_init_client(client);
=20
 	/* Register sysfs hooks */
-	if ((err =3D sysfs_create_group(&new_client->dev.kobj, &gl518_group)))
+	if ((err =3D sysfs_create_group(&client->dev.kobj, &gl518_group)))
 		goto exit_detach;
=20
-	data->hwmon_dev =3D hwmon_device_register(&new_client->dev);
+	data->hwmon_dev =3D hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err =3D PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
@@ -469,9 +461,9 @@ static int gl518_detect(struct i2c_adapt
 	return 0;
=20
 exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &gl518_group);
+	sysfs_remove_group(&client->dev.kobj, &gl518_group);
 exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
@@ -512,9 +504,9 @@ static int gl518_detach_client(struct i2
 	return 0;
 }
=20
-/* Registers 0x07 to 0x0c are word-sized, others are byte-sized=20
+/* Registers 0x07 to 0x0c are word-sized, others are byte-sized
    GL518 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
+   the SMBus standard. */
 static int gl518_read_value(struct i2c_client *client, u8 reg)
 {
 	if ((reg >=3D 0x07) && (reg <=3D 0x0c))
@@ -523,9 +515,6 @@ static int gl518_read_value(struct i2c_c
 		return i2c_smbus_read_byte_data(client, reg);
 }
=20
-/* Registers 0x07 to 0x0c are word-sized, others are byte-sized=20
-   GL518 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
 static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
 	if ((reg >=3D 0x07) && (reg <=3D 0x0c))
--- linux-2.6.24-rc0.orig/include/linux/i2c-id.h	2007-10-21 11:38:35.000000=
000 +0200
+++ linux-2.6.24-rc0/include/linux/i2c-id.h	2007-10-21 21:37:54.000000000 +=
0200
@@ -130,7 +130,6 @@
    These were originally in sensors.h in the lm_sensors package */
 #define I2C_DRIVERID_LM78 1002
 #define I2C_DRIVERID_LM75 1003
-#define I2C_DRIVERID_GL518 1004
 #define I2C_DRIVERID_EEPROM 1005
 #define I2C_DRIVERID_W83781D 1006
 #define I2C_DRIVERID_LM80 1007


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
