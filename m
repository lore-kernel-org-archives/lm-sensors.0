From: Nishanth Menon <nm@ti.com>
Date: Tue, 01 Oct 2013 22:46:47 +0000
Subject: Re: [lm-sensors] [PATCH 3/7] arm: dts: dra7: add bandgap entry
Message-Id: <20131001224645.GC11451@kahuna>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
 <1380652344-18819-4-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1380652344-18819-4-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, grant.likely@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 14:32-20131001, Eduardo Valentin wrote:
> This patch adds bandgap IP entry on DRA7 dtsi device tree file.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 3a746c2..4e9b159 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -53,6 +53,18 @@
>  		};
>  	};
>  
> +	bandgap: bandgap {
	would you like to follow bandgap: bandgap@4a0021e0 convention?
Also, could you move it under ocp?
I already commented about this previously here: 
https://lkml.org/lkml/2013/9/27/300

> +		reg = <0x4a0021e0 0xc
> +			0x4a00232c 0xc
> +			0x4a002380 0x2c
> +			0x4a0023C0 0x3c
> +			0x4a002564 0x8
> +			0x4a002574 0x50>;
> +		compatible = "ti,dra752-bandgap";
> +		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +
>  	gic: interrupt-controller@48211000 {
>  		compatible = "arm,cortex-a15-gic";
>  		interrupt-controller;
-- 
Regards,
Nishanth Menon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
