From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 18 Jun 2007 15:29:28 +0000
Subject: [lm-sensors] initial fintek f71882fg driver, test please
Message-Id: <4676A4D8.5020706@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040101030603090408040800"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040101030603090408040800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Here is my first work on a fintek f71882fg driver (also epox 1308). Still todo:
in1 max, beep and alarm read and write
tempX fault read
tempX beep and alarm read and write
tempX max / crit / hyst writing
fanX fault read
pwm support

This version should work on non Epox motherboards like MSI too (Thanks Mathias 
Grimmberger)

To test drop fintek71882 and the Makefile in a dir, type make and then insmod 
fintek71882.ko

The easiest way to then read the settings is by using the 3.0 sensors branch, 
which comes with dyn chipsupport:
remove your current lm-sensors userspace package (for example on Fedora do rpm 
-e lm_sensors --nodeps)
svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
cd lm-sensors-3.0.0
make
sudo make install
sudo ldconfig


I've also attached a sensors.conf for the Epox M1697 motherboard I'm using for 
testing, modify as needed.


Thanks for testing & Regards,

Hans

--------------040101030603090408040800
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

obj-m += fintek71882.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

--------------040101030603090408040800
Content-Type: text/x-csrc;
 name="fintek71882.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fintek71882.c"

/***************************************************************************
 *   Copyright (C) 2006 by Hans Edgington                                  *
 *   hans@edgington.nl                                                     *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/platform_device.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>
#include <asm/io.h>

#define DRVNAME "f71882fg"

#define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device*/
#define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */

#define SIO_REG_LDSEL		0x07	/* Logical device select */
#define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
#define SIO_REG_DEVREV		0x22	/* Device revision */
#define SIO_REG_MANID		0x23	/* Fintek ID (2 bytes) */
#define SIO_REG_ENABLE		0x30	/* Logical device enable */
#define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */

#define SIO_FINTEK_ID	0x1934 /* Manufacturers ID */
#define SIO_F71882_ID	0x0541 /* Chipset ID */

#define REGION_LENGTH	8
#define ADDR_REG_OFFSET	5
#define DATA_REG_OFFSET	6

#define F71882FG_REG_PECI		0x0A
#define F71882FG_REG_IN(nr)		(0x20  + (nr))
#define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
#define F71882FG_REG_TEMP(nr)		(0x72 + 2 * (nr))
#define F71882FG_REG_TEMP_OVT(nr)	(0x82 + 2 * (nr))
#define F71882FG_REG_TEMP_HIGH(nr)	(0x83 + 2 * (nr))
#define F71882FG_REG_TEMP_HYST1		0x6C
#define F71882FG_REG_TEMP_HYST23	0x6D
#define F71882FG_REG_TEMP_TYPE		0x6B

#define	F71882FG_REG_START		0x01

#define FAN_MIN_DETECT	366 /* Lowest detectable fanspeed */

static struct platform_device *f71882fg_pdev = NULL;

/* Super-I/O Function prototypes */
static inline int superio_inb(int base, int reg);
static inline int superio_inw(int base, int reg);
static inline void superio_enter(int base);
static inline void superio_select(int base, int ld);
static inline void superio_exit(int base);

static inline u16 fan_from_reg ( u16 reg );

struct f71882fg_data {
	unsigned short addr;
	struct class_device *class_dev;

	struct mutex update_lock;
	char valid;			/* !=0 if following fields are valid */
	unsigned long last_updated;	/* In jiffies */
	unsigned long last_limits;	/* In jiffies */

	/* Register Values */
	u8	in[9];
	u16	fan[4];
	u8	temp[3];
	u8	temp_ovt[3];
	u8	temp_high[3];
	u8	temp_hyst[3];
	u8	temp_type[3];
};

static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);
static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);
static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);

/* Sysfs in*/
static ssize_t show_in ( struct device *dev, struct device_attribute *devattr, char *buf );
/* Sysfs Fan */
static ssize_t show_fan ( struct device *dev, struct device_attribute *devattr, char *buf );
/* Sysfs Temp */
static ssize_t show_temp ( struct device *dev, struct device_attribute *devattr, char *buf );
static ssize_t show_temp_max ( struct device *dev, struct device_attribute *devattr, char *buf );
static ssize_t show_temp_crit ( struct device *dev, struct device_attribute *devattr, char *buf );
static ssize_t show_temp_hyst ( struct device *dev, struct device_attribute *devattr, char *buf );
static ssize_t show_temp_type (struct device *dev, struct device_attribute *devattr, char *buf );

