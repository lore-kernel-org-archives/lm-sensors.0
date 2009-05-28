From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 May 2009 15:55:33 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <20090528175533.2c7702af@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 May 2009 16:21:34 +0100, Ben Dooks wrote:
> Jean Delvare wrote:
> > Hi Ben,
> > 
> 
> [snip]
> 
> >> +	struct device		*hwmon_dev;
> >> +
> >> +	struct sensor_device_attribute *in_attr[8];
> > 
> > What is the benefit of allocating these attributes dynamically? You are
> > likely to fragment your memory and require ugly code to make it work.
> 
> I suppose if we're only looking at producing a single in
> or in and label attribute then it is only 24+name bytes
> for each attribute.
> 
> [snip]
> 
> >> +static int s3c_hwmon_create_attr(struct s3c_hwmon *hwmon,
> >> +				 struct s3c_hwmon_pdata *pdata,
> >> +				 int channel)
> >> +{
> >> +	struct s3c_hwmon_chcfg *cfg = pdata->in[channel];
> >> +	struct sensor_device_attribute *attr;
> >> +	const char *name;
> >> +
> >> +	if (!cfg)
> >> +		return 0;
> >> +
> >> +	attr = kzalloc(sizeof(*attr) + MAX_LABEL, GFP_KERNEL);
> >> +	if (attr = NULL)
> >> +		return -ENOMEM;
> >> +
> >> +	if (cfg->name)
> >> +		name = cfg->name;
> >> +	else {
> >> +		name = (char *)(attr+1);
> >> +		snprintf((char *)(attr+1), MAX_LABEL, "in_%d", channel);
> > 
> > This name doesn't match what is described in
> > Documentation/hwmon/sysfs-interface, which means that your driver won't
> > work with libsensors. This is a blocker.
> 
> Ah, having re-read it, it seems the name should go in in%d_label sysfs 
> field as well as changing in_%d to in%d_input.

Correct. Then you no longer need dynamic attribute names, which will
make your code much more simple.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
