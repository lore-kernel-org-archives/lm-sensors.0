From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 08 Aug 2013 17:35:59 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <5203D6FF.1060000@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com> <1375944991-29182-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1375944991-29182-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/08/2013 12:56 AM, Wei Ni wrote:
> Enable thermal sensor nct1008 for t114 dalmore.

It'd be best to remove this patch from the series; send one series to
the LM90 maintainer with just the driver and DT binding changes, and
another series to the Tegra maintainer with the *.dts changes. You can
tell me not to apply the *.dts changes until the driver/binding changes
are accepted (or just wait until they are before sending the patch).


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
