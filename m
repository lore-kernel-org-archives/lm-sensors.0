From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 06 Jul 2005 17:40:56 +0000
Subject: [lm-sensors] Re: [RFC PATCH] hwmon sysfs class, again
Message-Id: <20050703145207.GA15875@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050628041414.GA32087@jupiter.solarsys.private>
In-Reply-To: <20050628041414.GA32087@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

Thanks for the review.

* Jean Delvare <khali@linux-fr.org> [2005-06-28 12:44:07 +0200]:
> 
> Hi Mark,
> 
> > Here are the "new and improved" hwmon sysfs class patches:
> >
> > http://members.dca.net/mhoffman/sensors/temp/20050627/
> 
> Looks all OK to me, except for:
> 
> > --- linux-2.6.12-git5.orig/drivers/hwmon/adm1026.c
> > +++ linux-2.6.12-git5/drivers/hwmon/adm1026.c
> > (...)
> > @@ -1690,8 +1701,10 @@ int adm1026_detect(struct i2c_adapter *a
> > (...)
> >  exitfree:
> > -	kfree(new_client);
> > +	kfree(data);
> 
> Although this fix is correct, it would belong to
> hwmon-chips-kfree-fix.patch, not hwmon-class-chips.patch.
> 
> Also, it looks to me like adm9240, smsc47m1 and smsc47b397 need the same
> fix.

right - fixed all of that

> > --- linux-2.6.12-git5.orig/drivers/hwmon/asb100.c
> > +++ linux-2.6.12-git5/drivers/hwmon/asb100.c
> > (..)
> > +        data->class_dev = hwmon_device_register(&new_client->dev);
> > +        if (IS_ERR(data->class_dev)) {
> > +                err = PTR_ERR(data->class_dev);
> > +                goto ERROR3;
> > +        }
> 
> Beware you are using spaces instead of tabulations here.

oops - fixed

> > --- linux-2.6.12-git5.orig/drivers/hwmon/w83781d.c
> > +++ linux-2.6.12-git5/drivers/hwmon/w83781d.c
> > (...)
> > +ERROR4:
> > +	if (NULL != data->lm75[1]) {
> > +		i2c_detach_client(data->lm75[1]);
> > +		kfree(data->lm75[1]);
> > +	}
> > +	if (NULL != data->lm75[0]) {
> > +		i2c_detach_client(data->lm75[0]);
> > +		kfree(data->lm75[0]);
> > +	}
> 
> Please express the comparisons the other way around. I can guess why you
> did it this way, but the usual style in the kernel is different and gcc
> would warn you anyway.

Actually, there were two of those already in the file (probably by me though).
I prefer 'if (p)' myself, but the day job code style is stamped on my brain,
heh.  Anyway, they're fixed.

New patches here:

http://members.dca.net/mhoffman/sensors/temp/20050703/

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

