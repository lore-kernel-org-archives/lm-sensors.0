From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [Fwd: Re: TR : RE : VIA VT1211 Port to 2.6.x in progress]
Message-Id: <40BB89D6.5010209@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks francois.
I tested one of the other versions and saw that it didn't have temp4-7.
I see that what aronyette is testing has the same problem.
Whatever version we submit needs to support all the sysfs entries that
the 2.4 version does in /proc.
Looks like francois' version has some more entries in it.

> Subject:
> RE: TR : RE : VIA VT1211 Port to 2.6.x in progress
> From:
> BARRE Francois <francois.barre@siemens.com>
> Date:
> Mon, 24 May 2004 14:41:09 +0200
> To:
> Mark Studebaker <mds@paradyne.com>
> 
> 
> Ooops sorry for my weeks late.
> 
> Here is my own last version. I tried to merge with the one of Nuno, but
> while testing it my kern lost its module consistency (no way to perform any
> lsmod or rmmod).
> 
> http://thedebbie.org/kernel/vt1211/vt1211.c 
> 
> Mine is incomplete (esp. Sysfs bindings), but never crashed. I should take
> time to finish this work, but my boss always returns -EBUSY these days...
> 
> Regards,
> 
> Fran?ois.
> 
> 
>>-----Message d'origine-----
>>De : Mark Studebaker [mailto:mds@paradyne.com] 
>>Envoy? : samedi 15 mai 2004 18:05
>>? : BARRE Francois
>>Cc : Nuno Grilo; Alexander Isacson; LM Sensors
>>Objet : Re: TR : RE : VIA VT1211 Port to 2.6.x in progress
>>
>>sorry for 2 month delay.
>>I'm ready to test your driver. Is the code at the link below 
>>still the latest?
>>
>>Mark Studebaker wrote:
>>
>>>I promised Khali I'd test your driver but first I have to 
>>
>>move my 1211 
>>
>>>board over to 2.6,
>>>hope to get to it soon.
>>>mds
>>>
>>>
>>>BARRE Francois wrote:
>>>
>>>
>>>>Hello all,
>>>>
>>>>This is my own port of the vt1211 for 2.6.x which seems to 
>>
>>work pretty 
>>
>>>>well,
>>>>including extensive insmod/rmmod uses, ...
>>>>I just have a problem with temp_[hyst|over]2, not solved yet... 
>>>>Working on
>>>>it !
>>>>
>>>>I hope it will be of some help...
>>>>
>>>>By the way, should someone include me in the sensors ml ?
>>>>
>>>>Thanks in advance.
>>>>
>>>>-----Message d'origine-----
>>>>De : Nuno Grilo [mailto:nuno.grilo@netcabo.pt] Envoy? : lundi 26 
>>>>janvier 2004 00:58
>>>>? : Alexander Isacson; Mark Studebaker
>>>>Cc : BARRE Francois; 'nuno.grilo@netcabo.pt'; LM Sensors
>>>>Objet : Re: TR : RE : VIA VT1211 Port to 2.6.x in progress
>>>>
>>>>Hi
>>>>
>>>>Take a look at my port, I think it should be usable enough 
>>
>>for what you
>>
>>>>want: http://pwp.netcabo.pt/0246517002/vt1211.c
>>>>
>>>>On Sunday 25 January 2004 21:28, Alexander Isacson wrote:
>>>>
>>>>
>>>>>Hello all.
>>>>>
>>>>>I'm wondering about the status of the port. I'm 
>>
>>approaching the deadline
>>
>>>>>for my project and I need to monitor voltages and 
>>
>>temperature. Is that
>>
>>>>>working in the current version? If so, could someone 
>>
>>please e-mail it to
>>
>>>>>me?
>>>>>
>>>>>Thanks allot, keep up the good work!
>>>>
>>>>
>>>>
>>>>
>>>
> 
