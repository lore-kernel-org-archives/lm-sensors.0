From: "Hans Edgington" <hans@edgington.nl>
Date: Fri, 11 May 2007 14:26:45 +0000
Subject: [lm-sensors] Fintek F71882FG Driver -> Problems with non EPoX mobo's
Message-Id: <000301c793d8$678c3790$20140a0a@EA002>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0004_01C793E9.2B150790"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01C793E9.2B150790
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

Two weeks ago I posted the beta-version driver for the Fintek F71882FG. I
just wanted to let everyone know how things are standing at the moment. 

The driver has been tested by quite a few people. Results are that the
driver works on 2 different EPoX mobo's, but fails to work on a jetway and
all MSI mobo's. In all cases it does correctly detect the fintek chipset,
and select the proper device and enable it if needed. Only the register it
is supposed to read from is empty. It seems that the region is reserved for
pnp, which cannot be disabled in the bios. This seems to be the case on the
3 MSI mobo's. I don't know how to deal with this problem..

I would be grateful if someone could have a look at the driver, if they have
the time, and comment on it.
If you are wondering why the driver doesn't output any voltages that is
because it wasn't working correctly on my system. So I removed it to make
sure it didn't cause any problems on someone else system.

Regards
Hans Edgington

------=_NextPart_000_0004_01C793E9.2B150790
Content-Type: text/plain;
	name="f71882-driver.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="f71882-driver.c"

