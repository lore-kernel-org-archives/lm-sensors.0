From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Mon, 02 Mar 2015 19:28:03 +0000
Subject: Re: [lm-sensors] [PATCH v2] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
Message-Id: <54F4B9C3.8050602@free-electrons.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424887219-26652-1-git-send-email-simon.guinot@sequanux.org>
In-Reply-To: <1424887219-26652-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On 25/02/2015 19:00, Simon Guinot wrote:
> On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
> wired to the I2C fan controller but to a separe GPIO. This GPIO can be
> controlled by using the gpio-fan driver.
> 
> This patch adds the gpio-fan alarm description in the net2big_v2 DTS.

Now that the driver part had been merged, I applied this patch on
mvebu/dt.

Thanks,

Gregory

> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> v2 change:
> - Fix node name according to the ePAPR standard.
> 
> diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
> index 53dc37a3b687..13a44773b6df 100644
> --- a/arch/arm/boot/dts/kirkwood-net2big.dts
> +++ b/arch/arm/boot/dts/kirkwood-net2big.dts
> @@ -27,6 +27,11 @@
>  		device_type = "memory";
>  		reg = <0x00000000 0x10000000>;
>  	};
> +
> +	fan {
> +		compatible = "gpio-fan";
> +		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &regulators {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
