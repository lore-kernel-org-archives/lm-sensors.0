From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 16 Dec 2005 04:39:49 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <20051216043949.GC4026@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Jim:

* Jean Delvare <khali at linux-fr.org> [2005-12-10 11:21:34 +0100]:
> So it's great that you come back to me on that topic now. My version
> has shorter names and a few cosmetic changes. It's in my local stack :
> 
> http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-allow-sensor-attr-arrays.patch
> 
> But I did not send it to Greg for integration yet. I was waiting for
> some ack from you or others, and for a driver actually using the added
> possibility.

Although I haven't been involved in the macro cleanup and conversion work
up to this point... a long time ago I complained that the sysfs inits make
the hwmon drivers much bigger than they need to be.  Anyway, thanks for
working on this stuff; and that patch looks OK to me.

[...]

> I am working on similar changes on a different driver myself. This
> driver (f71805f) I have not released yet because it is implemented as a
> platform driver and there are still some changes needed to the core
> part for it to work properly. You may take a look at it here though:
> 
> http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-new-driver.patch
> 
> This initial version uses the old individual attribute file
> registration approach. From there, there are two possibilities to get
> the attributes registered as groups:
> 
> 1* Using sysfs_create_group(), as Greg KH suggested. This doesn't need
> any preliminary patch. The patch is here:
> 
> http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-sysfs-group.patch
> 
> 2* Using arrays of attributes and looping over them, as you proposed
> for the pc87360 driver. This needs the preliminary hwmon-sysfs.h patch.
> The patch is here:
> 
> http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-use-attr-array.patch
> 
> This second patch has my preference as it makes the code significantly
> smaller. I don't much like the sysfs_create_group interface because it
> forces you to create two additional data structures you otherwise have
> no need for.

I agree, but I wonder if sysfs_create_group() has benefits on the back
end.  It's possible that looping over the attributes uses more memory
after all. [checks code]  No, your second patch has the exact same
effect, less one big array and one small one.

> I am not totally sure what I want to do here, so hints in either
> direction are welcome.

Also, in the sysfs-group patch, there was this line...

>>> static struct attribute_group attr_group_fan[3] __initdata = {

"array of structs containing a pointer to array of pointers to struct attribute"

My own preference is to avoid that kind of stuff like the plague.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


