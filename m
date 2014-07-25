From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 25 Jul 2014 04:29:34 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pwm-fan) Add proper #ifdef CONFIG_OF guard for of_device_id tab
Message-Id: <53D1DD2E.2090704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406258073.9778.3.camel@phoenix>
In-Reply-To: <1406258073.9778.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/24/2014 08:14 PM, Axel Lin wrote:
> Use of_match_ptr and proper #ifdef CONFIG_OF guard for of_device_id table.
> Also makes of_pwm_fan_match const.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

The driver won't instantiate if OF is not configured.
Given that, I'd rather keep the code as is, because it does compile
without CONFIG_OF, so the ifdef is not really technically necessary.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
