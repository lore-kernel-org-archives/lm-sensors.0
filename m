From: Roland Stigge <stigge@antcom.de>
Date: Sat, 24 Mar 2012 19:45:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: max6639: Fix CONFIG_PM compile option
Message-Id: <4F6E2467.1050809@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332614169-30854-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1332614169-30854-1-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 24/03/12 20:12, Guenter Roeck wrote:
>> --- linux-2.6.orig/drivers/hwmon/max6639.c
>> +++ linux-2.6/drivers/hwmon/max6639.c
>> @@ -596,6 +596,7 @@ static int max6639_remove(struct i2c_cli
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PM
> 
> Looking into other drivers, I think that should be CONFIG_PM_SLEEP

Which other drivers did you mean?

What about those drivers that all handle it via CONFIG_PM:

abituguru.c
abituguru3.c
exynos4_tmu.c
gpio-fan.c
jc42.c
lm75.c
tmp102.c

?

>> +#else
>> +#define max6639_suspend NULL
>> +#define max6639_resume NULL
>> +#endif
>>  
> ... and that else case should not be necessary.

According to the compiler warning, right. :-)

Thanks,

Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
