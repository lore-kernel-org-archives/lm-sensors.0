From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 28 Feb 2015 15:45:59 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <54F1E2B7.70807@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424887099-26551-1-git-send-email-simon.guinot@sequanux.org>
In-Reply-To: <1424887099-26551-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/25/2015 09:58 AM, Simon Guinot wrote:
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

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
