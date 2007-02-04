From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 04 Feb 2007 18:49:08 +0000
Subject: [lm-sensors] new module for MAX1668, MAX1805, MAX1989
Message-Id: <45C62AA4.3090803@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Christoph,

Please can you post updated version of your driver?
(with the Kconfig patch + documentation patch if possible)

> It would be good if somebody with a MAX1668 or a MAX1989 could also test =
the
> module and the patch to sensors-detect (relative to SVN HEAD).

I will just do very brief review. You also may run indent -kr -i8 yourfile.=
c to
format it.

 /*
>     max1668.c - Part of lm_sensors, Linux kernel modules for hardware
>              monitoring

Just skip Part of lm_sensors

>     Copyright (c) 2006 Christoph Scheurer <christoph.scheurer at web.de>
>=20
>     based on adm1021.c
>=20
>     This program is free software; you can redistribute it and/or modify
>     it under the terms of the GNU General Public License as published by
>     the Free Software Foundation; either version 2 of the License, or
>     (at your option) any later version.
>=20
>     This program is distributed in the hope that it will be useful,
>     but WITHOUT ANY WARRANTY; without even the implied warranty of
>     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>     GNU General Public License for more details.
>=20
>     You should have received a copy of the GNU General Public License
>     along with this program; if not, write to the Free Software
>     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> */
>=20
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/slab.h>
> #include <linux/jiffies.h>
> #include <linux/i2c.h>
> #include <linux/hwmon.h>
> #include <linux/err.h>
>=20
> /* debugging */
> static int i2c_debug =3D 0;
> module_param(i2c_debug, int, 0);
> #define DEBE(x)  printk(KERN_DEBUG "max1668: " x )
> #define DEB1(x)  if (i2c_debug>=3D1) printk(KERN_DEBUG "max1668: " x )
> #define DEB2(x)  if (i2c_debug>=3D2) printk(KERN_DEBUG "max1668: " x )
> #define DEB3(x)  if (i2c_debug>=3D3) printk(KERN_DEBUG "max1668: " x )

Check how others do the debugging via the dev_dbg

>=20
> /* have to get a read id in i2c-id.h */
> #define I2C_DRIVERID_MAX1668 I2C_DRIVERID_ADM1021
>=20

Drop this

> /* Addresses to scan */
> static unsigned short normal_i2c[] =3D {  0x18, 0x19, 0x20,
>                                         0x29, 0x2a, 0x2b,
>                                         0x4c, 0x4d, 0x4e,=20
>                                         I2C_CLIENT_END };

You have it wrong here. My datasheet says that instead of 0x20 there is 0x1=
A.

