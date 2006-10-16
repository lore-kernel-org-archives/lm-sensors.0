From: r.marek@assembler.cz (Rudolf Marek)
Date: Mon, 16 Oct 2006 20:42:42 +0000
Subject: [lm-sensors] 2.6.16-rc5: f75387 driver
Message-Id: <4533EEC2.6090204@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Harald,

Well we are slow but we do not forget ;)

> Attached is a new version of the f75387 driver. The fan speed is
> correct now, except that the missing fan is not detected. fan1_input
> is 550, not 0.

Hmm can be this fixed somehow so non-used fan is 0?

> All values are still read-only.
>=20
> What is the procedure to get support for a new chip into the
> lm-sensors package?

review the driver. I will do that now. This is just a first shot review. Pl=
ease=20
update the driver where neccessary, try the driver against the 2.6.19-rc2 a=
nd=20
return with updated patch ;) I promise that I will continue with the review.

Thank you,

regards
Rudolf

> /*
>  * f75387.c - Part of lm_sensors, Linux kernel modules for hardware
>  *          monitoring
>  * Copyright (C) 2006  Harald Dunkel <harald.dunkel at t-online.de>
>  *
>  * Based on the lm90 driver provided by Jean Delvare <khali at linux-fr.o=
rg>.
>  *
>  * http://www.fintek.com.tw/files/productfiles/F75387_025P%20datasheet.pdf
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation version 2.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

They have new addr

>  */
>=20
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/slab.h>
> #include <linux/jiffies.h>
> #include <linux/i2c.h>
> #include <linux/hwmon-sysfs.h>
> #include <linux/hwmon.h>
> #include <linux/err.h>
> #include <linux/mutex.h>

Add sysfs.h please

> #ifndef I2C_DRIVERID_F75387
> #define I2C_DRIVERID_F75387 0
> #endif
>=20
> /*
>  * Addresses to scan
>  */
>=20
> static unsigned short normal_i2c[] =3D { 0x2d, I2C_CLIENT_END };
>=20
> /*
> Sample
> i2cdump 0 0x2d b:
> =3D=3D=3D=3D=3D=3D=3D=3D>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  =
e  f    0123456789abcdef
> 00: 01 07 00 40 5a ff ff ff ff ff ff ff ff ff ff ff    ??. at Z...........
> 10: c5 72 7e 85 25 22 01 df 0f fe 00 00 1c 80 ad 07    ?r~?%"????..????
> 20: ff 00 ff 00 ff 00 ff 00 4b 4b 4b 4b 3c 37 00 ff    ........KKKK<7..
> 30: 00 b0 b0 00 00 00 30 ff ff ff ff ff ff ff ff ff    .??...0.........
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff 04 10 20 19 34 ff    ..........?? ?4.
> 60: bb 0a 90 00 01 00 00 0f ff 55 64 46 64 46 ff ff    ???.?..?.UdFdF..
> 70: 02 ab ff ff 00 00 ff ff ff ff ff ff ff ff ff ff    ??..............
> 80: 0f ff ff ff 00 00 ff ff ff ff ff ff ff ff ff ff    ?...............
> 90: 00 00 0d ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
> a0: 46 3c 32 28 ff d9 b2 99 80 ff ff ff ff ff ff ff    F<2(.????.......
> b0: 46 3c 32 28 ff d9 b2 99 80 ff ff ff ff ff ff ff    F<2(.????.......
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: 00 00 00 00 00 00 39 38 01 45 00 ff ff ff ff 27    ......98?E.....'
>  */

I think this belongs to the  documentation directory.

