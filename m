From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <2538186705050308573061bb58@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/28/05, Greg KH <greg@kroah.com> wrote:
> On Thu, Apr 28, 2005 at 01:25:29PM -0400, Yani Ioannou wrote:
> > > My question is, please show me how you propagate this out to the driver
> > > core code, so that the drivers that use the DEVICE_ATTRIBUTE() stuff can
> > > take advantage of this.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
> > Well bmcsensors (before this patch) was creating device attributes
> > like the other chip drivers, just not explicitly using the
> > DEVICE_ATTRIBUTE macro, however I can easily modify one of the other
> > sensor chip drivers to show you how they might take advantage of this
> > if that what you are looking for? I'll probably have to do it tonight
> > after I get home though :-).
> 
> Yes, that is what I was looking for.
> 
> thanks,
> 
> greg k-h
> 

Hi, sorry for the delay. 

Obviously the drivers with more device attributes will benefit the
most from the patch (and in the extreme case of unlimited, like
bmcsensors), so I chose to demonstrate a patch for adm1026.c which
seems to have one of the largest number of attributes for the i2c
chips.

I've included a modified version of the previous dynamic callback
patch where I defined a DEVICE_ATTR_DATA macro which becomes useful in
these cases, likely in any real patch this would be rolled into the
DEVICE_ATTR macro but for simplicity (i.e. not breaking everything
else that uses DEVICE_ATTR out there) I'm using a separate one for
now.

The second attached patch simply modifies the driver to avoid compiler
warnings from using invalid show/store function pointers - this is the
bare minimum change a driver would need to make (although leaving the
warnings doesn't affect anything functionally I for one hate seeing
warnings on a kernel compile).

The third patch shows how we could get rid of the macro defined hoard
of static sysfs callbacks in the easiest and probably the best way -
define ints for indexes and pass pointers to them as void *data. This
compiles and should work fine (sorry can't test this since I don't
have this chip). Loading the module though the size difference is
again apparent:

-------------------2.6.11.7--------------------
Module                  Size  Used by
adm1026                44692  0
--------2.6.12-rc3-devdyncallback-----
Module                  Size  Used by
adm1026                33172  0


You can see in this example why Jean is not convinced that void * is
better than passing an int, in the case of the i2c chip drivers the
majority seem to do something along these lines, and really an int
suffices. In the grand scheme of things though I think the void * is
much more flexible.

Taking things even further you might restructure the the adm1026_data
structure and group together the related sensor attributes so that we
can pass a pointer to a data structure instead of the int index,
something like:

struct in_data {
	int id;
	u8 value;            /* Register value */
	u8 max;              /* Register value */
	u8 min;              /* Register value */
};

struct fan_data {
	int id;
	u8 value;           /* Register value */
	u8 min;             /* Register value */
	u8 div;             /* Decoded value */
};


struct temp_data {
	int id;
	s8 value;          /* Register value */
	s8 min;            /* Register value */
	s8 max;            /* Register value */
	s8 tmin;           /* Register value */
	s8 crit;           /* Register value */
	s8 offset;         /* Register value */	
};

struct adm1026_data {
	...
	struct in_data in[17];     /* Volt Sensor Data */
	struct fan_data fanp[8];     /* Fan Sensor Data */
	struct temp_data temp[3];    /* Temp Sensor Data */
	struct pwm_data pwm1;   /* Pwm control values */

	/* Voltage sensor device attributes */
	struct device_attribute in_reg_attr[17];
	struct device_attribute in_min_attr[17];
	struct device_attribute in_max_attr[17];
	
	/* Fan sensor device attributes */
	struct device_attribute fan_input_attr[8];
	struct device_attribute fan_min_attr[8];
	...
}

We would then be able to just use the passed data structure (e.g.
temp_data[offset] for a temp attribute callback) in the sysfs callback
as in the bmcsensors patch.

This won't work with static device_attributes like adm1026 uses
because we encounter the problem Dmitry described - adm1026 allows
multiple i2c_clients each with it's own adm1026_data structure, but
all of them would share the same static device_attribute. The
integer/index passed data above works because the adm1026 sensors
always have the same index for any i2c client. To pass something
client specific therefore each client would have to have it's own
device attribute created in the adm1026_init_client() rather than a
shared static one. This isn't worth the trouble or extra space for
something like adm1026 though, and is really only useful for something
like bmcsensors where we have to dynamically allocate the device
attributes.

Thanks,
Yani
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc3-devdyncallback-driversys.diff
Type: text/x-patch
Size: 2169 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050503/7163a9b5/patch-linux-2.6.12-rc3-devdyncallback-driversys.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adm1026-devdyncallback.nowarn.diff
Type: text/x-patch
Size: 19384 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050503/7163a9b5/adm1026-devdyncallback.nowarn.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adm1026-devdyncallback.sensor_nr.diff
Type: text/x-patch
Size: 29367 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050503/7163a9b5/adm1026-devdyncallback.sensor_nr.bin
