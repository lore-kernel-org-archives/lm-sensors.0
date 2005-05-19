From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: ATXP1 kernel patch
Message-Id: <41EECF3C.9040104@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I want to add two things to my last message:

- The VRM check in atxp1_detect was moved above i2c_attach_client.

- I've channged the detection method, because
..
temp = i2c_smbus_read_byte_data(new_client, ATXP1_VID);
if(!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
    (i2c_smbus_read_byte_data(new_client, 0x11) = temp)
...

the register 0x10,0x11 aren't the same as 0x00 all time (the dump say 
it, but I think that's because the device is dumped from 0x00 upwards). 
If you directly read 0x10, 0x11 they are also zero.

Instead I'm checking register 0x05, bit 7. It is always set:
..
if(!(i2c_smbus_read_byte_data(new_client, 0x05) & 0x80))
..

Regards,
Sebastian
-------------- next part --------------
/*
    atxp1.c - kernel module for setting Vcore using ATXP1 chip. 
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
    
    Version history:
    0.1: - Converted 8rdavcore into kernel module (Marcin Kaluza <marcin_ml@sekretarka.no-ip.org>)
    0.2: - Cleanup, general interface for VCore (Sebastian Witt <hasw@hasw.net>)
    0.3: - Fixed VID calculation (no FP operation)
         - Fixed VID setting loop
         - Added update lock
         - Renamed device file to cpu_vid
         - Added low_voltage module option to set lowest possible voltage (1075mV or 1100mV)
    0.4: - Added GPIO[1,2]
        - Using I2C VRM functions
        - Changed detection
        - Some other small fixes
*/

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/i2c.h>
#include <linux/i2c-sensor.h>
#include <linux/i2c-vid.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
MODULE_VERSION("0.4");

#define ATXP1_VID	0x00
#define ATXP1_CVID	0x01
#define ATXP1_GPIO1	0x06
#define ATXP1_GPIO2	0x0a
#define ATXP1_VIDENA	0x20
#define ATXP1_VIDMASK	0x1f
#define ATXP1_GPIO1MASK	0x0f

static unsigned short normal_i2c[]= { 0x37, 0x4e, I2C_CLIENT_END };
static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
static int atxp1_attach_adapter(struct i2c_adapter * adapter);
static int atxp1_detach_client(struct i2c_client * client);
static struct atxp1_data * atxp1_update_device(struct device *dev);
static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind);

static struct i2c_driver atxp1_driver = {
	.owner		= THIS_MODULE,
	.name		= "atxp1",
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter = atxp1_attach_adapter,
	.detach_client	= atxp1_detach_client,
};

SENSORS_INSMOD_1(atxp1);

struct atxp1_data {
	struct i2c_client client;
	struct semaphore update_lock;
	u16 valid;
	unsigned char reg[0x0f];
	u8 vrm;
};

static struct atxp1_data * atxp1_update_device(struct device *dev) 
{
	struct i2c_client *client;
	struct atxp1_data *data;
	unsigned char count;
	
	client = to_i2c_client(dev);
	data = i2c_get_clientdata(client);
	
	down(&data->update_lock);
	
	/* Update local register data only if register was written */
	for(count = 0; count <= 0x0a; count++) {
		if((data->valid >> count & 1) = 0) {
			data->reg[count] = i2c_smbus_read_byte_data(client, count);
			data->valid |= 1 << count;
		}
	}
    	
	up(&data->update_lock);
	
	return(data);
}

static int atxp1_write(struct i2c_client *client, unsigned char adr, unsigned char data) 
{
	int ret = -1;
	
	ret = i2c_smbus_write_byte_data(client, adr, data);
	
	if(ret < 0) {
		dev_err(&client->dev, "Write failed.\n");
		return -1;
	}

	return 0;
}

/* Device file functions for VCore */
ssize_t atxp1_showvcore(struct device *dev, char *buf)
{
	int size;
	struct atxp1_data *data;
	
	data = atxp1_update_device(dev);
	
	size = sprintf(buf, "%d\n", vid_from_reg(data->reg[ATXP1_VID] & ATXP1_VIDMASK, data->vrm));

	return size;
}

ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
{
	struct atxp1_data *data;
	struct i2c_client *client;
	char vid;
	char cvid;
	unsigned int vcore;

	client = to_i2c_client(dev);
	data = atxp1_update_device(dev);

	vcore = simple_strtoul(buf, NULL, 10);
	vcore /= 25;	
	vcore *= 25;	
	
	/* Calculate VID */
	vid = reg_from_vid(vcore, data->vrm);
	
	if(vid < 0) {
		dev_err(dev, "VID calculation failed.\n");
		return -1;
	}
	
	/* If output enabled, use control register value. Otherwise original CPU VID */
	if(data->reg[ATXP1_VID] & ATXP1_VIDENA)
		cvid = data->reg[ATXP1_VID] & ATXP1_VIDMASK;
	else
		cvid = data->reg[ATXP1_CVID];
	
	/* Nothing changed, aborting */
	if(vid = cvid)
		return strlen(buf);
	
	dev_info(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);
	
	/* Write every 25 mV step to increase stability */
	if(cvid > vid) {
		for(; cvid >= vid; cvid--) {
        		atxp1_write(client, ATXP1_VID, cvid | ATXP1_VIDENA);
		}
	}
	else {
		for(; cvid <= vid; cvid++) {
        		atxp1_write(client, ATXP1_VID, cvid | ATXP1_VIDENA);
		}
	}
	
	data->valid &= ~1;
	
	return strlen(buf);
}