static ssize_t show_name( struct device *dev, struct device_attribute *devattr, char *buf );

static int __devinit f71882fg_probe(struct platform_device * pdev);
static int __devexit f71882fg_remove(struct platform_device *pdev);
static int __init f71882fg_init(void);
static int __init f71882fg_find(int sioaddr, unsigned short *address);
static int __init f71882fg_device_add(unsigned short address);
static void __exit f71882fg_exit(void);

static struct platform_driver f71882fg_driver = {
	.driver = {
		.owner	= THIS_MODULE,
		.name	= DRVNAME,
	},
	.probe		= f71882fg_probe,
	.remove		= __devexit_p(f71882fg_remove),
};

static struct device_attribute f71882fg_dev_attr[] =
{
	__ATTR( name, S_IRUGO, show_name, NULL ),
};

static struct sensor_device_attribute f71882fg_in_temp_attr[] =
{
	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
	SENSOR_ATTR(in8_input, S_IRUGO, show_in, NULL, 8),
	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),
	SENSOR_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 0),
	SENSOR_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, 0),
	SENSOR_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0),
	SENSOR_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_hyst, NULL, 0),
	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),
	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),
	SENSOR_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 1),
	SENSOR_ATTR(temp2_max_hyst, S_IRUGO, show_temp_hyst, NULL, 1),
	SENSOR_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL, 1),
	SENSOR_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_hyst, NULL, 1),
	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),
	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),
	SENSOR_ATTR(temp3_max, S_IRUGO, show_temp_max, NULL, 2),
	SENSOR_ATTR(temp3_max_hyst, S_IRUGO, show_temp_hyst, NULL, 2),
	SENSOR_ATTR(temp3_crit, S_IRUGO, show_temp_crit, NULL, 2),
	SENSOR_ATTR(temp3_crit_hyst, S_IRUGO, show_temp_hyst, NULL, 2),
	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2)
};

static struct sensor_device_attribute f71882fg_fan_attr[] =
{
	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0 ),
	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1 ),
	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2 ),
	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3 )
};


/* Super I/O functions */
static inline int superio_inb(int base, int reg)
{
	outb(reg, base);
	return inb(base + 1);
}

static int superio_inw(int base, int reg)
{
	int val;
	outb(reg++, base);
	val = inb(base + 1) << 8;
	outb(reg, base);
	val |= inb(base + 1);
	return val;
}

static inline void superio_enter(int base)
{
	outb( SIO_UNLOCK_KEY, base);
	outb( SIO_UNLOCK_KEY, base);
}

static inline void superio_select( int base, int ld)
{
	outb(SIO_REG_LDSEL, base);
	outb(ld, base + 1);
}

static inline void superio_exit(int base)
{
	outb(SIO_LOCK_KEY, base);
}

static inline u16 fan_from_reg ( u16 reg )
{
	return ( 1500000 / reg );
}

static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg)
{
	u8 val;

	outb(reg, data->addr + ADDR_REG_OFFSET);
	val = inb(data->addr + DATA_REG_OFFSET);

	return val;
}

static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg)
{
	u16 val;

	outb(reg, data->addr + ADDR_REG_OFFSET);
	val = inb(data->addr + DATA_REG_OFFSET) << 8;
	outb(++reg, data->addr + ADDR_REG_OFFSET);
	val |= inb(data->addr + DATA_REG_OFFSET);

	return val;
}

static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val)
{
	outb(reg, data->addr + ADDR_REG_OFFSET );
	outb(val, data->addr + DATA_REG_OFFSET );	
}

static struct f71882fg_data *f71882fg_update_device(struct device * dev)
{
	struct f71882fg_data *data = dev_get_drvdata(dev);
	int nr, reg, reg2;

	mutex_lock(&data->update_lock);
	
