From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 19 Dec 2007 14:13:54 +0000
Subject: [lm-sensors] preliminary TI TMP401 driver
Message-Id: <47692722.1090705@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080809020600060604060701"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080809020600060604060701
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi All,

I thought I already send this to the lm_sensors list too, but appearantly n=
ot.
Here is a preliminary, but untested (no access to hardware) driver.

---

Notice that when compiling against anything older then 2.6.24-rc1, you will=
 get
the following 2 (harmless) warnings:
    CC [M]  /home/hans/projects/ti-tmp401/tmp401.o
/home/hans/projects/ti-tmp401/tmp401.c: In function =91tmp401_detect=92:
/home/hans/projects/ti-tmp401/tmp401.c:417: warning: assignment from
incompatible pointer type
/home/hans/projects/ti-tmp401/tmp401.c: In function =91tmp401_detach_client=
=92:
/home/hans/projects/ti-tmp401/tmp401.c:473: warning: passing argument 1 of
=91hwmon_device_unregister=92 from incompatible pointer type

Regards,

Hans


--------------080809020600060604060701
Content-Type: text/x-csrc;
 name="tmp401.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tmp401.c"

/* tmp401.c
 *
 * Copyright (C) 2007 Hans de Goede <j.w.r.degoede@hhs.nl>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * Driver for the Texas Instruments TMP401 SMBUS temperature sensor IC.
 *
 * Note this IC is in some aspect similar to the lm90, but it has quite a
 * few differences too, for example the local temp has a higher resolution
 * and thus has 16 bits registers for its value and limit instead of 8 bits.
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/i2c.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>
#include <linux/sysfs.h>

/* Addresses to scan */
static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };

/* Insmod parameters */
I2C_CLIENT_INSMOD_1(tmp401);


/*
 * The TMP401 registers, note some registers have different addresses for
 * reading and writing
 */
#define TMP401_STATUS				0x02
#define TMP401_CONFIG_READ			0x03
#define TMP401_CONFIG_WRITE			0x09
#define TMP401_CONVERSION_RATE_READ		0x04
#define TMP401_CONVERSION_RATE_WRITE		0x0A
#define TMP401_ONE_SHOT_START_WRITE		0x0F
#define TMP401_RESOLUTION			0x1A
#define TMP401_TEMP_CRIT_HYST			0x21
#define TMP401_CONSECUTIVE_ALERT		0x22
#define TMP401_MANUFACTURER_ID_REG		0xFE
#define TMP401_DEVICE_ID_REG			0xFF

static const u8 TMP401_TEMP_MSB[2]			= { 0x00, 0x01 };
static const u8 TMP401_TEMP_LSB[2]			= { 0x15, 0x10 };
static const u8 TMP401_TEMP_LOW_LIMIT_MSB_READ[2]	= { 0x06, 0x08 };
static const u8 TMP401_TEMP_LOW_LIMIT_MSB_WRITE[2]	= { 0x0C, 0x0E };
static const u8 TMP401_TEMP_LOW_LIMIT_LSB[2]		= { 0x17, 0x14 };
static const u8 TMP401_TEMP_HIGH_LIMIT_MSB_READ[2]	= { 0x05, 0x07 };
static const u8 TMP401_TEMP_HIGH_LIMIT_MSB_WRITE[2]	= { 0x0B, 0x0D };
static const u8 TMP401_TEMP_HIGH_LIMIT_LSB[2]		= { 0x16, 0x13 };
/* These are called the THERM limit / hysteresis / mask in the datasheets */
static const u8 TMP401_TEMP_CRIT_LIMIT[2]		= { 0x20, 0x19 };

/* Bit masks */
#define TMP401_CONFIG_RANGE_MASK		0x04
#define TMP401_CONFIG_SHUTDOWN_MASK		0x40
#define TMP401_STATUS_LOCAL_CRIT_MASK		0x01
#define TMP401_STATUS_REMOTE_CRIT_MASK		0x02
#define TMP401_STATUS_REMOTE_OPEN_MASK		0x04
#define TMP401_STATUS_REMOTE_LOW_MASK		0x08
#define TMP401_STATUS_REMOTE_HIGH_MASK		0x10
#define TMP401_STATUS_LOCAL_LOW_MASK		0x20
#define TMP401_STATUS_LOCAL_HIGH_MASK		0x40

/* Manufacturer / Device ID's */
#define TMP401_MANUFACTURER_ID			0x55
#define TMP401_DEVICE_ID			0x11

