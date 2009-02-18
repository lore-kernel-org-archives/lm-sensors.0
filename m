From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Feb 2009 14:25:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing parentheses
Message-Id: <499C1A70.702@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <499AB902.1080308@gmail.com>
In-Reply-To: <499AB902.1080308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> On Tue, 17 Feb 2009 21:03:23 +0000, Alistair John Strachan wrote:
>> On Tuesday 17 February 2009 13:17:54 Roel Kluin wrote:
>>> I think this was intended? please review.
>> This one's been there from the beginning.
>>
>> The change looks right to me. (i * count) account the previous successes, add 
>> either zero or x depending on the kind of read failure (timeout/short read vs 
>> other I/O error). I'm not entirely sure why i must be >0 for accounting the 
>> short read.
> 
> I can't make any sense of that "i &&" either. Hans?
> 

This is in an error handling path, if some bytes were read but not count bytes, 
then we return i * count + x, where i * count is the number of bytes read 
successful so far and x is the number of bytes read for the offset we were 
reading from when we got the short read.

However if this is not just a short read, but a read which error-ed out then x 
< 0. If we then would return i * count + x, we would return less then what 
we've actually read. So in this case we want to return just i * count, which 
gets done in the form of i * count + 0.

There is one special case however if we get an error code in the form of x < 0, 
and we've not done any successfull reads (so i = 0), then the right thing to 
do is to pass the error code along. So the condition in which we want to add 0 
to the result instead of x becomes (i && x < 0)

Hopes this helps.

Regards,

Hans

>> Nothing calling abituguru3_read_increment_offset() checks for anything other 
>> than complete success. Every caller passes count=1, and offset_count>1, so 
>> both the new code and the old could never return a full count 
>> (offset_count*count) when an error has occured (old returns either 0 or x, 
>> x=count). Ergo, the change can't cause any regressions.
>>
>> Acked-by: Alistair John Strachan <alistair@devzero.co.uk>
>>
>> Jean, are you happy to take this?
> 
> Yes, but I'd like to understand why the "i &&" is there, and if there's
> no good reason we should drop it.
> 
>>> --------------------------->8-------------8<------------------------------
>>> Add missing parentheses
>>>
>>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>>> ---
>>> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
>>> index e52b388..fd98685 100644
>>> --- a/drivers/hwmon/abituguru3.c
>>> +++ b/drivers/hwmon/abituguru3.c
>>> @@ -761,7 +761,7 @@ static int abituguru3_read_increment_offset(struct
>>> abituguru3_data *data, for (i = 0; i < offset_count; i++)
>>>  		if ((x = abituguru3_read(data, bank, offset + i, count,
>>>  				buf + i * count)) != count)
>>> -			return i * count + (i && (x < 0)) ? 0 : x;
>>> +			return i * count + ((i && (x < 0)) ? 0 : x);
>>>
>>>  	return i * count;
>>>  }
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
