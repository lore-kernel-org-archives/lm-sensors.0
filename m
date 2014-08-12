From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Aug 2014 15:37:59 +0000
Subject: Re: [lm-sensors] [RFT][PATCH v2 2/2] hwmon: (da9052) Convert to devm_hwmon_device_register_with_grou
Message-Id: <53EA34D7.3010005@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404868841.12195.3.camel@phoenix>
In-Reply-To: <1404868841.12195.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/12/2014 08:14 AM, Opensource [Adam Thomson] wrote:
> On July 9, 2014 02:21, Axel Lin wrote:
>
>> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups()
>> to
>> simplify the code a bit.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>

[ ... ]

>
> Change seems fine from my bring-up test.
>
> Tested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>

Thanks a lot for testing. Applied to -next.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
