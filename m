From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 May 2007 08:35:27 +0000
Subject: Re: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <20070522103527.5c8a21af@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sat, 19 May 2007 17:57:38 -0700, David Hubbard wrote:
> > On Thu, 29 Mar 2007 12:13:29 -0700, David Hubbard wrote:
> > > -static int w83627ehf_detach_client(struct i2c_client *client)
> > > +static int __devexit w83627ehf_remove(struct platform_device *pdev)
> > >  {
> > > -     struct w83627ehf_data *data = i2c_get_clientdata(client);
> > > -     int err;
> > > +     struct w83627ehf_data *data = platform_get_drvdata(pdev);
> > >
> > >       hwmon_device_unregister(data->class_dev);
> > > -     w83627ehf_device_remove_files(&client->dev);
> > > +     w83627ehf_device_remove_files(&pdev->dev);
> > > +     platform_set_drvdata(pdev, NULL);
> > >
> > > -     if ((err = i2c_detach_client(client)))
> > > -             return err;
> > > -     release_region(client->addr + REGION_OFFSET, REGION_LENGTH);
> >
> > You shouldn't remove this. You requested the region in .probe(), you
> > _must_ release it in .remove()!
> >
> > >       kfree(data);
> >
> > OTOH it's weird to free data here while you did not allocate it
> > in .probe().
> 
> So I added release_region() to w83627ehf_remove(). I left the kfree()
> in place (notice that the patch doesn't move it) even though I
> modified the way the data was allocated, because it is the simplest
> way of freeing the data. A more correct approach would be to get
> pdev->dev.platform_data in sensors_w83627ehf_exit and free it there.
> It does break the device driver model, and needs revision when the
> driver is moved over to a Super-I/O bus. I added a comment noting
> this.

A more correct approach, actually, would be to allocate data
in .probe(). The data structure holds driver-specific data. More on
that below.

> > >  static int __init sensors_w83627ehf_init(void)
> > >  {
> > > -     if (w83627ehf_find(0x2e, &address)
> > > -      && w83627ehf_find(0x4e, &address))
> > > -             return -ENODEV;
> > > +     int err;
> > > +     struct resource res;
> > > +     struct w83627ehf_data *data;
> > > +
> > > +     if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> > > +             err = -ENOMEM;
> > > +             goto exit;
> > > +     }
> >
> > This is an interesting approach. I did it differently in the other
> > drivers. Your way saves some memory and some code, but OTOH it breaks
> > the device driver model. The platform-specific data is supposed to be
> > stored in dev.platform_data, NOT dev.driver_data. The code which
> > instantiates the device isn't supposed to know how the driver is
> > implemented. Nothing prevents a given device from being supported by
> > more than one driver!
> >
> > So setting dev.driver_dat before .probe() is called sounds bad, and I
> > suspect we will have to move this part to the .probe() function once
> > we have a superio subsystem, anyway. So we might as well do it now.
> > What do you think?
> 
> Yes, I've changed the code to use dev.platform_data instead of
> dev.driver_data. I guess I was uncomfortable with dev.platform_data
> because I looked at the function platform_device_add_data():
> int platform_device_add_data(struct platform_device *pdev, const void
> *data, size_t size)
> {
>         void *d;
> 
>         d = kmalloc(size, GFP_KERNEL);
>         if (d) {
>                 memcpy(d, data, size);
>                 pdev->dev.platform_data = d;
>         }
>         return d ? 0 : -ENOMEM;
> }
> EXPORT_SYMBOL_GPL(platform_device_add_data);
> 
> If pdev->dev.platform_data is non-null on entry to this function it
> does not warn, it just leaks memory. (Example: a broken driver calls
> platform_device_add_data() twice in a row.) Or, I have misunderstood
> the function.

No, you're right, that's what the function does.

> Is this a bug in platform.c?

No, the bug would be to call this function twice. You really have no
reason to do that. You shouldn't expect all core functions to correct
your usage mistakes. I know some functions do, but this has a cost in
terms of performance and code readability so I'm glad this wasn't
generalized.

> I notice you just modify
> pdev->dev.platform_data directly in w83627hf.c (2.6.22-rc2).

I probably didn't know platform_device_add_data() existed! I should
have been using it, thanks for pointing this out. The w83627hf driver
should be updated, as well as the f71805f and smsc47m1 drivers. Patch
follows.

> Either way, the driver needs revision in the future when devices are
> probed from a Super-I/O bus driver.

Sure, but if the driver already follows the device driver model, the
amount of required changes will be smaller.

> > > +      * w83627ehf hardware monitor, and call probe() */
> > > +     if (w83627ehf_superio_probe(0x2e, data) &&
> > > +         w83627ehf_superio_probe(0x4e, data)) {
> > > +             err = -ENODEV;
> > > +             goto exit_free;
> > > +     }
> > >
> > > -     return i2c_isa_add_driver(&w83627ehf_driver);
> > > +     if ((err = platform_driver_register(&w83627ehf_driver))!=0)
> > > +             goto exit_free;
> >
> > Please remove the "!=0".
> 
> When I do that, I get the following warning:
> 
>   CC [M]  drivers/hwmon/w83627ehf.o
> drivers/hwmon/w83627ehf.c: In function 'sensors_w83627ehf_init':
> drivers/hwmon/w83627ehf.c:1428: warning: suggest parentheses around
> assignment used as truth value
> 
> So for now, the !=0 is still there, but I also added a comment.

I suspect you have been removing the !=0 _and_ the extra parentheses.
If I only remove the !=0 (which is what I wanted you to do) I do not
get the warning.

> So it's now patch 01. The stuff that belongs in patch 02 is (I think)
> now all in patch 02. Patch 03 revises the error handling in a couple
> of places to give more meaningful error messages. Patch 04 fixes a
> long-standing bug where the driver outputs "Increasing fan 4 clock
> divider from 4 to 8" and fills up the kernel message log.

Thanks for splitting the changes in multiple patches, this is very much
appreciated. However there's a major problem with your patchset. The
bug which your patch 04 fixes... it is _already_ fixed upstream:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h3725ad36d48c09e9537d3d7e680471c298539a9
The problem is that your patch 02 _reverts_ the fix. I guess you messed
up when porting your patches to 2.6.22-rc2. I can only suggest using
quilt to manage your patches.

Likewise, your patch 02 reverts this patch of mine which is upstream as
well:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h641fceb6bb6b0930db1aadbda1aaf5711d65d6

So I must ask you to rework your patchset so that these two patches are
no longer reverted. This will make your patch 02 smaller and your patch
04 will no longer exist.

> Please review when you get time.

Here you go. Patch 01:

> Add descriptions for w83627ehg and w83627dhg chips to Kconfig
> 
> Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>
> 
> Index: linux-2.6.22-rc2/drivers/hwmon/Kconfig
> =================================> --- linux-2.6.22-rc2/drivers/hwmon/Kconfig	2007-05-17 11:01:23.000000000 -0700
> +++ linux-2.6.22-rc2/drivers/hwmon/Kconfig	2007-05-17 11:20:52.000000000 -0700
> @@ -584,17 +584,17 @@
>  	  will be called w83627hf.
>  
>  config SENSORS_W83627EHF
> -	tristate "Winbond W83627EHF"
> +	tristate "Winbond W83627EHF/DHG"
>  	depends on I2C && EXPERIMENTAL
>  	select I2C_ISA
>  	help
> -	  If you say yes here you get preliminary support for the hardware
> -	  monitoring functionality of the Winbond W83627EHF Super-I/O chip.
> -	  Only fan and temperature inputs are supported at the moment, while
> -	  the chip does much more than that.
> +	  If you say yes here you get support for the hardware
> +	  monitoring functionality of the Winbond W83627EHF/DHG Super-I/O chip.

You can't list the DHG as supported here...

>  
>  	  This driver also supports the W83627EHG, which is the lead-free
> -	  version of the W83627EHF.
> +	  version of the W83627EHF. The driver also supports the W83627DHG,
> +	  which is a similar chip suited for specific Intel processors that
> +	  use PECI such as the Core 2 Duo.

... and then say it's "also supported" there.

>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called w83627ehf.

Otherwise this patch could go in 2.6.22.

Patch 02 (quoting only the relevant parts):

> This patch removes i2c-isa from the w83627ehf driver, and uses
> a platform driver instead.
> 
> Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>
> 
> Index: linux-2.6.22-rc2/drivers/hwmon/w83627ehf.c
> =================================> (...)
> -static int w83627ehf_detect(struct i2c_adapter *adapter)
> +/* w83627ehf_probe() looks for a Super-I/O chip at known addresses */
> +static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  {
> -	struct i2c_client *client;
> -	struct w83627ehf_data *data;
> -	struct device *dev;
> +	struct device *dev = &pdev->dev;
> +	struct w83627ehf_data *data = pdev->dev.platform_data;
>  	u8 fan4pin, fan5pin;
>  	int i, err = 0;
>  
> -	if (!request_region(address + IOREGION_OFFSET, IOREGION_LENGTH,
> -	                    w83627ehf_driver.driver.name)) {
> +	if (!request_region(data->addr + REGION_OFFSET, REGION_LENGTH,
> +			   DRVNAME)) {
>  		err = -EBUSY;
> +		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
> +			(unsigned long) (data->addr + REGION_OFFSET),
> +			(unsigned long) (
> +			data->addr + REGION_OFFSET + REGION_LENGTH - 1));
>  		goto exit;
>  	}
>  
> -	if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit_release;
> -	}
> -
> -	client = &data->client;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> -	mutex_init(&data->lock);
> -	client->adapter = adapter;
> -	client->driver = &w83627ehf_driver;
> -	client->flags = 0;
> -	dev = &client->dev;
> -
> -	if (w83627ehf_num_in = 9)
> -		strlcpy(client->name, "w83627dhg", I2C_NAME_SIZE);
> -	else	/* just say ehf. 627EHG is 627EHF in lead-free packaging. */
> -		strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
> +	/* fill in fields in *data so w83627ehf_read_value(), etc., work */
>  
>  	data->valid = 0;
> +	mutex_init(&data->lock);
>  	mutex_init(&data->update_lock);
>  
> -	/* Tell the i2c layer a new client has arrived */
> -	if ((err = i2c_attach_client(client)))
> -		goto exit_free;
> +	/* 627EHG and 627EHF have 10 voltage inputs; DHG has 9 */
> +	data->in_num = (data->kind = w83627dhg) ? 9 : 10;
>  
>  	/* Initialize the chip */
> -	w83627ehf_init_client(client);
> +	w83627ehf_init_device(data);
>  
> -	/* A few vars need to be filled upon startup */
>  	for (i = 0; i < 5; i++)
> -		data->fan_min[i] = w83627ehf_read_value(client,
> +		data->fan_min[i] = w83627ehf_read_value(data,
>  				   W83627EHF_REG_FAN_MIN[i]);
>  
>  	/* fan4 and fan5 share some pins with the GPIO and serial flash */
>  
> -	superio_enter();
> -	fan5pin = superio_inb(0x24) & 0x2;
> -	fan4pin = superio_inb(0x29) & 0x6;
> -	superio_exit();
> +	superio_enter(data->sioreg);
> +	fan5pin = superio_inb(data->sioreg, 0x24) & 0x2;
> +	fan4pin = superio_inb(data->sioreg, 0x29) & 0x6;
> +	superio_exit(data->sioreg);
>  
>  	/* It looks like fan4 and fan5 pins can be alternatively used
>  	   as fan on/off switches, but fan5 control is write only :/
> @@ -1248,7 +1229,7 @@
>  	   is not the default. */
>  
>  	data->has_fan = 0x07; /* fan1, fan2 and fan3 */
> -	i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
> +	i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
>  	if ((i & (1 << 2)) && (!fan4pin))
>  		data->has_fan |= (1 << 3);
>  	if (!(i & (1 << 1)) && (!fan5pin))
> @@ -1257,7 +1238,7 @@
>  	/* Register sysfs hooks */
>    	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
>  		if ((err = device_create_file(dev,
> -			&sda_sf3_arrays[i].dev_attr)))
> +				&sda_sf3_arrays[i].dev_attr)))
>  			goto exit_remove;
>  
>  	/* if fan4 is enabled create the sf3 files for it */

