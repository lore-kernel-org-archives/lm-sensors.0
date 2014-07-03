From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 14:21:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Avoid forward declaration
Message-Id: <CAFRkauAyBoMxUkEhJF9GaTw+kCvR+G3s=N5btoXfo2eMrMsLdA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395133.4895.1.camel@phoenix>
In-Reply-To: <1404395133.4895.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-03 22:12 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 07/03/2014 06:45 AM, Axel Lin wrote:
>>
>> Reorder functions to avoid forward declaration.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
>
> Hi Axel,
>
> did you write module test scripts for any of those by any chance ?
> Just asking, since it would save me some time.
No, not yet.
I need to study how to write the module test scripts first.

>
> The module test script for the adm1021 driver exposes a cache problem
> when writing temperature limits. temp_min and temp_max are expected
> to be stored in milli-degrees C but are stored in degrees C.
> Feel free to send a patch to fix the problem if you have time.
Ok. Thanks for the report and the nice test tool.

Regards,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
