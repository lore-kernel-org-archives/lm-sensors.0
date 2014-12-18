From: Richard Llom <richard.llom@gmail.com>
Date: Thu, 18 Dec 2014 15:41:59 +0000
Subject: Re: [lm-sensors] System Monitor cannot read sensors anymore
Message-Id: <m6usk8$isc$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m6bv17$gsp$1@ger.gmane.org>
In-Reply-To: <m6bv17$gsp$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter Roeck wrote:
> On 12/18/2014 04:29 AM, Richard Llom wrote:
>> Jean Delvare wrote:
>>> On Thu, 11 Dec 2014 16:06:02 +0100, Richard Llom wrote:
>>>> Jean Delvare wrote:
>>>
>>> In /sys/class/hwmon.
>>>
>> Hmm, but didn't you wrote earlier that k10temp and it87 are not (yet)
>> converted?
>>
>> This is my directory listing from [hwmon]$ ls -Rl
>> .:
>> total 0
>> lrwxrwxrwx 1 root root 0 18.12.2014 09:23 hwmon0 ->
>> ../../devices/pci0000:00/0000:00:02.0/0000:01:00.0/hwmon/hwmon0/
>> lrwxrwxrwx 1 root root 0 18.12.2014 09:23 hwmon1 ->
>> ../../devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/
>> lrwxrwxrwx 1 root root 0 18.12.2014 09:23 hwmon2 ->
>> ../../devices/platform/it87.552/hwmon/hwmon2/
>>
>> should there be a directory lmsensors?
>>
> No.
> 
> Look in /sys/class/hwmon/hwmonX/device.
> 
Ok, found it. And this is now the state before or after the conversion (Jean 
"We are in the process of converting many drivers to have their
attributes attached to the hwmon class device instead of the physical
device.")?
And what would be the other case/path?


>>>>> (...)
>>>>> Can you run ksysguard from a terminal and see if it's
>>>>> spitting any error message (or logging them somewhere maybe?)
>>>>
>>>> This is the output from the terminal
>>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>>> COMMAND
>>>> for:  "lmsensors/k10temp-pci-00c3/temp1?"
>>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>>> COMMAND
>>>> for:  "lmsensors/it8720-isa-0228/temp1?"
>>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>>> COMMAND
>>>> for:  "lmsensors/nouveau-pci-0100/temp1?"
>>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>>> COMMAND
>>>> for:  "lmsensors/it8720-isa-0228/fan1?"
>>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>>> COMMAND
>>>> for:  "lmsensors/it8720-isa-0228/fan2?"
>>>
>>> This should be reported to the maintainers of ksysguardd, this is an
>>> application error after all.
>>>
>> Or ksysguard actually doesn't use libsensors at all and is looking for
>> the information in the wrong place?
>> 
The "lmsensors/nouveau-pci-0100/temp1?" output refers then probably to an 
internal function... 

Still no clue whats the cause is of all this trouble. And there weren't any 
recent changes in ksysguard.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
