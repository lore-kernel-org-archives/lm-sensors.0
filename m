From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 21 Aug 2006 19:27:21 +0000
Subject: [lm-sensors] [patch 0/3] pc87360 - fix unchecked
Message-Id: <44EA0919.4080308@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E72DE7.10907@gmail.com>
In-Reply-To: <44E72DE7.10907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Jim,
>
>   
>>> More interesting would be a comparison of the
>>> contents of /sys/class/hwmon/hwmon0/device before and after the
>>> patches. If the contents differ, something's wrong, else everything
>>> should be OK - or at least there is no regression.
>>>       
>> Your choice of words leaves me unsure whether this is an observation,
>> or a requirement.  In any case, its easy, so here it is, plus some other 
>> observations.
>>     
>
> What difference does it make? I can't force you to do it, and I can't
> verify by myself. I can only hope that you want to provide good patches
> to the community, and will test your work as much as possible.
>
>   
It seems I could also have chosen my wording a bit better ;-)

> It's really about what you want to give to us, rather than what I
> request or suggest.
>
>   
>> By contents, I assume you mean the files within the dir:
>>     
>
> Yes.
>
>   
>>  diff sys-files-2.6.1*
>> 51a52
>>  > subsystem@
>>     
>
> No idea where this comes from, but not from your patch, for sure. I
> guess it's something new, I have such links on 2.6.18-rc4, but I don't
> remember seeing them before.
>
> If that's the only difference it means your patch didn't omit any file,
> so it works as designed for your chip. Good.
>
>   


>> One other thing / oddity I note (again on old kernel, and new/patched).
>> Datestamps on the 'files' is not uniform.
>>
>> IOW, there are 2 datestamps : Aug 20 23:39  and Aug 21 08:04
>>
>>     
> Yeah, I see similar patterns here. Looks like the files start with
> their creation time, then the timestamp gets updated when you write
> to (always) or read from them (first time only?)
>
>   
only thing that chgs date is re-modding.
None of these affect the date.
    sensors; sensors -s; cat /sys/class/hwmon/hwmon0/device/*


> I can't explain it all, but it makes some sense, and I don't see any
> serious problem here anyway. Again, your patch can't have anything to
> do with this.
>
>   

ack.  Im also seeing this on laptop running fc4 kernel.


thanks

