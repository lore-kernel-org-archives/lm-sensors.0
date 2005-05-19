From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: TR : RE : VIA VT1211 Port to 2.6.x in progress
Message-Id: <40A6410F.9060509@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <400DF5D5.4020209@verizon.net>
In-Reply-To: <400DF5D5.4020209@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I guess what I meant to ask is,
there are two ports, Nuno's and Francois', have you two done any merging or updating
or do you want me to just pick one?

Mark Studebaker wrote:
> sorry for 2 month delay.
> I'm ready to test your driver. Is the code at the link below still the 
> latest?
> 
> Mark Studebaker wrote:
> 
>> I promised Khali I'd test your driver but first I have to move my 1211 
>> board over to 2.6,
>> hope to get to it soon.
>> mds
>>
>>
>> BARRE Francois wrote:
>>
>>> Hello all,
>>>
>>> This is my own port of the vt1211 for 2.6.x which seems to work 
>>> pretty well,
>>> including extensive insmod/rmmod uses, ...
>>> I just have a problem with temp_[hyst|over]2, not solved yet... 
>>> Working on
>>> it !
>>>
>>> I hope it will be of some help...
>>>
>>> By the way, should someone include me in the sensors ml ?
>>>
>>> Thanks in advance.
>>>
>>> -----Message d'origine-----
>>> De : Nuno Grilo [mailto:nuno.grilo@netcabo.pt] Envoy? : lundi 26 
>>> janvier 2004 00:58
>>> ? : Alexander Isacson; Mark Studebaker
>>> Cc : BARRE Francois; 'nuno.grilo@netcabo.pt'; LM Sensors
>>> Objet : Re: TR : RE : VIA VT1211 Port to 2.6.x in progress
>>>
>>> Hi
>>>
>>> Take a look at my port, I think it should be usable enough for what you
>>> want: http://pwp.netcabo.pt/0246517002/vt1211.c
>>>
>>> On Sunday 25 January 2004 21:28, Alexander Isacson wrote:
>>>
>>>> Hello all.
>>>>
>>>> I'm wondering about the status of the port. I'm approaching the 
>>>> deadline
>>>> for my project and I need to monitor voltages and temperature. Is that
>>>> working in the current version? If so, could someone please e-mail 
>>>> it to
>>>> me?
>>>>
>>>> Thanks allot, keep up the good work!
>>>
>>>
>>>
>>>
>>>
>>
>>
> 
> 