/************************************************************************=
***=0A=
 *   Copyright (C) 2006 by Hans Edgington                                =
  *=0A=
 *   hans@edgington.nl                                                   =
  *=0A=
 *                                                                       =
  *=0A=
 *   This program is free software; you can redistribute it and/or =
modify  *=0A=
 *   it under the terms of the GNU General Public License as published =
by  *=0A=
 *   the Free Software Foundation; either version 2 of the License, or   =
  *=0A=
 *   (at your option) any later version.                                 =
  *=0A=
 *                                                                       =
  *=0A=
 *   This program is distributed in the hope that it will be useful,     =
  *=0A=
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of      =
  *=0A=
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       =
  *=0A=
 *   GNU General Public License for more details.                        =
  *=0A=
 *                                                                       =
  *=0A=
 *   You should have received a copy of the GNU General Public License   =
  *=0A=
 *   along with this program; if not, write to the                       =
  *=0A=
 *   Free Software Foundation, Inc.,                                     =
  *=0A=
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.           =
  *=0A=
 =
*************************************************************************=
**/=0A=
=0A=
#include <linux/module.h>=0A=
#include <linux/init.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/jiffies.h>=0A=
#include <linux/platform_device.h>=0A=
#include <linux/hwmon.h>=0A=
#include <linux/hwmon-sysfs.h>=0A=
#include <linux/err.h>=0A=
#include <linux/mutex.h>=0A=
#include <asm/io.h>=0A=
=0A=
#define DRVNAME "f71882fg"=0A=
=0A=
#define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device*/=0A=
#define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */=0A=
#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */=0A=
=0A=
#define SIO_REG_LDSEL		0x07	/* Logical device select */=0A=
#define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */=0A=
#define SIO_REG_DEVREV		0x22	/* Device revision */=0A=
#define SIO_REG_MANID		0x23	/* Fintek ID (2 bytes) */=0A=
#define SIO_REG_ENABLE		0x30	/* Logical device enable */=0A=
#define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */=0A=
=0A=
#define SIO_FINTEK_ID	0x1934 /* Manufacturers ID */=0A=
#define SIO_F71882_ID	0x0541 /* Chipset ID */=0A=
=0A=
#define REGION_LENGTH	2=0A=
#define ADDR_REG_OFFSET	0=0A=
#define DATA_REG_OFFSET	1=0A=
=0A=
#define F71882FG_REG_IN(nr)	(0x20  + (nr))=0A=
#define F71882FG_REG_FAN(nr)	(0xA0 + (16 * (nr)))=0A=
#define F71882FG_REG_TEMP(nr)	(0x72 + 2 * (nr))=0A=
#define F71882FG_REG_HIGH(nr)	(0x83 + 2 * (nr))=0A=
#define F71882FG_REG_HYST1	0x6C=0A=
#define F71882FG_REG_HYST23	0x6D=0A=
#define F71882FG_REG_TYPE	0x6B=0A=
=0A=
#define	F71882FG_REG_START	0x01=0A=
=0A=
#define FAN_MIN_DETECT	366 /* Lowest detectable fanspeed */=0A=
=0A=
static struct platform_device *f71882fg_pdev;=0A=
=0A=
/* Super-I/O Function prototypes */=0A=
static inline int superio_inb(int base, int reg);=0A=
static inline int superio_inw(int base, int reg);=0A=
static inline void superio_enter(int base);=0A=
static inline void superio_select(int base, int ld);=0A=
static inline void superio_exit(int base);=0A=
=0A=
static inline u16 fan_from_reg ( u16 reg );=0A=
=0A=
struct f71882fg_data {=0A=
	unsigned short addr;=0A=
	const char *name;=0A=
	struct class_device *class_dev;=0A=
=0A=
	struct mutex update_lock;=0A=
	char valid;		/* !=3D0 if following fields are valid */=0A=
	unsigned long last_updated;	/* In jiffies */=0A=
	unsigned long last_limits;	/* In jiffies */=0A=
=0A=
	/* Register Values */=0A=
	u8	in[9];=0A=
	u16	fan[4];=0A=
	u8	temp[3];=0A=
	u8	temp_high[3];=0A=
	u8	temp_hyst[3];=0A=
	u8	temp_type;=0A=
};=0A=
=0A=
static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);=0A=
static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);=0A=
static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);=0A=
=0A=
/* Sysfs in*/=0A=
/* Sysfs Fan */=0A=
static ssize_t show_fan ( struct device *dev, struct device_attribute =
*devattr, char *buf );=0A=
/* Sysfs Temp */=0A=
static ssize_t show_temp ( struct device *dev, struct device_attribute =
*devattr, char *buf );=0A=
static ssize_t show_temp_max ( struct device *dev, struct =
device_attribute *devattr, char *buf );=0A=
static ssize_t show_temp_hyst ( struct device *dev, struct =
device_attribute *devattr, char *buf );=0A=
static ssize_t show_temp_type (struct device *dev, struct =
device_attribute *devattr, char *buf );=0A=
=0A=
static ssize_t show_name( struct device *dev, struct device_attribute =
*devattr, char *buf );=0A=
=0A=
static int __devinit f71882fg_probe(struct platform_device * pdev);=0A=
static void __devinit f71882fg_init_device(struct f71882fg_data *data);=0A=
static int __devexit f71882fg_remove(struct platform_device *pdev);=0A=
static int __init f71882fg_init(void);=0A=
static int __init f71882fg_find(int sioaddr, unsigned short *address);=0A=
static int __init f71882fg_device_add(unsigned short address);=0A=
static void __exit f71882fg_exit(void);=0A=
=0A=
static struct platform_driver f71882fg_driver =3D {=0A=
	.driver =3D {=0A=
		.owner	=3D THIS_MODULE,=0A=
		.name	=3D DRVNAME,=0A=
	},=0A=
	.probe		=3D f71882fg_probe,=0A=
	.remove		=3D __devexit_p(f71882fg_remove),=0A=
};=0A=
=0A=
static struct device_attribute f71882fg_dev_attr[] =3D=0A=
{=0A=
	__ATTR( name, S_IRUGO, show_name, NULL ),=0A=
};=0A=
=0A=
static struct sensor_device_attribute f71882fg_sensor_attr[] =3D=0A=
{=0A=
	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),=0A=
	SENSOR_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 0),=0A=
	SENSOR_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, 0),=0A=
	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),=0A=
	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),=0A=
	SENSOR_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 1),=0A=
	SENSOR_ATTR(temp2_max_hyst, S_IRUGO, show_temp_hyst, NULL, 1),=0A=
	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),=0A=
	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),=0A=
	SENSOR_ATTR(temp3_max, S_IRUGO, show_temp_max, NULL, 2),=0A=
	SENSOR_ATTR(temp3_max_hyst, S_IRUGO, show_temp_hyst, NULL, 2),=0A=
	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),=0A=
};=0A=
=0A=
static struct sensor_device_attribute f71882fg_fan_attr[] =3D=0A=
{=0A=
	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0 ),=0A=
	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1 ),=0A=
	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2 ),=0A=
	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3 ),=0A=
};=0A=
/* Super I/O functions */=0A=
static inline int superio_inb(int base, int reg)=0A=
{=0A=
	outb(reg, base);=0A=
	return inb(base + 1);=0A=
}=0A=
=0A=
static int superio_inw(int base, int reg)=0A=
{=0A=
	int val;=0A=
	outb(reg++, base);=0A=
	val =3D inb(base + 1) << 8;=0A=
	outb(reg, base);=0A=
	val |=3D inb(base + 1);=0A=
	return val;=0A=
}=0A=
=0A=
static inline void superio_enter(int base)=0A=
{=0A=
	outb( SIO_UNLOCK_KEY, base);=0A=
	outb( SIO_UNLOCK_KEY, base);=0A=
}=0A=
=0A=
static inline void superio_select( int base, int ld)=0A=
{=0A=
	outb(SIO_REG_LDSEL, base);=0A=
	outb(ld, base + 1);=0A=
}=0A=
=0A=
static inline void superio_exit(int base)=0A=
{=0A=
	outb(SIO_LOCK_KEY, base);=0A=
}=0A=
=0A=
static inline u16 fan_from_reg ( u16 reg )=0A=
{=0A=
	return ( 1500000 / reg );=0A=
}=0A=
=0A=
static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg)=0A=
{=0A=
	u8 val;=0A=
=0A=
	outb(reg, data->addr + ADDR_REG_OFFSET);=0A=
	val =3D inb(data->addr + DATA_REG_OFFSET);=0A=
=0A=
	return val;=0A=
}=0A=
=0A=
static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg)=0A=
{=0A=
	u16 val;=0A=
=0A=
	outb(reg, data->addr + ADDR_REG_OFFSET);=0A=
	val =3D inb(data->addr + DATA_REG_OFFSET) << 8;=0A=
	outb(++reg, data->addr + ADDR_REG_OFFSET);=0A=
	val |=3D inb(data->addr + DATA_REG_OFFSET);=0A=
=0A=
	return val;=0A=
}=0A=
=0A=
static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val)=0A=
{=0A=
	outb(reg, data->addr + ADDR_REG_OFFSET );=0A=
	outb(val, data->addr + DATA_REG_OFFSET );	=0A=
}=0A=
=0A=
static struct f71882fg_data *f71882fg_update_device(struct device * dev)=0A=
{=0A=
	struct f71882fg_data *data =3D dev_get_drvdata(dev);=0A=
	int nr, reg;=0A=
=0A=
	mutex_lock(&data->update_lock);=0A=
	=0A=
	/* Update once every 60 seconds */=0A=
	if ( time_after(jiffies, data->last_updated + 60 * HZ ) || !data->valid)=0A=
	{=0A=
		/* Get High & boundary temps*/=0A=
		for (nr =3D 0; nr < 3; nr++)=0A=
		{=0A=
			data->temp_high[nr] =3D f71882fg_read8(data, F71882FG_REG_HIGH(nr));=0A=
		}=0A=
=0A=
		/* Have to hardcode hyst*/=0A=
		data->temp_hyst[0] =3D f71882fg_read8(data, F71882FG_REG_HYST1) >> 4;=0A=
		/* Hyst temps 2 & 3 stored in same regsiter */=0A=
		reg =3D f71882fg_read8(data, F71882FG_REG_HYST23);=0A=
		data->temp_hyst[1] =3D reg & 15;=0A=
		data->temp_hyst[2] =3D reg >> 4;=0A=
=0A=
		data->temp_type =3D f71882fg_read8(data, F71882FG_REG_TYPE);=0A=
=0A=
		data->last_limits =3D jiffies;=0A=
	}=0A=
	=0A=
	/* Update every second */=0A=
	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) =0A=
	{=0A=
		for (nr =3D 0; nr < 3; nr++)=0A=
		{=0A=
			data->temp[nr] =3D f71882fg_read8(data, F71882FG_REG_TEMP(nr));=0A=
		}=0A=
=0A=
		for (nr =3D 0; nr < 4; nr++)=0A=
		{=0A=
			data->fan[nr] =3D f71882fg_read16(data, F71882FG_REG_FAN(nr));=0A=
		}=0A=
=0A=
		for (nr =3D 0; nr < 9; nr++)=0A=
		{=0A=
			data->in[nr] =3D f71882fg_read8(data, F71882FG_REG_IN(nr));=0A=
		}=0A=
=0A=
		data->last_updated =3D jiffies;=0A=
		data->valid =3D 1;=0A=
	}=0A=
