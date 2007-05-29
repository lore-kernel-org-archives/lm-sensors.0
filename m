From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 29 May 2007 08:19:03 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <465BE1F7.2010408@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
>>> @@ -208,24 +197,27 @@
>>>    if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_FAULT) &&
>>>        TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_FAULT) > 0.5) {
>>>      printf(" FAULT");
>>> -  } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) && 
>>> -      TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5) {
>>> +  } else
>>> +  if ((TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) && 
>>> +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5)
>>> +   || (type = MINMAX &&
>>> +       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MIN_ALARM) && 
>>> +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MIN_ALARM) > 0.5)
>>> +   || (type = MINMAX &&
>>> +       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MAX_ALARM) && 
>>> +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MAX_ALARM) > 0.5)) {
>>>      printf(" ALARM");
>>>    }
>>>    printf("\n");
>>>    
>> -Is the type = MINMAX check for printing the alarms necessary, doesn't this 
>> has the risk of not showing an alarm for some chip with a funky combination of 
>> temp sysfs entries?
> 
> This will need to be double-checked. Removing the check altogether has
> the risk of printing alarms where they do not belong, which isn't
> better. Temperatures are a bit tricky because we may have up to 5 limit
> values to display and we only have 2 slots on the first line. So some
> of the limits may move to a second line. And I think we want to display
> the ALARM flag on the right line in this case. Or maybe you think the
> ALARM flag should always be on the first line even if it corresponds to
> a limit which is on the second line?
> 

I don't have any real preference either way (ALARM always on the first line, or 
on the line with the matching limit).

>> -Shouldn't the code somehow show the difference between a min and a max (and a 
>> generic) alarm? See how print_generic_chip_in() does this
> 
> Yes I know the voltage code does this, but the temperature code is much
> more complex at the moment. I have no objection if you want to add this
> feature, but let's first cleanup the code.
> 

+1

> I see we have SENSORS_FEATURE_TEMP_OVER, SENSORS_FEATURE_TEMP_LOW and
> SENSORS_FEATURE_TEMP_HIGH defined. What are these? We don't have names
> for these in our standard sysfs interface, and they seem completely
> redundant with SENSORS_FEATURE_TEMP_MAX and SENSORS_FEATURE_TEMP_MIN.
> Did your students get confused by the non-standard names in the 2.4
> driver somehow? It looks to me like we could plain delete these three
> symbols.
> 

I think my students may have gotten confused by the 2.4 names in lib/chips.c 
just like I was, so if you're reasonable sure that these do not exist in 2.6 
drivers, feel free to remove them.

>> Some generic notes not directly related to your patch:
>>
>> This piece of code in print_generic_chip_temp() can be done much simpler:
>>
>>    if (type = LIM) {
>>    } else {
>>      print_temp_info_real(val, max, min, 0.0, type, 1, 1);
>>    }
>>
>> Since lim always is 0.0 (this initalized to this) in the non LIM case, this can 
>> be written as just:
>>    print_temp_info_real(val, max, min, lim, type, 1, 1);
>>
>> Will you change this or shall I?
> 
> I would first need to be explained what this "LIM" thing is. It
> doesn't correspond to anything in our standard sysfs interface as far
> as I can see, and no legacy chip code was using it. I would get rid of
> it.
> 

I think my students added then LIM print_temp_info() minmax type, to support 
chips like the fscscy, see print_fscfsy() in prog/sensors/chips.c

>> More in general print_generic_chip_temp(), needs a good review by someone who 
>> is well aware of all possible tempX sysfs entry combo's (iow not by me).
> 
> We agree ;) see my comments above. If we get rid of the 4 unneeded
> limits as I am suggesting, I'm certain things will be a lot easier. Of
> course, even then, there are some decisions to make because we can have
> many different combinations of temperature limits depending on the
> chip, and we want to present them in the way that makes the more sense
> each time. I will look into this after the cleanups are done.
> 

Ok, well first we need a decision on the LIM feature + print support, then I 
can do some cleanup based on what was discussed sofar, after which it would be 
really nice if you could review print_generic_chip_temp()

>> Also print_generic_chip_in(), has some dangerous and unneeded assumptions, for 
>> example:
>> -it assumes that if there is a inX_max that there will also always be a inX_min
>> -it assumes that if there is no inX_max there will also be no alarms
>>
>> Shall I fix these or will you?
> 
> The code shouldn't assume anything like that. Please fix.
> 

will do.

>> Somewhat less "unneeded" assumption
>> -it doesn't check for inX_max_alarm without an inX_min_alarm and visa versa, I
>>   admit this would be a driver bug, as then the driver should have just a
>>   inX_alarm, but still we might want to concider this.
> 
> Your own assumption is wrong. A chip could have a voltage input with a
> min limit and a max limit, and an alarm which is only raised by the max
> limit. In this case, the driver would indeed have inX_max_alarm and not
> inX_min_alarm. Not to say that this particular hardware design would be
> smart, but if it existed, that's what how our driver would support it.
> And we've seen such weird hardware designs already... So you could fix
> this too.
> 

will do.

> I've committed my pending patches now, so if you could now fix the
> problems you've seen, this would be welcome.

Once I've got an answer on the LIM thing from you I'll fix all off the above.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
