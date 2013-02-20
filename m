From: Wei Ni <wni@nvidia.com>
Date: Wed, 20 Feb 2013 12:31:37 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/9] hwmon: (lm90) split set&show temp as common codes
Message-Id: <5124C229.4030002@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-3-git-send-email-wni@nvidia.com> <51240331.7080604@wwwdotorg.org>
In-Reply-To: <51240331.7080604-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 02/20/2013 06:56 AM, Stephen Warren wrote:
> On 02/18/2013 04:30 AM, Wei Ni wrote:
>> Split set&show temp codes as common functions, so we can use it directly when
>> implement linux thermal framework.
> 
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> 
>> -static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
>> -			  char *buf)
>> +static void _show_temp8(struct device *dev, int index, int *temp)
> 
> This function now seems to be "get" not "show". If you rename it to e.g.
> "get_temp8", then you won't need to use an _ in the function name. If
> that name causes conflicts with later patches, perhaps "read_temp8".

Yes, it looks "read_" is better.
I will change it.

> 
>> -static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
>> -			 const char *buf, size_t count)
>> +static void _set_temp8(struct device *dev, int index, long val)
> 
> Similarly, perhaps "write_temp8"?
> 
> Similar comments for the rest of the patch.
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
