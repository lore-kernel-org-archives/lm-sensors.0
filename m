From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 12 Feb 2014 11:56:36 +0000
Subject: Re: [lm-sensors] [PATCH 09/12] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <1392206196.848.18.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140212024904.GA19352@roeck-us.net>
In-Reply-To: <20140212024904.GA19352@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean Delvare <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, 2014-02-12 at 02:49 +0000, Guenter Roeck wrote:
> On Tue, Feb 11, 2014 at 05:10:33PM +0000, Pawel Moll wrote:
> > Use devm_hwmon_device_register_with_groups instead of
> > the old-style manual attributes and hwmon device registration.
> > 
> 
> [ ... ]
> 
> >  static int vexpress_hwmon_probe(struct platform_device *pdev)
> >  {
> > -	int err;
> >  	const struct of_device_id *match;
> >  	struct vexpress_hwmon_data *data;
> > +	const char *name;
> > +	const struct attribute_group **groups;
> >  
> >  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> > @@ -176,42 +151,19 @@ static int vexpress_hwmon_probe(struct platform_device *pdev)
> >  		return -ENODEV;
> >  
> 
> There is a leftover platform_set_drvdata() above which you can remove;
> attributes are now attached to the hwmon device and no longer
> to the platform device.

Right, missed this fact. Will remove.

BTW. It's cool that the attributes live in the class device now. You
probably don't remember, but in the very first version of the driver I
was trying to get this point with some tricks that weren't taken
nicely ;-)

> > -	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
> > -	sysfs_remove_group(&pdev->dev.kobj, match->data);
> > +	name = of_get_property(pdev->dev.of_node, "compatible", NULL);
> 
> Couple of problems, two of which escaped me earlier.
> First, can of_get_property ever return NULL ? I think not, just wondering.

Generally it can, but not in this particular case, no. The device
wouldn't get bound to the driver if it lacked the "compatible" property.

> Second is a real problem. You have a '-' in the compatible property which is
> illegal for the 'name' attribute in hwmon devices. It messes up libsensors
> and thus every application using it. Not sure what a good fix (or name)
> would be; simplest might be to copy the name string and replace it with '_'.
> Sorry for not noticing this earlier; it might actually make sense to submit
> a separate patch to address this so we can apply it to the current kernel
> and if necessary patch it into earlier kernels.

Ok, will do. Either with s/-/_/ or with a name lookup table.

Interestingly enough I never observed any problem with libsensors (3.3.2
was the one I used) on my board...

> Third, I noticed that the 'label' attribute is always created but returns  
> -ENOENT if there is no label. A much better implementation would be to use
> .is_visible and not create the label attribute if its devicetree entry
> does not exist. I don't know how libsensors reacts to -ENOENT on a read,
> but no matter how it does react, it is pretty much undefined.
> Again, that should be handled in a separate patch.

> I agree with Arnd that it would be nice to get rid of the local macro,
> but I won't mandate that.

I actually prefer to have the structures unfolded, but was just trying
to mimic the trend in other hwmon drivers. No problem - will change this
gladly.

Pawel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
