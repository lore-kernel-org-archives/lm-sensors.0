From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 15 Jun 2012 16:51:47 +0000
Subject: Re: [lm-sensors] [PATCH 17/95] hwmon: (adt7411) Convert to use devm_ functions
Message-Id: <1339779107.2299.39.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2012-06-15 at 11:52 -0400, Wolfram Sang wrote:
> On Fri, Jun 15, 2012 at 08:22:58AM -0700, Guenter Roeck wrote:
> > Convert to use devm_ functions to reduce code size and simplify the code.
> > 
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> I won't NACK it, but I don't think it is worth it. It increases runtime
> memory usage and execution time. Marginally, yes, but the gain in code
> size reduction is also marginally. If there is lots of devm_* in a
> driver, this is usually good, but I wouldn't care about converting
> single kzalloc calls.
> 
Wolfram,

code size reduction on x86_64 is about 15 kBytes for all drivers. With
most of the hwmon drivers built but not loaded on a typical system, that
does make a difference in disk space usage, and I think it is a bit more
than marginal. The runtime execution time increase only occurs once,
when a module is loaded or unloaded, and the increase in memory usage
only applies to loaded drivers.

In addition to that, it does help preventing memory leaks, and it does
make the code a bit simpler.

So, overall I do think it is worth it. Maybe not if I only look at one
driver, but very much so if I look at the overall impact.

Thanks,
Guenter

> Regards,
> 
>    Wolfram
> 
> > ---
> >  drivers/hwmon/adt7411.c |    9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> > index 71bacc5..fe72c69 100644
> > --- a/drivers/hwmon/adt7411.c
> > +++ b/drivers/hwmon/adt7411.c
> > @@ -283,7 +283,7 @@ static int __devinit adt7411_probe(struct i2c_client *client,
> >  	struct adt7411_data *data;
> >  	int ret;
> >  
> > -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> >  		return -ENOMEM;
> >  
> > @@ -294,14 +294,14 @@ static int __devinit adt7411_probe(struct i2c_client *client,
> >  	ret = adt7411_modify_bit(client, ADT7411_REG_CFG1,
> >  				 ADT7411_CFG1_START_MONITOR, 1);
> >  	if (ret < 0)
> > -		goto exit_free;
> > +		return ret;
> >  
> >  	/* force update on first occasion */
> >  	data->next_update = jiffies;
> >  
> >  	ret = sysfs_create_group(&client->dev.kobj, &adt7411_attr_grp);
> >  	if (ret)
> > -		goto exit_free;
> > +		return ret;
> >  
> >  	data->hwmon_dev = hwmon_device_register(&client->dev);
> >  	if (IS_ERR(data->hwmon_dev)) {
> > @@ -315,8 +315,6 @@ static int __devinit adt7411_probe(struct i2c_client *client,
> >  
> >   exit_remove:
> >  	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
> > - exit_free:
> > -	kfree(data);
> >  	return ret;
> >  }
> >  
> > @@ -326,7 +324,6 @@ static int __devexit adt7411_remove(struct i2c_client *client)
> >  
> >  	hwmon_device_unregister(data->hwmon_dev);
> >  	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
> > -	kfree(data);
> >  	return 0;
> >  }
> >  
> > -- 
> > 1.7.9.7
> > 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