/* our driver name */
#define TMP401_NAME "tmp401"

/*
 * Functions declarations
 */

static void tmp401_init_client(struct i2c_client *client);
static int tmp401_attach_adapter(struct i2c_adapter *adapter);
static int tmp401_detach_client(struct i2c_client *client);
static struct tmp401_data *tmp401_update_device(struct device *dev);

/*
 * Driver data (common to all clients)
 */

static struct i2c_driver tmp401_driver = {
	.driver = {
		.name	= TMP401_NAME,
	},
	.attach_adapter	= tmp401_attach_adapter,
	.detach_client	= tmp401_detach_client,
};

/*
 * Client data (each client gets its own)
 */

struct tmp401_data {
	struct i2c_client client;
	struct device *hwmon_dev;
	struct mutex update_lock;
	char valid; /* zero until following fields are valid */
	unsigned long last_updated; /* in jiffies */

	/* register values */
	u8 status;
	u8 config;
	u16 temp[2];
	u16 temp_low[2];
	u16 temp_high[2];
	u8 temp_crit[2];
	u8 temp_crit_hyst;
};

/*
 * Sysfs attr show / store functions
 */
 
static int tmp401_register_to_temp(u16 reg, u8 config)
{
	int temp = reg;
	
	return (temp * 625) / 160;
}

static u16 tmp401_temp_to_register(long temp, u8 config)
{
	if (config & TMP401_CONFIG_RANGE_MASK) {
		temp = SENSORS_LIMIT(temp, -64000, 191000);
		temp += 64000;
	} else
		temp = SENSORS_LIMIT(temp, 0, 127000);

	return (temp * 160) / 625;
}

static int tmp401_crit_register_to_temp(u8 reg, u8 config)
{
	int temp = reg;
	
	if (config & TMP401_CONFIG_RANGE_MASK)
		temp -= 64;
	
	return temp;
}

static u8 tmp401_temp_crit_to_register(long temp, u8 config)
{
	if (config & TMP401_CONFIG_RANGE_MASK) {
		temp = SENSORS_LIMIT(temp, -64000, 191000);
		temp += 64000;
	} else
		temp = SENSORS_LIMIT(temp, 0, 127000);

	return temp / 1000;
}

static ssize_t show_temp_value(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);
	
	return sprintf(buf, "%d\n",
		tmp401_register_to_temp(data->temp[index], data->config));
}

static ssize_t show_temp_min(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);

	return sprintf(buf, "%d\n",
		tmp401_register_to_temp(data->temp_low[index], data->config));
}

static ssize_t show_temp_max(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);

	return sprintf(buf, "%d\n",
		tmp401_register_to_temp(data->temp_high[index], data->config));
}

static ssize_t show_temp_crit(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);

	return sprintf(buf, "%d\n",
			tmp401_crit_register_to_temp(data->temp_crit[index],
							data->config));
}

static ssize_t show_temp_crit_hyst(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	int temp, index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);
	
	temp = tmp401_crit_register_to_temp(data->temp_crit[index],
						data->config);
	temp -= data->temp_crit_hyst;

	return sprintf(buf, "%d\n", temp);
}

static ssize_t show_status(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	int mask = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);
	
	if (data->status & mask)
		return sprintf(buf, "1\n");
	else
		return sprintf(buf, "0\n");
}

static ssize_t store_temp_min(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);
	long v = simple_strtol(buf, NULL, 10);
	u16 reg = tmp401_temp_to_register(v, data->config);

	mutex_lock(&data->update_lock);

	i2c_smbus_write_byte_data(&data->client,
		TMP401_TEMP_LOW_LIMIT_MSB_WRITE[index], reg >> 8);
	i2c_smbus_write_byte_data(&data->client,
		TMP401_TEMP_LOW_LIMIT_LSB[index], reg & 0xFF);

	data->temp_low[index] = reg;

	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t store_temp_max(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);
	long v = simple_strtol(buf, NULL, 10);
	u16 reg = tmp401_temp_to_register(v, data->config);

	mutex_lock(&data->update_lock);

	i2c_smbus_write_byte_data(&data->client,
		TMP401_TEMP_HIGH_LIMIT_MSB_WRITE[index], reg >> 8);
	i2c_smbus_write_byte_data(&data->client,
		TMP401_TEMP_HIGH_LIMIT_LSB[index], reg & 0xFF);

	data->temp_high[index] = reg;

	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t store_temp_crit(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);
	long v = simple_strtol(buf, NULL, 10);
	u8 reg = tmp401_temp_crit_to_register(v, data->config);

	mutex_lock(&data->update_lock);

	i2c_smbus_write_byte_data(&data->client,
		TMP401_TEMP_CRIT_LIMIT[index], reg);

	data->temp_crit[index] = reg;

	mutex_unlock(&data->update_lock);

	return count;
}

