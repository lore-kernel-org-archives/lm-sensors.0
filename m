From: dtor@insightbb.com (Dmitry Torokhov)
Date: Tue, 22 Aug 2006 00:43:05 +0000
Subject: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error
Message-Id: <200608212043.06256.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E8C9AE.3060307@gmail.com> <20060821100416.4d356328.khali@linux-fr.org>
In-Reply-To: <20060821100416.4d356328.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Andrew Morton <akpm@osdl.org>, lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>

On Monday 21 August 2006 04:04, Jean Delvare wrote:
> > --- linux-work-clean/drivers/hwmon/w83627hf.c	2006-08-20 22:02:40.000000000 +0200
> > +++ linux-work/drivers/hwmon/w83627hf.c	2006-08-20 22:27:14.000000000 +0200
> > @@ -513,9 +513,21 @@ static DEVICE_ATTR(in0_max, S_IRUGO | S_
> > 
> >  #define device_create_file_in(client, offset) \
> >  do { \
> > -device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> > -device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> > -device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> > +	if (err) {\
> > +		hwmon_device_unregister(data->class_dev); \
> > +		return err; \
> > +	} \
> > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> > +	if (err) {\
> > +		hwmon_device_unregister(data->class_dev); \
> > +		return err; \
> > +	} \
> > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> > +	if (err) {\
> > +		hwmon_device_unregister(data->class_dev); \
> > +		return err; \
> > +	} \
> >  } while (0)
> 
> _Never_ use "return" in a macro. It's way too confusing for whoever will
> read the code later.
>

Also I believe it is good practice to remove created attributes explicitely
instead of relying on sysfs to do the cleanup - I beliee Greg was going to
remove it from sysfs at some point of time... 

-- 
Dmitry

