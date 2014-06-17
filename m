From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Jun 2014 10:48:06 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for TI TMP103 temperature sensor
Message-Id: <53A01CE6.4010608@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402992713-22711-1-git-send-email-hs@denx.de>
In-Reply-To: <1402992713-22711-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Schocher <hs@denx.de>, lm-sensors@lm-sensors.org
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

On 06/17/2014 01:11 AM, Heiko Schocher wrote:
> Driver for the TI TMP103.
>
> The TI TMP103 is similar to the TMP102.  It differs from the TMP102
> by having only 8 bit registers.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
>
[ ... ]
> +#define TMP103_CONF_SD		(TMP103_CONF_M0 | TMP103_CONF_M1)

Hello Heiko,

I thought this needs to be TMP103_CONF_M1, but from the datasheet it looks
like it does not matter if M0 is set if M1 is set as well. Did you test it,
though, to make sure that it works ? I feel slightly uncomfortable with it.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
