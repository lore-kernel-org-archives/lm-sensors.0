From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 20:53:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: unchecked return status fixes
Message-Id: <20060923225327.571284be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060831220610.19a79141.khali@linux-fr.org>
In-Reply-To: <20060831220610.19a79141.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark,

> * Jean Delvare <khali at linux-fr.org> [2006-09-22 13:45:59 +0200]:
> > Fix up 5 more hwmon drivers so that they no longer ignore return
> > status from device_create_file(). Untested.
> > 
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > ---
> >  drivers/hwmon/atxp1.c   |   24 +++++++++--
> >  drivers/hwmon/ds1621.c  |   27 +++++++++----
> >  drivers/hwmon/max1619.c |   32 +++++++++++----
> >  drivers/hwmon/sis5595.c |  100 +++++++++++++++++++++++++++++++++--------------
> >  drivers/hwmon/via686a.c |   82 +++++++++++++++++++++++----------------
> >  5 files changed, 180 insertions(+), 85 deletions(-)
> 
> You should add '#include <linux/sysfs.h>' to all of these.  Also...

Yes, you're right. I've done so.

BTW, there are a lot of drivers missing it as well (basically all the
drivers which were converted early, including all of yours.) Should I
edit all the patches before I send them to Greg?

> > --- linux-2.6.18.orig/drivers/hwmon/sis5595.c	2006-09-21 21:41:50.000000000 +0200
> > +++ linux-2.6.18/drivers/hwmon/sis5595.c	2006-09-22 13:30:36.000000000 +0200
> > @@ -566,43 +610,37 @@
> >  	}
> >  
> >  	/* Register sysfs hooks */
> > +	if ((err = sysfs_create_group(&new_client->dev.kobj, &sis5595_group)))
> > +		goto exit_detach;
> > +	if (data->maxins = 4) {
> > +		if ((err = device_create_file(&new_client->dev,
> > +					      &dev_attr_in4_input))
> > +		 || (err = device_create_file(&new_client->dev,
> > +					      &dev_attr_in4_min))
> > +		 || (err = device_create_file(&new_client->dev,
> > +					      &dev_attr_in4_max)))
> > +			goto exit_remove_files;
> > +	} else {
> 
> This else implies data->maxins = 3 right?  Just checking.

I assumed so, but you're right to ask. Fortunately, after checking, it
appears to be correct.

> > +		if ((err = device_create_file(&new_client->dev,
> > +					      &dev_attr_temp1_input))
> > +		 || (err = device_create_file(&new_client->dev,
> > +					      &dev_attr_temp1_max))
> > +		 || (err = device_create_file(&new_client->dev,
> > +					      &dev_attr_temp1_max_hyst)))
> > +			goto exit_remove_files;
> > +	}
> > +
> >  	data->class_dev = hwmon_device_register(&new_client->dev);
> >  	if (IS_ERR(data->class_dev)) {
> >  		err = PTR_ERR(data->class_dev);
> > -		goto exit_detach;
> > +		goto exit_remove_files;
> >  	}
> >  
> > -	device_create_file(&new_client->dev, &dev_attr_in0_input);
> > -	device_create_file(&new_client->dev, &dev_attr_in0_min);
> > -	device_create_file(&new_client->dev, &dev_attr_in0_max);
> > -	device_create_file(&new_client->dev, &dev_attr_in1_input);
> > -	device_create_file(&new_client->dev, &dev_attr_in1_min);
> > -	device_create_file(&new_client->dev, &dev_attr_in1_max);
> > -	device_create_file(&new_client->dev, &dev_attr_in2_input);
> > -	device_create_file(&new_client->dev, &dev_attr_in2_min);
> > -	device_create_file(&new_client->dev, &dev_attr_in2_max);
> > -	device_create_file(&new_client->dev, &dev_attr_in3_input);
> > -	device_create_file(&new_client->dev, &dev_attr_in3_min);
> > -	device_create_file(&new_client->dev, &dev_attr_in3_max);
> > -	if (data->maxins = 4) {
> > -		device_create_file(&new_client->dev, &dev_attr_in4_input);
> > -		device_create_file(&new_client->dev, &dev_attr_in4_min);
> > -		device_create_file(&new_client->dev, &dev_attr_in4_max);
> > -	}
> > -	device_create_file(&new_client->dev, &dev_attr_fan1_input);
> > -	device_create_file(&new_client->dev, &dev_attr_fan1_min);
> > -	device_create_file(&new_client->dev, &dev_attr_fan1_div);
> > -	device_create_file(&new_client->dev, &dev_attr_fan2_input);
> > -	device_create_file(&new_client->dev, &dev_attr_fan2_min);
> > -	device_create_file(&new_client->dev, &dev_attr_fan2_div);
> > -	device_create_file(&new_client->dev, &dev_attr_alarms);
> > -	if (data->maxins = 3) {
> > -		device_create_file(&new_client->dev, &dev_attr_temp1_input);
> > -		device_create_file(&new_client->dev, &dev_attr_temp1_max);
> > -		device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
> > -	}
> >  	return 0;
> >  
> > +exit_remove_files:
> > +	sysfs_remove_group(&new_client->dev.kobj, &sis5595_group);
> > +	sysfs_remove_group(&new_client->dev.kobj, &sis5595_group_opt);
> >  exit_detach:
> >  	i2c_detach_client(new_client);
> >  exit_free:

Thanks for the review!

-- 
Jean Delvare

