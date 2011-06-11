From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 11 Jun 2011 16:11:05 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] hwmon: (s3c) Initialize sysfs
Message-Id: <20110611161105.GC26406@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306267814-31505-6-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306267814-31505-6-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 11, 2011 at 06:01:49AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 24 May 2011 13:10:14 -0700, Guenter Roeck wrote:
> > Initialize dynamically allocated sysfs attributes before device_create_file()
> > call to suppress lockdep_init_map() warning if lockdep debugging is enabled.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > Compile tested only.
> 
> Seems incomplete to me...
> 
> > 
> >  drivers/hwmon/s3c-hwmon.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
> > index 92b42db..731d1f3 100644
> > --- a/drivers/hwmon/s3c-hwmon.c
> > +++ b/drivers/hwmon/s3c-hwmon.c
> > @@ -232,6 +232,7 @@ static int s3c_hwmon_create_attr(struct device *dev,
> >  
> >  	attr = &attrs->in;
> >  	attr->index = channel;
> > +	sysfs_attr_init(&attr->dev_attr.attr);
> >  	attr->dev_attr.attr.name  = attrs->in_name;
> >  	attr->dev_attr.attr.mode  = S_IRUGO;
> >  	attr->dev_attr.show = s3c_hwmon_ch_show;
> 
> A few lines below, a second optional attribute is used for the label.
> So you also need:
> 
> --- linux-3.0-rc2.orig/drivers/hwmon/s3c-hwmon.c	2011-06-11 11:51:17.000000000 +0200
> +++ linux-3.0-rc2/drivers/hwmon/s3c-hwmon.c	2011-06-11 11:51:14.000000000 +0200
> @@ -250,6 +250,7 @@ static int s3c_hwmon_create_attr(struct
>  
>  		attr = &attrs->label;
>  		attr->index = channel;
> +		sysfs_attr_init(&attr->dev_attr.attr);
>  		attr->dev_attr.attr.name  = attrs->label_name;
>  		attr->dev_attr.attr.mode  = S_IRUGO;
>  		attr->dev_attr.show = s3c_hwmon_label_show;
> 
> (Not even build-tested, but that should work.)
> 
> With this change added:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Good catch, fixed, applied, and added Cc: for stable.

> Thanks for finally fixing all these warnings, BTW, they've been there
> for quite some time...
> 
Yes, I figured since I was looking into the problem anyway after it was found
in the coretemp driver, I should spend the time to track it down everywhere ...
I just hope I found all instances.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
