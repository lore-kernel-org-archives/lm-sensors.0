From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 01 Jun 2005 17:27:20 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4] PCA9539 - new driver
Message-Id: <429DD3C1.5050005@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I will add some coments into code.


> diff -uEbBN linux-2.6.12-rc4-clean/drivers/i2c/chips/Kconfig linux-2.6.12-rc4-pca9539/drivers/i2c/chips/Kconfig
> --- linux-2.6.12-rc4-clean/drivers/i2c/chips/Kconfig	2005-05-10 09:46:20.000000000 -0500
> +++ linux-2.6.12-rc4-pca9539/drivers/i2c/chips/Kconfig	2005-05-31 08:57:58.053027480 -0500

I think we would like to have patch against -mm- series of kernel. Please note that sysfs interface
changed a bit and you need to add one parameter

-static ssize_t show_xxx(struct device * dev, char * buf)
+static ssize_t show_xxx(struct device * dev, struct device_attribute *attr, char * buf)

Related info: http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012251.html

> @@ -440,4 +440,14 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called m41t00.
>  
> +config SENSORS_PCA9539
> +	tristate "PCA9539 16-bit digital IO"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the PCA9539
> +	  low power digital I/O with 16 bit.
> +          
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called pca9539.
> +
>  endmenu
> diff -uEbBN linux-2.6.12-rc4-clean/drivers/i2c/chips/Makefile linux-2.6.12-rc4-pca9539/drivers/i2c/chips/Makefile
> --- linux-2.6.12-rc4-clean/drivers/i2c/chips/Makefile	2005-05-10 09:46:20.000000000 -0500
> +++ linux-2.6.12-rc4-pca9539/drivers/i2c/chips/Makefile	2005-05-31 08:57:34.000000000 -0500
> @@ -41,6 +41,7 @@
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>  obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
>  obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
> +obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o

why not alphabetically? I think PCF8574 also is. Any other here around some other oppinion?

>  ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff -uEbBN linux-2.6.12-rc4-clean/drivers/i2c/chips/pca9539.c linux-2.6.12-rc4-pca9539/drivers/i2c/chips/pca9539.c
> --- linux-2.6.12-rc4-clean/drivers/i2c/chips/pca9539.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.12-rc4-pca9539/drivers/i2c/chips/pca9539.c	2005-05-31 08:53:38.000000000 -0500
> @@ -0,0 +1,203 @@
> +/*
> +    pca9539.c - 16 port digital I/O with interrupt and reset
> +    
> +    Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; version 2 of the License.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-sensor.h>
> +
> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = { 0x74, 0x75, 0x76, 0x77, I2C_CLIENT_END };
> +static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
> +
> +/* Insmod parameters */
> +SENSORS_INSMOD_1(pca9539);
> +
> +enum pca9539_cmd
> +{
> +	PCA9539_INPUT_0 = 0,
> +	PCA9539_INPUT_1 = 1,
> +	PCA9539_OUTPUT_0 = 2,
> +	PCA9539_OUTPUT_1 = 3,
> +	PCA9539_INVERT_0 = 4,
> +	PCA9539_INVERT_1 = 5,
> +	PCA9539_CONFIG_0 = 6,
> +	PCA9539_CONFIG_1 = 7
> +};
> +
> +struct pca9539_data {
> +	struct i2c_client client;
> +	struct semaphore  update_lock;
> +};
> +
> +static int pca9539_attach_adapter(struct i2c_adapter *adapter);
> +static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind);
> +static int pca9539_detach_client(struct i2c_client *client);
> +
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver pca9539_driver = {
> +	.owner		= THIS_MODULE,
> +	.name		= "pca9539",
> +	.flags		= I2C_DF_NOTIFY,
> +	.attach_adapter	= pca9539_attach_adapter,
> +	.detach_client	= pca9539_detach_client,
> +};
> +
> +static void pca9539_store_reg(struct device *dev, const char *buf, 
> +			      enum pca9539_cmd cmd)
> +{
> +	struct pca9539_data *data = i2c_get_clientdata(to_i2c_client(dev));
> +	u8 val = simple_strtoul(buf, NULL, 0);
> +	i2c_smbus_write_byte_data(&data->client, cmd, val);
> +}
> +
> +static ssize_t pca9539_show_reg(struct device *dev, char *buf, enum pca9539_cmd cmd)
> +{
> +	struct pca9539_data *data = i2c_get_clientdata(to_i2c_client(dev));
> +	return sprintf(buf, "%d\n", i2c_smbus_read_byte_data(&data->client, cmd));
> +}
> +
> +/* following are the sysfs callback functions */
> +#define show_data(enum_name)						\
> +static ssize_t show_##enum_name(struct device *dev, char *buf)		\

I think this place needs to change, see above.

