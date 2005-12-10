From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 10 Dec 2005 10:21:34 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <20051210112134.6c2a947f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> back in pre-14 days, I proposed a set of patches to hwmon/pc87360.c
> Id like to revisit the parts that didnt make it into 2.6.14,
> and see whether it might be consistent with some of Greg KHs
> longer term plans for sysfs rework  LWN 12/1

I just read that article, it doesn't seem to really mention anything
concrete. I'm not sure if your work on the pc87360 attributes are
anyhow related to any change Greg has in mind. Grouping the attributes
registration has been long needed for many hardware monitoring drivers
anyway. Individual file registration is very costly in terms of driver
size when there are many attributes.

> So, attached (sorry) is a patch (for discussion purposes), doing:
> 
> hwmon-sysfs.h:
> 
> gets a new __SENSOR_DEVICE_ATTR, which expands into an initialization, 
> like so:
> 
> +#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)    \
> +struct sensor_device_attribute sensor_dev_attr_##_name         \
> +       = __SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)

On November 23rd, I sent a similar patch to you and this list, mostly
derived from yours:

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014433.html

So it's great that you come back to me on that topic now. My version
has shorter names and a few cosmetic changes. It's in my local stack :

http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-allow-sensor-attr-arrays.patch

But I did not send it to Greg for integration yet. I was waiting for
some ack from you or others, and for a driver actually using the added
possibility.

> pc87360.c:
> 
> replaces many uses of SENSOR_DEVICE_ATTR with
> struct sensor_device_attribute array[] = { ..} 
> declarations and initializations using the new macro,
> and rolls lists of device_create_file into loops over those arrays.
> 
> Also includes a few macros that probly arent general enough for a .h,
> but are useful abbreviations here

I am working on similar changes on a different driver myself. This
driver (f71805f) I have not released yet because it is implemented as a
platform driver and there are still some changes needed to the core
part for it to work properly. You may take a look at it here though:

http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-new-driver.patch

This initial version uses the old individual attribute file
registration approach. From there, there are two possibilities to get
the attributes registered as groups:

1* Using sysfs_create_group(), as Greg KH suggested. This doesn't need
any preliminary patch. The patch is here:

http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-sysfs-group.patch

2* Using arrays of attributes and looping over them, as you proposed
for the pc87360 driver. This needs the preliminary hwmon-sysfs.h patch.
The patch is here:

http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-use-attr-array.patch

This second patch has my preference as it makes the code significantly
smaller. I don't much like the sysfs_create_group interface because it
forces you to create two additional data structures you otherwise have
no need for.

I am not totally sure what I want to do here, so hints in either
direction are welcome.

As far as your pc87360 driver patch is concerned, the diffences with my
f71805f patch seem to be as follows:

1* You introduce macros to make the attribute array definitions
shorter, I do not. I don't much like macros, they tend to make the code
more obscure to the reader, hide size costs and break grep and LXR.
They also increase the preprocessing time, which unfortunately distcc
cannot distribute. The point of Yani Ioannou's dynamic sysfs callbacks
was to remove a whole lot of macros, and we have a similar opportunity
here.

Now, I won't force my view on this to anyone. Just think about it and
compare your code with mine. If you still think using macros is better,
that's OK with me.

2* You defined many individual arrays for each type of attribute. I did
group them as much as possible, so in the end I only have three arrays.
The pc87360 driver is unarguably more complex than the f71805f driver,
so you might not be able to reduce the array number that low even if
you wanted to. But that might still be an idea to consider.

Here again, I'm not forcing my view. You may actually prefer to have
separate arrays, and that's OK with me as well.

Others are invited to comment on both patches and compare between them
if they feel like to, as my judgment is certainly a bit biased by me
being the author of one of the patches and not the other ;)

As for your patch itself, a few comments:

* Use tabs for indentation, kill trailing whitespace.

* Make everything (new code, at least) fit within 80 columns.

Lastly, would you want/accept to become the pc87360 driver maintainer?
If you do, just provide a patch to MAINTAINERS. You can look at other
hardware monitoring drivers entries for inspiration.

Thanks,
-- 
Jean Delvare