> #define MANU_ID_FINTEK 0x1934
> #define CHIP_ID_F75387 0x0410
>=20
> /*
>  * Insmod parameters
>  */
>=20
> I2C_CLIENT_INSMOD_1(f75387);
>=20
> /*
>  * The F75387 registers
>  */
>=20
> #define F75387_REG_R_MANU_ID		0x5D
> #define F75387_REG_R_CHIP_ID		0x5A
>=20
> #define F75387_REG_W_CONFIG0		0x00
> #define F75387_REG_W_CONFIG1		0x01
> #define F75387_REG_W_CONFIG2		0x02
> #define F75387_REG_W_CONFIG3		0x03
>=20
> #define F75387_REG_R_V0			0x10	/* 8mv */
> #define F75387_REG_R_V1			0x11	/* 8mv */
> #define F75387_REG_R_V2			0x12	/* 8mv */
> #define F75387_REG_R_V3			0x13	/* 8mv */
>=20
> #define F75387_REG_W_V0_MAX		0x20	/* 8mv */
> #define F75387_REG_W_V0_MIN		0x21	/* 8mv */
> #define F75387_REG_W_V1_MAX		0x22	/* 8mv */
> #define F75387_REG_W_V1_MIN		0x23	/* 8mv */
> #define F75387_REG_W_V2_MAX		0x24	/* 8mv */
> #define F75387_REG_W_V2_MIN		0x25	/* 8mv */
> #define F75387_REG_W_V3_MAX		0x26	/* 8mv */
> #define F75387_REG_W_V3_MIN		0x27	/* 8mv */
>=20
> #define F75387_REG_R_TEMP0_MSB		0x14	/* 1 degree */
> #define F75387_REG_R_TEMP0_LSB		0x1A	/* 1/256 degree */
> #define F75387_REG_R_TEMP1_MSB		0x15	/* 1 degree */
> #define F75387_REG_R_TEMP1_LSB		0x1B	/* 1/256 degree */
> #define F75387_REG_R_TEMP2_MSB		0x1C	/* local temp., 1 degree */
> #define F75387_REG_R_TEMP2_LSB		0x1D	/*              1/256 degree */
>=20
> #define F75387_REG_R_FAN0_MSB		0x16	/* MSB << 8 | LSB */
> #define F75387_REG_R_FAN0_LSB		0x17
> #define F75387_REG_R_FAN1_MSB		0x18	/* MSB << 8 | LSB */
> #define F75387_REG_R_FAN1_LSB		0x19
> /*
>  * Note: LSB is latched by reading MSB. Read MSB first.
>  */
>=20
> #define F75387_REG_W_TEMP0_MAX		0x28	/* 1 degree */
> #define F75387_REG_W_TEMP0_HYST		0x29	/* 1 degree */
> #define F75387_REG_W_TEMP1_MAX		0x2A	/* 1 degree */
> #define F75387_REG_W_TEMP1_HYST		0x2B	/* 1 degree */
> #define F75387_REG_W_TEMP2_MAX		0x2C	/* 1 degree */
> #define F75387_REG_W_TEMP2_HYST		0x2D	/* 1 degree */

Some of those defines are not used. Please wipe them out.

> /*
>  * Conversions and various macros
>  */
>=20
> #define VOLT_FROM_REG(val)		((val) << 3)

You will need to scale correctly the 3.3Vcc . You need to scale it in the d=
river=20
because it has in chip two  150Kohms regs - so it has to be *2. Other volta=
ges=20
should be left unscaled and proper scaling should be done via sensors.conf


> #define TEMP_FROM_REG2(val, low)	((val) * 1000 + (((low) * 1000) >> 8))
> #define TEMP_FROM_REG(val)		((val) * 1000)
> #define RPM_FROM_REG2(val, low)		(1500000/((val) << 8 | (low)))

TODO

