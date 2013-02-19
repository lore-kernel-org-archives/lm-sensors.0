From: Wei Ni <wni@nvidia.com>
Date: Tue, 19 Feb 2013 09:58:36 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/9] hwmon: (lm90) use macros for the indexes of temp8 and temp11
Message-Id: <51234CCC.2060909@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-5-git-send-email-wni@nvidia.com> <5123100A.9050604@nvidia.com>
In-Reply-To: <5123100A.9050604-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 02/19/2013 01:39 PM, Alex Courbot wrote:
> On 02/18/2013 08:30 PM, Wei Ni wrote:
>> Using macros for the indexes and nrs of temp8 and temp11.
>> This make the code much clearer.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Great patch. This makes the code much more readable. I also compiled 
> lm90.o before and after this patch, and diff'ed the stripped binaries to 
> make sure there was no error in the macro indexes. Both binaries were 
> indentical, therefore:
> 
> Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Great, thanks for your test, I will do it in my next version.

Wei.

> 
> Alex.
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
