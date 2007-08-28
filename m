From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 28 Aug 2007 21:16:34 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon/dme1737: add sch311x support
Message-Id: <191fb4ca0708281416i33287780m955b000f511bd6a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0707232042g73c21d34ic63f715f0e8438b8@mail.gmail.com>
In-Reply-To: <191fb4ca0707232042g73c21d34ic63f715f0e8438b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks a lot for the review!

On 8/28/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Sun, 26 Aug 2007 20:25:31 -0700, Juerg Haefliger wrote:
> > This patch adds support for the SMSC SCH3112, SCH3114, and SCH3116 Super-I/O
> > chips. These chips feature identical hardware monitoring capabilites with the
> > exception that some of the fan inputs and pmw outputs don't exist.
> >
> > The hardware monitoring features of the SCH311x chips can only be accessed via
> > the ISA bus. The driver therefore registers as a platform driver, if such a
> > chip is detected.
> >
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> Review:
>
> > Index: linux-2.6/drivers/hwmon/dme1737.c
> > =================================> > --- linux-2.6.orig/drivers/hwmon/dme1737.c    2007-08-26 20:10:16.000000000 -0700
> > +++ linux-2.6/drivers/hwmon/dme1737.c 2007-08-26 20:10:21.000000000 -0700
> > @@ -1,12 +1,13 @@
> >  /*
> > - * dme1737.c - driver for the SMSC DME1737 and Asus A8000 Super-I/O chips
> > - *             integrated hardware monitoring features.
> > + * dme1737.c - Driver for the SMSC DME1737, Asus A8000, and SMSC SCH311x
> > + *             Super-I/O chips integrated hardware monitoring features.
> >   * Copyright (c) 2007 Juerg Haefliger <juergh@gmail.com>
> >   *
> > - * This driver is based on the LM85 driver. The hardware monitoring
> > - * capabilities of the DME1737 are very similar to the LM85 with some
> > - * additional features. Even though the DME1737 is a Super-I/O chip, the
> > - * hardware monitoring registers are only accessible via SMBus.
> > + * This driver is an I2C/ISA hybrid, meaning that it registers as an I2C client
> > + * driver if a DME1737 (or A8000) is found and as a platform driver if a
> > + * SCH311x chip is found. Both types of chips have very similar hardware
> > + * monitoring capabilities but differ in the way they can be accessed, either
> > + * via I2C or ISA.
>
> This comment is not totally true: the driver registers as an I2C device
> driver in all cases (and quite rightly so.) Only the platform driver is
> conditional.

OK, will update the comment.


> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License as published by
> > @@ -28,6 +29,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/i2c.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/hwmon.h>
> >  #include <linux/hwmon-sysfs.h>
> >  #include <linux/hwmon-vid.h>
> > @@ -35,6 +37,9 @@
> >  #include <linux/mutex.h>
> >  #include <asm/io.h>
> >
> > +/* ISA device, if found */
> > +static struct platform_device *pdev;
> > +
> >  /* Module load parameters */
> >  static int force_start;
> >  module_param(force_start, bool, 0);
> > @@ -133,6 +138,7 @@
> >  static const u8 DME1737_BIT_ALARM_FAN[] = {10, 11, 12, 13, 22, 23};
> >
> >  /* Miscellaneous registers */
> > +#define DME1737_REG_DEVICE           0x3d
> >  #define DME1737_REG_COMPANY          0x3e
> >  #define DME1737_REG_VERSTEP          0x3f
> >  #define DME1737_REG_CONFIG           0x40
> > @@ -148,11 +154,14 @@
> >  #define DME1737_COMPANY_SMSC 0x5c
> >  #define DME1737_VERSTEP              0x88
> >  #define DME1737_VERSTEP_MASK 0xf8
> > +#define SCH311X_DEVICE               0x8c
> >
> >  /* ---------------------------------------------------------------------
> >   * Data structures and manipulation thereof
> >   * --------------------------------------------------------------------- */
> >
> > +/* For ISA chips, we abuse the i2c_client addr and name fields. We also use
> > +   the driver field to differentiate between I2C and ISA chips. */
> >  struct dme1737_data {
> >       struct i2c_client client;
> >       struct class_device *class_dev;
> > @@ -469,23 +478,39 @@
> >
> >  static u8 dme1737_read(struct i2c_client *client, u8 reg)
> >  {
> > -     s32 val = i2c_smbus_read_byte_data(client, reg);
> > +     s32 val;
> > +
> > +     if (client->driver) { /* I2C device */
> > +             val = i2c_smbus_read_byte_data(client, reg);
> >
> > -     if (val < 0) {
> > -             dev_warn(&client->dev, "Read from register 0x%02x failed! "
> > -                      "Please report to the driver maintainer.\n", reg);
> > +             if (val < 0) {
> > +                     dev_warn(&client->dev, "Read from register "
> > +                              "0x%02x failed! Please report to the driver "
> > +                              "maintainer.\n", reg);
> > +             }
> > +     } else { /* ISA device */
> > +             outb(reg, client->addr);
> > +             val = inb(client->addr + 1);
> >       }
> >
> >       return val;
> >  }
> >
> > -static s32 dme1737_write(struct i2c_client *client, u8 reg, u8 value)
> > +static s32 dme1737_write(struct i2c_client *client, u8 reg, u8 val)
> >  {
> > -     s32 res = i2c_smbus_write_byte_data(client, reg, value);
> > +     s32 res = 0;
> > +
> > +     if (client->driver) { /* I2C device */
> > +             res = i2c_smbus_write_byte_data(client, reg, val);
> >
> > -     if (res < 0) {
> > -             dev_warn(&client->dev, "Write to register 0x%02x failed! "
> > -                      "Please report to the driver maintainer.\n", reg);
> > +             if (res < 0) {
> > +                     dev_warn(&client->dev, "Write to register "
> > +                              "0x%02x failed! Please report to the driver "
> > +                              "maintainer.\n", reg);
> > +             }
> > +     } else { /* ISA device */
> > +             outb(reg, client->addr);
> > +             outb(val, client->addr + 1);
> >       }
> >
> >       return res;
>
> Because the ISA access is through an index/data I/O port pair, it needs
> to be protected by a mutex during runtime. You happen to have such a
> mutex (data->update_lock) and the code is already correct, however I
> suggest adding a comment before both dme1737_read() and dme1737_write()
> reminding that these functions can only be safely called when holding
> data->update_lock (except during initialization).

OK, will do.


> > @@ -630,6 +655,24 @@
> >                                               DME1737_REG_ALARM3) << 16;
> >               }
> >
> > +             /* The ISA chips require explicit clearing of alarm bits.
> > +              * Don't worry, an alarm will come back if the condition
> > +              * that causes it still exists */
> > +             if (!client->driver) {
> > +                     if (data->alarms & 0xff0000) {
> > +                             dme1737_write(client, DME1737_REG_ALARM3,
> > +                                           0xff);
> > +                     }
> > +                     if (data->alarms & 0xff00) {
> > +                             dme1737_write(client, DME1737_REG_ALARM2,
> > +                                           0xff);
> > +                     }
> > +                     if (data->alarms & 0xff) {
> > +                             dme1737_write(client, DME1737_REG_ALARM1,
> > +                                           0xff);
> > +                     }
> > +             }
> > +
> >               data->last_update = jiffies;
> >               data->valid = 1;
> >       }
> > @@ -1698,7 +1741,7 @@
> >  }
> >
> >  /* ---------------------------------------------------------------------
> > - * Device detection, registration and initialization
> > + * Device initialization
> >   * --------------------------------------------------------------------- */
> >
> >  static int dme1737_i2c_get_features(int, struct dme1737_data*);
> > @@ -1840,29 +1883,38 @@
> >               return -EFAULT;
> >       }
> >
> > -     data->config2 = dme1737_read(client, DME1737_REG_CONFIG2);
> > -     /* Check if optional fan3 input is enabled */
> > -     if (data->config2 & 0x04) {
> > +     /* Determine which optional fan and pwm features are enabled/present */
> > +     if (client->driver) {   /* I2C chip */
> > +             data->config2 = dme1737_read(client, DME1737_REG_CONFIG2);
> > +             /* Check if optional fan3 input is enabled */
> > +             if (data->config2 & 0x04) {
> > +                     data->has_fan |= (1 << 2);
> > +             }
> > +
> > +             /* Fan4 and pwm3 are only available if the client's I2C address
> > +              * is the default 0x2e. Otherwise the I/Os associated with
> > +              * these functions are used for addr enable/select. */
> > +             if (data->client.addr = 0x2e) {
> > +                     data->has_fan |= (1 << 3);
> > +                     data->has_pwm |= (1 << 2);
> > +             }
> > +
> > +             /* Determine which of the optional fan[5-6] and pwm[5-6]
> > +              * features are enabled. For this, we need to query the runtime
> > +              * registers through the Super-IO LPC interface. Try both
> > +              * config ports 0x2e and 0x4e. */
> > +             if (dme1737_i2c_get_features(0x2e, data) &&
> > +                 dme1737_i2c_get_features(0x4e, data)) {
> > +                     dev_warn(dev, "Failed to query Super-IO for optional "
> > +                              "features.\n");
> > +             }
> > +     } else {   /* ISA chip */
> > +             /* Fan3 and pwm3 are always available. Fan[4-5] and pwm[5-6]
> > +              * don't exist in the ISA chip. */
> >               data->has_fan |= (1 << 2);
> > -     }
> > -
> > -     /* Fan4 and pwm3 are only available if the client's I2C address
> > -      * is the default 0x2e. Otherwise the I/Os associated with these
> > -      * functions are used for addr enable/select. */
> > -     if (client->addr = 0x2e) {
> > -             data->has_fan |= (1 << 3);
> >               data->has_pwm |= (1 << 2);
> >       }
> >
> > -     /* Determine if the optional fan[5-6] and/or pwm[5-6] are enabled.
> > -      * For this, we need to query the runtime registers through the
> > -      * Super-IO LPC interface. Try both config ports 0x2e and 0x4e. */
> > -     if (dme1737_i2c_get_features(0x2e, data) &&
> > -         dme1737_i2c_get_features(0x4e, data)) {
> > -             dev_warn(dev, "Failed to query Super-IO for optional "
> > -                      "features.\n");
> > -     }
> > -
> >       /* Fan1, fan2, pwm1, and pwm2 are always present */
> >       data->has_fan |= 0x03;
> >       data->has_pwm |= 0x03;
> > @@ -1879,13 +1931,19 @@
> >
> >       reg = dme1737_read(client, DME1737_REG_TACH_PWM);
> >       /* Inform if fan-to-pwm mapping differs from the default */
> > -     if (reg != 0xa4) {
> > +     if (client->driver && reg != 0xa4) {   /* I2C chip */
> >               dev_warn(dev, "Non-standard fan to pwm mapping: "
> >                        "fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, "
> >                        "fan4->pwm%d. Please report to the driver "
> >                        "maintainer.\n",
> >                        (reg & 0x03) + 1, ((reg >> 2) & 0x03) + 1,
> >                        ((reg >> 4) & 0x03) + 1, ((reg >> 6) & 0x03) + 1);
> > +     } else if (!client->driver && reg != 0x24) {   /* ISA chip */
> > +             dev_warn(dev, "Non-standard fan to pwm mapping: "
> > +                      "fan1->pwm%d, fan2->pwm%d, fan3->pwm%d. "
> > +                      "Please report to the driver maintainer.\n",
> > +                      (reg & 0x03) + 1, ((reg >> 2) & 0x03) + 1,
> > +                      ((reg >> 4) & 0x03) + 1);
> >       }
> >
> >       /* Switch pwm[1-3] to manual mode if they are currently disabled and
> > @@ -2097,16 +2155,213 @@
> >  };
> >
> >  /* ---------------------------------------------------------------------
> > + * ISA device detection and registration
> > + * --------------------------------------------------------------------- */
> > +
> > +static int dme1737_isa_detect(int sio_cip, unsigned short *addr)
>
> Could be declared __init.

What does this do?


> > +{
> > +     int err = 0, reg;
> > +     unsigned short base_addr;
> > +
> > +     dme1737_sio_enter(sio_cip);
> > +
> > +     /* Check device ID
> > +      * We currently know about SCH3112 (0x7c), SCH3114 (0x7d), and
> > +      * SCH3116 (0x7f). */
> > +     reg = dme1737_sio_inb(sio_cip, 0x20);
> > +     if (!(reg = 0x7c || reg = 0x7d || reg = 0x7f)) {
> > +             err = -ENODEV;
> > +             goto exit;
> > +     }
> > +
> > +     /* Select logical device A (runtime registers) */
> > +     dme1737_sio_outb(sio_cip, 0x07, 0x0a);
> > +
> > +     /* Get the base address of the runtime registers */
> > +     if (!(base_addr = (dme1737_sio_inb(sio_cip, 0x60) << 8) |
> > +                        dme1737_sio_inb(sio_cip, 0x61))) {
> > +             printk(KERN_ERR "dme1737: Base address not set.\n");
> > +             err = -ENODEV;
> > +             goto exit;
> > +     }
> > +
> > +     /* Access to the hwmon registers is through an index/data register
> > +      * pair located at offset 0x70/0x71. */
> > +     *addr = base_addr + 0x70;
> > +
> > +exit:
> > +     dme1737_sio_exit(sio_cip);
> > +
> > +     return err;
> > +}
> > +
> > +static int __init dme1737_isa_device_add(unsigned short addr)
> > +{
> > +     struct resource res = {
> > +             .start  = addr,
> > +             .end    = addr + 1,
> > +             .name   = "dme1737",
> > +             .flags  = IORESOURCE_IO,
> > +     };
> > +     int err;
> > +
> > +     if (!(pdev = platform_device_alloc("dme1737", addr))) {
> > +             printk(KERN_ERR "dme1737: Failed to allocate device.\n");
> > +             err = -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     if ((err = platform_device_add_resources(pdev, &res, 1))) {
> > +             printk(KERN_ERR "dme1737: Failed to add device resource.\n");
>
> Printing the value of err would help investigating the problem if this
> ever happens.

OK, will do.


> > +             goto exit_device_put;
> > +     }
> > +
> > +     if ((err = platform_device_add(pdev))) {
> > +             printk(KERN_ERR "dme1737: Failed to add device.\n");
>
> Ditto.

Ditto.


> > +             goto exit_device_put;
> > +     }
> > +
> > +     return 0;
> > +
> > + exit_device_put:
> > +     platform_device_put(pdev);
> > + exit:
> > +     pdev = NULL;
>
> Minor optimization: the "pdev = NULL" can be moved before the "exit:"
> label.

Right.


> > +     return err;
> > +}
> > +
> > +static int __devinit dme1737_isa_probe(struct platform_device *pdev)
> > +{
> > +     u8 company, device;
> > +     struct resource *res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > +     struct i2c_client *client;
> > +     struct dme1737_data *data;
> > +     struct device *dev;
> > +     int err;
> > +
> > +     if (!(data = kzalloc(sizeof(struct dme1737_data), GFP_KERNEL))) {
> > +             dev_err(&pdev->dev, "Failed to allocate memory.\n");
> > +             err = -ENOMEM;
> > +             goto exit;
> > +     }
>
> You're missing a call to request_region() here. At this point the I/O
> region is declared but not requested, which means that another driver
> could request it. See the lm78 driver for an example.

OK, I'll check lm78.


> > +
> > +     client = &data->client;
> > +     i2c_set_clientdata(client, data);
> > +     client->addr = res->start;
> > +     platform_set_drvdata(pdev, data);
> > +     dev = &pdev->dev;
> > +
> > +     company = dme1737_read(&data->client, DME1737_REG_COMPANY);
> > +     device = dme1737_read(&data->client, DME1737_REG_DEVICE);
>
> You could use just "client" here. If you don't, it's probably not worth
> having this local variable at all.

I don't understand. What do you mean by using 'client'?


> > +
> > +     if (!((company = DME1737_COMPANY_SMSC) &&
> > +           (device = SCH311X_DEVICE))) {
> > +             err = -ENODEV;
> > +             goto exit_kfree;
> > +     }
> > +
> > +     /* Fill in the remaining client fields and put it into the global
> > +      * list */
>
> Comment is wrong, you are thankfully not adding this fake client
> structure to the global list!

Will fix.


> > +     strlcpy(client->name, "sch311x", I2C_NAME_SIZE);
> > +     mutex_init(&data->update_lock);
> > +
> > +     dev_info(dev, "Found a SCH311X chip at 0x%04x\n", client->addr);
>
> I'd suggest a lower case x in the chip name.

OK.


> > +
> > +     /* Initialize the chip */
> > +     if ((err = dme1737_init_device(dev))) {
> > +             dev_err(dev, "Failed to initialize device.\n");
> > +             goto exit_kfree;
> > +     }
> > +
> > +     /* Create sysfs files */
> > +     if ((err = dme1737_create_files(dev))) {
> > +             dev_err(dev, "Failed to create sysfs files.\n");
> > +             goto exit_kfree;
> > +     }
>
> As this is a non-i2c device, you also need to create the "name" file.
> See the lm78 driver for an example. Without that file, libsensors will
> discard the device.

Ah. That might be the reason why people don't get sensor readings with
this driver. Even though I thought someone reported success. I have to
go back and check my emails


> > +
> > +     /* Register device */
> > +     data->class_dev = hwmon_device_register(dev);
> > +     if (IS_ERR(data->class_dev)) {
> > +             dev_err(dev, "Failed to register device.\n");
> > +             err = PTR_ERR(data->class_dev);
> > +             goto exit_remove_files;
> > +     }
> > +
> > +     return 0;
> > +
> > +exit_remove_files:
> > +     dme1737_remove_files(dev);
> > +exit_kfree:
>
> Even though it's not strictly necessary, I suggest adding
>         platform_set_drvdata(pdev, NULL);
> here.

OK.


> > +     kfree(data);
> > + exit:
> > +     return err;
>
> The indentation of labels is inconsistent.

Darn emacs. Will fix.


> > +}
> > +
> > +static int __devexit dme1737_isa_remove(struct platform_device *pdev)
> > +{
> > +     struct dme1737_data *data = platform_get_drvdata(pdev);
> > +
> > +     hwmon_device_unregister(data->class_dev);
> > +     dme1737_remove_files(&pdev->dev);
> > +     platform_set_drvdata(pdev, NULL);
> > +     kfree(data);
>
> Stray space at beginning of line.

Will fix.


> > +
> > +     return 0;
>
> Ditto.

Ditto.


> > +}
> > +
> > +static struct platform_driver dme1737_isa_driver = {
> > +     .driver = {
> > +             .owner = THIS_MODULE,
> > +             .name = "dme1737",
> > +     },
> > +     .probe = dme1737_isa_probe,
> > +     .remove = dme1737_isa_remove,
>
> Missing __devexit_p().

Ok. What does it do?


> > +};
> > +
> > +/* ---------------------------------------------------------------------
> >   * Module initialization and cleanup
> >   * --------------------------------------------------------------------- */
> >
> >  static int __init dme1737_init(void)
> >  {
> > -     return i2c_add_driver(&dme1737_i2c_driver);
> > +     int err;
> > +     unsigned short addr;
> > +
> > +     if ((err = i2c_add_driver(&dme1737_i2c_driver))) {
> > +             goto exit;
> > +     }
> > +
> > +     if (dme1737_isa_detect(0x2e, &addr) &&
> > +         dme1737_isa_detect(0x4e, &addr)) {
> > +             goto exit;
>
> It took me some time to realize that this code is correct. A plain
> "return 0" would IMHO be more obvious. Or, if you don't want to change
> the code, add a comment to clarify that err = 0 so you're returning
> with success not error.

OK, will clarify.


> > +     }
> > +
> > +     if ((err = platform_driver_register(&dme1737_isa_driver))) {
> > +             goto exit_del_driver;
> > +     }
> > +
> > +     /* Sets global pdev as a side effect */
> > +     if ((err = dme1737_isa_device_add(addr))) {
> > +             goto exit_unregister;
> > +     }
> > +
> > +     return 0;
> > +
> > +exit_unregister:
> > +     platform_driver_unregister(&dme1737_isa_driver);
> > +exit_del_driver:
> > +     i2c_del_driver(&dme1737_i2c_driver);
>
> These labels might be better named exit_del_isa_driver and
> exit_del_i2c_driver or something like that.

OK.


> > +exit:
> > +     return err;
> >  }
> >
> >  static void __exit dme1737_exit(void)
> >  {
> > +     if (pdev) {
> > +             platform_device_unregister(pdev);
> > +             platform_driver_unregister(&dme1737_isa_driver);
> > +     }
> > +
> >       i2c_del_driver(&dme1737_i2c_driver);
> >  }
> >
>
> Additionally, you have a number of occurrences of "&client->dev" left
> in common code (set_fan, set_pwm twice), which will break in the ISA
> case. You should use "dev" instead.

OK, will check those and fix them.


> --
> Jean Delvare
>

Thanks again for the review.

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
