From: Wei Ni <wni@nvidia.com>
Date: Mon, 16 Sep 2013 04:21:54 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/3] hwmon: (lm90) Add power control
Message-Id: <52368762.7000701@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378985061-28547-1-git-send-email-wni@nvidia.com> <1378985061-28547-2-git-send-email-wni@nvidia.com> <20130912115106.GM29403@sirena.org.uk>
In-Reply-To: <20130912115106.GM29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/12/2013 07:51 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Sep 12, 2013 at 07:24:19PM +0800, Wei Ni wrote:
> 
>> +#include <linux/delay.h>
> 
> You don't need this any more, otherwise

Oh, yes, I will remove it.

> 
> Reviewed-by: Mark Brown <broonie@linaro.org>
> 
> * Unknown Key
> * 0x7EA229BD
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
