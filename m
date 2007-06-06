From: patric <pakar@imperialnet.org>
Date: Wed, 06 Jun 2007 07:04:11 +0000
Subject: Re: [lm-sensors] Fintek F71882 on MSI mainboard
Message-Id: <46665C6B.8050002@imperialnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <18021.51591.422191.587646@gate.local.mgri>
In-Reply-To: <18021.51591.422191.587646@gate.local.mgri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,


Well, just about for the different driver.. But i was more thinking
about something like this in the sensors.conf..


IF MB "ASUS M2N" "ASUS M2N-E" "ASUS M2N-SLI"

    "it8716-*"

        label fan1 "CPUFan"

        label temp1 "CPUTemp"

   

    "adt7463-*"

       label fan2 "Chassi fan"

       label temp2 "Some temp"

FI

   

and then at the end of the sensors.conf have the defaults for mainboards
that follow the rules..... That would make it possible to have simple
exceptions for lots of mainboards without messing up the defaults in the
config.

And yes, i know that you can specify addresses and stuff for the
different sensors, but i don't think anyone can keep a track of all
sensors in the config, and with all the mainboards with exceptions i
think this might be a good route to take.. And it will not require any
changes to the current config, only enable it to be expanded with
exceptions per MB type..


Currently involved in another project so don't know if i'll find the
time to get anything working on this, but just thought i post a reply on
a idea i got when i read the first mail...


And yet again... This is only brainstorming... Don't take anything
literary. =)


/Patric


Ivo Manca wrote:

> Replying ,even though I'm not Hans ;)
>
>> Hi Hans,
>>
>>
>> Just been thinking a while about all these non-standard motherboards,
>> and maybe it's time soon to implement something that enables lm-sensors
>> to behave differently on different boards...
>>
>>
>> One possibility could be to borrow some code from dmidecode to detect
>> the make/model...
>>
> We're currently working on sensors-detect with DMI support. The
> sensors-detect program is already almost completely functional and the
> website is getting quite some shape as well.
> If drivers need to have specific parameters for a specific
> motherboard, they can be embeded in the configuration file and
> sensors-detect just passes them through (if the config is indeed for
> the corresponding dmi-info, ofcourse)
> Dunno if that's what you mean :)
>
>> Another thing that this could be used for is to generate a known list of
>> options that are needed for different mainboards, and maybe provide a
>> list of modules for the motherboard instead of having to scan for
>> sensors.
> Done. If the motherboard is supported (IE: Config has been entered),
> the modules will be loaded by sensors-detect without scanning.
>
> You might want to check out some earlier messages on this list, like:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019834.html
> The school project for which we make this changes, is about to stop
> within a week or so. I don't think I'll stop reading this list or stop
> improving the script if needed, so if you want to add some
> "nice-to-haves", feel free to add them to the code or suggest them to
> this mailing list.
>
> Ivo Manca
>
>>
>>
>>
>> Hans Edgington wrote:
>>
>>> Hi,
>>>
>>> Thanks for taking a look at the driver.
>>>
>>>
>>>> I hacked the f71882fg driver so it works on my MSI P6N SLI Platinum
>>>> mainboard (Socket 775 with Nvidia 650).
>>>>
>>>
>>>
>>>> The critical fix was to use the address values and logic from the
>>>> existing f71805f driver (see diff).
>>>>
>>>
>>> I haven't had much time to look at your work, but as I understand it
>>> your
>>> version is kind of a cross between the f71882fg & f71805f driver. Which
>>> means it now won't work on the Epox mobo's and possibly others.
>>> So somehow we are going to have to detect which mobo is being used.
>>>
>>>
>>>> Note that the driver still causes a kernel oops on rmmod, this is
>>>> probably because f71882fg_exit doesn't call f71882fg_remove but I
>>>> didn't
>>>> feel like working on that, after all I don't remove the module at
>>>> all...
>>>> ;-)
>>>>
>>>
>>> Is already fixed.
>>>
>>>
>>> I'll have a closer look at it, as soon as I can.
>>>
>>> Regards,
>>> Hans
>>>
>>>
>>> _______________________________________________
>>> lm-sensors mailing list
>>> lm-sensors@lm-sensors.org
>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>>
>>>
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors 
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
