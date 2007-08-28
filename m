From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Aug 2007 21:36:23 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon/dme1737: add sch311x support
Message-Id: <20070828233623.1840229e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0707232042g73c21d34ic63f715f0e8438b8@mail.gmail.com>
In-Reply-To: <191fb4ca0707232042g73c21d34ic63f715f0e8438b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 28 Aug 2007 14:16:34 -0700, Juerg Haefliger wrote:
> On 8/28/07, Jean Delvare <khali@linux-fr.org> wrote:
> > On Sun, 26 Aug 2007 20:25:31 -0700, Juerg Haefliger wrote:
> > > +static int dme1737_isa_detect(int sio_cip, unsigned short *addr)
> >
> > Could be declared __init.
> 
> What does this do?

This allows the kernel to drop the code from memory after module
initialization has completed. dme1737_isa_detect() is only called from
dme1737_init(), which itself is __init, so dme1737_isa_detect() can be
declared __init too.

> > > +
> > > +     client = &data->client;
> > > +     i2c_set_clientdata(client, data);
> > > +     client->addr = res->start;
> > > +     platform_set_drvdata(pdev, data);
> > > +     dev = &pdev->dev;
> > > +
> > > +     company = dme1737_read(&data->client, DME1737_REG_COMPANY);
> > > +     device = dme1737_read(&data->client, DME1737_REG_DEVICE);
> >
> > You could use just "client" here. If you don't, it's probably not worth
> > having this local variable at all.
> 
> I don't understand. What do you mean by using 'client'?

I mean that you can do:

	company = dme1737_read(client, DME1737_REG_COMPANY);
	device = dme1737_read(client, DME1737_REG_DEVICE);

i.e. use the local variable "client" instead of "&data->client".

> > > +
> > > +     /* Initialize the chip */
> > > +     if ((err = dme1737_init_device(dev))) {
> > > +             dev_err(dev, "Failed to initialize device.\n");
> > > +             goto exit_kfree;
> > > +     }
> > > +
> > > +     /* Create sysfs files */
> > > +     if ((err = dme1737_create_files(dev))) {
> > > +             dev_err(dev, "Failed to create sysfs files.\n");
> > > +             goto exit_kfree;
> > > +     }
> >
> > As this is a non-i2c device, you also need to create the "name" file.
> > See the lm78 driver for an example. Without that file, libsensors will
> > discard the device.
> 
> Ah. That might be the reason why people don't get sensor readings with
> this driver. Even though I thought someone reported success. I have to
> go back and check my emails

Yes, I think that this is the fix for ticket #2243.

> > > +}
> > > +
> > > +static struct platform_driver dme1737_isa_driver = {
> > > +     .driver = {
> > > +             .owner = THIS_MODULE,
> > > +             .name = "dme1737",
> > > +     },
> > > +     .probe = dme1737_isa_probe,
> > > +     .remove = dme1737_isa_remove,
> >
> > Missing __devexit_p().
> 
> Ok. What does it do?

You declared dme1737_isa_remove() __devexit, which means that the code
is not included if the driver is built into the kernel and hotplug is
disabled. If it's not included, it has no address so you can't assign
its address to .remove; compilation will fail. The __devexit_p macro
takes care of that, replacing the function name by NULL when needed.

__init, __devexit etc. are documented in Documentation/pci.txt if you
want to know the details.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
