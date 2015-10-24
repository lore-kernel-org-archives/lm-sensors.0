From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 24 Oct 2015 12:45:10 +0000
Subject: Re: [lm-sensors] [RFC] hwmon: ina2xx: port to using remap, improve bandwidth.
Message-Id: <562B7D56.3010700@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <56263973.300@roeck-us.net>
 <1445616800-21329-1-git-send-email-mtitinger@baylibre.com>
 <562A65D3.8090306@roeck-us.net> <562A9A0A.5040503@baylibre.com>
In-Reply-To: <562A9A0A.5040503@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, bcousson@baylibre.com

On 10/23/2015 01:35 PM, Marc Titinger wrote:
> Hi Guenter
>
> thanks for the review, answers bellow.
>
[ ... ]

>>>   /* shunt voltage */
>>> -static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
>>> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_shunt, NULL,
>>>                 INA2XX_SHUNT_VOLTAGE);
>>
>> If you no longer use the register parameter, there is no need to provide it.
>> But then I'll have to spend some time trying to understand _why_ you don't
>> use it anymore and why you introduced separate show functions.
>> Some explanation might help.
>>
> The interval value is no longer needed to compute a read "gard" delay, but the client Application may still need to set a different averaging value through this interval setting, based on the DUT characteristics.

I don't really understand what you are saying here, sorry, and what it has
to do with the switch from a single to multiple show functions.

> As of using separate functions, it fits better in the new logic of "per-register" accesses. It does not bloat the code either.
>
"It does not bloat the code" is not a valid reason for making such a change,
nor "it fits better" (because that is an opinion). Reducing code size,
or simplifying the code, could be valid reasons.
The change is also technically unrelated to the switch to regmap.
Also, while it may not bloat the code, it definitely bloats the patch size
and makes it much more difficult to review the patch.

Please make only one logical change per patch. So far, we have identified
three independent sets of changes:
- switch to regmap
- switch to separate show functions
- switch to prioritize devicetree data over platform data

and I am not sure if there are more, given the complexity of the patch.

I would expect separate patches to address those changes. Please split
the patch accordingly.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
