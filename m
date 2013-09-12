From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 12 Sep 2013 15:00:25 +0000
Subject: Re: [lm-sensors] [PATCH v4 3/3] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <5231D709.5080308@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378985061-28547-1-git-send-email-wni@nvidia.com> <1378985061-28547-4-git-send-email-wni@nvidia.com>
In-Reply-To: <1378985061-28547-4-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/12/2013 05:24 AM, Wei Ni wrote:
> Add OF document for LM90 in Documentation/devicetree/.

> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt

> +Optional properties:
> +- vcc-supply: vcc regulator for the supply voltage.
> +              If this is not set, assuming vcc is always powered.

I thought that was going to be a "Required Property".

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
