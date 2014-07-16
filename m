From: Tobias Klauser <tklauser@distanz.ch>
Date: Wed, 16 Jul 2014 10:29:36 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: pwm-fan: Add pwm-fan driver
Message-Id: <20140716102935.GA24362@distanz.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405505014-24983-1-git-send-email-k.debski@samsung.com>
In-Reply-To: <1405505014-24983-1-git-send-email-k.debski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kamil Debski <k.debski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, t.figa@samsung.com, m.szyprowski@samsung.com, linux@roeck-us.net, linux-pwm@vger.kernel.org, varkabhadram@gmail.com

On 2014-07-16 at 12:03:34 +0200, Kamil Debski <k.debski@samsung.com> wrote:
> The pwm-fan driver enables control of fans connected to PWM lines.
> This driver uses the PWM framework, so it is compatible with all
> PWM devices that provide drivers through the PWM framework.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>

Looks good as for my comments. If you want you can add my

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