>=20
> /* Insmod parameters */
> I2C_CLIENT_INSMOD_3(max1668, max1989, max1805);
>=20
> /* max1805 does not have REMOTE3 and REMOTE4 */
>=20
> /* max1668 constants specified below */
>=20
> /* The max1668 registers */
> /* Read-only */
> #define MAX1668_REG_TEMP                0x00
> #define MAX1668_REG_REMOTE1_TEMP        0x01
> #define MAX1668_REG_REMOTE2_TEMP        0x02
> #define MAX1668_REG_REMOTE3_TEMP        0x03
> #define MAX1668_REG_REMOTE4_TEMP        0x04
> #define MAX1668_REG_STATUS1             0x05
> #define MAX1668_REG_STATUS2             0x06
> #define MAX1668_REG_MAN_ID              0xfe   /* 0x4d =3D Maxim */
> #define MAX1668_REG_DEV_ID              0xff   /* MAX1668 =3D 0x03, MAX18=
05 =3D 0x05, MAX1989 =3D 0x0b */
> /* These use different addresses for reading/writing */
> #define MAX1668_REG_CONFIG_R            0x07
> #define MAX1668_REG_CONFIG_W            0x12
> /* limits */
> #define MAX1668_REG_HI_R                0x08
> #define MAX1668_REG_LO_R                0x09
> #define MAX1668_REG_REMOTE1_HI_R        0x0a
> #define MAX1668_REG_REMOTE1_LO_R        0x0b
> #define MAX1668_REG_REMOTE2_HI_R        0x0c
> #define MAX1668_REG_REMOTE2_LO_R        0x0d
> #define MAX1668_REG_REMOTE3_HI_R        0x0e
> #define MAX1668_REG_REMOTE3_LO_R        0x0f
> #define MAX1668_REG_REMOTE4_HI_R        0x10
> #define MAX1668_REG_REMOTE4_LO_R        0x11
> #define MAX1668_REG_HI_W                0x13
> #define MAX1668_REG_LO_W                0x14
> #define MAX1668_REG_REMOTE1_HI_W        0x15
> #define MAX1668_REG_REMOTE1_LO_W        0x16
> #define MAX1668_REG_REMOTE2_HI_W        0x17
> #define MAX1668_REG_REMOTE2_LO_W        0x18
> #define MAX1668_REG_REMOTE3_HI_W        0x19
> #define MAX1668_REG_REMOTE3_LO_W        0x1a
> #define MAX1668_REG_REMOTE4_HI_W        0x1b
> #define MAX1668_REG_REMOTE4_LO_W        0x1c
>=20
>=20
> /* Conversions. Rounding and limit checking is only done on the TO_REG
>    variants. Note that you should be a bit careful with which arguments
>    these macros are called: arguments may be evaluated more than once.
>    Fixing this is just not worth it. */
> /* Range: -127 to +127 Celsius as 7 bits with sign in two's complement fo=
rm
>    with each bit representing 1 degree, MSB first. Measurements are offse=
t by
>    0.5 degrees to minimize internal rounding errors. */
> #define TEMP_FROM_REG(val)      (val > 127 ? (val-256)*1000 : val*1000)
> #define TEMP_TO_REG(val)        (SENSORS_LIMIT((val < 0 ? (val/1000)+256 =
: val/1000),0,255))
>=20
> /* Initial values */
>=20
> /* Each client has this additional data */
> struct max1668_data {
>         struct i2c_client client;
>         struct class_device *class_dev;
>         enum chips type;
>=20
>         struct semaphore update_lock;

Convert semaphore to mutex please

>         char valid;             /* !=3D0 if following fields are valid */
>         unsigned long last_updated;     /* In jiffies */
>=20
>         u8      temp_max;       /* Register values */
>         u8      temp_low;
>         u8      temp_input;
>         u8      remote1_temp_max;
>         u8      remote1_temp_low;
>         u8      remote1_temp_input;
>         u8      remote2_temp_max;
>         u8      remote2_temp_low;
>         u8      remote2_temp_input;
>         u8      remote3_temp_max;
>         u8      remote3_temp_low;
>         u8      remote3_temp_input;
>         u8      remote4_temp_max;
>         u8      remote4_temp_low;
>         u8      remote4_temp_input;

uhm maybe better would be to have the remote_temp[3][3]
first index is the temp second is the max/min/input? (check other drivers h=
ow
they do that)


If you do that this way, you may use the SENSORS_ATTR_2 macro to make it ve=
ry
easy (check w83793 or w83792 driver for that)

>         u8      alarms1;
>         u8      alarms2;
> };
>=20
> static int max1668_attach_adapter(struct i2c_adapter *adapter);
> static int max1668_detect(struct i2c_adapter *adapter, int address, int k=
ind);
> static void max1668_init_client(struct i2c_client *client);
> static int max1668_detach_client(struct i2c_client *client);
> static int max1668_read_value(struct i2c_client *client, u8 reg);
> static int max1668_write_value(struct i2c_client *client, u8 reg,
>                                u16 value);
> static struct max1668_data *max1668_update_device(struct device *dev);
>=20
> /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
> static int read_only;
>=20
>=20
> /* This is the driver that will be inserted */
> static struct i2c_driver max1668_driver =3D {
>         .driver =3D {
>                 .name   =3D "max1668",
>         },
>         .id             =3D I2C_DRIVERID_MAX1668,
drop this
>         .attach_adapter =3D max1668_attach_adapter,
>         .detach_client  =3D max1668_detach_client,
> };
>=20
> #define show(value)     \
> static ssize_t show_##value(struct device *dev, struct device_attribute *=
attr, char *buf)               \
> {                                                                       \
>         struct max1668_data *data =3D max1668_update_device(dev);        =
 \
>         return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));        \
> }
> show(temp_max);
> show(temp_low);
> show(temp_input);
> show(remote1_temp_max);
> show(remote1_temp_low);
> show(remote1_temp_input);
> show(remote2_temp_max);
> show(remote2_temp_low);
> show(remote2_temp_input);
> show(remote3_temp_max);
> show(remote3_temp_low);
> show(remote3_temp_input);
> show(remote4_temp_max);
> show(remote4_temp_low);
> show(remote4_temp_input);
>=20
> #define show2(value)    \
> static ssize_t show_##value(struct device *dev, struct device_attribute *=
attr, char *buf)               \
> {                                                                       \
>         struct max1668_data *data =3D max1668_update_device(dev);        =
 \
>         return sprintf(buf, "%d\n", data->value);                       \
> }
> show2(alarms1);
> show2(alarms2);

