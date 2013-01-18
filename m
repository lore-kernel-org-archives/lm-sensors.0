From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Jan 2013 22:09:22 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <20130118220922.GB12459@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net>
 <50B09EDC.4020200@kernel.org>
 <20130116054918.GA7056@roeck-us.net>
 <50F667C9.6000106@jic23.retrosnub.co.uk>
 <20130117204549.GB22045@roeck-us.net>
 <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
In-Reply-To: <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Thu, Jan 17, 2013 at 09:03:58PM +0000, Jonathan Cameron wrote:
> 
> Good point. New use case for us so suggestions on how to do the association cleanly would be most welcome. Is there anything similar out there? We could add a per iio device sysfs interface to add additional mappings but it is a little uggly...
> 

Best idea I can come up with is to disconnect iio_hwmon from the requirement to
instantiate it explicitly. There might be two sysfs entries - one to
attach it to a specific iio device, and one to attach it to individual channels
of an iio device. Similar like the new_device interface on i2c adapters, and
along the line of

echo max1139 something > /sys/module/iio_hwmon/something_else

and/or

echo max1139 something channel > /sys/module/iio_hwmon/something_else

ie sysfs attributes associated with iio_hwmon, not with the iio device itself.

That would require iio_hwmon to be instantiated automatically, though,
as soon as it is loaded, not through the iio device or through platform data
and/or through devicetree.

Guenter

> -- 
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> 
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrote:
> > On 16/01/13 05:49, Guenter Roeck wrote:
> > >On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:
> > >>On 11/24/2012 05:27 AM, Guenter Roeck wrote:
> > >>>Hi all,
> > >>Hi Guenter,
> > >>>
> > >>>What would it take to move the MAX1363 driver out of staging ?
> > >>>
> > >>Nothing given it is already out of staging in linux-next (though only has been
> > >>for about a week)
> > >>
> > >>>Background is that I need a hardware monitoring driver for MAX1139, and would
> > >>>like to avoid using a driver from staging if possible (after all, it might
> > >>>go away anytime). Another option would be to submit a hwmon driver for it,
> > >>>but that doesn't seem to be the best approach.
> > >>
> > >>The hwmon driver client driver for iio devices is still in staging, but mainly
> > >>because I haven't had a chance to take a last look at it before posting it to
> > >>the hmwon list. IIRC you were more or less happy with what went into staging
> > >>in the first place, so hopefully not too much left to do.
> > >>
> > >Jonathan,
> > >
> > >can you educate me how to actually use iio_hwmon ? I get it loaded,
> > >which registers the platform driver, but I have no idea how to instantiate it.
> > >
> > http://marc.info/?l=linux-iio&m2933525705497&w=2
> > 
> > [PATCH 6/6] stargate2: example of map configuration for iio to hwmon
> > example.
> > 
> Hi Jonathan,
> 
> In other words, I can not test it on a PC unless I write a driver to
> instantiate it. Not too helpful :(. It means that iio drivers can not
> be used / instantiated for hardware monitoring on PCs.
> 
> Thanks,
> Guenter
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
