From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: ATXP1 kernel patch
Message-Id: <41EFFE57.7050308@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> 
> Good idea. It's better not to register anything if we are giving it all
> up in the end. However, you forgot to free the memory you allocated.

Fixed.

> 
> You are right that what addresses 0x10 and 0x11 return depend on what was
> previously read from the chip, because these address don't map to
> physical registers. However this is precisely a very good way to detect
> exotic chips such as the ATXP1. Please do some tests to understand what
> exactly determines the values being returned. Usually this is the last
> "real" value read, but in your case this seems to be different.
> 
> At the very least you can check that both addresses (0x10 and 0x11)
> return the same value, whatever this is, right?
> 
> I really think we need to use this, or the detection will be possibly
> unreliable (although we are lucky that the ATXP1 uses uncommon
> addresses).
> 
> 

I've done some tests and it seems to work now if I first check the 
vendor ID registers and than after that 0,0x10,0x11. Also working
after some random read/writes and reloading the module.

> 
> We don't much care about future versions at this point. There might
> never be any future version. If there is, you'll be able to do all the
> required changes at that time. The code you will submit for the first
> version of your driver has to make sense per se. Please only read the
> registers you need.

Done.

> The reason why i2c clients have an update function is to centralize and
> control i2c traffic that can be triggered by regular users. Remember
> that regular users can read from sysfs files your driver exports. In
> order to prevent possible bus saturation by regular users, all client
> drivers have a timer in their update function, which prevent register
> updates more frequent than (typically) one second. Your driver doesn't.
> Please see in e.g. lm90.c how this has to be done, and do the same.
> 
> Having individual validity bits then becomes useless. The only driver
> which has that is eeprom.c, but only because it has a very large number
> of "registers" (256 as opposed to less than 30 for most drivers) and a
> very long cache timeout (5 minutes instead of 1 second). For your driver
> it doesn't make sense. You should NOT suppose that register values
> never change, this is dangerous.

You're right, it's possible that the register values are reset after
suspend-to-disk. And checking the validity bits doesn't recognize this.

> So please:
> 1* Add a timer check in your update function. 1 second (HZ) should be
> fine.
> 2* Only read registers you need.
> 3* Have a single valid bit for them all.

Done.

> 
> Random comments on your code now:
 > ....

All fixed, I think.

Thanks for your help,
Sebastian
-------------- next part --------------
/*
    atxp1.c - kernel module for setting CPU VID and general purpose
                     I/Os using the Attansic ATXP1 chip. 
    
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
    0.5: - Added timer check
        - Changed atxp1_update_device
        - Changed error handling

*/

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/i2c.h>
#include <linux/i2c-sensor.h>
#include <linux/i2c-vid.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
MODULE_VERSION("0.5");

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
	unsigned long last_updated;
	u8 valid;
	struct {
		u8 vid;		/* VID output register */
		u8 cpu_vid; /* VID input from CPU */
		u8 gpio1;   /* General purpose I/O register 1 */
		u8 gpio2;   /* General purpose I/O register 2 */
	} reg;	
	u8 vrm;			/* Detected CPU VRM */
};

static struct atxp1_data * atxp1_update_device(struct device *dev) 
{
	struct i2c_client *client;
	struct atxp1_data *data;

	client = to_i2c_client(dev);
	data = i2c_get_clientdata(client);

	down(&data->update_lock);
	
	if ((jiffies - data->last_updated > HZ) ||
	    (jiffies < data->last_updated) ||
	    !data->valid) {
		
		/* Update local register data */
		data->reg.vid = i2c_smbus_read_byte_data(client, ATXP1_VID);
		data->reg.cpu_vid = i2c_smbus_read_byte_data(client, ATXP1_CVID);
		data->reg.gpio1 = i2c_smbus_read_byte_data(client, ATXP1_GPIO1);
		data->reg.gpio2 = i2c_smbus_read_byte_data(client, ATXP1_GPIO2);
		
		data->valid = 1;
	}
    	
	up(&data->update_lock);
	
	return(data);
}

static int atxp1_write(struct i2c_client *client, unsigned char addr, unsigned char data) 
{
	i2c_smbus_write_byte_data(client, addr, data);
	
	return 0;
}

/* sys file functions for cpu0_vid */
ssize_t atxp1_showvcore(struct device *dev, char *buf)
{
	int size;
	struct atxp1_data *data;
	
	data = atxp1_update_device(dev);
	
	size = sprintf(buf, "%d\n", vid_from_reg(data->reg.vid & ATXP1_VIDMASK, data->vrm));

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
	if(data->reg.vid & ATXP1_VIDENA)
		cvid = data->reg.vid & ATXP1_VIDMASK;
	else
		cvid = data->reg.cpu_vid;
	
	/* Nothing changed, aborting */
	if(vid = cvid)
		return count;
	
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
	
	data->valid = 0;
	
	return count;
}

