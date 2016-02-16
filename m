From: Stefan Agner <stefan@agner.ch>
Date: Tue, 16 Feb 2016 17:50:08 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/3] ARM: dts: vfxxx: Add iio_hwmon node for ADC temperature channel
Message-Id: <06aa0e2a7958c81fb6d3ab9c23164156@agner.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1455597464.git.maitysanchayan@gmail.com>
 <88b677c3ab62d965b70846618fe566523f95c9bb.1455597464.git.maitysanchayan@gmail.com>
In-Reply-To: <88b677c3ab62d965b70846618fe566523f95c9bb.1455597464.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux@roeck-us.net, shawnguo@kernel.org, jdelvare@suse.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 2016-02-15 21:00, Sanchayan Maity wrote:
> Add iio-hwmon node to expose the temperature channel on Vybrid as
> hardware monitor device using the iio_hwmon driver.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>

Acked-by: Stefan Agner <stefan@agner.ch>

> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index a5f07e3..24ac5b1 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -673,5 +673,10 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		iio-hwmon {
> +			compatible = "iio-hwmon";
> +			io-channels = <&adc0 16>, <&adc1 16>;
> +		};
>  	};
>  };

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