> /*
>  * Functions declaration
>  */
>=20
> static int f75387_attach_adapter(struct i2c_adapter *adapter);
> static int f75387_detect(struct i2c_adapter *adapter, int address,
> 	int kind);
> static void f75387_init_client(struct i2c_client *client);
> static int f75387_detach_client(struct i2c_client *client);
> static struct f75387_data *f75387_update_device(struct device *dev);
>=20
> /*
>  * Driver data (common to all clients)
>  */
>=20
> static struct i2c_driver f75387_driver =3D {
> 	.driver =3D {
> 		.name	=3D "f75387",
> 	},
> 	.id		=3D I2C_DRIVERID_F75387,
> 	.attach_adapter	=3D f75387_attach_adapter,
> 	.detach_client	=3D f75387_detach_client,
> };
>=20
> /*
>  * Client data (each client gets its own)
>  */
>=20
> struct f75387_data {
> 	struct i2c_client client;
> 	struct class_device *class_dev;
> 	struct mutex update_lock;
> 	char valid; /* zero until following fields are valid */
> 	unsigned long last_updated; /* in jiffies */
> 	int kind;
>=20
> 	/* registers values */
> 	u8 config[4];
>=20
> 	u8 in[4];
> 	u8 in_min[4];
> 	u8 in_max[4];
>=20
> 	u8 temph[3];
> 	u8 templ[3];
> 	u8 temp_max[3];
> 	u8 temp_hyst[3];
>=20
> 	u8 fanh[2];
> 	u8 fanl[2];
>=20
> };
>=20
> /*
>  * Sysfs stuff
>  */
>=20
> static ssize_t show_in(struct device *dev, struct device_attribute *devat=
tr, char *buf)
> {
> 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> 	struct f75387_data *data =3D f75387_update_device(dev);
> 	return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in[attr->index]));
> }
>=20
> static ssize_t show_in_min(struct device *dev, struct device_attribute *d=
evattr, char *buf)
> {
> 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> 	struct f75387_data *data =3D f75387_update_device(dev);
> 	return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in_min[attr->index]));
> }
>=20
> static ssize_t show_in_max(struct device *dev, struct device_attribute *d=
evattr, char *buf)
> {
> 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> 	struct f75387_data *data =3D f75387_update_device(dev);
> 	return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in_max[attr->index]));
> }
>=20
> static ssize_t show_temp(struct device *dev, struct device_attribute *dev=
attr, char *buf)
> {
> 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> 	struct f75387_data *data =3D f75387_update_device(dev);
> 	return sprintf(buf, "%d\n", TEMP_FROM_REG2(data->temph[attr->index], dat=
a->templ[attr->index]));
> }
>=20
> static ssize_t show_temp_max(struct device *dev, struct device_attribute =
*devattr, char *buf)
> {
> 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> 	struct f75387_data *data =3D f75387_update_device(dev);
> 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index]));
> }
>=20
> static ssize_t show_temp_hyst(struct device *dev, struct device_attribute=
 *devattr, char *buf)
> {
> 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> 	struct f75387_data *data =3D f75387_update_device(dev);
> 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst[attr->index]));
> }
>=20
> static ssize_t show_rpm(struct device *dev, struct device_attribute *deva=
ttr, char *buf)
> {
> 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> 	struct f75387_data *data =3D f75387_update_device(dev);
> 	return sprintf(buf, "%d\n", RPM_FROM_REG2(data->fanh[attr->index], data-=
>fanl[attr->index]));
> }
> static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
> static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
> static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
> static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
>=20
> static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO, show_in_min, NULL, 0);
> static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO, show_in_min, NULL, 1);
> static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO, show_in_min, NULL, 2);
> static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO, show_in_min, NULL, 3);
>=20
> static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO, show_in_max, NULL, 0);
> static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO, show_in_max, NULL, 1);
> static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO, show_in_max, NULL, 2);
> static SENSOR_DEVICE_ATTR(in3_max, S_IRUGO, show_in_max, NULL, 3);
>=20
> static SENSOR_DEVICE_ATTR(temp0_input, S_IRUGO, show_temp, NULL, 0);
> static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 1);
> static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 2);
>=20
> static SENSOR_DEVICE_ATTR(temp0_max, S_IRUGO, show_temp_max, NULL, 0);
> static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 1);
> static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 2);
>=20
> static SENSOR_DEVICE_ATTR(temp0_hyst, S_IRUGO, show_temp_hyst, NULL, 0);
> static SENSOR_DEVICE_ATTR(temp1_hyst, S_IRUGO, show_temp_hyst, NULL, 1);
> static SENSOR_DEVICE_ATTR(temp2_hyst, S_IRUGO, show_temp_hyst, NULL, 2);
>=20
> static SENSOR_DEVICE_ATTR(fan0_input, S_IRUGO, show_rpm, NULL, 0);
> static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_rpm, NULL, 1);
>=20
>=20
> /*
>  * Real code
>  */
>=20
> /* It is assumed that client->update_lock is held (unless we are in
>    detection or initialization steps). This matters when PEC is enabled,
>    because we don't want the address pointer to change between the write
>    byte and the read byte transactions. */
> static int f75387_read_reg(struct i2c_client* client, u8 reg, u8 *value)
> {
> 	int err =3D i2c_smbus_read_byte_data(client, reg);
>=20
> 	if (err < 0) {
> 		dev_warn(&client->dev, "Register %#02x read failed (%d)\n",
> 			 reg, err);
> 		return err;
> 	}
> 	*value =3D err;
>=20
> 	return 0;
> }
>=20
>=20
> static int f75387_read_reg2(struct i2c_client* client, u8 reg, u16 *value)

