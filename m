From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 19 Feb 2013 03:28:34 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/9] ARM: dt: t30 cardhu: add dt entry for lm90
Message-Id: <5122F162.9030103@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org" <linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 02/18/2013 08:30 PM, Wei Ni wrote:
> Enable thermal sensor lm90 in the dts file.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Btw, shouldn't this patch come last, after all the changes you did to 
lm90? If you keep the current order, you will need to ensure that the 
device performs as expected on Cardhu for each of the remaining patches 
of the series. It is probably safer to just move this one at the end to 
avoid trouble.

Alex.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