=0A=
	mutex_unlock(&data->update_lock);=0A=
=0A=
	return data;=0A=
}=0A=
/* Sysfs Interface */=0A=
static ssize_t show_fan ( struct device *dev, struct device_attribute =
*devattr, char *buf )=0A=
{=0A=
	struct f71882fg_data *data =3D f71882fg_update_device( dev );=0A=
	struct sensor_device_attribute * attr =3D to_sensor_dev_attr( devattr );=0A=
	int nr =3D attr->index;=0A=
=0A=
	return sprintf( buf, "%ld\n", fan_from_reg( data->fan[nr] ));=0A=
}=0A=
=0A=
static ssize_t show_temp ( struct device *dev, struct device_attribute =
*devattr, char *buf )=0A=
{=0A=
	struct f71882fg_data *data =3D f71882fg_update_device( dev );=0A=
	struct sensor_device_attribute * attr =3D to_sensor_dev_attr( devattr );=0A=
	int nr =3D attr->index;=0A=
=0A=
	return sprintf( buf, "%ld\n", data->temp[nr] );=0A=
}=0A=
=0A=
static ssize_t show_temp_max ( struct device *dev, struct =
device_attribute *devattr, char *buf )=0A=
{=0A=
	struct f71882fg_data *data =3D f71882fg_update_device( dev );=0A=
	struct sensor_device_attribute * attr =3D to_sensor_dev_attr( devattr );=0A=
	int nr =3D attr->index;=0A=
=0A=
	return sprintf( buf, "%ld\n", data->temp_high[nr] );=0A=
}=0A=
=0A=
static ssize_t show_temp_hyst (struct device *dev, struct =
device_attribute *devattr, char *buf )=0A=
{=0A=
	struct f71882fg_data *data =3D f71882fg_update_device( dev );=0A=
	struct sensor_device_attribute * attr =3D to_sensor_dev_attr( devattr );=0A=
	int nr =3D attr->index;=0A=
=0A=
	return sprintf( buf, "%ld\n", (data->temp_hyst[nr] ));=0A=
}=0A=
=0A=
static ssize_t show_temp_type (struct device *dev, struct =
device_attribute *devattr, char *buf )=0A=
{=0A=
	struct f71882fg_data *data =3D f71882fg_update_device( dev );=0A=
	struct sensor_device_attribute * attr =3D to_sensor_dev_attr( devattr );=0A=
	int nr =3D attr->index;=0A=
=0A=
	return sprintf(buf, "%u\n", (data->temp_type & (1 << nr)) ? 4 : 2);=0A=
}=0A=
=0A=
static ssize_t show_name( struct device *dev, struct device_attribute =
*devattr, char *buf )=0A=
{=0A=
	struct f71882fg_data *data =3D dev_get_drvdata( dev );=0A=
=0A=
	return sprintf( buf, "%s\n", data->name);=0A=
}=0A=
=0A=
static void __devinit f71882fg_init_device(struct f71882fg_data *data)=0A=
{=0A=
	u8 reg;=0A=
=0A=
	reg =3D f71882fg_read8( data, F71882FG_REG_START );=0A=
	=0A=
	if ((reg & 0x01) !=3D 0x01)=0A=
	{=0A=
		/* Temperature and voltage monitoring disabled, so enable*/=0A=
		f71882fg_write8( data, F71882FG_REG_START, (reg | 0x01 ) ); =0A=
	}=0A=
	=0A=
	if ((reg & 0x02) !=3D 0x02)=0A=
	{=0A=
		/* Fan monitoring disabled, so enable*/=0A=
		f71882fg_write8( data, F71882FG_REG_START, (reg | 0x02 ) ); =0A=
	}=0A=
}=0A=
=0A=
static int __devinit f71882fg_probe(struct platform_device * pdev)=0A=
{=0A=
	struct f71882fg_data *data;=0A=
	struct resource *res;=0A=
	int err, i;=0A=
=0A=
	if(!(data =3D kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL)))=0A=
	{=0A=
		err =3D -ENOMEM;=0A=
		printk(KERN_ERR DRVNAME ": Out of memory\n");=0A=
		goto exit;=0A=
	}=0A=
