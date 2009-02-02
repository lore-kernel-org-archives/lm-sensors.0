From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 02 Feb 2009 13:27:36 +0000
Subject: Re: [lm-sensors] Updated initialization script, testers wanted
Message-Id: <4986F4C8.4010507@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090112140236.6b74302e@hyperion.delvare>
In-Reply-To: <20090112140236.6b74302e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Sun, 25 Jan 2009 14:47:30 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Really? I agree for bus drivers, but this seems difficult for hwmon
>>> chip drivers. Do you have some ideas that you didn't share with us yet?
>> Well I hope that for graphiccards, the drm / modesetting driver will also 
>> (probe for?) and instantiate any known to be (sometimes) present i2c sensors.
> 
> If they are going to do the same probings we have to do for mainboards,
> then I don't quite get the point.

Well yes and no, most cards based on a certain GPU all use the same hwmon IC 
(the one from the reference design). But some may deviate, so there only needs 
to be a probe for one, maybe 2 chips, and a fairly simple probe. There is no 
certainty that some manufacturer won't deviate, hence the probe is needed, but 
the situation is nowhere as bad as with mainboards.

> If it is possible to instantiate the sensor devices without probing
> because you can get enough information from the hardware to know what
> and where they are, then that's a different story, and I agree we
> should do that. Any probing we can avoid is good.
> 

Well there is no 100% certainty (AFAIK) so we still need a probe, but basicly 
only for one chip, if the user has one of the rare deviating board he / she is 
out of luck.

>>> My initial goal was to make the configuration file more simple, not
>>> more complex ;) The main reason why I wanted to split bus drivers and
>>> hardware monitoring chip drivers is that lm_sensors should be
>>> considered not configured as long as no hardware monitoring drivers are
>>> listed. The fact that this will make things a little clearer to the
>>> users is only a side benefit. Oh, and in a few cases, it is more
>>> efficient to load the bus drivers first.
>>>
>>> I don't see much value in splitting the variables further.
>>>
>>> Bus drivers will almost always auto-load these days, so these variables
>>> will almost always be empty. And the trend for graphics adapter is to
>>> expose I2C buses from the graphics driver itself, so you aren't loading
>>> the bus drivers just for lm-sensors.
>>>
>>> If we ever have a kernel driver for hard disk temperatures (that would
>>> be nice!) then I suspect it will be the same driver for all disks, and
>>> hopefully it will auto-load.
>>>
>>> This leaves us with the hardware monitoring chips themselves. Given
>>> that it is possible that the same driver is used for the motherboard
>>> and for the graphics adapter, how would you split them? Sure, you could
>>> list the module twice, but that's not exactly efficient.
>>>
>>> What benefits do you see in splitting the variables that way?
>> Oneday I hope we have a tool which will generate and /etc/sensors.conf and 
>> /etc/sysconfig/lm_sensors based on dmi info and a database, then it would be 
>> good to have separate line in /etc/sysconfig/lm_sensors, for sensors located on 
>> the motherboard and sensors located on for example a graphic card, so that that 
>> tool then can only mangle the motherboard lines, without touching any 
>> (potentially manually added) other line.
> 
> I don't expect /etc/sensors.conf to be ever generated. Instead my plan
> is to change libsensors to read all configuration files from
> directory /etc/sensors.d. Then our to-be-written configuration tool
> would simply drop board-specific configuration files to that directory.
> This is IMHO much easier than merging several files
> into /etc/sensors.conf.

Ack, this sounds like a good plan.

> I wanted to work on this before the end of
> January but have been delayed by other issues.
> 
> With regards to separate variables in /etc/sysconfig/lm_sensors, it
> seems to only make sense if our to-be-written configuration tool allows
> the user to reconfigure the sensors separately on the mainboard and on
> graphics adapters. Do we have a need for this? At the moment,
> sensors-detect doesn't make any difference between the mainboard and
> graphics adapters, it probes the graphics adapters' I2C buses as it
> does for the SMBus.

True, I guess this is something best revisited when it actually becomes an issue.

<snip>

> 
> But I don't think there is anything that needs to be done now. The new
> configuration file format is easily extended in the future if we need
> variables for specific purposes.
> 

Ack.


Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
