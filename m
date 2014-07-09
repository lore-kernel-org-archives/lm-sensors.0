From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 09 Jul 2014 00:27:28 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (da9052) Convert to devm_hwmon_device_register_with_groups
Message-Id: <CAFRkauCYdm8gszM38VuM6GPFHGjXGmzRf5z5PXnVkE2hAW_jaQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404010388.5607.1.camel@phoenix>
In-Reply-To: <1404010388.5607.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-08 22:07 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 06/28/2014 07:53 PM, Axel Lin wrote:
>>
>> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
>> simplify the code a bit.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
>
> I'll need a Tested-by: to apply this patch.
Indeed. I think I'll try to CC more people when send v2.
>
>
>> ---
>> Note, devm_hwmon_device_register_with_groups does not allow "-" in the
>> name
>> argument. So there is a change in 'name' attribute.
>> It was "da9052-hwmon", and now it's "da9052".
>
>
> It might be worthwhile to send a separate patch to address this problem.
I know devm_hwmon_device_register_with_groups does not allow "-" in
the name argument,
but I don't know why.
So I'm wondering if current code which use "da9052-hwmon" in name
attribute causes any problem?

Regards,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
