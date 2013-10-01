From: Nishanth Menon <nm@ti.com>
Date: Tue, 01 Oct 2013 22:51:08 +0000
Subject: Re: [lm-sensors] [PATCH 6/7] arm: dts: add tmp102 i2c sensor node on dra7-evm
Message-Id: <20131001225108.GA11885@kahuna>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
 <1380652344-18819-7-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1380652344-18819-7-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, grant.likely@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 14:32-20131001, Eduardo Valentin wrote:
> On dra7-evm there is an tmp102 temperature sensor on i2c bus 1.
> This patch adds its device tree node.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 21fe16b..3b6c16a 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -7,6 +7,8 @@
>   */
>  /dts-v1/;
>  
> +#include <dt-bindings/thermal/thermal.h>
> +

^^ needed?

>  #include "dra7.dtsi"
>  
>  / {
> @@ -93,6 +95,12 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c1_pins>;
>  	clock-frequency = <400000>;
could you add an EOL here?
> +	tmp102: tmp102@48{
	a space before the {?
> +		compatible = "ti,tmp102";
> +		reg = <0x48>;
> +
> +		#thermal-sensor-cells = <0>;
> +	};
>  };
>  
>  &i2c2 {
> -- 
> 1.8.2.1.342.gfa7285d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,
Nishanth Menon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
