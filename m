From: Nishanth Menon <nm@ti.com>
Date: Tue, 01 Oct 2013 22:37:03 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] arm: dts: add dra7 DSPEVE thermal data
Message-Id: <20131001223703.GB11451@kahuna>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
 <1380652344-18819-2-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1380652344-18819-2-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, grant.likely@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 14:32-20131001, Eduardo Valentin wrote:
> This patch changes a dtsi file to contain the thermal data
	     ^^ introduces?
> for DSPEVE domain on DRA7 and later SoCs. This data will
> enable a thermal shutdown at 125C.
> 
> This thermal data can be reused across TI SoC devices.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
> 
> diff --git a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
> new file mode 100644
> index 0000000..f8b9051
> --- /dev/null
> +++ b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
> @@ -0,0 +1,28 @@
> +/*
> + * Device Tree Source for DRA7 SoC DSPEVE thermal
> + *
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +dspeve_thermal: dspeve_thermal {
> +	polling-delay-passive = <250>; /* milliseconds */
> +	polling-delay = <1000>; /* milliseconds */
> +
> +		/* sensor       ID */
^^
> +	thermal-sensors = <&bandgap     3>;
^^ tab control a bit? ;)
> +
> +	trips {
> +		dspeve_crit: dspeve_crit {
> +			temperature = <125000>; /* milliCelsius */
> +			hysteresis = <2000>; /* milliCelsius */
> +			type = THERMAL_TRIP_CRITICAL;
> +		};
> +	};
> +};

-- 
Regards,
Nishanth Menon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