/* CPU core reference voltage
    unit: millivolt
*/
static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);

/* sys file functions for GPIO1 */
ssize_t atxp1_showgpio1(struct device *dev, char *buf)
{
	int size;
	struct atxp1_data *data;
	
	data = atxp1_update_device(dev);
	
	size = sprintf(buf, "0x%02x\n", data->reg.gpio1 & ATXP1_GPIO1MASK);

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
	
	if(value != (data->reg.gpio1 & ATXP1_GPIO1MASK)) {
		dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
		
		atxp1_write(client, ATXP1_GPIO1, value);
		
		data->valid = 0;
	}
	
	return count;
}

/* GPIO1 data register
    unit: Four bit as hex (e.g. 0x0f)
*/
static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);

/* sys file functions for GPIO2 */
ssize_t atxp1_showgpio2(struct device *dev, char *buf)
{
	int size;
	struct atxp1_data *data;
	
	data = atxp1_update_device(dev);
	
	size = sprintf(buf, "0x%02x\n", data->reg.gpio2);

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
	
	if(value != data->reg.gpio2) {
		dev_info(dev, "Writing 0x%x to GPIO1.\n", value);

		atxp1_write(client, ATXP1_GPIO2, value);

		data->valid = 0;
	}
	
	return count;
}

/* GPIO2 data register
    unit: Eight bit as hex (e.g. 0xff)
*/
static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);


static int atxp1_attach_adapter(struct i2c_adapter *adapter)
{
	return i2c_detect(adapter, &addr_data, &atxp1_detect);
};
	
static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
{
	struct i2c_client * new_client;
	struct atxp1_data * data;
	int err = 0;
	u8 temp;
	
	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
		goto exit;
	
	if (!(data = kmalloc(sizeof(struct atxp1_data), GFP_KERNEL))) {
		err = -ENOMEM;
		goto exit;
	}

	memset(data, 0, sizeof(struct atxp1_data));
	new_client = &data->client;
	i2c_set_clientdata(new_client, data);
	
	new_client->addr = address;
	new_client->adapter = adapter;
	new_client->driver = &atxp1_driver;
	new_client->flags = 0;
	
	/* Detect ATXP1, checking if vendor ID registers are all zero */
	if(!((i2c_smbus_read_byte_data(new_client, 0x3e) = 0) &&
	     (i2c_smbus_read_byte_data(new_client, 0x3f) = 0) &&
	     (i2c_smbus_read_byte_data(new_client, 0xfe) = 0) &&
	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0) )) {
		
		/* No vendor ID, now checking if registers 0x10,0x11 (non-existent)
		 * showing the same as register 0x00 */
		temp = i2c_smbus_read_byte_data(new_client, 0x00);
		
		if(!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
			 (i2c_smbus_read_byte_data(new_client, 0x11) = temp) ))
			goto exit_free;
	}
	
	/* Get VRM */
	data->vrm = i2c_which_vrm();
	
	if((data->vrm != 90) && (data->vrm != 91)) {
		dev_err(&new_client->dev, "Not supporting VRM %d.%d\n", 
				data->vrm / 10, data->vrm % 10);
		goto exit_free;
	}
	
	strncpy(new_client->name, "atxp1", I2C_NAME_SIZE);

	data->valid = 0;
	
	init_MUTEX(&data->update_lock);
	
	if ((err = i2c_attach_client(new_client)))
	{
		dev_err(&new_client->dev, "Attach client error.\n");
		goto exit_free;
	}
	
	device_create_file(&new_client->dev, &dev_attr_gpio1);
	device_create_file(&new_client->dev, &dev_attr_gpio2);
	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
	
	dev_info(&new_client->dev, "Detected on %s. Using VRM: %d.%d\n", 
			 adapter->name, data->vrm / 10, data->vrm % 10);
	
	return 0;
	
exit_free:
	kfree(data);
exit:
	return err;
};

static int atxp1_detach_client(struct i2c_client * client)
{
	int err;
	
	err = i2c_detach_client(client);
	
	if (err) 
		dev_err(&client->dev, "Failed to detach client.\n");
	else
		kfree(i2c_get_clientdata(client));
	
	return err;
};
 
static int __init atxp1_init(void)  
{ 
	return i2c_add_driver(&atxp1_driver);
};

static void __exit atxp1_exit(void) 
{ 
	i2c_del_driver(&atxp1_driver);
};

module_init(atxp1_init);
module_exit(atxp1_exit);
