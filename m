From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Nov 2014 16:19:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pwm-fan) Fix suspend/resume behavior
Message-Id: <20141103161924.GA26935@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1415025775-24237-1-git-send-email-k.debski@samsung.com>
In-Reply-To: <1415025775-24237-1-git-send-email-k.debski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kamil Debski <k.debski@samsung.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, Nov 03, 2014 at 03:42:55PM +0100, Kamil Debski wrote:
> The state of a PWM output is not clearly defined after resume. Some PWM
> drivers do not restore the duty cycle upon resume, thus it is necessary to
> manually restore the correct value.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
