From: Mathias Grimmberger <mgri@zaphod.sax.de>
Date: Tue, 05 Jun 2007 20:37:27 +0000
Subject: [lm-sensors] Fintek F71882 on MSI mainboard
Message-Id: <18021.51591.422191.587646@gate.local.mgri>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

I hacked the f71882fg driver so it works on my MSI P6N SLI Platinum
mainboard (Socket 775 with Nvidia 650).

The critical fix was to use the address values and logic from the
existing f71805f driver (see diff).

I also fixed some type mismatches and the chip init logic (it could
inadvertently disable part of HW monitoring).

Note that the driver still causes a kernel oops on rmmod, this is
probably because f71882fg_exit doesn't call f71882fg_remove but I didn't
feel like working on that, after all I don't remove the module at all...
;-)

See below for a diff and the complete source for people wanting to try
it out. Note that I have no idea whether the driver still works on
mainboards it worked on before!

Please also note that I'm not subscribed to lm-sensors.


MGri

----------------------------------->8 -----------------------------------
--- f71882fg.c.org	2007-06-05 22:16:10.000000000 +0200
+++ f71882fg.c	2007-06-05 13:24:02.000000000 +0200
@@ -45,9 +45,9 @@
 #define SIO_FINTEK_ID	0x1934 /* Manufacturers ID */
 #define SIO_F71882_ID	0x0541 /* Chipset ID */
 
-#define REGION_LENGTH	2
-#define ADDR_REG_OFFSET	0
-#define DATA_REG_OFFSET	1
+#define REGION_LENGTH	8
+#define ADDR_REG_OFFSET	5
+#define DATA_REG_OFFSET	6
 
 #define F71882FG_REG_IN(nr)	(0x20  + (nr))
 #define F71882FG_REG_FAN(nr)	(0xA0 + (16 * (nr)))
@@ -279,7 +279,7 @@
 	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
 	int nr = attr->index;
 
-	return sprintf( buf, "%ld\n", fan_from_reg( data->fan[nr] ));
+	return sprintf( buf, "%d\n", fan_from_reg( data->fan[nr] ));
 }
 
 static ssize_t show_temp ( struct device *dev, struct device_attribute *devattr, char *buf )
@@ -288,7 +288,7 @@
 	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
 	int nr = attr->index;
 
-	return sprintf( buf, "%ld\n", data->temp[nr] );
+	return sprintf( buf, "%d\n", data->temp[nr] );
 }
 
 static ssize_t show_temp_max ( struct device *dev, struct device_attribute *devattr, char *buf )
@@ -297,7 +297,7 @@
 	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
 	int nr = attr->index;
 
-	return sprintf( buf, "%ld\n", data->temp_high[nr] );
+	return sprintf( buf, "%d\n", data->temp_high[nr] );
 }
 
 static ssize_t show_temp_hyst (struct device *dev, struct device_attribute *devattr, char *buf )
@@ -306,7 +306,7 @@
 	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
 	int nr = attr->index;
 
-	return sprintf( buf, "%ld\n", (data->temp_hyst[nr] ));
+	return sprintf( buf, "%d\n", (data->temp_hyst[nr] ));
 }
 
 static ssize_t show_temp_type (struct device *dev, struct device_attribute *devattr, char *buf )
@@ -331,16 +331,10 @@
 
 	reg = f71882fg_read8( data, F71882FG_REG_START );
 	
-	if ((reg & 0x01) != 0x01)
+	if ((reg & 0x03) != 0x03)
 	{
-		/* Temperature and voltage monitoring disabled, so enable*/
-		f71882fg_write8( data, F71882FG_REG_START, (reg | 0x01 ) ); 
-	}
-	
-	if ((reg & 0x02) != 0x02)
-	{
-		/* Fan monitoring disabled, so enable*/
-		f71882fg_write8( data, F71882FG_REG_START, (reg | 0x02 ) ); 
+		/* (some) monitoring disabled, so enable */
+		f71882fg_write8( data, F71882FG_REG_START, (reg | 0x03 ) ); 
 	}
 }
 
@@ -452,9 +446,11 @@
 		printk(KERN_WARNING DRVNAME ": Base address not set\n");
 		goto exit;
 	}
+	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
 	err = 0;
-	printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x\n", *address);
+	printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x, revision %u\n",
+               *address, superio_inb(sioaddr, SIO_REG_DEVREV));
 
 exit:
 	superio_exit(sioaddr);
----------------------------------->8 -----------------------------------


----------------------------------->8 -----------------------------------
/***************************************************************************
 *   Copyright (C) 2006 by Hans Edgington                                  *
 *   hans <at> edgington.nl                                                     *
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

#define F71882FG_REG_IN(nr)	(0x20  + (nr))
#define F71882FG_REG_FAN(nr)	(0xA0 + (16 * (nr)))
#define F71882FG_REG_TEMP(nr)	(0x72 + 2 * (nr))
#define F71882FG_REG_HIGH(nr)	(0x83 + 2 * (nr))
#define F71882FG_REG_HYST1	0x6C
#define F71882FG_REG_HYST23	0x6D
#define F71882FG_REG_TYPE	0x6B

#define	F71882FG_REG_START	0x01

#define FAN_MIN_DETECT	366 /* Lowest detectable fanspeed */