We have now per temp channel alarms. like temp1_alarm for example. CHeck the
recent kernel drivers/patches or ask for help.

>=20
> #define set(value, reg) \
> static ssize_t set_##value(struct device *dev, struct device_attribute *a=
ttr, const char *buf, size_t count)    \
> {                                                               \
>         struct i2c_client *client =3D to_i2c_client(dev);         \
>         struct max1668_data *data =3D i2c_get_clientdata(client); \
>         int temp =3D simple_strtoul(buf, NULL, 10);               \
>                                                                 \
>         down(&data->update_lock);                               \
>         data->value =3D TEMP_TO_REG(temp);                        \
>         max1668_write_value(client, reg, data->value);          \
>         up(&data->update_lock);                                 \
>         return count;                                           \
> }
> set(temp_max, MAX1668_REG_HI_W);
> set(temp_low, MAX1668_REG_LO_W);
> set(remote1_temp_max, MAX1668_REG_REMOTE1_HI_W);
> set(remote1_temp_low, MAX1668_REG_REMOTE1_LO_W);
> set(remote2_temp_max, MAX1668_REG_REMOTE2_HI_W);
> set(remote2_temp_low, MAX1668_REG_REMOTE2_LO_W);
> set(remote3_temp_max, MAX1668_REG_REMOTE3_HI_W);
> set(remote3_temp_low, MAX1668_REG_REMOTE3_LO_W);
> set(remote4_temp_max, MAX1668_REG_REMOTE4_HI_W);
> set(remote4_temp_low, MAX1668_REG_REMOTE4_LO_W);
>=20
> static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_max, set_remote=
4_temp_max);
> static DEVICE_ATTR(temp_min, S_IWUSR | S_IRUGO, show_temp_low, set_remote=
4_temp_low);
> static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
> static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_remote1_temp_max, s=
et_temp_max);
> static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_remote1_temp_low, s=
et_temp_low);
> static DEVICE_ATTR(temp1_input, S_IRUGO, show_remote1_temp_input, NULL);
> static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_remote2_temp_max, s=
et_remote1_temp_max);
> static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote2_temp_low, s=
et_remote1_temp_low);
> static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote2_temp_input, NULL);
> static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_remote3_temp_max, s=
et_remote2_temp_max);
> static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_remote3_temp_low, s=
et_remote2_temp_low);
> static DEVICE_ATTR(temp3_input, S_IRUGO, show_remote3_temp_input, NULL);
> static DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_remote4_temp_max, s=
et_remote3_temp_max);
> static DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_remote4_temp_low, s=
et_remote3_temp_low);
> static DEVICE_ATTR(temp4_input, S_IRUGO, show_remote4_temp_input, NULL);
> static DEVICE_ATTR(alarms1, S_IRUGO, show_alarms1, NULL);
> static DEVICE_ATTR(alarms2, S_IRUGO, show_alarms2, NULL);
>=20

If you go for  the SENSOR_ATTR and SENSOR_ATTR_2 stuff you may group it and=
 then
just register it with single call. ( sysfs_create_group as used in w83792)

> static int max1668_attach_adapter(struct i2c_adapter *adapter)
> {
>         if (!(adapter->class & I2C_CLASS_HWMON)) {
>             DEB2("I2C_CLASS_HWMON\n");
>             return 0;

You have here spaces instead of tabs.


>         }
>         return i2c_probe(adapter, &addr_data, max1668_detect);
> }
>=20
> static int max1668_detect(struct i2c_adapter *adapter, int address, int k=
ind)
> {
>         int i;
>         struct i2c_client *new_client;
>         struct max1668_data *data;
>         int err =3D 0;
>         const char *type_name =3D "";
>=20
>         if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>             DEB2("I2C_FUNC_SMBUS_BYTE_DATA\n");
>             goto error0;
>         }
>=20
>         /* OK. For now, we presume we have a valid client. We now create =
the
>            client structure, even though we cannot fill it completely yet.
>            But it allows us to access max1668_{read,write}_value. */
>=20
>         if (!(data =3D kzalloc(sizeof(struct max1668_data), GFP_KERNEL)))=
 {
>             DEB2("out of memory\n");
>             err =3D -ENOMEM;
>             goto error0;
>     }
>=20
>         new_client =3D &data->client;
>         i2c_set_clientdata(new_client, data);
>         new_client->addr =3D address;
>         new_client->adapter =3D adapter;
>         new_client->driver =3D &max1668_driver;
>         new_client->flags =3D 0;