=0A=
	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);=0A=
	data->addr =3D res->start;=0A=
	data->name =3D DRVNAME;=0A=
	mutex_init(&data->update_lock);=0A=
=0A=
	platform_set_drvdata(pdev, data);=0A=
=0A=
	data->class_dev =3D hwmon_device_register(&pdev->dev);=0A=
	if (IS_ERR(data->class_dev))=0A=
	{=0A=
		err =3D PTR_ERR(data->class_dev);=0A=
		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);=0A=
		goto exit_free;=0A=
	}=0A=
=0A=
	/* Initialize the F71882FG chip */=0A=
	f71882fg_init_device(data);=0A=
=0A=
	/* Register sysfs interface files */=0A=
	for ( i =3D 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)=0A=
	{=0A=
		err =3D device_create_file(&pdev->dev, &f71882fg_dev_attr[i]);=0A=
		if (err)=0A=
			goto exit_class;=0A=
	}=0A=
	=0A=
	for ( i =3D 0; i < ARRAY_SIZE(f71882fg_sensor_attr); i++)=0A=
	{=0A=
		err =3D device_create_file(&pdev->dev, =
&f71882fg_sensor_attr[i].dev_attr);=0A=
		if (err)=0A=
			goto exit_class;=0A=
	}=0A=
	=0A=
	for ( i =3D 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)=0A=
	{=0A=
		err =3D device_create_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);=0A=
		if (err)=0A=
			goto exit_class;=0A=
	}=0A=
	return 0;=0A=
