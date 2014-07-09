From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jul 2014 03:33:50 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (ads7871) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53BCB81E.5080906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404304281.15238.3.camel@phoenix>
In-Reply-To: <1404304281.15238.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/02/2014 05:31 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> The update_lock mutex is not used, so remove it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

This patch will need a Tested-by:.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
