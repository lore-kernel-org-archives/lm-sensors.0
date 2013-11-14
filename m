From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Nov 2013 12:33:20 +0000
Subject: Re: [lm-sensors] [PATCH v5 3/3] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <20131114133320.00ad70c0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381137940-22608-1-git-send-email-wni@nvidia.com>
	<1381137940-22608-4-git-send-email-wni@nvidia.com>
In-Reply-To: <1381137940-22608-4-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Mon, 7 Oct 2013 17:25:40 +0800, Wei Ni wrote:
> Add OF document for LM90 in Documentation/devicetree/.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/hwmon/lm90.txt |   44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
> new file mode 100644
> index 0000000..e863248
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
> @@ -0,0 +1,44 @@
> +* LM90 series thermometer.
> +
> +Required node properties:
> +- compatible: manufacturer and chip name, one of
> +		"adi,adm1032"
> +		"adi,adt7461"
> +		"adi,adt7461a"
> +		"gmt,g781"
> +		"national,lm90"
> +		"national,lm86"
> +		"national,lm89"
> +		"national,lm99"
> +		"dallas,max6646"
> +		"dallas,max6647"
> +		"dallas,max6649"
> +		"dallas,max6657"
> +		"dallas,max6658"
> +		"dallas,max6659"
> +		"dallas,max6680"
> +		"dallas,max6681"
> +		"dallas,max6695"
> +		"dallas,max6696"
> +		"onnn,nct1008"
> +		"winbond,w83l771"
> +		"nxp,sa56004"
> +
> +- reg: I2C bus address of the device
> +
> +- vcc-supply: vcc regulator for the supply voltage.
> +
> +Optional properties:
> +- interrupts: Contains a single interrupt specifier which describes the
> +              LM90 "-ALERT" pin output.
> +              See interrupt-controller/interrupts.txt for the format.
> +
> +Example LM90 node:
> +
> +temp-sensor {
> +	compatible = "onnn,nct1008";
> +	reg = <0x4c>;
> +	vcc-supply = <&palmas_ldo6_reg>;
> +	interrupt-parent = <&gpio>;
> +	interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> +}

Looks good to me, just one question: is it OK that interrupt-parent is
not described in the document? Is it supposed to be a standard property?

I'll add this file to the LM90 entry in MAINTAINERS, so that I can pick
this patch in my tree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