=0A=
exit_class:=0A=
	dev_err(&pdev->dev, "Sysfs interface creation failed\n");=0A=
	hwmon_device_unregister(data->class_dev);=0A=
exit_free:=0A=
	kfree(data);=0A=
exit:=0A=
	return err;=0A=
}=0A=
=0A=
static int __devexit f71882fg_remove(struct platform_device *pdev)=0A=
{=0A=
	struct f71882fg_data *data =3D platform_get_drvdata(pdev);=0A=
=0A=
	platform_set_drvdata(pdev, NULL);=0A=
	hwmon_device_unregister(data->class_dev);=0A=
	kfree(data);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static int __init f71882fg_find(int sioaddr, unsigned short *address)=0A=
{=0A=
	int err =3D -ENODEV;=0A=
	u16 devid;=0A=
=0A=
	superio_enter(sioaddr);=0A=
	=0A=
	devid =3D superio_inw(sioaddr, SIO_REG_MANID);=0A=
	if (devid !=3D SIO_FINTEK_ID)=0A=
	{=0A=
		printk(KERN_INFO DRVNAME ": Not a Fintek device\n");=0A=
		goto exit;=0A=
	}=0A=
=0A=
	devid =3D superio_inw(sioaddr, SIO_REG_DEVID);=0A=
	if (devid !=3D SIO_F71882_ID)=0A=
	{=0A=
		printk(KERN_INFO DRVNAME ": Unsupported Fintek device\n");=0A=
		goto exit;=0A=
	}=0A=
=0A=
	superio_select(sioaddr, SIO_F71882FG_LD_HWM);=0A=
	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) =0A=
	{=0A=
		printk(KERN_WARNING DRVNAME ": Device not activated\n");=0A=
		goto exit;=0A=
	}=0A=
=0A=
	*address =3D superio_inw(sioaddr, SIO_REG_ADDR);=0A=
	if (*address =3D=3D 0) =0A=
	{=0A=
		printk(KERN_WARNING DRVNAME ": Base address not set\n");=0A=
		goto exit;=0A=
	}=0A=
=0A=
	err =3D 0;=0A=
	printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x\n", *address);=0A=
=0A=
exit:=0A=
	superio_exit(sioaddr);=0A=
	return err;=0A=
}=0A=
=0A=
static int __init f71882fg_device_add(unsigned short address)=0A=
{=0A=
	struct resource res =3D {=0A=
		.start	=3D address,=0A=
		.end	=3D address + REGION_LENGTH - 1,=0A=
		.flags	=3D IORESOURCE_IO,=0A=
	};=0A=
	int err;=0A=
=0A=
	f71882fg_pdev =3D platform_device_alloc(DRVNAME, address);=0A=
	if(!f71882fg_pdev)=0A=
	{=0A=
		err =3D -ENOMEM;=0A=
		printk(KERN_ERR DRVNAME ": Device allocation failed\n");=0A=
		goto exit;=0A=
	}=0A=
=0A=
	res.name =3D f71882fg_pdev->name;=0A=
	err =3D platform_device_add_resources(f71882fg_pdev, &res, 1);=0A=
	if(err)=0A=
	{=0A=
		printk(KERN_ERR DRVNAME ": Device resource addition failed %d\n", err);=0A=
		goto exit_device_put;=0A=
	}=0A=
=0A=
	err =3D platform_device_add(f71882fg_pdev);=0A=
	if(err)=0A=
	{=0A=
		printk(KERN_ERR DRVNAME ": Device resource addition failed %d\n", err);=0A=
		goto exit_device_put;=0A=
	}=0A=
=0A=
exit_device_put:=0A=
	platform_device_put(f71882fg_pdev);=0A=
exit:=0A=
	return err;=0A=
}=0A=
=0A=
static int __init f71882fg_init(void)=0A=
{=0A=
	int err;=0A=
	unsigned short address;=0A=
=0A=
	printk( KERN_DEBUG "Module F71882FG init\n" );=0A=
=0A=
	if (f71882fg_find(0x2e, &address) && f71882fg_find(0x4e, &address))=0A=
	{=0A=
		err =3D -ENODEV;=0A=
		goto exit;=0A=
	}=0A=
=0A=
	err =3D platform_driver_register(&f71882fg_driver);=0A=
	if(err)=0A=
		goto exit;=0A=
	=0A=
	err =3D f71882fg_device_add(address);=0A=
	if(err)=0A=
		goto exit_driver;=0A=
=0A=
	return 0;=0A=
exit_driver:=0A=
	platform_driver_unregister(&f71882fg_driver);=0A=
exit:=0A=
	return err;=0A=
}=0A=
=0A=
static void __exit f71882fg_exit(void)=0A=
{=0A=
	platform_device_unregister(f71882fg_pdev);=0A=
	platform_driver_unregister(&f71882fg_driver);=0A=
=0A=
	printk( KERN_DEBUG "Module F71882FG exit\n" );=0A=
}=0A=
=0A=
MODULE_DESCRIPTION("F71882FG Hardware Monitoring Driver");=0A=
MODULE_AUTHOR("Hans Edgington (hans@edgington.nl)");=0A=
MODULE_LICENSE("GPL");=0A=
=0A=
module_init(f71882fg_init);=0A=
module_exit(f71882fg_exit);=0A=

------=_NextPart_000_0004_01C793E9.2B150790
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_0004_01C793E9.2B150790--

