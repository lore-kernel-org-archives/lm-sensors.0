From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 16 Jan 2013 08:41:45 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <50F667C9.6000106@jic23.retrosnub.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net> <50B09EDC.4020200@kernel.org> <20130116054918.GA7056@roeck-us.net>
In-Reply-To: <20130116054918.GA7056@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On 16/01/13 05:49, Guenter Roeck wrote:
> On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:
>> On 11/24/2012 05:27 AM, Guenter Roeck wrote:
>>> Hi all,
>> Hi Guenter,
>>>
>>> What would it take to move the MAX1363 driver out of staging ?
>>>
>> Nothing given it is already out of staging in linux-next (though only has been
>> for about a week)
>>
>>> Background is that I need a hardware monitoring driver for MAX1139, and would
>>> like to avoid using a driver from staging if possible (after all, it might
>>> go away anytime). Another option would be to submit a hwmon driver for it,
>>> but that doesn't seem to be the best approach.
>>
>> The hwmon driver client driver for iio devices is still in staging, but mainly
>> because I haven't had a chance to take a last look at it before posting it to
>> the hmwon list.  IIRC you were more or less happy with what went into staging
>> in the first place, so hopefully not too much left to do.
>>
> Jonathan,
>
> can you educate me how to actually use iio_hwmon ? I get it loaded,
> which registers the platform driver, but I have no idea how to instantiate it.
>
http://marc.info/?l=linux-iio&m2933525705497&w=2

[PATCH 6/6] stargate2: example of map configuration for iio to hwmon 
example.

Should give you a basic example.  Clearly a spot of documentation might
be in order ;)

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