/* CPU core reference voltage
    unit: millivolt
*/
static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);

/* Device file functions for GPIO1 */
ssize_t atxp1_showgpio1(struct device *dev, char *buf)
{
	int size;
	struct atxp1_data *data;
	
	data = atxp1_update_device(dev);
	
	size = sprintf(buf, "0x%02x\n", data->reg[ATXP1_GPIO1] & ATXP1_GPIO1MASK);

	return size;
}

ssize_t atxp1_storegpio1(struct device *dev, const char* buf, size_t count)
{
	struct atxp1_data *data;
	struct i2c_client *client;
	unsigned int value;
	
	client = to_i2c_client(dev);
	data = atxp1_update_device(dev);

	value = simple_strtoul(buf, NULL, 16);
	
	value &= ATXP1_GPIO1MASK;
	
	dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
	
	if(value != (data->reg[ATXP1_GPIO1] & ATXP1_GPIO1MASK)) {
		atxp1_write(client, ATXP1_GPIO1, value);
		data->valid &= ~(1 << ATXP1_GPIO1);
	}
	
	return strlen(buf);
}

static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);

/* Device file functions for GPIO2 */
ssize_t atxp1_showgpio2(struct device *dev, char *buf)
{
	int size;
	struct atxp1_data *data;
	
	data = atxp1_update_device(dev);
	
	size = sprintf(buf, "0x%02x\n", data->reg[ATXP1_GPIO2]);

	return size;
}

ssize_t atxp1_storegpio2(struct device *dev, const char* buf, size_t count)
{
	struct atxp1_data *data;
	struct i2c_client *client;
	unsigned int value;
	
	client = to_i2c_client(dev);
	data = atxp1_update_device(dev);

	value = simple_strtoul(buf, NULL, 16) & 0xff;
	
	dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
	
	if(value != data->reg[ATXP1_GPIO2]) {
		atxp1_write(client, ATXP1_GPIO2, value);
		data->valid &= ~(1 << ATXP1_GPIO2);
	}
	
	return strlen(buf);
}

static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);


static int atxp1_attach_adapter(struct i2c_adapter *adapter)
{
	return i2c_detect(adapter, &addr_data, &atxp1_detect);
};
	
static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
{
	struct i2c_client* new_client;
	struct atxp1_data * data;
	int err;

	if (!(data = kmalloc(sizeof(struct atxp1_data), GFP_KERNEL)))
		return -ENOMEM;

	memset(data, 0, sizeof(struct atxp1_data));
	new_client = &data->client;
	i2c_set_clientdata(new_client, data);
	
	new_client->addr = address;
	new_client->adapter = adapter;
	new_client->driver = &atxp1_driver;
	new_client->flags = 0;
	
	/* Detect ATXP1, checking if vendor ID registers are all zero 
	 * and register 0x05 bit 7 is set */
	if(!((i2c_smbus_read_byte_data(new_client, 0x3e) = 0) &&
	     (i2c_smbus_read_byte_data(new_client, 0x3f) = 0) &&
	     (i2c_smbus_read_byte_data(new_client, 0xfe) = 0) &&
	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0) )) {

		if(!(i2c_smbus_read_byte_data(new_client, 0x05) & 0x80)) {
			kfree(data);
			return 0;
		}
	}
	
	/* Get VRM */
	data->vrm = i2c_which_vrm();
	
	if(data->vrm != 90) {
		dev_err(&new_client->dev, "Not supporting VRM %d\n", data->vrm);
		return 0;
	}
	
	strncpy(new_client->name, "atxp1", I2C_NAME_SIZE);

	data->valid = 0;
	
	init_MUTEX(&data->update_lock);
	
	if ((err = i2c_attach_client(new_client)))
	{
		dev_err(&new_client->dev, "Attach client error.\n");
		kfree(data);
		return err;
	}
	
	device_create_file(&new_client->dev, &dev_attr_gpio1);
	device_create_file(&new_client->dev, &dev_attr_gpio2);
	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
	
	dev_info(&new_client->dev, "Detected on %s. Using VRM: %d.%d\n", 
			 adapter->name, data->vrm / 10, data->vrm % 10);
	
	return 0;
};

static int atxp1_detach_client(struct i2c_client * client)
{
	int err;
	
	err = i2c_detach_client(client);
	
	if (err) 
		dev_err(&client->dev, "Failed to detach client.\n");
	else
		kfree(i2c_get_clientdata(client));
	
	return 0;
};
 
static int __init atxp1_init(void)  
{ 
	i2c_add_driver(&atxp1_driver);
	
	return 0; 
};

static void __exit atxp1_exit(void) 
{ 
	i2c_del_driver(&atxp1_driver);
};

module_init(atxp1_init);
module_exit(atxp1_exit);