static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
	*devattr, const char *buf, size_t count)
{
	int temp, index = to_sensor_dev_attr(devattr)->index;
	struct tmp401_data *data = tmp401_update_device(dev);
	long v = simple_strtol(buf, NULL, 10);
	u8 reg;

	if (data->config & TMP401_CONFIG_RANGE_MASK)
		v = SENSORS_LIMIT(v, -64000, 191000);
	else
		v = SENSORS_LIMIT(v, 0, 127000);

	mutex_lock(&data->update_lock);
	temp = tmp401_crit_register_to_temp(data->temp_crit[index],
						data->config);
	reg = tmp401_temp_crit_to_register(temp - v, data->config);

	i2c_smbus_write_byte_data(&data->client,
		TMP401_TEMP_CRIT_HYST, reg);

	data->temp_crit_hyst = reg;

	mutex_unlock(&data->update_lock);

	return count;
}

static struct sensor_device_attribute tmp401_attr[] = {
	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
	SENSOR_ATTR(temp1_min, 0644, show_temp_min, store_temp_min, 0),
	SENSOR_ATTR(temp1_max, 0644, show_temp_max, store_temp_max, 0),
	SENSOR_ATTR(temp1_crit, 0644, show_temp_crit, store_temp_crit, 0),
	SENSOR_ATTR(temp1_crit_hyst, 0644, show_temp_crit_hyst,
			store_temp_crit_hyst, 0),
	SENSOR_ATTR(temp1_min_alarm, 0444, show_status, NULL,
			TMP401_STATUS_LOCAL_LOW_MASK),
	SENSOR_ATTR(temp1_max_alarm, 0444, show_status, NULL,
			TMP401_STATUS_LOCAL_HIGH_MASK),
	SENSOR_ATTR(temp1_crit_alarm, 0444, show_status, NULL,
			TMP401_STATUS_LOCAL_CRIT_MASK),
	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
	SENSOR_ATTR(temp2_min, 0644, show_temp_min, store_temp_min, 1),
	SENSOR_ATTR(temp2_max, 0644, show_temp_max, store_temp_max, 1),
	SENSOR_ATTR(temp2_crit, 0644, show_temp_crit, store_temp_crit, 1),
	SENSOR_ATTR(temp2_crit_hyst, 0444, show_temp_crit_hyst, NULL, 1),
	SENSOR_ATTR(temp2_fault, 0444, show_status, NULL,
			TMP401_STATUS_REMOTE_OPEN_MASK),
	SENSOR_ATTR(temp2_min_alarm, 0444, show_status, NULL,
			TMP401_STATUS_REMOTE_LOW_MASK),
	SENSOR_ATTR(temp2_max_alarm, 0444, show_status, NULL,
			TMP401_STATUS_REMOTE_HIGH_MASK),
	SENSOR_ATTR(temp2_crit_alarm, 0444, show_status, NULL,
			TMP401_STATUS_REMOTE_CRIT_MASK),
};

/*
 * Real code
 */

static int tmp401_detect(struct i2c_adapter *adapter, int address, int kind)
{
	int i, err = 0;
	struct i2c_client *client;
	struct tmp401_data *data;

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		return 0;

	/* OK. For now, we presume we have a valid client. We now create the
	 * client structure, even though we cannot fill it completely yet.
	 * But it allows us to access i2c_smbus_read_byte_data. */
	if (!(data = kzalloc(sizeof(struct tmp401_data), GFP_KERNEL)))
		return -ENOMEM;

	client = &data->client;
	i2c_set_clientdata(client, data);
	client->addr = address;
	client->adapter = adapter;
	client->driver = &tmp401_driver;
	mutex_init(&data->update_lock);

	/* Detect & Identify the chip */
	if (kind <= 0) {
		u8 manufacturer_id;
		u8 device_id;
		
		manufacturer_id = i2c_smbus_read_byte_data(client,
						TMP401_MANUFACTURER_ID_REG);
		device_id = i2c_smbus_read_byte_data(client,
						TMP401_DEVICE_ID_REG);
		if (manufacturer_id != TMP401_MANUFACTURER_ID ||
				device_id != TMP401_DEVICE_ID_REG)
			goto exit_free;
	}

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(client)))
		goto exit_free;
		
	/* Initialize the TMP401 chip */
	tmp401_init_client(client);
		
	/* Register sysfs hooks */
	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++) {
		err = device_create_file(&client->dev,
					&tmp401_attr[i].dev_attr);
		if (err)
			goto exit_detach;
	}

	data->hwmon_dev = hwmon_device_register(&client->dev);
	if (IS_ERR(data->hwmon_dev)) {
		err = PTR_ERR(data->hwmon_dev);
		data->hwmon_dev = NULL; 
		goto exit_detach;
	}

	printk(KERN_INFO TMP401_NAME ": Detected TI TMP401 chip\n");

	return 0;

