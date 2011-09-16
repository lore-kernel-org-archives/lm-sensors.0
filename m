From: Lucas Stach <dev@lynxeye.de>
Date: Fri, 16 Sep 2011 13:05:39 +0000
Subject: Re: [lm-sensors] [RFC 1/2] add new hwmon-core interface v3
Message-Id: <1316178339.2018.15.camel@tellur>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316119550.25490.14.camel@tellur>
In-Reply-To: <1316119550.25490.14.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Hans,

Am Freitag, den 16.09.2011, 10:37 +0200 schrieb Hans de Goede:
> Hi,
> 
> On 09/16/2011 12:31 AM, Lucas Stach wrote:
> > v3: now checkpatch clean (doh!)
> > Many of the errors were caused by my attempt to make all these
> > definitions readable. Now I think I have a good compromise between
> > readability and making checkpatch happy.
> >
> >
> > This adds a new hwmon-core interface to centralize sysfs handling
> > and enable cooperation with other in-kernel drivers.
> 
> First of all a big thanks for working on this, having a way for other in-kernel
> drivers to access hwmon devices is a much needed feature for proper gpu power
> management.
> 
> However I'm afraid that the current implementation needs some work. My biggest
> reason to nack this at this time is that it is not flexible enough.
> 
> My biggest concern wrt flexibility is that the current code assumes that
> all temperature / voltage / fan sensors of a hwmon ic have the same capabilities
> (and thus the same sysfs attributes) that is simply not true. On for example
> the f71882fg (and other models supported by that driver), only one of the
> 3 - 9 voltage inputs has an alarm capability, and thus alarm and max attributes.

Handling different caps on every channel will make the interface a bit
more complicated, as I don't want to waste too much space for the caps,
but it should be doable with reasonable effort.

> 
> Another concern is that it always assumes 1 dimensional indexing, but if you
> look at automatic fan control related sysfs attributes (which your code currently
> does not seem to support), then there is 2 dimensional indexing going on there,
> for each fan or temperature (depending on if the thresholds one can configure are
> bound to a fan input/output, or to a temp input) one can set multiple thresholds
> (and per threshold a corresponding pwm duty cycle). One could simply see this
> as 1 dimensional with a lot of attributes, but it would be much better (and easier
> from the driver pov) to implement this 2 dimensional.

Really it's the other way around. It doesn't support trip point handling
as I haven't implemented 2 dimensional indexing. :)

Originally I wanted to do this in a second iteration of the interface,
but if you say I'm generally moving in the right direction I will
happily incorporate support for 2d entries in a v4 of this patch.
> 
> For a good idea of how complicated a hwmon driver can grow when it comes to
> having a wild mix of sysfs attributes, where the type of attributes can
> vary from one channel to the next take a look at the f71882fg driver, if your
> code can handle converting that to the new hwmon-core interface (and preferably
> clean up the driver while doing so), then it has the needed flexibility.

Ok, will take a look at this. Hopefully I'm not too depressed afterwards
to work on. ;)

> 
> An other issue you need to tackle is non continuous indexes. Some drivers have
> the ability to handle large amounts of channels, for example the sch5636 has
> upto 5 voltage inputs, 16 temperatures and 8 fans. Almost no motherboard
> will use these all, and the BIOS should program the chip to disable unused
> channels, we read this information back and only add sysfs attributes for
> enabled channels, which can lead to having fan1 and fan6 but nothing in between.
> Note that when you've per sensor rather then per channel caps, you can essentially
> handle this for free, since an unused index can simply be a channel without any
> caps.

Do we really have to reflect the hole in sensor numbering? Isn't it
enough to only expose the supported number of channels in the interface
and do the remapping index->channel within the driver? This would be
simple with the current interface, as you can reflect this mapping in
the inst_data, which is passed around. Is there any application or
use-case relying on the numbering hole being existent?

> And one last nitpick wrt the current implementation:
> > +static ssize_t get_num(struct device *dev,
> > +		       struct device_attribute *devattr, char *buf)
> > +{
> > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +	struct hwmon_device_attribute *hw_attr = to_hwmon_device_attr(attr);
> > +	struct hwmon_device_instance *hw_dev = hw_attr->hw_dev_inst;
> > +	int value, ret;
> > +	ret = hw_dev->get_numeric_attr(hw_dev->inst_data,
> > +				       hw_attr->attr_enum, attr->index,&value);
> > +	if (ret)
> > +		return ret;
> > +	ret = snprintf(buf, PAGE_SIZE, "%u\n", value);
> 
> value is a signed int, so that should be %d, and we really want that as
> things like negative temperatures are possible.
> 
Ok, this is a no brainer for v4.

Thanks for your feedback,
Lucas

> Regards,
> 
> Hans
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