You used kzalloc so you dont need the 0

>=20
>         /* Now, we do the remaining detection. */
>         if (kind < 0) {
>             if (max1668_read_value(new_client, MAX1668_REG_MAN_ID) !=3D 0=
x4d) {
>                 DEB2("not a Maxim device\n");
>                 err =3D -ENODEV;
>                 goto error1;
>             }
>         }
>=20
>         /* Determine the chip type. */
>         if (kind <=3D 0) {
>             i =3D max1668_read_value(new_client, MAX1668_REG_DEV_ID);
>             if (i =3D 0x03) {
>                 kind =3D max1668;
>                 type_name =3D "max1668";
>             } else if (i =3D 0x05) {
>                 kind =3D max1805;
>                 type_name =3D "max1805";
>             } else if (i =3D 0x0b) {
>                 kind =3D max1989;
>                 type_name =3D "max1989";
>             } else {
>                 DEB2("no supported device\n");
>                 goto error1;
>             }
>         }
>=20
>         /* Fill in the remaining client fields and put it into the global=
 list */
>         strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
>         data->type =3D kind;
>         data->valid =3D 0;
>         init_MUTEX(&data->update_lock);
>=20
>         /* Tell the I2C layer a new client has arrived */
>         if ((err =3D i2c_attach_client(new_client))) {
>             DEB2("failed to attach to I2C layer");
>             goto error1;
>         }
>=20
>         /* Initialize the MAX1668 chip */
>         max1668_init_client(new_client);
>=20
>         /* Register sysfs hooks */
>         data->class_dev =3D hwmon_device_register(&new_client->dev);
>         if (IS_ERR(data->class_dev)) {
>                 DEB2("failed to register as hwmon device");
>                 err =3D PTR_ERR(data->class_dev);
>                 goto error2;
>         }
>=20
>         device_create_file(&new_client->dev, &dev_attr_temp_max);
>         device_create_file(&new_client->dev, &dev_attr_temp_min);
>         device_create_file(&new_client->dev, &dev_attr_temp_input);
>         device_create_file(&new_client->dev, &dev_attr_temp1_max);
>         device_create_file(&new_client->dev, &dev_attr_temp1_min);
>         device_create_file(&new_client->dev, &dev_attr_temp1_input);
>         device_create_file(&new_client->dev, &dev_attr_temp2_max);
>         device_create_file(&new_client->dev, &dev_attr_temp2_min);
>         device_create_file(&new_client->dev, &dev_attr_temp2_input);
>         if ((data->type =3D max1668) || (data->type =3D max1989)) {
>             device_create_file(&new_client->dev, &dev_attr_temp3_max);
>             device_create_file(&new_client->dev, &dev_attr_temp3_min);
>             device_create_file(&new_client->dev, &dev_attr_temp3_input);
>             device_create_file(&new_client->dev, &dev_attr_temp4_max);
>             device_create_file(&new_client->dev, &dev_attr_temp4_min);
>             device_create_file(&new_client->dev, &dev_attr_temp4_input);
>         }
>         device_create_file(&new_client->dev, &dev_attr_alarms1);
>         device_create_file(&new_client->dev, &dev_attr_alarms2);
>=20
>         DEB2("loaded successfully");
>=20
>         return 0;
>=20
> error2:
>         i2c_detach_client(new_client);
> error1:
>         kfree(data);
> error0:
>         return err;
> }
>=20
> static void max1668_init_client(struct i2c_client *client)
> {
>         /* enable all interrupts and disable standby mode */
>         max1668_write_value(client, MAX1668_REG_CONFIG_W, 0x00);
> }
>=20
> static int max1668_detach_client(struct i2c_client *client)
> {
>         struct max1668_data *data =3D i2c_get_clientdata(client);
>         int err;
>=20
>         /* mask all interrupts and enter standby mode */
>         max1668_write_value(client, MAX1668_REG_CONFIG_W, 0xC0);
>=20
>         hwmon_device_unregister(data->class_dev);
>=20
>         if ((err =3D i2c_detach_client(client)))
>                 return err;
>=20
>         kfree(data);
>         return 0;
> }
>=20
> /* All registers are byte-sized */
> static int max1668_read_value(struct i2c_client *client, u8 reg)
> {
>         return i2c_smbus_read_byte_data(client, reg);
> }
>=20
> static int max1668_write_value(struct i2c_client *client, u8 reg, u16 val=
ue)
> {
>         if (!read_only)
>                 return i2c_smbus_write_byte_data(client, reg, value);
>         return 0;
> }
>=20
> static struct max1668_data *max1668_update_device(struct device *dev)
> {
>         struct i2c_client *client =3D to_i2c_client(dev);
>         struct max1668_data *data =3D i2c_get_clientdata(client);
>=20
>         down(&data->update_lock);
>=20
>         if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>             || !data->valid) {
>                 dev_dbg(&client->dev, "Starting max1668 update\n");
>=20
>                 data->temp_input =3D max1668_read_value(client, MAX1668_R=
EG_TEMP);
>                 data->temp_max =3D max1668_read_value(client, MAX1668_REG=
_HI_R);
>                 data->temp_low =3D max1668_read_value(client, MAX1668_REG=
_LO_R);
>                 data->remote1_temp_input =3D max1668_read_value(client, M=
AX1668_REG_REMOTE1_TEMP);
>                 data->remote1_temp_max =3D max1668_read_value(client, MAX=
1668_REG_REMOTE1_HI_R);
>                 data->remote1_temp_low =3D max1668_read_value(client, MAX=
1668_REG_REMOTE1_LO_R);
>                 data->remote2_temp_input =3D max1668_read_value(client, M=
AX1668_REG_REMOTE2_TEMP);
>                 data->remote2_temp_max =3D max1668_read_value(client, MAX=
1668_REG_REMOTE2_HI_R);
>                 data->remote2_temp_low =3D max1668_read_value(client, MAX=
1668_REG_REMOTE2_LO_R);
>                 if ((data->type =3D max1668) || (data->type =3D max1989))=
 {
>                     data->remote3_temp_input =3D max1668_read_value(clien=
t, MAX1668_REG_REMOTE3_TEMP);
>                     data->remote3_temp_max =3D max1668_read_value(client,=
 MAX1668_REG_REMOTE3_HI_R);
>                     data->remote3_temp_low =3D max1668_read_value(client,=
 MAX1668_REG_REMOTE3_LO_R);
>                     data->remote4_temp_input =3D max1668_read_value(clien=
t, MAX1668_REG_REMOTE4_TEMP);
>                     data->remote4_temp_max =3D max1668_read_value(client,=
 MAX1668_REG_REMOTE4_HI_R);
>                     data->remote4_temp_low =3D max1668_read_value(client,=
 MAX1668_REG_REMOTE4_LO_R);
>                 }
>                 data->alarms1 =3D max1668_read_value(client, MAX1668_REG_=
STATUS1) & 0x7c;
>                 data->alarms2 =3D max1668_read_value(client, MAX1668_REG_=
STATUS2) & 0x7c;
>                 data->last_updated =3D jiffies;
>                 data->valid =3D 1;
>         }
>=20
>         up(&data->update_lock);
>=20
>         return data;
> }
>=20
> static int __init sensors_max1668_init(void)
> {
>         return i2c_add_driver(&max1668_driver);
> }
>=20
> static void __exit sensors_max1668_exit(void)
> {
>         i2c_del_driver(&max1668_driver);
> }
>=20
> MODULE_AUTHOR ("Christoph Scheurer <christoph.scheurer at web.de>");
> MODULE_DESCRIPTION("max1668 driver");
> MODULE_LICENSE("GPL");
>=20
> module_param(read_only, bool, 0);
> MODULE_PARM_DESC(read_only, "Don't set any values, read only mode");
>=20
> module_init(sensors_max1668_init)
> module_exit(sensors_max1668_exit)
>=20
>=20


