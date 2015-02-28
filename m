From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 28 Feb 2015 15:46:33 +0000
Subject: Re: [lm-sensors] [PATCH v2] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
Message-Id: <54F1E2D9.8060004@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424887219-26652-1-git-send-email-simon.guinot@sequanux.org>
In-Reply-To: <1424887219-26652-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/25/2015 10:00 AM, Simon Guinot wrote:
> On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
> wired to the I2C fan controller but to a separe GPIO. This GPIO can be
> controlled by using the gpio-fan driver.
>
> This patch adds the gpio-fan alarm description in the net2big_v2 DTS.
>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
