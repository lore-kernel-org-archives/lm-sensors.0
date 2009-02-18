From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Feb 2009 15:15:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing parentheses
Message-Id: <499C2614.4000606@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <499AB902.1080308@gmail.com>
In-Reply-To: <499AB902.1080308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Wed, 18 Feb 2009 15:25:52 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> On Tue, 17 Feb 2009 21:03:23 +0000, Alistair John Strachan wrote:
>>>> This one's been there from the beginning.
>>>>
>>>> The change looks right to me. (i * count) account the previous successes, add 
>>>> either zero or x depending on the kind of read failure (timeout/short read vs 
>>>> other I/O error). I'm not entirely sure why i must be >0 for accounting the 
>>>> short read.
>>> I can't make any sense of that "i &&" either. Hans?
>> This is in an error handling path, if some bytes were read but not count bytes, 
>> then we return i * count + x, where i * count is the number of bytes read 
>> successful so far and x is the number of bytes read for the offset we were 
>> reading from when we got the short read.
>>
>> However if this is not just a short read, but a read which error-ed out then x 
>> < 0. If we then would return i * count + x, we would return less then what 
>> we've actually read. So in this case we want to return just i * count, which 
>> gets done in the form of i * count + 0.
> 
> So far so good...
> 
>> There is one special case however if we get an error code in the form of x < 0, 
>> and we've not done any successfull reads (so i = 0), then the right thing to 
>> do is to pass the error code along. So the condition in which we want to add 0 
>> to the result instead of x becomes (i && x < 0)
>>
>> Hopes this helps.
> 
> OK... I get the idea now. I'm glad you were still around to explain it
> because I would never have figured it out. And I don't really like the
> logic: behaving differently if the error occurs during the first read
> or the later ones doesn't make a lot of sense to me. If the error is so
> important that it needs to be reported, then I say it should be
> reported later as well. Or seen the other way around, if it doesn't
> need to be reported on later reads, then why bother reporting it on the
> first read (rather than just returning 0)?
> 
> Roel's patch is correct and could be applied. That being said, I don't
> like that kind of tricky code that needs to be explained to you. I'd
> rather rewrite it in a simpler form which can be understood directly.
> Especially given the fact that all the callers care about is boolean
> success or failure. So I'd suggest the following code clean-up:
> 
> ---
>  drivers/hwmon/abituguru3.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.29-rc5.orig/drivers/hwmon/abituguru3.c	2009-01-17 09:06:19.000000000 +0100
> +++ linux-2.6.29-rc5/drivers/hwmon/abituguru3.c	2009-02-18 16:07:51.000000000 +0100
> @@ -760,8 +760,11 @@ static int abituguru3_read_increment_off
>  
>  	for (i = 0; i < offset_count; i++)
>  		if ((x = abituguru3_read(data, bank, offset + i, count,
> -				buf + i * count)) != count)
> -			return i * count + (i && (x < 0)) ? 0 : x;
> +				buf + i * count)) != count) {
> +			if (x < 0)
> +				return x;
> +			return i * count + x;
> +		}
>  
>  	return i * count;
>  }
> 
> Objections?
> 

No, looks good to me!

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
