From: "Phil Endecott" <phil_lftzl_endecott@chezphil.org>
Date: Tue, 26 Jun 2007 21:50:40 +0000
Subject: Re: [lm-sensors] [PATCH] Add temperature-tracking mode to
Message-Id: <1182894640566@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182682179001@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182682179001@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>> --- linux-2.6-2.6.21/drivers/hwmon/f71805f.c.orig	2007-06-16 00:10:54.000000000 +0100
>> +++ linux-2.6-2.6.21/drivers/hwmon/f71805f.c	2007-06-19 21:07:26.000000000 +0100
[snip]
>> @@ -931,6 +1029,58 @@
>>  			  show_pwm_freq, set_pwm_freq, 2);
>>  static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
>>  
>> +static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IRUGO,
>> +					show_pwm_auto_channels, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IRUGO,
>> +					show_pwm_auto_channels, NULL, 1);
>> +static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IRUGO,
>> +					show_pwm_auto_channels, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(pwm1_auto_channels_fan, S_IRUGO,
>> +					show_pwm_auto_channels, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(pwm2_auto_channels_fan, S_IRUGO,
>> +					show_pwm_auto_channels, NULL, 1);
>> +static SENSOR_DEVICE_ATTR(pwm3_auto_channels_fan, S_IRUGO,
>> +					show_pwm_auto_channels, NULL, 2);
>
> Not sure what others think about this (Mark? Juerg?) but this (pwm1 to
> fan1 and to temp1, etc.) seems to be the usual mapping for chips where
> the mappings can't be changed, so I wonder what's the benefit of
> creating read-only sysfs files to express it. I think I'd be just as
> happy with no channel files at all (and it's cheaper.) No strong
> opinion though.

If anyone would like to express an opinion on this please do so as soon 
as possible.  The hardware on which I am able to test this will soon 
become unavailable.


Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
