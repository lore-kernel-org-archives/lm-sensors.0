From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 14 Aug 2006 13:17:58 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060814151758.842fd027.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Jim,

> * Jim Cromie <jim.cromie at gmail.com> [2006-08-03 13:40:59 -0600]:
> > Im completely impressed by how clean Mark's patch is.
> > In the end, the elegance seduced me, patch follows.
> > 
> > in the start, I cut-pasted my own remove-bunch/group.
> > its if-0'd now, to be yanked..
> > 
> > In contrast with Mark's declarative grouping, Im doing it at runtime:
> >      pc87360_detect()
> >             calls add_tothe_group() to add it to one_big_group[] for 
> > each sensor-attr wanted,
> >              then calls sysfs_create_group()
> 
> What is the point of generating the group at runtime?

Having a single file group to create and delete. I made something
similar for the pcf8591 driver (although I didn't publish that patch
yet.)

> > Its probly worth noting that pc87360 now does:    hwmon_register b4 
> > sysfs_create_group
> > whereas Mark's patch does the opposite.   Does this matter ??
> 
> I changed the ordering in asb100 on purpose... it closes the small window
> of time between when the hwmon class is registered and the device attributes
> are populated.  It's something of a race condition... sensors(1) could run
> in the middle of that.

And I second that change. We should fix all drivers in a similar way,
before we add feature detection capability to libsensors.

> > --- ../linux-2.6.18-rc3-sk/drivers/hwmon/pc87360.c	2006-06-17 19:49:35.000000000 -0600
> > +++ sysdev/drivers/hwmon/pc87360.c	2006-08-03 12:58:29.000000000 -0600
> > @@ -829,6 +829,83 @@ static int __init pc87360_find(int sioad
> >  	return 0;
> >  }
> >  
> > +/* Declare and use an attribute-group for simplicity.
> > +   This driver declares all attributes statically, so we count uses of 
> > +   SENSOR_ATTR, DEVICE_ATTR, and add 1 space for trailing NULL (+0 fudge)
> > +*/
> > +#define ENOUGH_ATTRS	89 + 4 + 1 + 0

My experience is that this kind of construct is likely to break as soon
as the driver evolves :( I see you check carefully so no overflow can
happen, good, but still...

> > +static struct attribute *one_big_group[ENOUGH_ATTRS];
> > +static int next_member;
> > +
> > +static struct attribute_group my_group = {
> > +	.attrs = one_big_group
> > +};
> > +
> > +static void add_tothe_group(struct device *dev,
> > +				struct device_attribute *devattr)
> > +{
> > +	/* add attr to the group for later sysfs_create_group */
> > +	if (next_member < ENOUGH_ATTRS)
> > +		one_big_group[next_member++] = &devattr->attr;
> > +	else {
> > +		BUG_ON("too many in group for static alloc!\n");
> > +		dev_err(dev, "too many in group for static alloc!\n");
> > +	}
> > +}
> > +
> > +#if 0
> > +static void remove_all_devattr_files(struct device *dev)
> > +{
> > +	int i;
> > +	/* Mark Hoffman used sysfs_remove_group here, it nicely tracks
> > +	   group membership, at cost of array of pointers.  For now,
> > +	   stick w non-group approach - cost is cut-paste in-elegance
> > +	   & maint if sensor set changes */
> > +
> > +	dev_info(dev, "created %d attr-files, w errs %d.  now destroying\n",
> > +		 next_member, devattr_file_create_errs);
> > +
> > +	/* tiny cheat - rely on size equivalence of {type}_{attr}[]
> > +	   arrays across all attrs for each type (declared that way)
> > +	*/
> > +	for (i = 0; i < ARRAY_SIZE(in_input); i++) {
> > +		device_remove_file(dev, &in_input[i].dev_attr);
> > +		device_remove_file(dev, &in_min[i].dev_attr);
> > +		device_remove_file(dev, &in_max[i].dev_attr);
> > +		device_remove_file(dev, &in_status[i].dev_attr);
> > +	}
> > +	device_remove_file(dev, &dev_attr_cpu0_vid);
> > +	device_remove_file(dev, &dev_attr_vrm);
> > +	device_remove_file(dev, &dev_attr_alarms_in);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(temp_input); i++) {
> > +		device_remove_file(dev, &temp_input[i].dev_attr);
> > +		device_remove_file(dev, &temp_min[i].dev_attr);
> > +		device_remove_file(dev, &temp_max[i].dev_attr);
> > +		device_remove_file(dev, &temp_crit[i].dev_attr);
> > +		device_remove_file(dev, &temp_status[i].dev_attr);
> > +	}
> > +	device_remove_file(dev, &dev_attr_alarms_temp);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(therm_input); i++) {
> > +		device_remove_file(dev, &therm_input[i].dev_attr);
> > +		device_remove_file(dev, &therm_min[i].dev_attr);
> > +		device_remove_file(dev, &therm_max[i].dev_attr);
> > +		device_remove_file(dev, &therm_crit[i].dev_attr);
> > +		device_remove_file(dev, &therm_status[i].dev_attr);
> > +	}
> > +	for (i = 0; i < ARRAY_SIZE(fan_input); i++) {
> > +		device_remove_file(dev, &fan_input[i].dev_attr);
> > +		device_remove_file(dev, &fan_min[i].dev_attr);
> > +		device_remove_file(dev, &fan_div[i].dev_attr);
> > +		device_remove_file(dev, &fan_status[i].dev_attr);
> > +		device_remove_file(dev, &pwm[i].dev_attr);
> > +	}
> > +
> > +	dev_info(dev, "remaining attr-files %d\n", next_member);
> > +}
> > +#endif
> > +
> >  static int pc87360_detect(struct i2c_adapter *adapter)
> 
> You can't fill your static array from here.  What if you have two
> pc87360s?  If you're going to do it at runtime, it has to be during
> module init.  But again, why do it at runtime in the first place?

There will never be two PC87360s in a machine, that wouldn't make
sense. But this raises a concern about Jim's approach: it only works
for drivers which can handle a single chip, or at least where all chips
are guaranteed to share the exact same configuration. I took that
shortcut for the PCF8591 as well, but on second though it's plain
wrong. This doesn't fit in the device driver model at all. Given that
we want to convert all i2c-isa drivers to platform drivers at the end
of this year, and the i2c subsystem to the driver model hopefully even
before that, we are shooting ourselves in the feet if we go Jim's (and
my) way.

Mark's approach is magnitudes better.

Jim, sorry about that, nothing personal ;) Thanks for your contribution
anyway, I'm certain it helps Mark refine his own excellent ideas :)

-- 
Jean Delvare

