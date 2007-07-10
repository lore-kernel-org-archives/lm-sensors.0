From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jul 2007 13:25:24 +0000
Subject: Re: [lm-sensors] de-macro-fy w83627hf.c
Message-Id: <20070710152524.56546dd5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070709185335.dc6b94b0.krzysztof.h1@wp.pl>
In-Reply-To: <20070709185335.dc6b94b0.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Mon, 9 Jul 2007 18:53:35 +0200, Krzysztof Helt wrote:
> Jim Cromie wrote:
> > diff -ruNp -X dontdiff -X exclude-diffs lx-22rc7-hwmon/drivers/hwmon/w83627hf.c lx-22rc7-hwmon-slim/drivers/hwmon/w83627hf.c
> > --- lx-22rc7-hwmon/drivers/hwmon/w83627hf.c	2007-07-01 13:54:24.000000000 -0600
> > +++ lx-22rc7-hwmon-slim/drivers/hwmon/w83627hf.c	2007-07-07 17:50:16.000000000 -0600
> > (...)
> > +	struct w83627hf_data *data = w83627hf_update_device(dev);
> > +	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->in[attr->index]));
> 
> There is no need to cast it to long. The IN_FROM_REG macro multiply by 16 only and in value is u8. Print it
> as unsigned int (or int) as the most natural type for it. 
> 
> All comments above apply to two following functions.

I really appreciate that you started reviewing the patches that are
being sent to the lm-sensors mailing list, but in this specific case, I
have to contradict you. Jim has written a patch which does one thing:
convert macro-generated functions to dynamic sysfs callbacks. He should
not include unrelated changes in the same patch, otherwise reviewing and
testing the patch becomes much more difficult. The cleanups you suggest
may be good ideas, but if they are implemented, that must be in a
separate patch, applying on top of Jim's one.

Same for most of your comments to this patch.

> > -static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
> > -	const char *buf, size_t count)
> > +static ssize_t store_in_max0(struct device *dev, struct device_attribute *attr,
> > +			     const char *buf, size_t count)
> >  {
> >  	struct w83627hf_data *data = dev_get_drvdata(dev);
> >  	u32 val;
> > @@ -504,70 +503,58 @@ static ssize_t store_regs_in_max0(struct
> >  	return count;
> >  }
> >  
> > -static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL);
> > +static DEVICE_ATTR(in0_input, S_IRUGO, show_in_0, NULL);
> 
> Why this one is not SENSOR_DEVICE_ATTR as other inX values?

Because this callback needs no parameter (attr->index) contrary to the
other callbacks.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
