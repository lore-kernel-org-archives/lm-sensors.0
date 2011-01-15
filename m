From: Anish Patel <anish.mailing.list@gmail.com>
Date: Sat, 15 Jan 2011 18:33:52 +0000
Subject: [lm-sensors] support for emc1023
Message-Id: <4D31E890.7030004@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020607010105090709040004"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607010105090709040004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
     i've attached a patch for the sensors-detect script that will 
detect the SMSC EMC1023 smbus Thermal IC.
also attached is a driver, please let me know if i did anything wrong in 
it or did not give anyone proper credit,
I was the tmp401 driver for a framework.


Regards,
Anish


--------------020607010105090709040004
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Makefile"

# For building for the current running version of Linux
TARGET		:= $(shell uname -r)
# Or specific version
#TARGET		:= 2.6.33.5
#TARGET		:= 2.6.32.15

KERNEL_MODULES	:= /lib/modules/$(TARGET)
KERNEL_BUILD	:= $(KERNEL_MODULES)/build

#DRIVER := pc87427
DRIVER := emc1023

# Directory below /lib/modules/$(TARGET)/kernel into which to install
# the module:
MOD_SUBDIR = drivers/hwmon

obj-m	:= $(DRIVER).o

EXTRA_CFLAGS    += -DDEBUG

.PHONY: all install modules modules_install clean

all: modules

# Targets for running make directly in the external module directory:
modules clean:
	@$(MAKE) -C $(KERNEL_BUILD) M=$(CURDIR) $@

install: modules_install

modules_install:
	test -d $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR) || mkdir $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	cp $(DRIVER).ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	depmod -a -F $(KERNEL_BUILD)/System.map $(TARGET)

--------------020607010105090709040004
Content-Type: text/plain;
 name="sensors-detect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sensors-detect.patch"

*** sensors-detect	Fri Jan 14 11:11:56 2011
--- sensors-detect-new	Sat Jan 15 03:01:01 2011
***************
*** 1205,1210 ****
--- 1205,1215 ----
  		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
  		i2c_detect => sub { emc1403_detect(@_, 3); },
  	}, {
+ 		name => "SMSC_EMC1023",
+ 		driver => "emc1023",
+ 		i2c_addrs => [0x48,0x49,0x4c,0x4d],
+ 		i2c_detect => sub { emc1023_detect(@_); },
+ 	}, {
  		name => "ST STTS424",
  		driver => "jc42",
  		i2c_addrs => [0x18..0x1f],
***************
*** 5387,5392 ****
--- 5392,5418 ----
  	return 6;
  }
  
+ # Chip to detect:
+ # Registers used:
+ #   0xed: Device ID register
+ #   0xfe: Vendor ID register
+ #   0xff: Revision register
+ sub emc1023_detect
+ {
+ 	my ($file, $addr, $chip) = @_;
+ 	my $dev_id = i2c_smbus_read_byte_data($file, 0xed);
+ 	my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
+ 	my $rev = i2c_smbus_read_byte_data($file, 0xff);
+ 
+ 	return unless $man_id == 0x5d;	# SMSC
+ 
+ 	return unless ($dev_id == 0x0c) || ($dev_id == 0x0d) || ($dev_id == 0x08) || ($dev_id == 0x09) ;
+ 	return unless $rev == 0x01;
+ 	
+ 	return 9;
+ }
+ 
+ 
  # This checks for non-FFFF values for temperature, voltage, and current.
  # The address (0x0b) is specified by the SMBus standard so it's likely
  # that this really is a smart battery.

--------------020607010105090709040004
Content-Type: text/x-c;
 name="emc1023.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="emc1023.c"

/* emc1023.c
 *
 * Copyright (C) 2011 Anish K. Patel <anishs.online.junk@gmail.com>
 * based heavily on tmp401.c
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
 *
 *
 * Driver for the SMSC EMC1023 SMBUS temperature sensor IC.
 * examples taken from datasheet
 *
 * legacy format (LF)
 * registers for temperature store them in an 11bit value,
 * 2's complement form
 * the high byte holds the sign and the whole number part
 * the low byte holds the fraction in the upper 3 bits.
 * goes from -63.125 to 127.875
 *         bit 7 - 0.500
 *         bit 6 - 0.250
 *         bit 5 - 0.125
 *         	 		  temp data  junk bits  		 hex
 * ie Diode fault = 10000000000|00000	 			 400
 *    -63	 		= 11000001000|00000				 608	
 *    -63.875	  	= 11000000001|00000 		 		 601
 *    0	  		   = 00000000000|00000		 		 000
 *    1		 		= 00000001000|00000		 		 008
 *    127	  	  	= 01111111000|00000				 3F8
 *    127.875	  	= 01111111111|00000				 3FF
 *  
 * for the extend format (EF) add 64d to read the data 
 *
 *
 * todo - clean up the fraction part, implement EF temp
 * 		 *possibly make EF reporting default with module flag
 *      
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
static const unsigned short normal_i2c[] = { 0x48,0x49,0x4c,0x4d, I2C_CLIENT_END };

enum chips { emc1023_1 , emc1023_2, emc1023_3, emc1023_4 };

/*
 * The EMC1023 registers, note some registers have different addresses for
 * reading and writing
 * device id - seems to be the 8,9,c,d corresponding to address of IC 
 * ie devid 0x08  ic addr 0x48, etc
 */
