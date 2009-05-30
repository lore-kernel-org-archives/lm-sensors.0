From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 30 May 2009 14:53:51 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <20090530165351.48b8bb75@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 30 May 2009 14:47:03 +0100, Ben Dooks wrote:
> Jean Delvare wrote:
> > On Thu, 28 May 2009 21:42:20 +0100, Ben Dooks wrote:
> >> +static int s3c_hwmon_read_ch(struct device *dev,
> >> +			     struct s3c_hwmon *hwmon, int channel)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = down_interruptible(&hwmon->lock);
> >> +	if (ret < 0)
> >> +		return ret;
> > 
> > Why do you need locking here? If any locking is needed, I am reasonably
> > certain it should be handled by the s3c adc core rather than drivers
> > using it.
> 
> I'd rather leave the locking to the client, as in this case
> we use down_interruptible() so the user can interrupt the
> call if necessary.

What are you protecting? And how are you protecting it with a
per-client lock, if there are several clients?

> >> (...)
> >> +static inline int s3c_hwmon_add_raw(struct device *dev)
> >> +{
> >> +	int ret, i;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(s3c_hwmon_attrs); i++) {
> >> +		ret = device_create_file(dev, s3c_hwmon_attrs[i]);  
> > 
> > Is it OK to create entries for channels which do not exist?  
> 
> The channels always exist, the pdata specifies which channels
> the board wants to export to userspace via hwmon.

OK. Then you may want to consider declaring a group of attribute and
register it all at once. This saves you the hassle of handling the
errors manually.

> >> (...)
> >> +static int s3c_hwmon_create_attr(struct device *dev,
> >> +				 struct s3c_hwmon_chcfg *cfg,
> >> +				 struct s3c_hwmon_attr *attrs,
> >> +				 int channel)
> >> +{
> >> +	struct sensor_device_attribute *attr;
> >> +	int ret;
> >> +
> >> +	if (!cfg)
> >> +		return 0;
> >> +
> >> +	snprintf(attrs->in_name, sizeof(attrs->in_name), "in%d_input", channel);
> >> +
> >> +	attr = &attrs->in;
> >> +	attr->index = channel;
> >> +	attr->dev_attr.attr.name  = attrs->in_name;
> >> +	attr->dev_attr.attr.mode  = S_IRUGO;
> >> +	attr->dev_attr.attr.owner = THIS_MODULE;
> >> +	attr->dev_attr.show = s3c_hwmon_ch_show;
> >> +
> >> +	ret =  device_create_file(dev, &attr->dev_attr);
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "failed to create input attribute\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	/* if this has a name, add a label */
> >> +	if (cfg->name) {
> >> +		snprintf(attrs->label_name, sizeof(attrs->label_name),
> >> +			 "in%d_label", channel);
> >> +
> >> +		attr = &attrs->label;
> >> +		attr->index = channel;
> >> +		attr->dev_attr.attr.name  = attrs->label_name;
> >> +		attr->dev_attr.attr.mode  = S_IRUGO;
> >> +		attr->dev_attr.attr.owner = THIS_MODULE;
> >> +		attr->dev_attr.show = s3c_hwmon_label_show;
> >> +
> >> +		ret = device_create_file(dev, &attr->dev_attr);
> >> +		if (ret < 0) {
> >> +			device_remove_file(dev, &attrs->in.dev_attr);
> >> +			dev_err(dev, "failed to create label attribute\n");
> >> +		}
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> > 
> > I don't understand why you insist on creating these attributes
> > dynamically. Almost all other hwmon drivers declare the attributes in a
> > static manner, and only the decision to create each attribute for a
>         you probably wanted to use add here instead of reusing create.
> > given device is decided at runtime. This makes the code much smaller.
> 
> I've always prefered to avoid static data when there's a possiblity
> the device may not be instantiated for the particular machine the
> kernel is being booted on.
> 
> The code itself is 256 bytes, wheras having two arrays of attributes
> would turn up at 384 bytes not including the code to call
> device_create_file() as appropriate.

You didn't count the memory you have to allocate in the dynamic case,
so the comparison is hardly fair. That can't be less than the static
data if all 8 channels are used, and it's even likely to be somewhat
more due to memory fragmentation. Then of course the exact computation
depends on how many channels you expect to have on average.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
