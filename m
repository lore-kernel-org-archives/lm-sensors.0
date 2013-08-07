From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 07 Aug 2013 16:03:58 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <52026FEE.9070003@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com> <1375858358-15070-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1375858358-15070-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/07/2013 12:52 AM, Wei Ni wrote:
> Enable thermal sensor nct1008 for t114 dalmore.

Wei, I assume this patch doesn't depend on any of the other LM90-related
patches you've sent; I can simply apply it right away?

Is the LM90 DT binding fully documented somewhere, including the
vdd-supply property?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
