From: Nikola Pajkovsky <npajkovs@redhat.com>
Date: Tue, 06 Apr 2010 10:10:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] add FSCSYL to lm_sensors 2.10.8
Message-Id: <4BBB087A.6070108@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BBAFA6B.3080508@redhat.com>
In-Reply-To: <4BBAFA6B.3080508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/06/2010 11:43 AM, Jean Delvare wrote:
> Hi Nikola,
>
> On Tue, 06 Apr 2010 11:10:03 +0200, Nikola Pajkovsky wrote:
>   
>> diff -up lm_sensors-2.10.7/lib/chips.c.fscsyl lm_sensors-2.10.7/lib/chips.c
>> --- lm_sensors-2.10.7/lib/chips.c.fscsyl    2008-07-01 14:23:06.000000000 -0400
>> +++ lm_sensors-2.10.7/lib/chips.c    2009-12-09 10:05:57.000000000 -0500
>> @@ -6361,6 +6361,68 @@ static sensors_chip_feature fschmd_featu
>>      { { 0 }, 0 }
>>  };
>>  
>> +#define SENSORS_FSCSYL_IN_FEATURES(nr) \
>> +    { { SENSORS_FSCSYL_IN(nr), "in" #nr, \
>> +        NOMAP, NOMAP, R }, \
>> +        NOSYSCTL, VALUE(1), 3 }
>> +
>> +#define SENSORS_FSCSYL_TEMP_FEATURES(nr) \
>> +    { { SENSORS_FSCSYL_TEMP(nr), "temp" #nr, \
>> +        NOMAP, NOMAP, R }, \
>> +        NOSYSCTL, VALUE(2), 3 }, \
>> +    { { SENSORS_FSCSYL_TEMP_MAX(nr), "temp" #nr "_max", \
>> +        SENSORS_FSCSYL_TEMP(nr), SENSORS_FSCSYL_TEMP(nr), RW }, \
>> +        NOSYSCTL, VALUE(1), 3 }, \
>> +    { { SENSORS_FSCSYL_TEMP_ALARM(nr), "temp" #nr "_alarm", \
>> +        SENSORS_FSCSYL_TEMP(nr), NOMAP, R }, \
>> +        NOSYSCTL, VALUE(1), 0 }, \
>> +    { { SENSORS_FSCSYL_TEMP_FAULT(nr), "temp" #nr "_fault", \
>> +        SENSORS_FSCSYL_TEMP(nr), NOMAP, R }, \
>> +        NOSYSCTL, VALUE(1), 0 }
>> + (...)
>>     
> lm-sensors 2.x is in maintenance mode, we no longer add chip support to
> it. Please move to lm-sensors 3.x, it's much better it pretty much all
> respects.
>
>   
I have to do it like that, because we still have lm-sensors 2.x in
rhel5. fscsyl and fschds has already support in lm-sensros 3.x

-- 
Nikola


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
