From: Jerry Lin <jerry@lincircle.com>
Date: Fri, 21 Jan 2011 17:07:06 +0000
Subject: Re: [lm-sensors] user question about how to load xeontemp
Message-Id: <AANLkTi=egGaYTh1LWWBFyLC4eFMiP3WQVRTZWrSk73WZ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
In-Reply-To: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I upgraded the kernel to 2.6.35 (which corresponds to Ubuntu 10.10),
and I can now get the temperature readings from the Xeon cores. (I
still needed to load the coretemp module, but I think that was because
the /etc/modules file was not configured properly.)

In any case, thanks a lot for your help -- I got much faster responses
from this list than I expected.

This project was tremendously helpful in confirming that there was a
hardware problem with the CPU overheating (my mistake in assembling
the components). Thanks for working on it!

Best,
Jerry

On Wed, Jan 19, 2011 at 11:09 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Wed, 2011-01-19 at 13:52 -0500, Jerry Lin wrote:
> [ ... ]
>
>> Questions:
>> 1) What's the name of the jc42 module that I would need to load via modprobe?
>
> jc42. Problem is that support for it was added in a later version of the
> kernel.
>
>> 2a) sensors-detect mentions copying from "prog/init/lm_sensors.init"
>> -- where is that prog directory?
>> 2b) Does doing that copy of lm_sensors.init take the place of
>> copying-and-pasting the module lines into the /etc/modules file in the
>> older version of the script?
>> 3) Is "ipmisensors" the same as "ipmi-si" (as in "modprobe ipmi-si")?
>
> I don't know the status of ipmi integration and ipmi module names. There
> is the OpenIPMI project, and they have lots of patches to improve ipmi
> support. Jean may know better than me if/when/how those patches will be
> integrated into the mainline kernel.
>
>> 4) Why is sensors-detect able to detect the sensor via the coretemp
>> driver, but modprobe not able to load it?
>
> Because your version of the coretemp driver is old and doesn't support
> your CPU.
>
>> 5) Is there something else that I should be doing?
>>
> Easiest would be if you could switch to a recent kernel (2.6.37 or at
> least 2.6.36). Otherwise you'll have to backport the coretemp driver (as
> Jean has tried) as well as the jc42 driver.
>
> Guenter
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
