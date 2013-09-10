From: Wei Ni <wni@nvidia.com>
Date: Tue, 10 Sep 2013 04:36:31 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <522EA1CF.4070605@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com> <1378722552-10357-3-git-send-email-wni@nvidia.com> <CALkWK0nqgF6yn4QRe2tTD-Qd+5GLtH-ifCesayk-+uxkWMx-5w@mail.gmail.com> <522EA177.6050608@nvidia.com>
In-Reply-To: <522EA177.6050608-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ramkumar Ramachandra <artagnon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/10/2013 12:35 PM, Wei Ni wrote:
> On 09/09/2013 06:57 PM, Ramkumar Ramachandra wrote:
>> Wei Ni wrote:
>>> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
>>> new file mode 100644
>>> index 0000000..5570875
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
>>
>> While at it, please update and rename ads1015.txt.
> 
> This series is for lm90 compatible devices, it seems ads1015 is not
> register-compatible with lm90.
> 
>>
>>> @@ -0,0 +1,44 @@
>>> +* LM90 series thermometer.
>>> +
>>> +Required node properties:
>>> +- compatible: manufacture and chip name, one of
>>> +               "<manufacture>,adm1032"
>>> +               "<manufacture>,adt7461"
>>> +               "<manufacture>,adt7461a"
>>> +               "<manufacture>,g781"
>>> +               "<manufacture>,lm90"
>>> +               "<manufacture>,lm86"
>>> +               "<manufacture>,lm89"
>>> +               "<manufacture>,lm99"
>>
>> More versions of this of different ages are required.
> 
> In here, the chip names, such as "lm99", come from lm90.c id_table, the
> i2c subsystem want to use it to load driver, so we can add any other names.

Sorry, it's typo, it should be "can't add any other names".

> 
>>
>>> +               "<manufacture>,max6646"
>>> +               "<manufacture>,max6647"
>>> +               "<manufacture>,max6649"
>>> +               "<manufacture>,max6657"
>>> +               "<manufacture>,max6658"
>>> +               "<manufacture>,max6659"
>>> +               "<manufacture>,max6680"
>>> +               "<manufacture>,max6681"
>>> +               "<manufacture>,max6695"
>>> +               "<manufacture>,max6696"
>>
>> SSDNow devices are required.
> What's the SSDNow device? It seems the lm90.c doesn't support it.
> 
> Thanks.
> Wei.
> 
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
