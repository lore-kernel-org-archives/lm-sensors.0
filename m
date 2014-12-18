From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Dec 2014 14:27:56 +0000
Subject: Re: [lm-sensors] [PATCH 2/9] hwmon: dts: Doc: Add DTS doc to explain how to use PWM FAN as a cooling
Message-Id: <5492E46C.3080100@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com> <1418897591-18332-3-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1418897591-18332-3-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>

On 12/18/2014 02:13 AM, Lukasz Majewski wrote:
> Several new properties to allow PWM fan working as a cooling device have been
> combined into this single commit.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>   .../devicetree/bindings/hwmon/pwm-fan.txt          | 28 ++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> index 610757c..3877810 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -3,10 +3,38 @@ Bindings for a fan connected to the PWM lines
>   Required properties:
>   - compatible	: "pwm-fan"
>   - pwms		: the PWM that is used to control the PWM fan
> +- cooling-pwm-values      : PWM duty cycle values relative to
> +			    cooling-max-pwm-value correspondig to
> +			    proper cooling states

I don't understand what you mean with "relative to". Please elaborate.
Do you mean "associated with" ?

Where is "cooling-max-pwm-value" defined, and how is this all expected
to relate to the maximum duty cycle value provided by the pwm device ?

> +- default-pulse-width     : Property specifying default pulse width for FAN
> +			    at system boot (zero to disable FAN on boot).
> +			    Allowed range is 0 to 255

You'll need dt maintainer approval for the new properties.

One thing I wonder about though is why you use "default-pulse-width"
and not "default-pwm". Seems to be arbitrary. I don't see "pulse-width"
used anywhere in the upstream kernel.

I am somewhat concerned that you define the new properties as mandatory.
That means existing configurations will fail, which does not seem to be
a good idea. It would be more appropriate to not configure the thermal device
if the new properties are not provided.

The newly introduced semantics also conflicts with the current semantics,
which sets the initial duty cycle initially to the maximum allowed duty cycle
as reported by the pwm device itself.

Guenter

> +
> +Thorough description of the following bindings:
> +		cooling-min-state = <0>;
> +		cooling-max-state = <3>;
> +		#cooling-cells = <2>;
> +		thermal-zone {
> +			cpu_thermal: cpu-thermal {
> +			cooling-maps {
> +				map0 {
> +				     trip = <&cpu_alert1>;
> +				     cooling-device = <&fan0 0 1>;
> +				};
> +			};
> +		};
> +
> +for PWM FAN used as cooling device can be found at:
> +./Documentation/devicetree/bindings/thermal/thermal.txt
>
>   Example:
>   	pwm-fan {
>   		compatible = "pwm-fan";
>   		status = "okay";
>   		pwms = <&pwm 0 10000 0>;
> +		cooling-min-state = <0>;
> +		cooling-max-state = <3>;
> +		#cooling-cells = <2>;
> +		cooling-pwm-values = <0 102 170 255>;
> +		default-pulse-width = <0>;
>   	};
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