This cleanup would be better moved to the next patch.

> @@ -1268,7 +1249,7 @@
>  				goto exit_remove;
>  		}
>  
> -	for (i = 0; i < w83627ehf_num_in; i++)
> +	for (i = 0; i < data->in_num; i++)
>  		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
>  			|| (err = device_create_file(dev,
>  				&sda_in_alarm[i].dev_attr))
> @@ -1308,6 +1289,10 @@
>  		if ((err = device_create_file(dev, &sda_temp[i].dev_attr)))
>  			goto exit_remove;
>  
> +	err = device_create_file(dev, &dev_attr_name);
> +	if (err)
> +		goto exit_remove;
> +
>  	data->class_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->class_dev)) {
>  		err = PTR_ERR(data->class_dev);
> @@ -1318,95 +1303,184 @@
>  
>  exit_remove:
>  	w83627ehf_device_remove_files(dev);
> -	i2c_detach_client(client);
> -exit_free:
> -	kfree(data);
> -exit_release:
> -	release_region(address + IOREGION_OFFSET, IOREGION_LENGTH);
> +	release_region(data->addr + REGION_OFFSET, REGION_LENGTH);
>  exit:
>  	return err;
>  }

> +/* when Super-I/O functions move to a separate file, the Super-I/O
> + * bus will manage the lifetime of the device and this module will only keep
> + * track of the w83627ehf driver. But since we platform_device_alloc(), we
> + * must keep track of the device */
> +static struct platform_device *pdev;
> +
>  static int __init sensors_w83627ehf_init(void)
>  {
> -	if (w83627ehf_find(0x2e, &address)
> -	 && w83627ehf_find(0x4e, &address))
> -		return -ENODEV;
> +	int err;
> +	struct resource res;
> +	struct w83627ehf_data *data;
> +
> +	if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}

