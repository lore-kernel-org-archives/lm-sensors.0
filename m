From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 17 Jan 2013 21:37:14 +0000
Subject: [lm-sensors] Userspace IIO map instantiation [was MAX1363 IIO driver questions]
Message-Id: <50F86F0A.4080804@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net> <50B09EDC.4020200@kernel.org> <20130116054918.GA7056@roeck-us.net> <50F667C9.6000106@jic23.retrosnub.co.uk> <20130117204549.GB22045@roeck-us.net> <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
In-Reply-To: <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 
Cc: Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, James Peverill <arsenix@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Greg KH <gregkh@linuxfoundation.org>

Thinking about it, this functionality would also be of use to
James Peverill as part of his idea for in kernel real time control
loops fully configurable from userspace.  I've cc'd a few others
involved in the original interfaces for setting up these maps.

To take a random stab at how it might work.

Every iio device gains some new interfaces

iio_map_add
iio_map_del

These two take comma separated parameter lists to effectively fill
a struct iio_map
so

iio_channel_name,client_device_name,client_channel_name
(possibly other punctuation to make it clearer, also
we would need to explicitly make the channel names available
from userspace which is fine if tedious)

Each of these effectively describes a single channel map
and is one conceptual entity so fine as a sysfs attribute.

Probably also need a means to list current maps that are
set up, perhaps iio_map_list or similar (ugly: perhaps
we can come up with a better way of describing them).

This would then call iio_map_array_register (or a single
element variant) to set up the maps.

Now for currently un inserted client modules, these maps
will be picked up on insertion just fine. The 'interesting'
case would be for modules that are already there.  We could
define an appropriate callback to be notified of new entries
that match the device name.  Then the client will have to decide
what to do about them.  For example the iio to hwmon module
would want to add more sysfs attributes for the new channels.

So the questions are

a) is there a better way?
b) what types of driver do something similar already?
c) would something like the above work?

There is a clear use case for something with this functionality
(several of them as it turns out) so let us work out how
best to proceed.

Jonathan

On 01/17/2013 09:03 PM, Jonathan Cameron wrote:
> 
> Good point. New use case for us so suggestions on how to do the association cleanly would be most welcome. Is there
> anything similar out there? We could add a per iio device sysfs interface to add additional mappings but it is a little
> uggly...
> 
> -- 
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> 
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>     On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrote:
>     > On 16/01/13 05:49, Guenter Roeck wrote:
>     > >On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:
>     > >>On 11/24/2012 05:27 AM, Guenter Roeck wrote:
>     > >>>Hi all,
>     > >>Hi Guenter,
>     > >>>
>     > >>>What would it take to move the MAX1363 driver out of staging ?
>     > >>>
>     > >>Nothing given it is already out of staging in linux-next (though only has been
>     > >>for about a week)
>     > >>
>     > >>>Background is that I need a hardware monitoring driver for MAX1139, and would
>     > >>>like to avoid using a driver from staging if possible (after all, it might
>     > >>>go away anytime). Another option would be to submit a hwmon driver for it,
>     >
>     >>>but that doesn't seem to be the best approach.
>     > >>
>     > >>The hwmon driver client driver for iio devices is still in staging, but mainly
>     > >>because I haven't had a chance to take a last look at it before posting it to
>     > >>the hmwon list.  IIRC you were more or less happy with what went into staging
>     > >>in the first place, so hopefully not too much left to do.
>     > >>
>     > >Jonathan,
>     > >
>     > >can you educate me how to actually use iio_hwmon ? I get it loaded,
>     > >which registers the platform driver, but I have no idea how to instantiate it.
>     > >
>     > http://marc.info/?l=linux-iio&m2933525705497&w=2
>     > 
>     > [PATCH 6/6] stargate2: example of map configuration for iio to hwmon
>     > example.
>     > 
>     Hi Jonathan,
> 
>     In oth
>      er
>     words, I can not test it on a PC unless I write a driver to
>     instantiate it. Not too helpful :(. It means that iio drivers can not
>     be used / instantiated for hardware monitoring on PCs.
> 
>     Thanks,
>     Guenter
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