static struct platform_device *f71882fg_pdev;

/* Super-I/O Function prototypes */
static inline int superio_inb(int base, int reg);
static inline int superio_inw(int base, int reg);
static inline void superio_enter(int base);
static inline void superio_select(int base, int ld);
static inline void superio_exit(int base);

static inline u16 fan_from_reg ( u16 reg );

struct f71882fg_data {
	unsigned short addr;
	const char *name;
	struct class_device *class_dev;

	struct mutex update_lock;
	char valid;		/* !=0 if following fields are valid */
	unsigned long last_updated;	/* In jiffies */
	unsigned long last_limits;	/* In jiffies */

	/* Register Values */
	u8	in[9];
	u16	fan[4];
	u8	temp[3];
	u8	temp_high[3];
	u8	temp_hyst[3];
	u8	temp_type;
};

static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);
static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);
static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);

/* Sysfs in*/
/* Sysfs Fan */
static ssize_t show_fan ( struct device *dev, struct device_attribute *devattr, char *buf );
/* Sysfs Temp */
static ssize_t show_temp ( struct device *dev, struct device_attribute *devattr, char *buf );
static ssize_t show_temp_max ( struct device *dev, struct device_attribute *devattr, char *buf );
static ssize_t show_temp_hyst ( struct device *dev, struct device_attribute *devattr, char *buf );
static ssize_t show_temp_type (struct device *dev, struct device_attribute *devattr, char *buf );

static ssize_t show_name( struct device *dev, struct device_attribute *devattr, char *buf );

static int __devinit f71882fg_probe(struct platform_device * pdev);
static void __devinit f71882fg_init_device(struct f71882fg_data *data);
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

static struct device_attribute f71882fg_dev_attr[] {
	__ATTR( name, S_IRUGO, show_name, NULL ),
};

static struct sensor_device_attribute f71882fg_sensor_attr[] {
	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),
	SENSOR_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 0),
	SENSOR_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, 0),
	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),
	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),
	SENSOR_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 1),
	SENSOR_ATTR(temp2_max_hyst, S_IRUGO, show_temp_hyst, NULL, 1),
	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),
	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),
	SENSOR_ATTR(temp3_max, S_IRUGO, show_temp_max, NULL, 2),
	SENSOR_ATTR(temp3_max_hyst, S_IRUGO, show_temp_hyst, NULL, 2),
	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),
};

static struct sensor_device_attribute f71882fg_fan_attr[] {
	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0 ),
	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1 ),
	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2 ),
	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3 ),
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
	int nr, reg;

	mutex_lock(&data->update_lock);
	
	/* Update once every 60 seconds */
	if ( time_after(jiffies, data->last_updated + 60 * HZ ) || !data->valid)
	{
		/* Get High & boundary temps*/
		for (nr = 0; nr < 3; nr++)
		{
			data->temp_high[nr] = f71882fg_read8(data, F71882FG_REG_HIGH(nr));
		}

		/* Have to hardcode hyst*/
		data->temp_hyst[0] = f71882fg_read8(data, F71882FG_REG_HYST1) >> 4;
		/* Hyst temps 2 & 3 stored in same regsiter */
		reg = f71882fg_read8(data, F71882FG_REG_HYST23);
		data->temp_hyst[1] = reg & 15;
		data->temp_hyst[2] = reg >> 4;

		data->temp_type = f71882fg_read8(data, F71882FG_REG_TYPE);

		data->last_limits = jiffies;
	}
	
	/* Update every second */
	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) 
	{
		for (nr = 0; nr < 3; nr++)
		{
			data->temp[nr] = f71882fg_read8(data, F71882FG_REG_TEMP(nr));
		}

		for (nr = 0; nr < 4; nr++)
		{
			data->fan[nr] = f71882fg_read16(data, F71882FG_REG_FAN(nr));
		}

		for (nr = 0; nr < 9; nr++)
		{
			data->in[nr] = f71882fg_read8(data, F71882FG_REG_IN(nr));
		}

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

static ssize_t show_temp ( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", data->temp[nr] );
}

static ssize_t show_temp_max ( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", data->temp_high[nr] );
}

static ssize_t show_temp_hyst (struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf( buf, "%d\n", (data->temp_hyst[nr] ));
}

static ssize_t show_temp_type (struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = f71882fg_update_device( dev );
	struct sensor_device_attribute * attr = to_sensor_dev_attr( devattr );
	int nr = attr->index;

	return sprintf(buf, "%u\n", (data->temp_type & (1 << nr)) ? 4 : 2);
}

static ssize_t show_name( struct device *dev, struct device_attribute *devattr, char *buf )
{
	struct f71882fg_data *data = dev_get_drvdata( dev );

	return sprintf( buf, "%s\n", data->name);
}

static void __devinit f71882fg_init_device(struct f71882fg_data *data)
{
	u8 reg;

	reg = f71882fg_read8( data, F71882FG_REG_START );
	
	if ((reg & 0x03) != 0x03)
	{
		/* (some) monitoring disabled, so enable */
		f71882fg_write8( data, F71882FG_REG_START, (reg | 0x03 ) ); 
	}
}

static int __devinit f71882fg_probe(struct platform_device * pdev)
{
	struct f71882fg_data *data;
	struct resource *res;
	int err, i;

	if(!(data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL)))
	{
		err = -ENOMEM;
		printk(KERN_ERR DRVNAME ": Out of memory\n");
		goto exit;
	}

	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
	data->addr = res->start;
	data->name = DRVNAME;
	mutex_init(&data->update_lock);

	platform_set_drvdata(pdev, data);

	data->class_dev = hwmon_device_register(&pdev->dev);
	if (IS_ERR(data->class_dev))
	{
		err = PTR_ERR(data->class_dev);
		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
		goto exit_free;
	}

	/* Initialize the F71882FG chip */
	f71882fg_init_device(data);

	/* Register sysfs interface files */
	for ( i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)
	{
		err = device_create_file(&pdev->dev, &f71882fg_dev_attr[i]);
		if (err)
			goto exit_class;
	}
	
	for ( i = 0; i < ARRAY_SIZE(f71882fg_sensor_attr); i++)
	{
		err = device_create_file(&pdev->dev, &f71882fg_sensor_attr[i].dev_attr);
		if (err)
			goto exit_class;
	}
	
	for ( i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
	{
		err = device_create_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);
		if (err)
			goto exit_class;
	}
	return 0;

exit_class:
	dev_err(&pdev->dev, "Sysfs interface creation failed\n");
	hwmon_device_unregister(data->class_dev);
exit_free:
	kfree(data);
exit:
	return err;
}

