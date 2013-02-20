From: Wei Ni <wni@nvidia.com>
Date: Wed, 20 Feb 2013 10:27:29 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/9] hwmon: (lm90) add support to handle irq
Message-Id: <5124A511.1060508@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-4-git-send-email-wni@nvidia.com> <512403F5.5010005@wwwdotorg.org> <5124429B.2000404@nvidia.com>
In-Reply-To: <5124429B.2000404-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 02/20/2013 11:27 AM, Alex Courbot wrote:
> On 02/20/2013 08:00 AM, Stephen Warren wrote:
>> On 02/18/2013 04:30 AM, Wei Ni wrote:
>>> Add support to handle irq. When the temperature touch the limit value, the
>>> driver can handle the interrupt.
>>
>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>
>>> +static void lm90_irq_work(struct work_struct *work)
>> ...
>>> +	enable_irq(client->irq);
>>> +}
>>> +
>>> +static irqreturn_t lm90_irq(int irq, void *dev_id)
>>> +{
>>> +	struct lm90_data *data = dev_id;
>>> +
>>> +	disable_irq_nosync(irq);
>>
>> I think IRQF_ONESHOT would enable you to remove the manual
>> enable/disable_irq calls.
> 
> Oh, right. Using a threaded IRQ with IRQF_ONESHOT would make that happen 
> transparently. Wasn't aware of that, thanks.

Oh, yes, I will use it in my next version.

Thanks.
Wei.

> 
> Alex.
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
