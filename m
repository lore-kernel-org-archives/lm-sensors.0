From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 19 May 2009 17:08:43 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.29.3 1/1] hwmon: added support for the
Message-Id: <4A12E79B.8050908@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/19/2009 12:45 PM, Engelmayer Christian wrote:
>> I'm not sure we should be exporting gpio functionality like this. First of
>> all the gpio function usually is fixed by how the IC is wired up, so I
> would
>> expect that to be set by the BIOS / firmware. And when not, this should be
>> set through a board configuration file, exporting this to userspace feels
> wrong.
>
> I see Your points. I also missed the actual sysfs interface definition.
> I will leave setting up the pins and the knowledge on the actual wiring
> completely to the custom firmware then.
>
>> The same can be said for toggling the pin when its an output, its function
> will
>> depend upon how its wired up again, and I would expect some higher level
> interface
>> (like an ACPI interface or whatever) expose its functionality in a more
> sane way.
>
> For the usecase that drives me, I would nevertheless need userspace
> to be able to check whether an alarm condition exists. Having firmware
> set up the gpio usage and enabled the adapted alarm conditions one
> could combine the various alarm sources provided by the chip (min/max
> output, tach overflow, gpio related) into alarm file 'fan1_alarm' as
> already specified in the hwmon sysfs-interface standard.
>
> Would that be an acceptable extension?
>

Extending the supported alarms would be fine, although I would not aggregate
them all under one sysfs file, just make a gpio#_alarm sysfs file, and make the
presence of this file conditional on the configuration of the gpio pins.

Would that work for you ?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
