From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 31 Jul 2014 05:49:39 +0000
Subject: Re: [lm-sensors] [RFT][PATCH v2 2/2] hwmon: (da9055) Convert to devm_hwmon_device_register_with_grou
Message-Id: <53D9D8F3.3090407@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404869112.12195.6.camel@phoenix>
In-Reply-To: <1404869112.12195.6.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/30/2014 07:05 PM, Axel Lin wrote:
> 2014-07-09 9:25 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
>> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
>> simplify the code a bit.
>
> Hi Guenter:
>
> I resent the patches (for da9052 and da9055) to Support.Opensource@diasemi.com>.
> And I got reply from Adam as below:
>
> Hi Axel,
>
> Apologies for the late response to this. Realistically I don't think we're going
> to be able to test this within the next couple of weeks, but we will try and
> find some time as soon as we can to verify your changes.
>
>>From looking at the patches initially though, I don't see anything obvious that
> should cause a problem.
>
> Thanks
>
>
> So I'm wondering if it's ok to apply the patches if having Adam's Acked or
> Reviewed-by.
>
If Adam would be willing to do that, I would accept it.

Guenter

> Adam,
> May I have your Acked-by or Reviewed-by tag for both da9052 and da9055 patches?
>
> Thanks,
> Axel
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
