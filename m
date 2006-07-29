From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 29 Jul 2006 15:09:30 +0000
Subject: [lm-sensors] 18-rc1-mm1  and unchecked return-codes
Message-Id: <44CB7A2A.7080204@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44B3EEFD.5050209@gmail.com>
In-Reply-To: <44B3EEFD.5050209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Jim:
>
> * Jim Cromie <jim.cromie at gmail.com> [2006-07-27 16:07:05 -0600]:
>   
>>>> FWIW, device_remove_file() is only called 9 times.
>>>>     
>>>>         
>> 8 from hwmon/ams.c
>> 1 from hwmon/lm70.c
>>
>> This compares rather sparsely against:
>> [jimc at harpo linux-2.6.18-rc2-mm1-sk]$ grep device_create_file 
>> drivers/hwmon/*.c |wc
>>    1027    3046   83340
>>
>> Is it truly this optional ?
>>     
>
> At present, yes.  When the device goes away, the sysfs files go away too.
> This will become a problem though when we (eventually) move to persistent
> (i2c) devices, so we might as well fix it up now.
>
>   
>>>> Ive gone ahead and worked up a patch against pc87360 to
>>>> count-errors-and-warn, which should suffice, at least for short term.
>>>>     
>>>>         
>>> (Hopefully) I'll take a look at this later today.
>>>
>>>   
>>>       
>> dashed-hopes  ;-)
>> If you'd rather punt, I'll send it on to lkml, but I suppose Id like to 
>> keep it in-channel.
>>     
>
> Someday I will learn to keep my fantasies about free time to myself.
;-)  -  I now swallow the words "Two Weeks!", and try to answer with a 
question instead :-)

>   But
> you didn't actually send your patch to the list right (?)  At least I can't
> find it now that I'm looking again.
>
>   
For the patch itself, I used a subject-line I thought more suitable for 
submission.
However, it lost connection to this subject - doh.
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-July/016909.html


> Anyway... I guess we should stuff all those attributes in a table and run
> over them with a for loop.  Then if we catch an error, we can run back
> through the table in reverse.  I mean, what else can we do right? 
Im not sure what you mean -
- we dont *need* device-remove-file, since they 'go away' by themselves 
(at least for normal rmmods)
    and work properly when re-modprobed
- changing strategy  from completely-unchecked to 
undo-everything-and-bailout
    is a rather long step, and makes driver possibly unusable in some 
corner cases
    (none of which we know and can repeat)
- my approach of just counting and warning is 'more legacy'
    (but warnings may be ignored, whereas a 'broken-driver' will elicit 
more feedback)

IOW - theres a balance to strike here, and Im not sure where (too-clever 
see-saw analogy elided)
Anyway, your forthcoming patches will clarify your sense of the right 
balance..

>  I'll
> patch the following to start, all of which I can either test easily or
> for which I'm responsible anyway...
>
> 	asb100, lm75, lm78, smsc47b397, w83627hf
>
> Any volunteers for the other 38?
>
> Regards,
>
>   


