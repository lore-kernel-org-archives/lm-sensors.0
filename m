From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Feb 2015 14:10:59 +0000
Subject: Re: [lm-sensors] [PATCH] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
Message-Id: <54EB34F3.4000500@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
In-Reply-To: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/23/2015 05:02 AM, Simon Guinot wrote:
> On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
> wired to the I2C fan controller but to a separe GPIO. This GPIO can be
> controlled by using the gpio-fan driver.
>
> This patch adds the gpio-fan alarm description in the net2big_v2 DTS.
>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>   arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
> index 53dc37a3b687..e4f7e497379f 100644
> --- a/arch/arm/boot/dts/kirkwood-net2big.dts
> +++ b/arch/arm/boot/dts/kirkwood-net2big.dts
> @@ -27,6 +27,11 @@
>   		device_type = "memory";
>   		reg = <0x00000000 0x10000000>;
>   	};
> +
> +	gpio_fan {
> +		compatible = "gpio-fan";
> +		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> +	};
>   };
>
>   &regulators {
>
Again, wrong solution, and conceptually wrong as well from a dt perspective.

The alarm signal should be handled by the g762 driver, and the alarm-gpios
property should be added to the g762 description.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
