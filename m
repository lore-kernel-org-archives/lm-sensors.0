From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 04 Jan 2009 19:14:25 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <49610A91.9010907@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Luca Tettamanti wrote:

<snip>

>> So summarizing:
>> 1) I like it :)
>> 2) I see some opportunities for removing duplicate code /
>>    simplifying (only one list).
>> 3) Blocker: must protect against userspace abuse causing lots of IO /
>>    an ACPI call storm
>> 4) Blocker: we must make sure we do not have ACPI and native IC drivers
>>    banging IO's of the same IC
> 
> 2 has been taken care of

Nice! One small mistake though, you forgot to do the value *= 100 when its a 
temp sensor in the show_limitX functions.

> will do 3.

Ok.

> About 4: not my fault ;) The IO region
> of the SMBUS controller is reserved by the firmware; once the resource
> enforcing is set to strict the drivers will be exclusive.

Ack, I'm not claiming that this is your fault. Still this is something which 
must be fixed before we can drop the atk0110 driver in to the mainline, esp. as 
it will autoload when build.

> There's is of
> course the possibility of broken firmwares where the IO range is not
> marked as reserved (I wouldn't be suprised...).

Yeah I know, well since this is all Asus only, lets hope the IO reservations 
are done properly on all Asus motherboards. I prefer not to try and think about 
what if there are Asus boards where this does not hold true.

> Here's another iteration of the patch, I'll implement caching ASAP.

Besides the value *= 100 in case of temp sensor for the limits, I have one 
small nitpick left, I think that the atk_create_files and atk_remove_files have 
lost their value as separate functions, and that it would be better to just 
move the code to where they all called all in all this would be a reduction in 
the number of lines, and more importantly if someone tries to follow the code 
flow while reading through the code it is one less function call / jump to 
follow, while figuring out what is exactly happening.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