exit_detach:
	tmp401_detach_client(client); /* will also free data for us */
	return err;
	
exit_free:
	kfree(data);
	return err;
}

static void tmp401_init_client(struct i2c_client *client)
{
	int config, config_orig;

	/* Set the conversion rate to 2 Hz */
	i2c_smbus_write_byte_data(client, TMP401_CONVERSION_RATE_WRITE, 5);

	/* Start conversions (disable shutdown if necessary) */
	config = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
	if (config < 0) {
		dev_warn(&client->dev, "Initialization failed!\n");
		return;
	}

	config_orig = config;
	config &= ~TMP401_CONFIG_SHUTDOWN_MASK;

	if (config != config_orig)
		i2c_smbus_write_byte_data(client, TMP401_CONFIG_WRITE, config);
}

static int tmp401_attach_adapter(struct i2c_adapter *adapter)
{
	if (!(adapter->class & I2C_CLASS_HWMON))
		return 0;
	return i2c_probe(adapter, &addr_data, tmp401_detect);
}

static int tmp401_detach_client(struct i2c_client *client)
{
	struct tmp401_data *data = i2c_get_clientdata(client);
	int i, err;

	/* Check if registered in case we're called from tmp401_detect
	   to cleanup after an error */
	if (data->hwmon_dev)
		hwmon_device_unregister(data->hwmon_dev);

	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++)
		device_remove_file(&client->dev, &tmp401_attr[i].dev_attr);

	if ((err = i2c_detach_client(client)))
		return err;

	kfree(data);
	return 0;
}

static struct tmp401_data *tmp401_update_device(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct tmp401_data *data = i2c_get_clientdata(client);
	int i;

	mutex_lock(&data->update_lock);

	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
		data->status = i2c_smbus_read_byte_data(client, TMP401_STATUS);
		data->config = i2c_smbus_read_byte_data(client,
						TMP401_CONFIG_READ);
		for (i = 0; i < 2; i++) {
			data->temp[i] = i2c_smbus_read_byte_data(client,
						TMP401_TEMP_MSB[i]) << 8;
			data->temp[i] |= i2c_smbus_read_byte_data(client,
						TMP401_TEMP_LSB[i]);
			data->temp_low[i] = i2c_smbus_read_byte_data(client,
				TMP401_TEMP_LOW_LIMIT_MSB_READ[i]) << 8;
			data->temp_low[i] |= i2c_smbus_read_byte_data(client,
						TMP401_TEMP_LOW_LIMIT_LSB[i]);
			data->temp_high[i] = i2c_smbus_read_byte_data(client,
				TMP401_TEMP_HIGH_LIMIT_MSB_READ[i]) << 8;
			data->temp_high[i] |= i2c_smbus_read_byte_data(client,
						TMP401_TEMP_HIGH_LIMIT_LSB[i]);
			data->temp_crit[i] = i2c_smbus_read_byte_data(client,
						TMP401_TEMP_CRIT_LIMIT[i]);
		}

		data->temp_crit_hyst = i2c_smbus_read_byte_data(client,  
						TMP401_TEMP_CRIT_HYST);

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);

	return data;
}

static int __init tmp401_init(void)
{
	return i2c_add_driver(&tmp401_driver);
}

static void __exit tmp401_exit(void)
{
	i2c_del_driver(&tmp401_driver);
}

MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
MODULE_DESCRIPTION("Texas Instruments TMP401 temperature sensor driver");
MODULE_LICENSE("GPL");

module_init(tmp401_init);
module_exit(tmp401_exit);


--------------080809020600060604060701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080809020600060604060701--
