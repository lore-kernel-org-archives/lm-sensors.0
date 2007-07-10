From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 10 Jul 2007 22:51:40 +0000
Subject: Re: [lm-sensors] [ patch 0/4 RFC for 2.6.23-rc0 ] superio-locks
Message-Id: <46940D7C.3070705@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690A311.3090407@hhs.nl>
In-Reply-To: <4690A311.3090407@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:
> Hans de Goede wrote:
>> Jim Cromie wrote:
>>> Hans de Goede wrote:
>>>
>>> Hi Hans,
>>>
>>> thanks for stepping up.
>>>
>>
>> Your welcome
>>
>>>> 2) make superio_find return the device_id which was found through a 
>>>> by reference param, this way drivers who support multiple id's do 
>>>> not need to read the device_id registers again, but can use the 
>>>> returned value.
>>>>
>>>
>>> No - devid is available via gate->devid     (modulo spelling)
>>> will provide inline wrapper
>>>
>>
>> Ah I missed that because your chip driver patches didn't use it, 
>> instead the chip drivers read the devid registers again to get the dev 
>> register.
>>
>>>> 3) move superio_select from the drivers to the superio code.
>>>>
>>> disagreed at 1st, but added ld_addr field to superio_search,
>>> and copied it into gate in superio_find.
>>>
>>
>> Why add a ld_addr there? That address is defined in the lpc spec 
>> afaik, then again so is the devid address, yet some devices deviate. I 
>> have a good idea, make these both configurable through the search 
>> struct, but allow them to be 0, and in case of 0 use the default 
>> addresses from the lpc spec (which 90% of all drivers use atm afaik).
>>
> I was unaware that its standard.  I'll go with your idea 0 -> default.
> 
>>>> > - Ive not thought much about the 16-bit device-id check
>>>>     ( I need hardware to sharpen this focus )
>>>> I can check that on / with the f71882fg
>>>>
>>> I'll leave that patch to you - as an API clarity test.
>>> If the API is confusing to you (non-newbie), then its flawed.
>>>
>>
>> Will do.
>>
>>> And after I get rev 3 out ( Im calling last one rev2 - postfacto),
>>> I'll review your driver.  Can you send me the datasheet ?
>>>
>>
>> Thanks for the review offer, however I already have a reviewer :)
>> The datasheet is publicly available, see the link from the devices 
>> section on the wiki.
>>
>>>> > - superio_{enter,exit} are no-ops on my natsemi chip, so again the 
>>>> code
>>>> > is {}
>>>> >
>>>> > the prob is (of course) that every chip does it differently,
>>>> > and superio_locks shouldnt care.  Probably best to drop them
>>>> > from superio-locks API, and expect drivers to do them themselves.
>>>>
>>>> I think its fine to leave any additional handshaking to the drivers, 
>>>> besides that, as you say with this locking that won't be necessary 
>>>> anymore.
>>>>
>>> my reasoning as commented in superio_locks.h is questionable.
>>> enter/exit is orthogonal to mutex, it gives no protection to drivers
>>> that properly use enter/exit.
>>>
>>> drivers could reasonably just enter, never exit (since theres no 
>>> protection)
>>> mutexs must be used to give transaction guarantees.
>>>
>>> Maybe more to say later..
>>>
>>
>>
>> I cannot follow you here, what exactly do you mean with enter / exit, 
>> some kind ahandshaking between different users which can be done 
>> through the chip, like testing the highest bit of the index reg? That 
>> will only work if you shortly disable any and all taskswitching as you 
>> first need to read it and then set it and you cannot do this atomically .
>>
> 
> superio_enter/exit - theyre write sequences that enable/disable the 
> superio-port
> (the isa port still works)  I guess it protects against random access and
> wrong drivers ( driver for Y dont know how to unlock chip X)
> 

Ah, you mean the unlock code to "unlock" the superio ports, thats indeed to 
stop software who accidentally access these ports to wreck havoc, this offers 
no protection against a gpio versus hwmom driver conflict though, where both 
drivers know howto unlock.

You could try to integrate this enter / exit stuff into the locking though, but 
I'm not sure if we want this, we should first take a look to see when drivers 
open up the io ports by sending the key sequence, and when the close them again 
by sending the closing key, if this matches with moments when a drivers should 
call superio_enter and superio_exit, then we can make superio_enter and exit do 
the sending of the enter and leave codes, this would require adding these codes 
to the gate structure though,

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