I still do not agree with your allocation scheme. It is correct that
for now the w83627ehf driver must take care of both the platform data
and the driver data, however these are still two different things. The
platform data should be allocated and filled before .probe() is called.
The driver data should be allocated _by_ .probe(). Here you're putting
everything in the platform data structure, this isn't acceptable.
Please look at the w83627hf driver and follow the same allocation
scheme. This is far better than adding comments saying that you're
aware you're not doing the right thing.

> +
> +	/* initialize data->kind, data->sioreg, and data->addr.
> +	 *
> +	 * when Super-I/O functions move to a separate file, the Super-I/O
> +	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
> +	 * w83627ehf hardware monitor, and call probe() */
> +	if (w83627ehf_superio_probe(0x2e, data) &&
> +	    w83627ehf_superio_probe(0x4e, data)) {
> +		err = -ENODEV;
> +		goto exit_free;
> +	}
>  
> -	return i2c_isa_add_driver(&w83627ehf_driver);
> +	/* !=0 to suppress warning:
> +	 * suggest parentheses around assignment used as truth value */
> +	if ((err = platform_driver_register(&w83627ehf_driver))!=0)
> +		goto exit_free;
> +
> +	if (!(pdev = platform_device_alloc(DRVNAME, data->addr))) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto exit_unregister;
> +	}
> +
> +	pdev->dev.platform_data = data;
> +
> +	memset(&res, 0, sizeof(res));
> +	data->name = w83627ehf_device_names[data->kind];
> +	res.name = data->name;
> +	res.start = data->addr + REGION_OFFSET;
> +	res.end = data->addr + REGION_OFFSET + REGION_LENGTH - 1;
> +	res.flags = IORESOURCE_IO;
> +	err = platform_device_add_resources(pdev, &res, 1);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device resource addition failed "
> +		       "(%d)\n", err);
> +		goto exit_device_put;
> +	}
> +
> +	/* platform_device_add calls probe() */
> +	err = platform_device_add(pdev);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> +		       err);
> +		goto exit_device_put;
> +	}
> +
> +	return 0;
> +
> +exit_device_put:
> +	pdev->dev.platform_data = NULL;
> +	platform_device_put(pdev);
> +exit_unregister:
> +	platform_driver_unregister(&w83627ehf_driver);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
>  }

> --- linux-2.6.22-rc2/drivers/hwmon/Kconfig	2007-05-17 11:20:52.000000000 -0700
> +++ linux-2.6.22-rc2/drivers/hwmon/Kconfig	2007-05-17 11:20:50.000000000 -0700
> @@ -585,8 +585,7 @@
>  
>  config SENSORS_W83627EHF
>  	tristate "Winbond W83627EHF/DHG"
> -	depends on I2C && EXPERIMENTAL
> -	select I2C_ISA
> +	depends on HWMON && EXPERIMENTAL

You're adding back HWMON which is no longer needed and has been removed
upstream:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h72acf91abb327e25137ad2e371c1a788b34e45

>  	help
>  	  If you say yes here you get support for the hardware
>  	  monitoring functionality of the Winbond W83627EHF/DHG Super-I/O chip.

Rest looks OK.

Patch 03: OK.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
