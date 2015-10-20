From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 20 Oct 2015 17:00:51 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: ina2xx: allow for actual measurement bandwidth above 160 Hz
Message-Id: <56267343.8060601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <56259997.6080706@roeck-us.net>
 <1445329244-21627-1-git-send-email-mtitinger@baylibre.com>
 <56263973.300@roeck-us.net> <56263EED.7020902@baylibre.com>
 <562641DB.1080100@roeck-us.net> <562645B8.80905@baylibre.com>
In-Reply-To: <562645B8.80905@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, mturquette@baylibre.com

On 10/20/2015 06:46 AM, Marc Titinger wrote:
> On 20/10/2015 15:30, Guenter Roeck wrote:
>> On 10/20/2015 06:17 AM, Marc Titinger wrote:
>>> On 20/10/2015 14:54, Guenter Roeck wrote:
>>>> On 10/20/2015 01:20 AM, Marc Titinger wrote:
>>>>> With the current implementation, the driver will prevent a readout at a
>>>>> pace faster than the default conversion time (2ms) times the averaging
>>>>> setting, min AVG being 1:1.
>>>>>
>>>>> Any sysfs "show" read access from the client app faster than 500 Hz
>>>>> will be
>>>>> 'cached' by the driver, but actually since do_update reads all 8
>>>>> registers,
>>>>> the best achievable measurement rate is roughly 8*800 us (for the time
>>>>> spent in i2c-core) i.e. <= 156Hz with Beagle Bone Black.
>>>>>
>>>>> This change set uses a register mask to allow for the readout of a
>>>>> single
>>>>> i2c register at a time. Furthermore, performing subsequent reads on the
>>>>> same register will make use of the ability of the i2c chip to retain
>>>>> the
>>>>> last reg offset, hence use a shorter i2c message (roughly 400us
>>>>> instead of
>>>>> 800us spent in i2c-core.c).
>>>>>
>>>> That doesn't work. There could be accesses from other sources (such as
>>>> through
>>>> i2c-dev, or in multi-master systems) between two reads.
>>>
>>> Re-setting the register address with each read transaction will not
>>> prevent another master to change the configuration in your back, in
>>> this case. That sounds like a general issue of concurrent clients for
>>> one device, this is beyond just reading one register IMO.
>>>
>> That is an invasive change, though, not just a simple read. Sure, it is
>> a risk as well. But it is a different level of risk than someone using
>> i2cget or i2cdump while the driver is running.
>>
> Yes, I get your point.
>
>>>>
>>>>> The best readout rate for a single measurement is now around 2kHz. And
>>>>> for
>>>>> four measurements around (1/(4*800us) = 312 Hz. Since for any readout
>>>>> rate
>>>>> faster than 160 Hz the interval is set by the i2c transactions
>>>>> completion,
>>>>> the 'last-update' anti-flooding code will not have a limiting effect in
>>>>> practice. Hence I also remove the elapsed time checking in the hwmon
>>>>> driver
>>>>> for ina2xx.
>>>>>
>>>>> To summarize, the patch provides a max bandwidth improvement with hwmon
>>>>> client apps from ~160 Hz to ~320 Hz, and better in single-channel
>>>>> polling mode.
>>>>>
>>>> Overall your patch pretty much re-implements regmap. Since you drop
>>>> caching,
>>>> it is also unnecessary to read all registers at a time, so you can
>>>> just use
>>>> a function to read _one_ register and returns its value (with retries).
>>>> Or use regmap. Either case, do_update() and ina2xx_update_device()
>>>> are no
>>>> longer needed.
>>> Agreed.
>>>
>>>>
>>>> If you want to convert the driver to regmap, just look for 'regmap' in
>>>> drivers/hwmon for examples.
>>>
>>> Fair enough, but based on your comments, I may look into an iio driver
>>> instead for this device, given our application, rather than 'twisting'
>>> the hwmon interface.
>>>
>>
>> Sorry, you lost me there. How are you twisting the hwmon interface ?
>> Because I am concerned about multiple accesses from multiple sources ?
>> How is iio going to solve that problem ? By ignoring it ?
>
> Sure someone can still use i2c diag tools as you said, you have a point here. But similarly, someone can use /dev/mem to remap stuff and peek/poke mm registers, and to my knowledge we do not generally design drivers or subsystems with retries and feature limitations to cope with potential use of diag and debug facilities.
>

Depends on the system, and on the use case. Many systems I deal with
are multi-master, and user space does end up accessing chips using i2c-dev.

Drivers are (supposed to be) designed with as much multi-master access
safety as possible. I had patches rejected because they broke multi-master
support by sending two commands depending on each other in a sequence.

Using /dev/mem and peek/poke as counter-examples isn't really appropriate
here, so I won't comment further on it.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
