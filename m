From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jul 2015 16:38:50 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: ads7828: Add devicetree documentation
Message-Id: <55AFC71A.1040701@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437582620-2294-1-git-send-email-denis@eukrea.com> <1437582620-2294-3-git-send-email-denis@eukrea.com>
In-Reply-To: <1437582620-2294-3-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?windows-1252?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On 07/22/2015 09:30 AM, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

You should probably send this patch to the i2c mailing list.

Guenter

> ---
>   Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 00f8652..d77d412 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -95,6 +95,8 @@ stm,m41t00		Serial Access TIMEKEEPER
>   stm,m41t62		Serial real-time clock (RTC) with alarm
>   stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
>   taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> +ti,ads7828		8-Channels, 12-bit ADC
> +ti,ads7830		8-Channels, 8-bit ADC
>   ti,tsc2003		I2C Touch-Screen Controller
>   ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>   ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
