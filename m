From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Apr 2010 18:04:29 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] emc1403: thermal sensor support
Message-Id: <20100429200429.06d67c01@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100414125205.23181.15562.stgit@localhost.localdomain>
In-Reply-To: <20100414125205.23181.15562.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

On Mon, 26 Apr 2010 11:09:13 +0100, Alan Cox wrote:
> +static int emc1403_detect(struct i2c_client *client,
> +			struct i2c_board_info *info)
> +{
> +	int id;
> +	/* Check if thermal chip is SMSC and EMC1403 */
> +
> +	id = i2c_smbus_read_byte_data(client, THERMAL_SMSC_ID_REG);
> +	if (id != 0x5d)
> +		return -ENODEV;
> +
> +	/* Note: 0x25 is the 1404 which is very similar and this
> +	   driver could be extended */
> +	id = i2c_smbus_read_byte_data(client, THERMAL_PID_REG);
> +	if (id != 0x21)
> +		return -ENODEV;
> +
> +	id = i2c_smbus_read_byte_data(client, THERMAL_REVISION_REG);
> +	if (id != 0x01)
> +		return -ENODEV;
> +
> +	strlcpy(info->type, "emc1403", I2C_NAME_SIZE);
> +	return 0;
> +}
> + (...)
> +
> +const static struct i2c_device_id emc1403_idtable[] = {
> +	{ "emc1403", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
> +
> +static struct i2c_driver sensor_emc1403 = {
> +	.driver = {
> +		.name = "emc1403",
> +	},
> +	.detect = emc1403_detect,
> +	.probe = emc1403_probe,
> +	.remove = emc1403_remove,
> +	.id_table = emc1403_idtable,
> +};

I had to apply the following patch for device detection to actually
work:

---
 drivers/hwmon/emc1403.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.34-rc5.orig/drivers/hwmon/emc1403.c	2010-04-26 15:44:23.000000000 +0200
+++ linux-2.6.34-rc5/drivers/hwmon/emc1403.c	2010-04-29 19:45:06.000000000 +0200
@@ -332,6 +332,10 @@ static int emc1403_remove(struct i2c_cli
 	return 0;
 }
 
+static const unsigned short emc1403_address_list[] = {
+	0x18, 0x2a, 0x4c, 0x4d, I2C_CLIENT_END
+};
+
 const static struct i2c_device_id emc1403_idtable[] = {
 	{ "emc1403", 0 },
 	{ }
@@ -339,6 +343,7 @@ const static struct i2c_device_id emc140
 MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
 
 static struct i2c_driver sensor_emc1403 = {
+	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name = "emc1403",
 	},
@@ -346,6 +351,7 @@ static struct i2c_driver sensor_emc1403
 	.probe = emc1403_probe,
 	.remove = emc1403_remove,
 	.id_table = emc1403_idtable,
+	.address_list = emc1403_address_list,
 };
 
 static int __init sensor_emc1403_init(void)



-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
