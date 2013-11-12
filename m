From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Nov 2013 14:39:34 +0000
Subject: Re: [lm-sensors] [PATCH v5 2/3] of: add vendor prefix for GMT
Message-Id: <20131112153934.30543f8d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381137940-22608-1-git-send-email-wni@nvidia.com>
	<1381137940-22608-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1381137940-22608-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Mon, 7 Oct 2013 17:25:39 +0800, Wei Ni wrote:
> Adding Global Mixed-mode Technology Inc. to the list
> of devicetree vendor prefixes.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2956800..634c35f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -28,6 +28,7 @@ est	ESTeem Wireless Modems
>  fsl	Freescale Semiconductor
>  GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
> +gmt	Global Mixed-mode Technology Inc.
>  hisilicon	Hisilicon Limited.
>  hp	Hewlett Packard
>  ibm	International Business Machines (IBM)

This patch looks good (except maybe for the missing comma before
"Inc.") but I'm not the one who can apply it. If should be sent to the
OF/DT maintainers as listed by ./scripts/get_maintainer.pl.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
