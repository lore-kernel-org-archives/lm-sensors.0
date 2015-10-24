From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 24 Oct 2015 02:21:42 +0000
Subject: Re: [lm-sensors] [RFC] hwmon: ina2xx: port to using remap, improve bandwidth.
Message-Id: <562AEB36.2090901@roeck-us.net>
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
> Marc.
>

[ ... ]

>>> -    /*
>>> -     * Ina226 has a variable update_interval. For ina219 we
>>> -     * use a constant value.
>>> +    /* Check for shunt resistor value.

Another comment: Standard multi-line comments, please.

>>> +     * Give precedence to device tree over must-recompile.
>>>        */
>>> -    if (data->kind = ina226)
>>> -        ina226_set_update_interval(data);
>>> -    else
>>> -        data->update_interval = HZ / INA2XX_CONVERSION_RATE;
>>> +    if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
>>> +        pdata = dev_get_platdata(dev);
>>> +        if (pdata)
>>> +            val = pdata->shunt_uohms;
>>> +        else
>>> +            val = INA2XX_RSHUNT_DEFAULT;
>>> +    }
>>
>> This changes priority from platform data first to devicetree configuration first.
>> As such, it is an unrelated change. If needed, split into a separate patch, and
> Yes I would do a separate patch normaly, agreed.
>
>> explain the reasoning, please.
> Changing the platform data requires changes in the kernel code, and hence recompilation. It seems a bit unexpected that setting a new value in the dtb will be ignored because there is a compiled-in platform data. Should'nt the dtb allow to override platform data ?

Normally you would not _have_ platform data in a system which is dtb enabled.
I don't really mind changing priorities (you are right, it makes sense to
check for devicetree data first), but as mentioned as separate patch, please.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
