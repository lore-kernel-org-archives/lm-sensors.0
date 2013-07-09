From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Jul 2013 07:55:25 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] ARM: dt: t30 cardhu: add dt entry for lm90
Message-Id: <20130709095525.5158a0a5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372928979-26938-1-git-send-email-wni@nvidia.com>
	<1372928979-26938-2-git-send-email-wni@nvidia.com>
	<51D70483.70203@wwwdotorg.org>
	<51DA6BD4.1040300@nvidia.com>
	<20130708095024.041a6d57@endymion.delvare>
	<51DA8805.50709@nvidia.com>
	<20130708131421.GB21638@roeck-us.net>
	<20130709062112.GC17499@mithrandir>
	<51DBC058.2040904@nvidia.com>
In-Reply-To: <51DBC058.2040904-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Tue, 9 Jul 2013 15:48:40 +0800, Wei Ni wrote:
> On 07/09/2013 02:21 PM, Thierry Reding wrote:
> > It should work out of the box. As a matter of fact the same chip is used
> > on Tamonten and the DTS files use "onnn,nct1008". That used to work. If
> > it no longer does then that's a regression.
> 
> I synced the linux-next from:
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> and use the tag v3.10-rc7, but in the lm90.c it doesn't have DT support,
> such as "onnn,nct1008".
> I googled it and found there has patch:
> [PATCH] hwmon: (lm90) Add device tree support , which is in:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2013-February/038099.html
> , but it didn't be merged into the linux-next.

It was not, because of the next reply in the same thread:
http://lists.lm-sensors.org/pipermail/lm-sensors/2013-February/038100.html

> which git repository and branch should I use ?

It is supposed to just work. What doesn't work for you exactly?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