static int __devexit f71882fg_remove(struct platform_device *pdev)
{
	struct f71882fg_data *data = platform_get_drvdata(pdev);

	platform_set_drvdata(pdev, NULL);
	hwmon_device_unregister(data->class_dev);
	kfree(data);

	return 0;
}

static int __init f71882fg_find(int sioaddr, unsigned short *address)
{
	int err = -ENODEV;
	u16 devid;

	superio_enter(sioaddr);
	
	devid = superio_inw(sioaddr, SIO_REG_MANID);
	if (devid != SIO_FINTEK_ID)
	{
		printk(KERN_INFO DRVNAME ": Not a Fintek device\n");
		goto exit;
	}

	devid = superio_inw(sioaddr, SIO_REG_DEVID);
	if (devid != SIO_F71882_ID)
	{
		printk(KERN_INFO DRVNAME ": Unsupported Fintek device\n");
		goto exit;
	}

	superio_select(sioaddr, SIO_F71882FG_LD_HWM);
	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) 
	{
		printk(KERN_WARNING DRVNAME ": Device not activated\n");
		goto exit;
	}

	*address = superio_inw(sioaddr, SIO_REG_ADDR);
	if (*address = 0) 
	{
		printk(KERN_WARNING DRVNAME ": Base address not set\n");
		goto exit;
	}
	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */

	err = 0;
	printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x, revision %u\n",
               *address, superio_inb(sioaddr, SIO_REG_DEVREV));

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
	{
		err = -ENOMEM;
		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
		goto exit;
	}

	res.name = f71882fg_pdev->name;
	err = platform_device_add_resources(f71882fg_pdev, &res, 1);
	if(err)
	{
		printk(KERN_ERR DRVNAME ": Device resource addition failed %d\n", err);
		goto exit_device_put;
	}

	err = platform_device_add(f71882fg_pdev);
	if(err)
	{
		printk(KERN_ERR DRVNAME ": Device resource addition failed %d\n", err);
		goto exit_device_put;
	}

exit_device_put:
	platform_device_put(f71882fg_pdev);
exit:
	return err;
}

static int __init f71882fg_init(void)
{
	int err;
	unsigned short address;

	printk( KERN_DEBUG "Module F71882FG init\n" );

	if (f71882fg_find(0x2e, &address) && f71882fg_find(0x4e, &address))
	{
		err = -ENODEV;
		goto exit;
	}

	err = platform_driver_register(&f71882fg_driver);
	if(err)
		goto exit;
	
	err = f71882fg_device_add(address);
	if(err)
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

	printk( KERN_DEBUG "Module F71882FG exit\n" );
}

MODULE_DESCRIPTION("F71882FG Hardware Monitoring Driver");
MODULE_AUTHOR("Hans Edgington (hans <at> edgington.nl)");
MODULE_LICENSE("GPL");

module_init(f71882fg_init);
module_exit(f71882fg_exit);
----------------------------------->8 -----------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
