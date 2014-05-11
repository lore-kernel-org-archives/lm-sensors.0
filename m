From: atx@atx.name
Date: Sun, 11 May 2014 11:27:38 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: bugfix and support for emc1412 in emc1403.c
Message-Id: <b9f6fe08e91b81bfd870105ab36a531c@rainloop.atalax.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140511131228.019bdba5@endymion.delvare>
 <20140511103152.GA5631@dashie>
In-Reply-To: <20140511131228.019bdba5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

May 11 2014 1:12 PM, "Jean Delvare"  wrote: 

> Hi Josef,
> 
> On Sun, 11 May 2014 12:31:52 +0200, Josef Gajdusek wrote:
> 
> 
>> Adds support for emc1412 to emc1403.c + minor bugfix
>> 
>> * Renamed generic thermal_* prefixed names to emc1403_*
>> 
>> 
>> Why? This adds a lot of noise to your patch and the benefit isn't
>> obvious. If you really want to do that, then it should be a separate
>> patch.
>> 
>> 
>>> * Fixed set_hyst being broken (i. e. writing 86000 set hysteresis to 84000)
>>> 
>> 
>> 
>> Bug fixes should be sent as separate patches, so that they can be
>> ported back to stable, long-term and distribution kernels.
>> 
>> 
>> * Added support for emc1412
>> 
>> Signed-off-by: Josef Gajdusek 
>> 
>> +MODULE_ALIAS("i2c:emc1403");
>> 
> 
> 
> Why add an alias which is already present?
> 
> --
> Jean Delvare
> SUSE L3 Support
> 


Hello,
thanks for your feedback. I am going to split and change the patches as you suggested and then resend within few hours.

Josef Gajdusek <atx@atx.name>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
