From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Fri, 13 Jan 2006 04:59:34 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43C733B6.8010801@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> OK, great :) The /usr/local variants should always be before the /usr
> variants in $PATH, but depending on the distribution and/or the user,
> it might not actually be the case.
>   
Suse 10.0 in my case


> You may have noticed that I have been committing the user-space part of
> the W83687THF support to CVS already. 
I hadn't, but now that you mention it, I see that now in the Changes 
File. I notice that the version number has changed from 2.9.3 to 2.10.0. 
As an aside, I also notice that the projected release date for 2.10.0 is 
incorrect ;)


> I also modified the Linux 2.4 w83627hf driver to fully support the W83687THF chip. I still need to
> rework the 2.6 patch based on what I found in the datasheet, and then
> we'll have to work on a sample configuration file for the chip. I hope
> to get all this done by the end of the week. Stay tuned! :)
>   
Sounds good pretty good to me! :)

> Steven Karatnyk wrote:
>
>   
>> Anyways, here's the successful output:
>> (...)
>> w83687thf-isa-0290
>> Adapter: ISA adapter
>> in0: +1.10 V (min = +0.70 V, max = +1.87 V)
>>     
>
> Most probably your CPU Core voltage. Is it correct? What's your CPU?
>   
Yes, that looks right. Its an A64 3000. I believe its Kpowersave that is 
controlling the dynamic CPU throttling (multiplier and voltage), and 
that its default idle values are 5x200 @1.1V (which is, I believe, the 
AMD C'n'Q defaults). Eventually I will look more closely into this as I 
would like to provide my own throttling config settings [given under 
Windows I can user define, with the user app/driver Crystalcpuid, a 
5x200 @ 0.9V idle values no problem .... in my case, trying to drop the 
multiplier or V any further completely freezes the system .... although 
I know someone who can drop to 4x200 on the same chip ].

>   
>> in1: +1.52 V (min = +2.54 V, max = +2.11 V) ALARM
>>     
>
> I'd guess this is the AGP voltage (nominal is +1.5V).
>   
I agree.

>> in2: +3.30 V (min = +2.86 V, max = +1.66 V) ALARM
>>     
>
> And this could be +3.3V.
>   
Agree.

>> in3: +2.99 V (min = +2.05 V, max = +3.36 V)
>> in4: +2.59 V (min = +3.49 V, max = +2.14 V) ALARM
>> in7: +2.94 V (min = +0.16 V, max = +0.42 V) ALARM
>>     
>
> These ones are probably greater voltages (+5V, +12V...) scaled down. Or
> in4 may be Vdimm.
>   
I think in4 is the Vdimm. IIRC, I have it set at 2.6V in the BIOS. Will 
have to check, but think its a safe bet.


>> in8: +3.30 V (min = +0.38 V, max = +3.14 V) ALARM
>>     
>
> I'd guess 3VSB (same as +3.3V but when your system is in standby mode.)
>   
Sounds reasonable.

>> fan1: 1328 RPM (min = 9375 RPM, div = 8) ALARM
>> fan2: 1339 RPM (min = 1016 RPM, div = 8)
>> fan3: 0 RPM (min = 6136 RPM, div = 2) ALARM
>>     
>
> If you only have these two slow fans in the box, that looks OK.
>   
Yes, CPU fan and an exhaust. RPM's are correct. There is a third fan 
(PSU) but it lacks monitoring capability ... although I imagine a 
modification could correct that, but I'm not certain if there is a 3rd 
fan header on the mobo... would have to check manual.

>> temp1: +39?C (high = -122?C, hyst = -41?C) sensor = diode ALARM
>> temp2: +39.0?C (high = +80?C, hyst = +75?C) sensor = diode
>> temp3: +59.0?C (high = +80?C, hyst = +75?C) sensor = diode
>>     
>
> May be OK too. You should set temp1's limits to something more
> reasonable though.
>   
Temp3 is definitely CPU, but it looks a bit off .... I suspect the lm90 
output (CPU Temp: +54.4?C) is closer to accurate.
Temp2 looks to be the Mobo, but it too is a bit off ... again, I suspect 
the lm90 output (M/B Temp: +37?C) is closer to the true value

I'm a little uncertain about temp1 (i.e what it actually is) or why its 
limits are like that (I did do a sensors -s first.....haven't touched 
the etc/sensors.conf file yet though). I'm wondering if its a bogus 
sensor....although the "diode Alarm " makes me wonder if its actually 
tied to the BIOS alarm temp setting in anyway.
>> vid: +0.275 V (VRM Version 9.0)
>>     
>
> Bogus, and this is expected as the W83687THF needs completely different
> code for VID, which my initial patch didn't have. I've implemented
> that now, a new patch is available here:
>
> http://jdelvare.net2.nerim.net/sensors/hwmon-w83627hf-add-w83687thf-support.patch
>
> Note that it only applies to Linus' git tree (or any recent mm tree),
> not 2.6.15 - unless you fix the few rejects manually.
> ...
> If you happen to test the patch linked above, please
> report the result.
Awesome. I'll look into that. Will report back.

Sounds good.
> As the chip is quite rare,
It does indeed appear that way - when I was googling for information 
about it last week, I found reference to it in conjunction with only a 
few boards (Epox, Albatron, Soltek, and, IIRC, one from PC Chips or 
similar).

> Also, I'd like to work on a sample configuration
> file for this chip....maybe we can simply write a configuration file for your board. Can you please visit the
> BIOS setup screens of your system and report all the hardware
> monitoring items listed there, in order, with value? Then I'll provide
> a configuration file for you to test.
>   
Will do.

Thanks, Steven