> +{									\
> +	return pca9539_show_reg(dev, buf, enum_name);			\
> +}
> +
> +show_data(PCA9539_INPUT_0);
> +show_data(PCA9539_INPUT_1);
> +show_data(PCA9539_OUTPUT_0);
> +show_data(PCA9539_OUTPUT_1);
> +show_data(PCA9539_INVERT_0);
> +show_data(PCA9539_INVERT_1);
> +show_data(PCA9539_CONFIG_0);
> +show_data(PCA9539_CONFIG_1);
> +
> +#define store_data(enum_name)						\
> +static ssize_t store_##enum_name(struct device *dev, const char *buf, size_t count) \
and here too.
> +{									\
> +	pca9539_store_reg(dev, buf, enum_name);				\
> +	return count;							\
> +}
> +
> +store_data(PCA9539_OUTPUT_0);
> +store_data(PCA9539_OUTPUT_1);
> +store_data(PCA9539_INVERT_0);
> +store_data(PCA9539_INVERT_1);
> +store_data(PCA9539_CONFIG_0);
> +store_data(PCA9539_CONFIG_1);
> +
> +/* Define the device attributes */
> +#define my_rw_attr(name,enum_name) \
> +static DEVICE_ATTR(name,S_IRUGO|S_IWUGO,show_##enum_name,store_##enum_name)
> +
> +#define my_ro_attr(name,enum_name) \
> +static DEVICE_ATTR(name,S_IRUGO,show_##enum_name,NULL)
> +
> +my_ro_attr(input0,  PCA9539_INPUT_0);
> +my_ro_attr(input1,  PCA9539_INPUT_1);
> +my_rw_attr(output0, PCA9539_OUTPUT_0);
> +my_rw_attr(output1, PCA9539_OUTPUT_1);
> +my_rw_attr(invert0, PCA9539_INVERT_0);
> +my_rw_attr(invert1, PCA9539_INVERT_1);
> +my_rw_attr(config0, PCA9539_CONFIG_0);
> +my_rw_attr(config1, PCA9539_CONFIG_1);

Question is if the name chosen are OK? We have PCF8574 driver and it has "read" and "write" names instead of input output.
Please can other members say something to this?

> +static int pca9539_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	return i2c_detect(adapter, &addr_data, pca9539_detect);
> +}
> +
> +/* This function is called by i2c_detect */
> +static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	struct i2c_client *new_client;
> +	struct pca9539_data *data;
> +	int err = 0;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
> +				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_READ_BYTE_DATA))
> +		goto exit;
> +
> +	/* OK. For now, we presume we have a valid client. We now create the
> +	   client structure, even though we cannot fill it completely yet. */
> +	if (!(data = kmalloc(sizeof(struct pca9539_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +	memset(data, 0, sizeof(struct pca9539_data));
> +	
> +	new_client = &data->client;
> +	i2c_set_clientdata(new_client, data);
> +	new_client->addr = address;
> +	new_client->adapter = adapter;
> +	new_client->driver = &pca9539_driver;
> +	new_client->flags = 0;
> +
> +	/* Detection: not sure how to do that... 
> +	 * possibility: toggle the value read from invert0 and see if input0
> +	 * changes polarity.
> +	 */

I can try to help you with this a bit.
Please can you use i2cdump to dump chip registers?

We can try to look what are the values of non-existing registers like:
1) last valid register read
2) zero
3) ff
4) aliased so reg0 is same value as reg8 etc
5) good would be to check what is read from 0x3e 0x3f 0xfe 0xff regs
   because this are often used for manufacturers id and if there is 0x0 or 0xff it will help.



> +	strlcpy(new_client->name, "pca9539", I2C_NAME_SIZE);
> +
> +	/* Tell the I2C layer a new client has arrived */
> +	if ((err = i2c_attach_client(new_client)))
> +		goto exit_kfree;
> +
> +	/* Register sysfs hooks */
> +	device_create_file(&new_client->dev, &dev_attr_input0);
> +	device_create_file(&new_client->dev, &dev_attr_input1);
> +	device_create_file(&new_client->dev, &dev_attr_output0);
> +	device_create_file(&new_client->dev, &dev_attr_output1);
> +	device_create_file(&new_client->dev, &dev_attr_invert0);
> +	device_create_file(&new_client->dev, &dev_attr_invert1);
> +	device_create_file(&new_client->dev, &dev_attr_config0);
> +	device_create_file(&new_client->dev, &dev_attr_config1);
> +	return 0;

If you would read more about sysfs changes newer "size sparing" method of sysfs entries exists.
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012265.html
So if you want to save some bytes of kernel memory you can change it.

> +
> +exit_kfree:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int pca9539_detach_client(struct i2c_client *client)
> +{
> +	int err;
> +
> +	if ((err = i2c_detach_client(client))) {
> +		dev_err(&client->dev,
> +			"Client deregistration failed, client not detached.\n");
> +		return err;
> +	}
> +
> +	kfree(i2c_get_clientdata(client));
> +	return 0;
> +}
> +
> +static int __init pca9539_init(void)
> +{
> +	return i2c_add_driver(&pca9539_driver);
> +}
> +
> +static void __exit pca9539_exit(void)
> +{
> +	i2c_del_driver(&pca9539_driver);
> +}
> +
> +MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
> +MODULE_DESCRIPTION("PCA9539 driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(pca9539_init);
> +module_exit(pca9539_exit);