To sum it up. Please convert the driver to SENSORS_ATTR and SENSORS_ATTR_2 =
where
possible. Create the per channel alarms please. Use mutexes instead of
semaphores. To register the sysfs groups best would be to use the grouping
function, (you will need two groups because you have there one condition).
Please remove the sysfs file groups on driver unload and also when something
fails. Register the group first, then register with hwmon class.

(http://www2.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblobdiff;f=3Ddrivers/hwmon/w83792d.c;hN108262576fa9bcf7887b94a21225d14d0=
13d50;hpu76ec9426a35b0e733d08f5552058aa67e9cd73;hb=F52f79da2908796a0fa1e7bb=
be0d5ff20183d75f;hpb=CCc5c306957bb7fbaef61de249bac4b0f09f2336)
(http://www2.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblobdiff;f=3Ddrivers/hwmon/f71805f.c;hg8bae43716d079309cf4fa0e6a3630b34e=
015ad;hp=FD72440faf76167e08a22d9409255a70c4dba256;hb-45771e6ea79f56a7d85e44=
8f702f60ef86c228;hpbQbd56339335fad3643739504523190cd6d3416b)

I admit I wrote that in quick, so if you have any detailed questions just a=
sk.

I applied the modified version of sensors-detect patch. Check here:
http://www.lm-sensors.org/changeset/4314