This should have more meaningful name.

> {
> 	int err =3D i2c_smbus_read_byte_data(client, reg);
> 	if (err >=3D 0) {
> 		*value =3D err << 8;
> 		err =3D i2c_smbus_read_byte_data(client, ++reg);
> 	}
> 	if (err >=3D 0) {
> 		*value |=3D err;

I would sugegst & 0x ff;
Also perhaps would be nicer to have temp variable and update the output jus=
t once.


> 	} else {
> 		dev_warn(&client->dev, "Register %#02x read failed (%d)\n",
> 			 reg, err);
> 		return err;
> 	}
>=20
> 	return 0;
> }
>=20
>=20
> static int f75387_attach_adapter(struct i2c_adapter *adapter)
> {
> 	if (!(adapter->class & I2C_CLASS_HWMON))
> 		return 0;
> 	return i2c_probe(adapter, &addr_data, f75387_detect);
> }
>=20
> /*
>  * The following function does more than just detection. If detection
>  * succeeds, it also registers the new chip.
>  */
> static int f75387_detect(struct i2c_adapter *adapter, int address, int ki=
nd)
> {
> 	struct i2c_client *new_client;
> 	struct f75387_data *data;
> 	int err =3D 0;
> 	const char *name =3D "";
>=20
> 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> 		goto exit;
>=20
> 	if (!(data =3D kzalloc(sizeof(struct f75387_data), GFP_KERNEL))) {
> 		err =3D -ENOMEM;
> 		goto exit;
> 	}
>=20
> 	/* The common I2C client data is placed right before the
> 	   F75387-specific data. */
> 	new_client =3D &data->client;
> 	i2c_set_clientdata(new_client, data);
> 	new_client->addr =3D address;
> 	new_client->adapter =3D adapter;
> 	new_client->driver =3D &f75387_driver;
> 	new_client->flags =3D 0;
>=20
> 	/*
> 	 * Now we do the remaining detection. A negative kind means that
> 	 * the driver was loaded with no force parameter (default), so we
> 	 * must both detect and identify the chip. A zero kind means that
> 	 * the driver was loaded with the force parameter, the detection
> 	 * step shall be skipped. A positive kind means that the driver
> 	 * was loaded with the force parameter and a given kind of chip is
> 	 * requested, so both the detection and the identification steps
> 	 * are skipped.
> 	 */
>=20
> 	/* Default to an F75387 if forced */
> 	if (kind =3D 0)
> 		kind =3D f75387;
>=20
> 	if (kind < 0) { /* detection and identification */
> 		u16 man_id, chip_id;
>=20
> 		if (f75387_read_reg2(new_client, F75387_REG_R_MANU_ID, &man_id ) < 0 ||
> 		    f75387_read_reg2(new_client, F75387_REG_R_CHIP_ID, &chip_id) < 0)
> 			goto exit_free;
> 	=09
> 		switch (man_id) {
> 		case MANU_ID_FINTEK:		/* Fintek */
> 			switch (chip_id) {
> 			case CHIP_ID_F75387:	/* F73587 */
> 				kind =3D f75387;
> 				break;
> 			default:
> 				break;
> 			}
> 		default:
> 			break;


Hmm is there some compatible not yet supported chip? Maybe we dont need the=
 case=20
just with one member.

> 		}
> 		if (kind <=3D 0) { /* identification failed */
> 			dev_info(&adapter->dev,
> 			    "Unsupported chip (man_id=3D0x%04X, "
> 			    "chip_id=3D0x%04X).\n", man_id, chip_id);
> 			goto exit_free;
> 		}
> 	}
>=20
> 	if (kind =3D f75387) {
> 		name =3D "f75387";
> 	}=20
>=20
> 	/* We can fill in the remaining client fields */
> 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> 	data->valid =3D 0;
> 	data->kind =3D kind;
> 	mutex_init(&data->update_lock);
>=20
> 	/* Tell the I2C layer a new client has arrived */
> 	if ((err =3D i2c_attach_client(new_client)))
> 		goto exit_free;
>=20
> 	/* Initialize the F75387 chip */
> 	f75387_init_client(new_client);
>=20
> 	/* Register sysfs hooks */
> 	data->class_dev =3D hwmon_device_register(&new_client->dev);
> 	if (IS_ERR(data->class_dev)) {
> 		err =3D PTR_ERR(data->class_dev);
> 		goto exit_detach;
> 	}

We should register AFTER we created the files


Those file lines could be merged to one, and also tested for the return val=
ue.=20
Please check the=20
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blobdiff;hN108262576fa9bcf7887b94a21225d14d013d50;hpu76ec9426a35b0e733d08f5=
552058aa67e9cd73;hb=F52f79da2908796a0fa1e7bbbe0d5ff20183d75f;f=3Ddrivers/hw=
mon/w83792d.c

patch for details.

> 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr=
);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr=
);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr=
);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr=
);
>=20
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
>=20
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
>=20
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp0_input.dev_at=
tr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_at=
tr);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_at=
tr);
>=20
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp0_max.dev_attr=
);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr=
);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr=
);
>=20
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp0_hyst.dev_att=
r);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_hyst.dev_att=
r);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_hyst.dev_att=
r);
>=20
> 	device_create_file(&new_client->dev, &sensor_dev_attr_fan0_input.dev_att=
r);
> 	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_att=
r);


