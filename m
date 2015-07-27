From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Jul 2015 22:17:11 +0000
Subject: Re: [lm-sensors] [PATCH v5] hwmon: (nct7802) Add auto_point attributes
Message-Id: <55B6ADE7.3080003@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438034468-809-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1438034468-809-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/27/2015 03:01 PM, Constantine Shulyupin wrote:
> Introduced REG_PWM, pwm[1..3]_auto_point[1..5]_temp,
> pwm[1..3]_auto_point[1..5]_pwm, nct7802_auto_point_attrs,
> nct7802_auto_point_group, updated nct7802_regmap_is_volatile
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>

Applied to -next.

Note that the patch requires http://www.spinics.net/lists/kernel/msg2041703.html
to work reliably.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