Thanks,

Rudolf



> ------------------------------------------------------------------------
>=20
> --- lm-sensors/prog/detect/sensors-detect.orig	2006-09-22 22:54:34.359156=
000 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2006-09-22 23:12:50.412859000 +=
0200
> @@ -1078,6 +1078,24 @@
>         i2c_detect =3D> sub { adm1021_detect(3, @_); },
>       },
>       {
> +       name =3D> "Maxim MAX1668",
> +       driver =3D> "max1668",
> +       i2c_addrs =3D> [0x18..0x20,0x29..0x2b,0x4c..0x4e],
> +       i2c_detect =3D> sub { max1668_detect(0, @_); },
> +     },
> +     {
> +       name =3D> "Maxim MAX1805",
> +       driver =3D> "max1668",
> +       i2c_addrs =3D> [0x18..0x20,0x29..0x2b,0x4c..0x4e],
> +       i2c_detect =3D> sub { max1668_detect(1, @_); },
> +     },
> +     {
> +       name =3D> "Maxim MAX1989",
> +       driver =3D> "max1668",
> +       i2c_addrs =3D> [0x18..0x20,0x29..0x2b,0x4c..0x4e],
> +       i2c_detect =3D> sub { max1668_detect(2, @_); },
> +     },
> +     {
>         name =3D> "Maxim MAX6650/MAX6651",
>         driver =3D> "max6650",
>         i2c_addrs =3D> [0x1b,0x1f,0x48,0x4b],
> @@ -4255,6 +4273,35 @@
>  }
> =20
>  # $_[0]: Chip to detect
> +#   (0 =3D MAX1668, 1 =3D MAX1805, 2 =3D MAX1989)
> +# $_[1]: A reference to the file descriptor to access this chip.
> +#        We may assume an i2c_set_slave_addr was already done.
> +# $_[2]: Address
> +# Returns: undef if not detected, 7 if detected
> +# Registers used:
> +#   0xfe: Company ID
> +#   0xff: Device ID
> +#   0x05: Status1
> +#   0x06: Status2
> +#   0x07: Configuration
> +sub max1668_detect
> +{
> +  my ($chip, $file, $addr) =3D @_;
> +  my $man_id =3D i2c_smbus_read_byte_data($file, 0xfe);
> +  my $dev_id =3D i2c_smbus_read_byte_data($file, 0xff);
> +  my $status1 =3D i2c_smbus_read_byte_data($file, 0x05);
> +  my $status2 =3D i2c_smbus_read_byte_data($file, 0x06);
> +  my $conf =3D i2c_smbus_read_byte_data($file, 0x07);
> +
> +  return if $man_id !=3D 0x4D;
> +  return if $chip =3D 0 and $dev_id !=3D 0x03;
> +  return if $chip =3D 1 and $dev_id !=3D 0x05;
> +  return if $chip =3D 2 and $dev_id !=3D 0x0b;
> +
> +  return 7;
> +}
> +
> +# $_[0]: Chip to detect
>  #   (0 =3D MAX1619)
>  # $_[1]: A reference to the file descriptor to access this chip.
>  #        We may assume an i2c_set_slave_addr was already done.
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

