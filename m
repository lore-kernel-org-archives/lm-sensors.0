From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 26 Jan 2013 11:25:35 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <5103BD2F.30405@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net> <50B09EDC.4020200@kernel.org> <20130116054918.GA7056@roeck-us.net> <50F667C9.6000106@jic23.retrosnub.co.uk> <20130117204549.GB22045@roeck-us.net> <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com> <20130118220922.GB12459@roeck-us.net>
In-Reply-To: <20130118220922.GB12459@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, linux-iio@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On 01/18/2013 10:09 PM, Guenter Roeck wrote:
> On Thu, Jan 17, 2013 at 09:03:58PM +0000, Jonathan Cameron wrote:
>>
>> Good point. New use case for us so suggestions on how to do the association cleanly would be most welcome. Is there anything similar out there? We could add a per iio device sysfs interface to add additional mappings but it is a little uggly...
>>
> 
> Best idea I can come up with is to disconnect iio_hwmon from the requirement to
> instantiate it explicitly. There might be two sysfs entries - one to
> attach it to a specific iio device, and one to attach it to individual channels
> of an iio device. Similar like the new_device interface on i2c adapters, and
> along the line of
> 
> echo max1139 something > /sys/module/iio_hwmon/something_else

We'll have to have something more specific or the common case of more than
one instance of an adc will cause trouble.  Obviously this doesn't matter
doing by adding the map from the IIO side.

> 
> and/or
> 
> echo max1139 something channel > /sys/module/iio_hwmon/something_else
> 
> ie sysfs attributes associated with iio_hwmon, not with the iio device itself.
> 
This will play havock with the way the internal mappings work.  Originally
we had it mapped from both sides by name (e.g. the map wasn't in any way
handled by either driver) but that got an awful lot of flack and really
wasn't considered acceptable.  The current version of treating it much like
regulators etc is much cleaner.

> That would require iio_hwmon to be instantiated automatically, though,
> as soon as it is loaded, not through the iio device or through platform data
> and/or through devicetree.

I'm fine with instantiating automatically.  There are quite a few bits of
IIO that have to do this for one reason or another.   A slightly nasty
but easy to implement form would be to do this in two steps.
Have attrs to add the mapping form the IIO side so something like

iio_channel_name : iio_hwmon_device_name, hwmon_channel_name >> /sys/bus/iio/devices/iio:device0/add_client_channel_map
(removal by reversing this, but blocked obviously if in use by iio_hwmon)

then (and not sure where the magic hwmon device will sit)

iio_hwmon_device_name >> /sys/bus/iio/devices/iio_hwmon/add_device
with a remove_device means of reversing this.

This can then effectively add a platform_device as if we had had the map all
along. I kind of like this because it corresponds to the steps that
effectively exist for a statically set up mapping.

To take the three possible approaches.

The advantage of doing the mapping form the hwmon side is that there
is no need for callbacks etc as the hwmon driver will inherently know the
mapping has been updated.

The disadvantage is that we then need to maintain a way of finding the right
IIO device and adding the channel map effectively backwards then retrieving it again.
That's rather uggly to put it lightly.

Doing it all from the iio device side requires some nasty callbacks to tell the
hwmon driver that there are new channels.

The hybrid approach is perhaps the most rigid but does conform to the current standards
and interestingly will also allow you to have iio_hwmon devices that have channels from
multiple IIO devices (not entirely sure that will actually work right now, but the
interface allows for it ;)  The nasty here is what we do about attempts to add additional
mappings after the iio_hwmon device has been instantiated. Easy approach is probably to
just ignore them.. They'll get added to the map, and IFF the hwmon device is removed
and readded they'll get picked up.

There are a few fiddly corners with all the approaches.  As ever they mostly
relate to not undercutting a driver by removing its dependencies.  We may
need some 'inuse' flags for the map to indicate someone cares about it currently.
Not to hard I guess.

So my vote is for a hybrid approach were:

1) mappings are added / removed via attributes that all IIO devices get.
2) iio_hwmon 'instances' are added / removed via attributes in a special control device
  that will then instantiate the actual hmwon devices.  (very much like the way
  i2c devices can be added or iio's userspace triggers)

How does this sound?

Jonathan

>> -- 
>> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
>>
>> Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrote:
>>> On 16/01/13 05:49, Guenter Roeck wrote:
>>>> On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:
>>>>> On 11/24/2012 05:27 AM, Guenter Roeck wrote:
>>>>>> Hi all,
>>>>> Hi Guenter,
>>>>>>
>>>>>> What would it take to move the MAX1363 driver out of staging ?
>>>>>>
>>>>> Nothing given it is already out of staging in linux-next (though only has been
>>>>> for about a week)
>>>>>
>>>>>> Background is that I need a hardware monitoring driver for MAX1139, and would
>>>>>> like to avoid using a driver from staging if possible (after all, it might
>>>>>> go away anytime). Another option would be to submit a hwmon driver for it,
>>>>>> but that doesn't seem to be the best approach.
>>>>>
>>>>> The hwmon driver client driver for iio devices is still in staging, but mainly
>>>>> because I haven't had a chance to take a last look at it before posting it to
>>>>> the hmwon list. IIRC you were more or less happy with what went into staging
>>>>> in the first place, so hopefully not too much left to do.
>>>>>
>>>> Jonathan,
>>>>
>>>> can you educate me how to actually use iio_hwmon ? I get it loaded,
>>>> which registers the platform driver, but I have no idea how to instantiate it.
>>>>
>>> http://marc.info/?l=linux-iio&m2933525705497&w=2
>>>
>>> [PATCH 6/6] stargate2: example of map configuration for iio to hwmon
>>> example.
>>>
>> Hi Jonathan,
>>
>> In other words, I can not test it on a PC unless I write a driver to
>> instantiate it. Not too helpful :(. It means that iio drivers can not
>> be used / instantiated for hardware monitoring on PCs.
>>
>> Thanks,
>> Guenter
>>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
