From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Sep 2013 10:52:27 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <522DA86B.6000603@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com> <1378722552-10357-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1378722552-10357-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/09/2013 03:29 AM, Wei Ni wrote:
> Add OF document for LM90 in Documentation/devicetree/.
>
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>   Documentation/devicetree/bindings/hwmon/lm90.txt |   44 ++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt
>
> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
> new file mode 100644
> index 0000000..5570875
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
> @@ -0,0 +1,44 @@
> +* LM90 series thermometer.
> +
> +Required node properties:
> +- compatible: manufacture and chip name, one of

manufacturer

> +		"<manufacture>,adm1032"
> +		"<manufacture>,adt7461"
> +		"<manufacture>,adt7461a"
> +		"<manufacture>,g781"
> +		"<manufacture>,lm90"
> +		"<manufacture>,lm86"
> +		"<manufacture>,lm89"
> +		"<manufacture>,lm99"
> +		"<manufacture>,max6646"
> +		"<manufacture>,max6647"
> +		"<manufacture>,max6649"
> +		"<manufacture>,max6657"
> +		"<manufacture>,max6658"
> +		"<manufacture>,max6659"
> +		"<manufacture>,max6680"
> +		"<manufacture>,max6681"
> +		"<manufacture>,max6695"
> +		"<manufacture>,max6696"
> +		"<manufacture>,nct1008"
> +		"<manufacture>,w83l771"
> +		"<manufacture>,sa56004"
> +
Shouldn't the manufacturers be listed explicitly ?

> +- reg: I2C bus address of the device
> +
> +Optional properties:
> +- vcc-supply: vcc regulator for the supply voltage.
> +              If this is not set, assuming vdd is always powered.

s/assuming/assume/

> +- interrupts: Contains a single interrupt specifier which describes the
> +              LM90 pin6 output.
> +              See interrupt-controller/interrupts.txt for the format.
> +
> +Example LM90 node:
> +
> +temp-sensor {
> +	compatible = "onnn,nct1008";
> +	reg = <0x4c>;
> +	vcc-supply = <&palmas_ldo6_reg>;
> +	interrupt-parent = <&gpio>;

List above as optional property.

> +	interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> +}
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
