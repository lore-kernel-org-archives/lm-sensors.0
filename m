From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Feb 2015 14:06:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <54EB33D4.1000804@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
In-Reply-To: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/23/2015 04:58 AM, Simon Guinot wrote:
> On some boards, such as the LaCie 2Big Network v2 or 2Big NAS (based on
> Marvell Kirkwood SoCs), an I2C fan controller is used but the alarm
> signal is wired to a separate GPIO. Unfortunately, the gpio-fan driver
> can't be used to handle GPIO alarm alone from DT: an error is returned
> if the "gpios" DT property is missing.
>
> This patch allows to use the gpio-fan driver even if the "alarm-gpios"
> DT property is defined alone.
>

That is the wrong solution. The gpio alarm signal should be handled
by the fan controller driver.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
