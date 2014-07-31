From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 31 Jul 2014 08:43:00 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (da9052) Convert to devm_hwmon_device_register_with_groups
Message-Id: <CAFRkauCjm=ZbKoRVpH5ATVgPLHeLh28ssPpJXmRDHsfSHkVm7w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-31 16:38 GMT+08:00 Opensource [Steve Twiss]
<stwiss.opensource@diasemi.com>:
>
> On 23 July 2014 05:45 Axel Lin wrote:
>
>>
>>Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
>>simplify the code a bit.
>>
>>Signed-off-by: Axel Lin <axel.lin@ingics.com>
>>---
>>Hi,
>>This patch is appliable to linux-3.16-rc6.
>>I have sent the patch to lm-sensor ML, but still got nobody to test it.
>>Any chance to test if this patch works?
>>
>>Thanks,
>>Axel
>
> Hi Axel,
>
> I will take a look at this patch in the next few days and let you know the outcome.
>
> Regards,
> Steve

Thaks, Steve.

Cc lm-sensors ML.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
