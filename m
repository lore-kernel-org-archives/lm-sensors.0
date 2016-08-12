From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Aug 2016 18:26:21 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon/max6650.c: Add devicetree support
Message-Id: <20160812182621.GA30513@rob-hp-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1470727827-15907-1-git-send-email-mike.looijmans@topic.nl>
 <20160809163727.GC9105@roeck-us.net>
 <1470838787-8273-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1470838787-8273-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: lm-sensors@lm-sensors.org, devicetree@vger.kernel.org, linux@roeck-us.net, linux-kernel@vger.kernel.org

On Wed, Aug 10, 2016 at 04:19:47PM +0200, Mike Looijmans wrote:
> Parse devicetree parameters for voltage and prescaler setting. This allows
> using multiple max6550 devices with varying settings, and also makes it
> possible to instantiate and configure the device using devicetree.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v3: Resubmit because mailing lists bounced
>     Fix style errors as reported by checkpatch.pl
>     Fix bug in DT parsing of fan-prescale
> v2: Add devicetree binding documentation
>     Code changes as suggested by Guenter
>     Reduce log info, output only a single line
> 
>  .../devicetree/bindings/hwmon/max6650.txt          | 20 ++++++++++++++++
>  drivers/hwmon/max6650.c                            | 28 +++++++++++++---------
>  2 files changed, 37 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/max6650.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/max6650.txt b/Documentation/devicetree/bindings/hwmon/max6650.txt
> new file mode 100644
> index 0000000..89d87c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/max6650.txt
> @@ -0,0 +1,20 @@
> +Bindings for MAX6651 and MAX6650 I2C fan controllers
> +
> +Required properties:
> +- compatible : One of "max6650" or "max6651"

Needs a vendor prefix.

> +- reg        : I2C address
> +
> +Optional properties:
> +- fan-voltage    : The supply voltage of the fan. Valid values are 5 and 12.

This is in volts? Please use microvolt and the standard unit suffix as 
found in property-units.txt.

> +                   Default is to use the chip's current setting.
> +- fan-prescale   : Pre-scaling value as per datasheet. Valid are 1, 2, 4, 8, 16.
> +                   Default is to use the chip's current setting.

Add a vendor prefix here.

> + 
> +
> +Example:
> +	fan-max6650: max6650@1b {
> +		reg = <0x1b>;
> +		compatible = "max6650";
> +		fan-voltage = <12>;
> +		fan-prescale = <4>;
> +	};

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
