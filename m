From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 11 Jul 2014 04:22:36 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (sht21) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53BF668C.1020404@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/10/2014 07:44 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Tested, and applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
