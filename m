From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 28 Oct 2009 09:26:00 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon-f71882fg: Cleanup sysfs attr
Message-Id: <4AE80E28.8020308@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AE02F3A.3000608@redhat.com>
In-Reply-To: <4AE02F3A.3000608@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 10/28/2009 10:06 AM, Jean Delvare wrote:
> On Thu, 22 Oct 2009 12:08:58 +0200, Hans de Goede wrote:
>> hwmon-f71882fg: Cleanup sysfs attr creation 2/2
>>
>> This patch merges the f71882fg_auto_pwm_attr array into the
>> fxxxx_fan_attr resp. fxxxx_auto_pwm_attr array, as the f71882fg_auto_pwm_attr
>> array was merely extending these 2 with entries for a 4th fan, it also makes
>> these 2 arrays 2 dimensional so that the rest of the code can choose to
>> add attr for 3 or 4 fans without needing to know the nr of attr per fan.
>
> Again only minor comments, which I can fix myself:
>

And again thanks and feel free to fix them!

Some responses to your comments below:

<snip>

>>
>>   /* Fan attr specific to the f8000 (4th fan input can only measure speed) */
>>   static struct sensor_device_attribute_2 f8000_fan_attr[] = {
>> @@ -1917,39 +1913,24 @@
>>   			goto exit_unregister_sysfs;
>>   		}
>>
>> -		err = f71882fg_create_sysfs_files(pdev, fxxxx_fan_attr,
>> -					ARRAY_SIZE(fxxxx_fan_attr));
>> +		err = f71882fg_create_sysfs_files(pdev,&fxxxx_fan_attr[0][0],
>> +				ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
>
> I have to admit I am a little worried by this. Looping over individual
> sub-arrays would look better (less hackish) to me. But maybe it's just
> me. Another problem is that any hole in the array will cause a bug, and
> unfortunately (my version of) gcc doesn't warn about this (and looping
> over individual sub-arrays doesn't help.) But well, if you know what
> you're doing it should be OK.
>

I agree this is a bit tricky, at first I wanted to add a
f71882fg_create_sysfs_files2 function, which would do a double loop, but that
then would need to get passed in the array dimensions and would still
need to get passed in a normal pointer to the first element, as I can
not code any of the dimensions inside the parameter list as they are not
constant, so that function would end up doing exactly the same as I'm
doing now, so I opted to just use the existing function for this.

> As a side note, I don't think "fxxxx_fan_attr" or
> "&fxxxx_fan_attr[0][0]" make any difference.
>

I would expect the type of fxxxx_fan_attr to be a *foo[] and not a *foo,
and thus to get a compiler warning, but you might be right, I didn't try.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
