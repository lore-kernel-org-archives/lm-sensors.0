From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 04:04:09 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (gl520sm) Convert to devm_hwmon_device_register_with_groups
Message-Id: <CAFRkauAE9qfpKj7T_UnpZ1UAP9JKiA-jDk1vd9zeBSL8UnpUFQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404352213.29709.5.camel@phoenix>
In-Reply-To: <1404352213.29709.5.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-03 11:59 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 07/02/2014 06:50 PM, Axel Lin wrote:
>>
>> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
>> simplify the code a bit.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
>
> Applied to -next.
>
> Wonder if I should put the module tests into a repository on github.
> Interested, anyone ?

Yes, I'm interested in the module tests.

Thanks,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
