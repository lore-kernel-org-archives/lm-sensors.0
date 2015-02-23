From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 23 Feb 2015 13:42:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <20150223134247.GC23581@lunn.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
In-Reply-To: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Feb 23, 2015 at 01:58:54PM +0100, Simon Guinot wrote:
> On some boards, such as the LaCie 2Big Network v2 or 2Big NAS (based on
> Marvell Kirkwood SoCs), an I2C fan controller is used but the alarm
> signal is wired to a separate GPIO. Unfortunately, the gpio-fan driver
> can't be used to handle GPIO alarm alone from DT: an error is returned
> if the "gpios" DT property is missing.
> 
> This patch allows to use the gpio-fan driver even if the "alarm-gpios"
> DT property is defined alone.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  .../devicetree/bindings/gpio/gpio-fan.txt          |  6 ++-
>  drivers/hwmon/gpio-fan.c                           | 44 +++++++++++-----------
>  2 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-fan.txt b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
> index 2dd457a3469a..a4c5d15b72e6 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-fan.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
> @@ -2,16 +2,18 @@ Bindings for fan connected to GPIO lines
>  
>  Required properties:
>  - compatible : "gpio-fan"
> +
> +Optional properties:
>  - gpios: Specifies the pins that map to bits in the control value,
>    ordered MSB-->LSB.
>  - gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
>    control value that should be set to achieve them. This array
>    must have the RPM values in ascending order.
> -
> -Optional properties:
>  - alarm-gpios: This pin going active indicates something is wrong with
>    the fan, and a udev event will be fired.
>  
> +Note: At least one the "gpios" and "alarm-gpios" properties should be set.

I think you have this sentence wrong. What i think you mean is

Note: At least one of "gpios" or "alarm-gpios" properties should be set.

      Andrew

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
