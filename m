From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Aug 2010 18:50:20 +0000
Subject: Re: [lm-sensors] [PATCH 6/6] hwmon: (pc87427) Move sysfs file
Message-Id: <20100812205020.0498ab53@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811171423.01720059@hyperion.delvare>
In-Reply-To: <20100811171423.01720059@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Aug 2010 10:40:12 -0700, Guenter Roeck wrote:
> On Wed, 2010-08-11 at 11:14 -0400, Jean Delvare wrote:
> > The sysfs file removal code is the same in the probe error path and in
> > the remove function, so move it to a separate function to avoid code
> > duplication.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Another minor question below.
> 
> > ---
> >  drivers/hwmon/pc87427.c |   58 +++++++++++++++++++++--------------------------
> >  1 file changed, 26 insertions(+), 32 deletions(-)
> > 
> > --- linux-2.6.35-rc4.orig/drivers/hwmon/pc87427.c	2010-07-11 10:13:07.000000000 +0200
> > +++ linux-2.6.35-rc4/drivers/hwmon/pc87427.c	2010-07-11 10:17:44.000000000 +0200
> > @@ -1045,6 +1045,29 @@ static void __devinit pc87427_init_devic
> >  	}
> >  }
> >  
> > +static void pc87427_remove_files(struct device *dev)
> > +{
> > +	struct pc87427_data *data = dev_get_drvdata(dev);
> > +	int i;
> > +
> > +	device_remove_file(dev, &dev_attr_name);
> 
> device_remove_file() is not called in the error path. Does that matter ?

No it doesn't matter. It's always OK to remove files that do not exist.
In fact, I could even remove all the tests on data->*_enabled below, it
would still work fine.

> 
> > +	for (i = 0; i < 8; i++) {
> > +		if (!(data->fan_enabled & (1 << i)))
> > +			continue;
> > +		sysfs_remove_group(&dev->kobj, &pc87427_group_fan[i]);
> > +	}
> > +	for (i = 0; i < 4; i++) {
> > +		if (!(data->pwm_enabled & (1 << i)))
> > +			continue;
> > +		sysfs_remove_group(&dev->kobj, &pc87427_group_pwm[i]);
> > +	}
> > +	for (i = 0; i < 6; i++) {
> > +		if (!(data->temp_enabled & (1 << i)))
> > +			continue;
> > +		sysfs_remove_group(&dev->kobj, &pc87427_group_temp[i]);
> > +	}
> > +}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
