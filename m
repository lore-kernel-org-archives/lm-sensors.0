From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 Mar 2011 14:40:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Make gain and datarate
Message-Id: <20110309144003.GA25609@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299678760-4027-1-git-send-email-eibach@gdsys.de>
In-Reply-To: <1299678760-4027-1-git-send-email-eibach@gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dirk Eibach <eibach@gdsys.de>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>

Hi Dirk,

On Wed, Mar 09, 2011 at 08:52:40AM -0500, Dirk Eibach wrote:
> Signed-off-by: Dirk Eibach <eibach@gdsys.de>
> ---
>  .../devicetree/bindings/hwmon/ads1015.txt          |   73 ++++++++++++++
>  Documentation/devicetree/bindings/i2c/ads1015.txt  |   29 ------
>  Documentation/hwmon/ads1015                        |   48 +++++++---
>  drivers/hwmon/ads1015.c                            |  104 ++++++++++++++++----
>  include/linux/i2c/ads1015.h                        |    8 ++
>  5 files changed, 202 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ads1015.txt
>  delete mode 100644 Documentation/devicetree/bindings/i2c/ads1015.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ads1015.txt b/Documentation/devicetree/bindings/hwmon/ads1015.txt
> new file mode 100644
> index 0000000..fb6e139
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ads1015.txt
> @@ -0,0 +1,73 @@
> +ADS1015 (I2C)
> +
> +This device is a 12-bit A-D converter with 4 inputs.
> +
> +The inputs can be used single ended or in certain differential combinations.
> +
> +For configuration all possible combinations are mapped to 8 channels:
> +  0: Voltage over AIN0 and AIN1.
> +  1: Voltage over AIN0 and AIN3.
> +  2: Voltage over AIN1 and AIN3.
> +  3: Voltage over AIN2 and AIN3.
> +  4: Voltage over AIN0 and GND.
> +  5: Voltage over AIN1 and GND.
> +  6: Voltage over AIN2 and GND.
> +  7: Voltage over AIN3 and GND.
> +
> +Each channel can be configured indvidually:
> + - pga ist the programmable gain amplifier
> +    0: FS = +/- 6.144 V
> +    1: FS = +/- 4.096 V
> +    2: FS = +/- 2.048 V (default)
> +    3: FS = +/- 1.024 V
> +    4: FS = +/- 0.512 V
> +    5: FS = +/- 0.256 V
> + - data_rate in samples per second
> +    0: 128
> +    1: 250
> +    2: 490
> +    3: 920
> +    4: 1600
> +    5: 2400
> +    6: 3300
> +

I thought the data rate only applies for continuous mode, which you don't use.
What does it do in single shot mode ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
