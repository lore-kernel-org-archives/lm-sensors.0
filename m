From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Jan 2012 18:03:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add new hwmon-core interface
Message-Id: <1325700218.26706.51.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323378601-6930-2-git-send-email-dev@lynxeye.de>
In-Reply-To: <1323378601-6930-2-git-send-email-dev@lynxeye.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lucas,

On Thu, 2011-12-08 at 16:10 -0500, Lucas Stach wrote:
> This adds a new hwmon-core interface to centralize sysfs handling
> and enable cooperation with other in-kernel drivers.
> 
> v3:
> - checkpatch clean
> 
> v4:
> - more flexible interface to allow different capabilities for
>   every sensor and holes in sensor numbering
> - corrected a few oversights
> - split out vid and vrm handling as separate feature
> - support 2d attributes for trip point and treshold handling
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>

Couple of high level comments:

inX numbering starts with 0, not 1. You'll have to take that into
account.

You can not determine based on the attribute type or name that or if a
write function exists or not. This really depends on the driver. So
there has to be a means to set file permissions per driver and per
attribute. Returning -EINVAL in the set function in that case is not an
option; the write capability has to be reflected in file permissions.
Note that some attributes may have dynamic permissions using is_visible
from struct attribute_group.

You'll have to describe the API somewhere, including expected return
codes from access functions. You should not use -EINVAL if an attempt is
made to access an unsupported attribute type; maybe -EOPNOTSUPP.

It is not a good idea to mandate that all access functions always exist.
If there is no text read function, or if there is no set function, a
driver should not have to provide a dummy one. Otherwise, most drivers
would have to provide dummy text read functions just to return
-E<Something>, and many drivers would have to provide dummy set
functions for the same reason. It should be up to the core code to
determine if access functions exist or not, and set permissions
accordingly.

I don't fully understand the need for an use of enum entry_count. Please
elaborate.

Number of memory allocations in the adt7475 driver initialization is a
bit excessive. Looks like the overall amount of code is now less, but
initialization code is way more complex than it used to be. This makes
driver development more complex, not less complex.

In your sample driver, you have created race conditions by calling
hwmon_device_register() early. The call to hwmon_device_register() must
be the last call in the probe function, after everything else is done.
Not sure if that is a new requirement, but it is definitely not correct.
Besides, you have introduced some errors there - if the subsequent
sysfs_create_file() fails, you bail out, but you don't call
hwmon_device_unregister() (or hwmon_destroy_sysfs, for that matter).
Besides, it doesn't make sense to try to delete the file you just failed
to create. And during unregistration, you actually free all mmeory prior
to calling hwmon_device_unregister(). That will cause some nice
crashes ;). That will require some cleanup work.

Coding style:
- Some unnecessary ().
- Watch for Chapter 7 violations.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
