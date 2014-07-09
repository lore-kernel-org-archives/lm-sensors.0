From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jul 2014 03:31:11 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ds620) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53BCB77F.3020604@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404871191.7760.1.camel@phoenix>
In-Reply-To: <1404871191.7760.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/08/2014 06:59 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

This one is better :-)

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