	/* Update once every 60 seconds */
	if ( time_after(jiffies, data->last_updated + 60 * HZ ) ||
			!data->valid) {
		/* Get High & boundary temps*/
		for (nr = 0; nr < 3; nr++) {
			data->temp_ovt[nr] = f71882fg_read8(data,
						F71882FG_REG_TEMP_OVT(nr));
			data->temp_high[nr] = f71882fg_read8(data,
						F71882FG_REG_TEMP_HIGH(nr));
		}

		/* Have to hardcode hyst*/
		data->temp_hyst[0] = f71882fg_read8(data,
						F71882FG_REG_TEMP_HYST1) >> 4;
		/* Hyst temps 2 & 3 stored in same register */
		reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
		data->temp_hyst[1] = reg & 0x0F;
		data->temp_hyst[2] = reg >> 4;

		/* Have to hardcode type, because temp1 is special */
		reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
		reg2 = f71882fg_read8(data, F71882FG_REG_PECI);
		if ((reg2 & 0x03) == 0x01) 
			data->temp_type[0] = 6 /* PECI */;
		else if ((reg2 & 0x03) == 0x02)
			data->temp_type[0] = 5 /* AMDSI */;
		else
			data->temp_type[0] = (reg & 0x02) ? 2 : 4;
		
		data->temp_type[1] = (reg & 0x04) ? 2 : 4;
		data->temp_type[2] = (reg & 0x08) ? 2 : 4;

		data->last_limits = jiffies;
	}
	
	/* Update every second */
	if (time_after(jiffies, data->last_updated + HZ) || !data->valid)  {
		for (nr = 0; nr < 3; nr++)
			data->temp[nr] = f71882fg_read8(data,
						F71882FG_REG_TEMP(nr));

		for (nr = 0; nr < 4; nr++)
			data->fan[nr] = f71882fg_read16(data,
						F71882FG_REG_FAN(nr));

		for (nr = 0; nr < 9; nr++)
			data->in[nr] = f71882fg_read8(data,
						F71882FG_REG_IN(nr));

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);

	return data;
}

/* Sysfs Interface */
static ssize_t show_fan ( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", fan_from_reg( data->fan[nr] ));
}

static ssize_t show_in ( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", data->in[nr] * 8);
}

static ssize_t show_temp ( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", data->temp[nr] * 1000);
}

static ssize_t show_temp_max ( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", data->temp_high[nr] * 1000);
}

static ssize_t show_temp_crit ( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", data->temp_ovt[nr] * 1000);
}

static ssize_t show_temp_hyst (struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", (data->temp_hyst[nr] * 1000));
}

static ssize_t show_temp_type (struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf(buf, "%d\n", data->temp_type[nr]);
}

static ssize_t show_name( struct device *dev, struct device_attribute *devattr, char *buf )
{
	return sprintf( buf, DRVNAME "\n");
}


static int __devinit f71882fg_probe(struct platform_device * pdev)
{
	struct f71882fg_data *data;
	int err, i;
	u8 start_reg;

	if(!(data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL)))
		return -ENOMEM;

	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
	mutex_init(&data->update_lock);
	platform_set_drvdata(pdev, data);

	/* Register sysfs interface files */
	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++) {
		err = device_create_file(&pdev->dev, &f71882fg_dev_attr[i]);
		if (err)
			goto exit_unregister_sysfs;
	}
	
	start_reg = f71882fg_read8(data, F71882FG_REG_START);
	if (start_reg & 0x01) {
		for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++) {
			err = device_create_file(&pdev->dev,
					&f71882fg_in_temp_attr[i].dev_attr);
			if (err)
				goto exit_unregister_sysfs;
		}
	}

	if (start_reg & 0x02) {
		for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++) {
			err = device_create_file(&pdev->dev,
					&f71882fg_fan_attr[i].dev_attr);
			if (err)
				goto exit_unregister_sysfs;
		}
	}
	
	data->class_dev = hwmon_device_register(&pdev->dev);
	if (IS_ERR(data->class_dev)) {
		err = PTR_ERR(data->class_dev);
		goto exit_unregister_sysfs;
	}

	return 0;

exit_unregister_sysfs:
	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)
		device_remove_file(&pdev->dev, &f71882fg_dev_attr[i]);
	
	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
		device_remove_file(&pdev->dev,
					&f71882fg_in_temp_attr[i].dev_attr);
	
	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);

	kfree(data);

	return err;
}

static int __devexit f71882fg_remove(struct platform_device *pdev)
{
	int i;
	struct f71882fg_data *data = platform_get_drvdata(pdev);

	platform_set_drvdata(pdev, NULL);
	hwmon_device_unregister(data->class_dev);

	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)
		device_remove_file(&pdev->dev, &f71882fg_dev_attr[i]);
	
	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
		device_remove_file(&pdev->dev,
					&f71882fg_in_temp_attr[i].dev_attr);
	
	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);

	kfree(data);

	return 0;
}

