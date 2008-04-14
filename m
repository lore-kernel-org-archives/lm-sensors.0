From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 14 Apr 2008 14:29:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fix common race conditions,
Message-Id: <48036A64.4080406@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406180721.GN27659@mars.solarsys.private>
In-Reply-To: <20080406180721.GN27659@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 11 Apr 2008 09:18:24 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> I don't like the current approach either. In fact it seems that every
>>> new developer finds it odd at first, and in the end we only keep doing
>>> it because it has been so from the beginning of the lm-sensors project.
>>> The fact is that our drivers would perform much better if we did not
>>> repeatedly read from registers which aren't supposed to change. Some
>>> drivers mitigate the performance penalty by reading from these
>>> registers less frequently, but then it somewhat misses the original
>>> point of always reflecting the current register state.
>>>
>>> But on the other hand, anything that helps spot conflicts with ACPI or
>>> SMM is welcome, as these issues can be very hard to investigate - in
>>> particular for SMBus-based chips or chips with index/data pair I/O port
>>> access, where simultaneous access can result in data corruption. Thomas
>>> Renninger and myself proposed something that should help for ACPI in
>>> some cases but Linus rejected our approach. Removing the extra reads
>>> from our drivers would be one less way to spot that kind of problem. Of
>>> course we can look at the registers directly using i2cdump or isadump
>>> in most cases, but users are less likely to do that, while they usually
>>> do notice when limits change mysteriously.
>>>
>>> So all in all I have to admit that I don't really know what to do.
>>> Maybe the extra reads should be made a compilation-time or (probably
>>> better) a run-time option, so we leave the decision to the user?
>> I think given the slowness of reading these registers (esp in the i2c / smbus 
>> case) making it an option is a good idea, I think we should combine this with 
>> when this option is activated (it should be default off) actually checking if 
>> things were changed and if so complain.
>>
>> Then when we suspect faulplay by acpi/smm we can ask the user to turn on the 
>> option.
>>
>> Does that sound like a plan?
> 
> Fine with me, as long as this is a run-time option and not a build-time
> option. Rebuilding a kernel module is not an option for many users.
> 

Yes it should definitely be a runtime option, even one which can changed 
through sysfs.

So now I guess its time for everyone to start writing patches for the drivers 
they maintain to implement this. I'll start working on patches for my hwmon 
drivers as time permits (iow it may take a while, as I'm awefully busy lately).

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
