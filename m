From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Dec 2014 14:05:43 +0000
Subject: Re: [lm-sensors] System Monitor cannot read sensors anymore
Message-Id: <5492DF37.4040100@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <m6bv17$gsp$1@ger.gmane.org>
In-Reply-To: <m6bv17$gsp$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/18/2014 04:29 AM, Richard Llom wrote:
> Jean Delvare wrote:
>> On Thu, 11 Dec 2014 16:06:02 +0100, Richard Llom wrote:
>>> Jean Delvare wrote:
>>>> No service is doing that. The information is available in sysfs, and
>>>> libsensors gets it from there and makes it available to applications in
>>>> an easy way.
>>>
>>> Where exactly in /sys ? Because here I can't find anything there related
>>> to my sensors...
>>
>> In /sys/class/hwmon.
>>
> Hmm, but didn't you wrote earlier that k10temp and it87 are not (yet)
> converted?
>
> This is my directory listing from [hwmon]$ ls -Rl
> .:
> total 0
> lrwxrwxrwx 1 root root 0 18.12.2014 09:23 hwmon0 ->
> ../../devices/pci0000:00/0000:00:02.0/0000:01:00.0/hwmon/hwmon0/
> lrwxrwxrwx 1 root root 0 18.12.2014 09:23 hwmon1 ->
> ../../devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/
> lrwxrwxrwx 1 root root 0 18.12.2014 09:23 hwmon2 ->
> ../../devices/platform/it87.552/hwmon/hwmon2/
>
> should there be a directory lmsensors?
>
No.

Look in /sys/class/hwmon/hwmonX/device.

Guenter

>>>> (...)
>>>> Can you run ksysguard from a terminal and see if it's
>>>> spitting any error message (or logging them somewhere maybe?)
>>>
>>> This is the output from the terminal
>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>> COMMAND
>>> for:  "lmsensors/k10temp-pci-00c3/temp1?"
>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>> COMMAND
>>> for:  "lmsensors/it8720-isa-0228/temp1?"
>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>> COMMAND
>>> for:  "lmsensors/nouveau-pci-0100/temp1?"
>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>> COMMAND
>>> for:  "lmsensors/it8720-isa-0228/fan1?"
>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>> COMMAND
>>> for:  "lmsensors/it8720-isa-0228/fan2?"
>>
>> This should be reported to the maintainers of ksysguardd, this is an
>> application error after all.
>>
> Or ksysguard actually doesn't use libsensors at all and is looking for the
> information in the wrong place?
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