This all lines will disappear.
> 	return 0;
>=20
> exit_detach:
> 	i2c_detach_client(new_client);
> exit_free:
> 	kfree(data);
> exit:
> 	return err;
> }
>=20
> static void f75387_init_client(struct i2c_client *client)
> {
> /*
>  *	Chip specific initialization should go here.
>  */
> }
>=20
> static int f75387_detach_client(struct i2c_client *client)
> {
> 	struct f75387_data *data =3D i2c_get_clientdata(client);
> 	int err;
>=20
> 	hwmon_device_unregister(data->class_dev);
>=20
> 	if ((err =3D i2c_detach_client(client)))
> 		return err;
>=20
> 	kfree(data);
> 	return 0;
> }
>=20
> static struct f75387_data *f75387_update_device(struct device *dev)
> {
> 	struct i2c_client *client =3D to_i2c_client(dev);
> 	struct f75387_data *data =3D i2c_get_clientdata(client);
>=20
> 	mutex_lock(&data->update_lock);
>=20
> 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
>=20
> 		dev_dbg(&client->dev, "Updating f75387 data.\n");
>=20
> /*
>  * The sequence is important here! Read the *_MSB first, then the *_LSB.
>  */
> 		f75387_read_reg(client, F75387_REG_W_CONFIG0, &data->config[0]);
> 		f75387_read_reg(client, F75387_REG_W_CONFIG1, &data->config[1]);
> 		f75387_read_reg(client, F75387_REG_W_CONFIG2, &data->config[2]);
> 		f75387_read_reg(client, F75387_REG_W_CONFIG3, &data->config[3]);

Dont read when you dont need.

> 		f75387_read_reg(client, F75387_REG_R_V0, &data->in[0]);
> 		f75387_read_reg(client, F75387_REG_R_V1, &data->in[1]);
> 		f75387_read_reg(client, F75387_REG_R_V2, &data->in[2]);
> 		f75387_read_reg(client, F75387_REG_R_V3, &data->in[3]);
>=20
> 		f75387_read_reg(client, F75387_REG_W_V0_MAX, &data->in_max[0]);
> 		f75387_read_reg(client, F75387_REG_W_V1_MAX, &data->in_max[1]);
> 		f75387_read_reg(client, F75387_REG_W_V2_MAX, &data->in_max[2]);
> 		f75387_read_reg(client, F75387_REG_W_V3_MAX, &data->in_max[3]);
>=20
> 		f75387_read_reg(client, F75387_REG_W_V0_MIN, &data->in_min[0]);
> 		f75387_read_reg(client, F75387_REG_W_V1_MIN, &data->in_min[1]);
> 		f75387_read_reg(client, F75387_REG_W_V2_MIN, &data->in_min[2]);
> 		f75387_read_reg(client, F75387_REG_W_V3_MIN, &data->in_min[3]);

Maybe for cycle with three lines will do it better. if the register mapping=
 is=20
problem (or the mapping cannot be easily computed, please check the w83792d=
=20
driver how it maps the arrays of REG addresses.

>=20
> 		f75387_read_reg(client, F75387_REG_R_TEMP0_MSB, &data->temph[0]);
> 		f75387_read_reg(client, F75387_REG_R_TEMP0_LSB, &data->templ[0]);
>=20
> 		f75387_read_reg(client, F75387_REG_R_TEMP1_MSB, &data->temph[1]);
> 		f75387_read_reg(client, F75387_REG_R_TEMP1_LSB, &data->templ[1]);
>=20
> 		f75387_read_reg(client, F75387_REG_R_TEMP2_MSB, &data->temph[2]);
> 		f75387_read_reg(client, F75387_REG_R_TEMP2_LSB, &data->templ[2]);
>=20
> 		f75387_read_reg(client, F75387_REG_W_TEMP0_MAX, &data->temp_max[0]);
> 		f75387_read_reg(client, F75387_REG_W_TEMP1_MAX, &data->temp_max[1]);
> 		f75387_read_reg(client, F75387_REG_W_TEMP2_MAX, &data->temp_max[2]);
>=20
> 		f75387_read_reg(client, F75387_REG_W_TEMP0_HYST, &data->temp_hyst[0]);
> 		f75387_read_reg(client, F75387_REG_W_TEMP1_HYST, &data->temp_hyst[1]);
> 		f75387_read_reg(client, F75387_REG_W_TEMP2_HYST, &data->temp_hyst[2]);
>=20
> 		f75387_read_reg(client, F75387_REG_R_FAN0_MSB, &data->fanh[0]);
> 		f75387_read_reg(client, F75387_REG_R_FAN0_LSB, &data->fanl[0]);
>=20
> 		f75387_read_reg(client, F75387_REG_R_FAN1_MSB, &data->fanh[1]);
> 		f75387_read_reg(client, F75387_REG_R_FAN1_LSB, &data->fanl[1]);
>=20
> 		data->last_updated =3D jiffies;
> 		data->valid =3D 1;
> 	}
>=20
> 	mutex_unlock(&data->update_lock);
>=20
> 	return data;
> }
>=20
> static int __init sensors_f75387_init(void)
> {
> 	return i2c_add_driver(&f75387_driver);
> }
>=20
> static void __exit sensors_f75387_exit(void)
> {
> 	i2c_del_driver(&f75387_driver);
> }
>=20
> MODULE_AUTHOR("Harald Dunkel <harald.dunkel at t-online.de>");
> MODULE_DESCRIPTION("F75387 driver");
> MODULE_LICENSE("GPL");
>=20
> module_init(sensors_f75387_init);
> module_exit(sensors_f75387_exit);

