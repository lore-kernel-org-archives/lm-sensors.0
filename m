From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Jul 2014 04:07:38 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (g762) Convert to hwmon_device_register_with_groups
Message-Id: <53CB408A.5090601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405780184.15902.3.camel@phoenix>
In-Reply-To: <1405780184.15902.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/19/2014 07:29 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and hwmon_device_register_with_groups() to simplify
> the code a bit.
>
> Use hwmon_device_register_with_groups rather than the device managed version to
> ensure g762_of_clock_disable() is called after hwmon_device_unregister().
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
