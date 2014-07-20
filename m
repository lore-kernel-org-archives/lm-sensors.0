From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Jul 2014 05:05:19 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (adt7411) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53CB4E0F.2010002@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405780953.15902.6.camel@phoenix>
In-Reply-To: <1405780953.15902.6.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/19/2014 07:42 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
