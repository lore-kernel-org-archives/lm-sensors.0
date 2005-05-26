From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 26 May 2005 05:55:22 +0000
Subject: [lm-sensors] Re: [RFC PATCH 2.6.12-rc3-mm2 1/2] i2c: new sysfs
Message-Id: <20050526035452.GC18994@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050503034928.GC4977@jupiter.solarsys.private>
In-Reply-To: <20050503034928.GC4977@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani:

* Yani Ioannou <yani.ioannou@gmail.com> [2005-05-24 21:42:19 -0400]:
> Sorry to bother you again, but would it be possible to see/explain
> what modifications you plan to make to libsensors to read/write to
> sensors for hwmon class devices, I'm in particular what specific sysfs
> attributes you are reading from in /sys/class/hwmon/blah/.
> 
> At first I assumed you would probably be using the device_attributes
> under /sys/class/hwmon/blah/device/ (assuming the particular hwmon
> driver has an associated device - its optional), but on further though

That is just it, nothing more.

> that really doesn't make much sense because we would be assuming all
> the hwmon class driver devices would share the same driver type (or
> common sysfs device attribute interface)..which would sort of seem to
> defy the whole point of having a hwmon class in the first place. From
> what I see really we should be using class_device_attributes instead
> of device_attributes for a hwmon driver, in which case I'm going to
> have to submit a patch to Greg adding dynamic sysfs callbacks to
> class_device_attribute sooner than I expected..

We could use class device attributes, sure.  We could move all the
existing device attributes, even.  It's not like the sensors kernel
interface has been stable in 2.6.x since... well... ever.

I suggested the current path (use hwmon class just for the link to
device attributes) to Khali, rather than something more elaborate,
mostly so that I could hope to actually complete it while leaving
libsensors looking less ugly than it does now.  When libsensors has
a more flexible and maintainable way of parsing sysfs structure (like
using libsysfs, for one) then the rest may follow.

> Using class_device_attributes would also lend the ability to, for
> example, adding a hwmon interface to a device that's primary function
> isn't to interface sensors, e.g. instead of having a bmcsensors driver
> we would add a hwmon interface to the actual kernel IPMI bmc driver,
> this would make much more sense to me.

That would be neat, true.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

