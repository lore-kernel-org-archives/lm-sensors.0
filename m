From: "Ivo Manca" <pinkel@gmail.com>
Date: Tue, 05 Jun 2007 23:11:40 +0000
Subject: Re: [lm-sensors] Fintek F71882 on MSI mainboard
Message-Id: <000501c7a7c6$e254f410$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <18021.51591.422191.587646@gate.local.mgri>
In-Reply-To: <18021.51591.422191.587646@gate.local.mgri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replying ,even though I'm not Hans ;)

> Hi Hans,
>
>
> Just been thinking a while about all these non-standard motherboards,
> and maybe it's time soon to implement something that enables lm-sensors
> to behave differently on different boards...
>
>
> One possibility could be to borrow some code from dmidecode to detect
> the make/model...
>
We're currently working on sensors-detect with DMI support. The 
sensors-detect program is already almost completely functional and the 
website is getting quite some shape as well.
If drivers need to have specific parameters for a specific motherboard, they 
can be embeded in the configuration file and sensors-detect just passes them 
through (if the config is indeed for the corresponding dmi-info, ofcourse)
Dunno if that's what you mean :)

> Another thing that this could be used for is to generate a known list of
> options that are needed for different mainboards, and maybe provide a
> list of modules for the motherboard instead of having to scan for sensors.
Done. If the motherboard is supported (IE: Config has been entered), the 
modules will be loaded by sensors-detect without scanning.

You might want to check out some earlier messages on this list, like:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019834.html
The school project for which we make this changes, is about to stop within a 
week or so. I don't think I'll stop reading this list or stop improving the 
script if needed, so if you want to add some "nice-to-haves", feel free to 
add them to the code or suggest them to this mailing list.

Ivo Manca

>
>
>
> Hans Edgington wrote:
>
>> Hi,
>>
>> Thanks for taking a look at the driver.
>>
>>
>>> I hacked the f71882fg driver so it works on my MSI P6N SLI Platinum
>>> mainboard (Socket 775 with Nvidia 650).
>>>
>>
>>
>>> The critical fix was to use the address values and logic from the
>>> existing f71805f driver (see diff).
>>>
>>
>> I haven't had much time to look at your work, but as I understand it your
>> version is kind of a cross between the f71882fg & f71805f driver. Which
>> means it now won't work on the Epox mobo's and possibly others.
>> So somehow we are going to have to detect which mobo is being used.
>>
>>
>>> Note that the driver still causes a kernel oops on rmmod, this is
>>> probably because f71882fg_exit doesn't call f71882fg_remove but I didn't
>>> feel like working on that, after all I don't remove the module at all...
>>> ;-)
>>>
>>
>> Is already fixed.
>>
>>
>> I'll have a closer look at it, as soon as I can.
>>
>> Regards,
>> Hans
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