#define EMC1023_ONE_SHOT_CMD					0x0F
#define EMC1023_RMT1_IF_Rw						0x27
#define EMC1023_RMT2_IF_RW						0x28
#define EMC1023_STATUS							0x02
#define EMC1023_CONFIG_READ					0x03
#define EMC1023_CONFIG_WRITE					0x09
#define EMC1023_DEVICE_ID_REG					0xED
#define EMC1023_MANUFACTURER_ID_REG			0xFE
#define EMC1023_PRODUCT_ID_REG				0xFF

#define EMC1023_MANUFACTURER_ID				0x5D

#define EMC1023_DEVICE_ID_1				0x0C
#define EMC1023_DEVICE_ID_2				0x0D
#define EMC1023_DEVICE_ID_3				0x08
#define EMC1023_DEVICE_ID_4				0x09
static const u8 EMC1023_DEVICE_ID[]				= { 0x08, 0x09, 
															    0x0c, 0x0d };

static const u8 EMC1023_LF_TEMP_HIGH_BYTE[3] = { 0x00, 0x01, 0xF8 };
static const u8 EMC1023_LF_TEMP_LOW_BYTE[3]	= { 0x23, 0x10, 0xF9 };

static const u8 EMC1023_EF_TEMP_HIGH_BYTE[2] = { 0xFA, 0XFC };
static const u8 EMC1023_EF_TEMP_LOW_BYTE[2] 	= { 0xFB, 0XFD };
	
/*
 * Driver data (common to all clients)
 */

static const struct i2c_device_id emc1023_id[] = {
	{ "emc1023_1", emc1023_1 },
	{ "emc1023_2", emc1023_2 },
	{ "emc1023_3", emc1023_3 },
	{ "emc1023_4", emc1023_4 },
	{ }
};

MODULE_DEVICE_TABLE(i2c, emc1023_id);

/*
 * Client data (each client gets its own)
 */

struct threebit{
	u8 info:3;
};
struct emc1023_data {
	struct device *hwmon_dev;
	struct mutex update_lock;
	char valid; /* zero until following fields are valid */
	unsigned long last_updated; /* in jiffies */
	enum chips kind;
	/* register values */
	u8 status;
	u8 config;
	u16 temp;
	u8 temp_high[3];
	u8 temp_low[3];
};

/*
 * Sysfs attr show / store functions
 */

static int emc1023_register_to_temp(u8 reg_high,u8 reg_low)
{
	int temphigh = reg_high;
	//since we only need the top 3bits from reg_low shift over 5
	//and then do the magic below to pop temp low with correct data
	int templow = (reg_low >> 5);

	if ( temphigh > 128 )
		temphigh = ((temphigh % 128 ) - 128)*1000;
	else
		temphigh *= 1000;
	//get fraction part and populate temp low with info (ugly)
	templow =(((templow&4)>>2)*500 )+ (((templow&2)>>1)*250 )+ ((templow&1)*125);
	
	return (temphigh+templow);

}

static struct emc1023_data *emc1023_update_device_reg16(
	struct i2c_client *client, struct emc1023_data *data)
{
	int i;

	for (i=0; i < 3; i++) {
		data->temp_high[i] = i2c_smbus_read_byte_data(client,
			EMC1023_LF_TEMP_HIGH_BYTE[i]);
		data->temp_low[i] = i2c_smbus_read_byte_data(client,
			EMC1023_LF_TEMP_LOW_BYTE[i]);

	}
	return data;
}

static struct emc1023_data *emc1023_update_device(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct emc1023_data *data = i2c_get_clientdata(client);

	mutex_lock(&data->update_lock);

	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
		data->status = i2c_smbus_read_byte_data(client, EMC1023_STATUS);
		data->config = i2c_smbus_read_byte_data(client,
						EMC1023_CONFIG_READ);
		emc1023_update_device_reg16(client, data);

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);

	return data;
}

static ssize_t show_temp_value(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	int index = to_sensor_dev_attr(devattr)->index;
	struct emc1023_data *data = emc1023_update_device(dev);
	
	
	return sprintf(buf, "%d\n",
		emc1023_register_to_temp(data->temp_high[index], data->temp_low[index]));
}


