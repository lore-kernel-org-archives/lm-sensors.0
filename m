From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 01 Apr 2010 13:49:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: sht15: Fix sht15_calc_temp
Message-Id: <4BB4A465.3050305@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1732720040.861270126460533.JavaMail.root@mail.savoirfairelinux.com>
In-Reply-To: <1732720040.861270126460533.JavaMail.root@mail.savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 04/01/10 13:54, Jerome Oufella wrote:
> ----- "Jean Delvare" <khali@linux-fr.org> wrote :
>> May I suggest the more simple fix below?
>>
>> ---
>>  drivers/hwmon/sht15.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-2.6.34-rc3.orig/drivers/hwmon/sht15.c	2010-04-01
>> 13:41:15.000000000 +0200
>> +++ linux-2.6.34-rc3/drivers/hwmon/sht15.c	2010-04-01
>> 13:41:55.000000000 +0200
>> @@ -305,10 +305,10 @@ static inline int sht15_calc_temp(struct
>>  	int d1 = 0;
>>  	int i;
>>  
>> -	for (i = 1; i < ARRAY_SIZE(temppoints); i++)
>> +	for (i = ARRAY_SIZE(temppoints) - 1; i > 0 ;i--)
>>  		/* Find pointer to interpolate */
>>  		if (data->supply_uV > temppoints[i - 1].vdd) {
>> -			d1 = (data->supply_uV/1000 - temppoints[i - 1].vdd)
>> +			d1 = (data->supply_uV - temppoints[i - 1].vdd)
>>  				* (temppoints[i].d1 - temppoints[i - 1].d1)
>>  				/ (temppoints[i].vdd - temppoints[i - 1].vdd)
>>  				+ temppoints[i - 1].d1;
>>
>> It leads to the same numbers as with Jerome's patch, with the
>> advantages that 1* it is a much smaller change, more suitable for
>> applying to stable kernels and 2* it avoids the magic constant number
>> 10000.
>>
>> The "/1000" seems to be a relict of former times when
>> temppoints[*].vdd
>> was probably expressed in millivolt instead of microvolt. And the
>> inverted loop iteration is obviously a bug.
>>
>> Note that in both cases, something should be done about values which
>> are outside of the temppoints array. I don't know how likely these
>> are,
>> but they are seriously mishandled. For supply_uV values below
>> temppoints[0].vdd, d1 defaults to 0, so no adjustment is done at all.
>> temppoints[0].d1 would seem to be a much better default, if we don't
>> want to do any interpolation in that case. For supply_uV values above
>> temppoints[4].vdd, we do interpolate, which seems reasonable.
>>
>> Opinions?
>>
>> -- 
>> Jean Delvare
> 
> That's fine, it does a good job for me, in the expected voltage range.

Seems sensible.  I'm not quite sure but I think the code in question predates
my involvement with the driver, so I'm guessing I never actually looked
closely enough at it.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