static int __init f71882fg_find(int sioaddr, unsigned short *address)
{
	int err = -ENODEV;
	u16 devid;
	u8 start_reg;
	struct f71882fg_data data;

	superio_enter(sioaddr);
	
	devid = superio_inw(sioaddr, SIO_REG_MANID);
	if (devid != SIO_FINTEK_ID) {
		printk(KERN_INFO DRVNAME ": Not a Fintek device\n");
		goto exit;
	}

	devid = superio_inw(sioaddr, SIO_REG_DEVID);
	if (devid != SIO_F71882_ID) {
		printk(KERN_INFO DRVNAME ": Unsupported Fintek device\n");
		goto exit;
	}

	superio_select(sioaddr, SIO_F71882FG_LD_HWM);
	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01))  {
		printk(KERN_WARNING DRVNAME ": Device not activated\n");
		goto exit;
	}

	*address = superio_inw(sioaddr, SIO_REG_ADDR);
	if (*address == 0) 
	{
		printk(KERN_WARNING DRVNAME ": Base address not set\n");
		goto exit;
	}
	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
	
	data.addr = *address;
	start_reg = f71882fg_read8(&data, F71882FG_REG_START);
	if (!(start_reg & 0x03)) {
		printk(KERN_WARNING DRVNAME
			": Hardware monitoring not activated\n");
		goto exit;
	}

	err = 0;
	printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x, revision %d\n",
		(unsigned int)*address,
		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
exit:
	superio_exit(sioaddr);
	return err;
}

static int __init f71882fg_device_add(unsigned short address)
{
	struct resource res = {
		.start	= address,
		.end	= address + REGION_LENGTH - 1,
		.flags	= IORESOURCE_IO,
	};
	int err;

	f71882fg_pdev = platform_device_alloc(DRVNAME, address);
	if(!f71882fg_pdev)
		return -ENOMEM;

	res.name = f71882fg_pdev->name;
	err = platform_device_add_resources(f71882fg_pdev, &res, 1);
	if(err) {
		printk(KERN_ERR DRVNAME ": Device resource addition failed\n");
		goto exit_device_put;
	}

	err = platform_device_add(f71882fg_pdev);
	if(err) {
		printk(KERN_ERR DRVNAME ": Device addition failed\n");
		goto exit_device_put;
	}
	
	return 0;

exit_device_put:
	platform_device_put(f71882fg_pdev);

	return err;
}

static int __init f71882fg_init(void)
{
	int err = -ENODEV;
	unsigned short address;

	if (f71882fg_find(0x2e, &address) && f71882fg_find(0x4e, &address))
		goto exit;

	if ((err = platform_driver_register(&f71882fg_driver)))
		goto exit;
	
	if ((err = f71882fg_device_add(address)))
		goto exit_driver;

	return 0;

exit_driver:
	platform_driver_unregister(&f71882fg_driver);
exit:
	return err;
}

static void __exit f71882fg_exit(void)
{
	platform_device_unregister(f71882fg_pdev);
	platform_driver_unregister(&f71882fg_driver);
}

MODULE_DESCRIPTION("F71882FG Hardware Monitoring Driver");
MODULE_AUTHOR("Hans Edgington (hans@edgington.nl)");
MODULE_LICENSE("GPL");

module_init(f71882fg_init);
module_exit(f71882fg_exit);

--------------040101030603090408040800
Content-Type: text/plain;
 name="sensors.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sensors.conf"

chip "f71882fg-*"
# Fintek f71882fg
# Notice that this config is for the Epox M1697 board, which has a Fintek
# f71882fg relabeled as Epox ep1308. Your milage with thos config on other
# boards will probably vary

# Temperature
    label temp1       "CPU"
    label temp2       "System"
    ignore temp3
    ignore temp4

# Fans
    label fan1        "CPU"
    ignore fan2
    ignore fan3
    ignore fan4

# Voltage
    label in0         "3.3V"
    label in1         "Vcore"
    label in2         "Vdimm"
    label in3         "Vchip"
    label in4         "+5V"
    label in5         "12V"
    label in6         "5VSB"
    label in7         "3VSB"
    label in8         "Batery"

# never change the in0, in7 and in8 compute, these are hardwired in the chip!
    compute in0       (@ * 2), (@ / 2) 
    compute in2       (@ * 2), (@ / 2)
    compute in3       (@ * 2), (@ / 2)
    compute in4       (@ * 5.25), (@ / 5.25)
    compute in5       (@ * 12.83), (@ / 12.83)
    compute in6       (@ * 5.25), (@ / 5.25)
    compute in7       (@ * 2), (@ / 2)
    compute in8       (@ * 2), (@ / 2)

--------------040101030603090408040800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040101030603090408040800--