/*static ssize_t show_status(struct device *dev,
	struct device_attribute *devattr, char *buf)
{
	//int mask = to_sensor_dev_attr(devattr)->index;
	struct emc1023_data *data = emc1023_update_device(dev);

	if ( (data->status >> 7) == 1 )
		return sprintf(buf, "ready\n");
	else
		return sprintf(buf, "not ready\n");
}*/

static struct sensor_device_attribute emc1023_attr[] = {
	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp_value, NULL, 0),
	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp_value, NULL, 1),
	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp_value, NULL, 2),
};

/*
 * Begin non sysfs callback code (aka Real code)
 */

static void emc1023_init_client(struct i2c_client *client)
{
	int config;

	/* Start conversions (disable shutdown if necessary) */
	config = i2c_smbus_read_byte_data(client, EMC1023_CONFIG_READ);
	if (config < 0) {
		dev_warn(&client->dev, "Initialization failed!\n");
		return;
	}

}

static int emc1023_detect(struct i2c_client *client,
			 struct i2c_board_info *info)
{
	//int i=0;
	struct i2c_adapter *adapter = client->adapter;
	u8 reg;
	enum chips kind;
	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		return -ENODEV;

	/* Detect and identify the chip */
	reg = i2c_smbus_read_byte_data(client, EMC1023_MANUFACTURER_ID_REG);
	if (reg != EMC1023_MANUFACTURER_ID)
		return -ENODEV;

	reg = i2c_smbus_read_byte_data(client, EMC1023_DEVICE_ID_REG);

	//tried to cycle through array to match id.
	/*for(i=0;i<4;i++)
		if( reg == EMC1023_DEVICE_ID[i] )
		{
			kind = i;
			break;
		}*/
	switch (reg) {
	case EMC1023_DEVICE_ID_1:
		kind = emc1023_1;
		break;
	case EMC1023_DEVICE_ID_2:
		kind = emc1023_2;
		break;
	case EMC1023_DEVICE_ID_3:
		kind = emc1023_3;
		break;
	case EMC1023_DEVICE_ID_4:
		kind = emc1023_4;
		break;
	default:
		return -ENODEV;
	}


	strlcpy(info->type, emc1023_id[kind].name, I2C_NAME_SIZE);

	return 0;
}

static int emc1023_remove(struct i2c_client *client)
{
	struct emc1023_data *data = i2c_get_clientdata(client);
	int i;

	if (data->hwmon_dev)
		hwmon_device_unregister(data->hwmon_dev);

	for (i = 0; i < ARRAY_SIZE(emc1023_attr); i++)
		device_remove_file(&client->dev, &emc1023_attr[i].dev_attr);

	kfree(data);
	return 0;
}

static int emc1023_probe(struct i2c_client *client,
			const struct i2c_device_id *id)
{
	int i, err = 0;
	struct emc1023_data *data;
	const char *names[] = { "EMC1023_1", "EMC1023_2", "EMC1023_3","EMC1023_4" };

	data = kzalloc(sizeof(struct emc1023_data), GFP_KERNEL);
	if (!data)
		return -ENOMEM;

	i2c_set_clientdata(client, data);
	mutex_init(&data->update_lock);
	data->kind = id->driver_data;

	/* Initialize the EMC1023 chip */
	emc1023_init_client(client);

	/* Register sysfs hooks */
	for (i = 0; i < ARRAY_SIZE(emc1023_attr); i++) {
		err = device_create_file(&client->dev,
					 &emc1023_attr[i].dev_attr);
		if (err)
			goto exit_remove;
	}

	data->hwmon_dev = hwmon_device_register(&client->dev);
	if (IS_ERR(data->hwmon_dev)) {
		err = PTR_ERR(data->hwmon_dev);
		data->hwmon_dev = NULL;
		goto exit_remove;
	}

	dev_info(&client->dev, "Detected emc1023 %s chip\n", names[data->kind]);

	return 0;

exit_remove:
	emc1023_remove(client); /* will also free data for us */
	return err;
}

static struct i2c_driver emc1023_driver = {
	.class		= I2C_CLASS_HWMON,
	.driver = {
		.name	= "emc1023",
	},
	.probe		= emc1023_probe,
	.remove		= emc1023_remove,
	.id_table	= emc1023_id,
	.detect		= emc1023_detect,
	.address_list	= normal_i2c,
};

static int __init emc1023_init(void)
{
	return i2c_add_driver(&emc1023_driver);
}

static void __exit emc1023_exit(void)
{
	i2c_del_driver(&emc1023_driver);
}

MODULE_AUTHOR("Anish K Patel <anishp@win-ent.com!>");
MODULE_DESCRIPTION("SMSC emc1023 temperature sensor driver");
MODULE_LICENSE("GPL");

module_init(emc1023_init);
module_exit(emc1023_exit);

--------------020607010105090709040004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020607010105090709040004--
