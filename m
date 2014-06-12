From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 12 Jun 2014 15:12:33 +0000
Subject: Re: [lm-sensors] [PATCH v2 RESENT] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <5399C361.5020700@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402582473-12447-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1402582473-12447-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/12/2014 07:14 AM, Pawel Moll wrote:
> Use devm_hwmon_device_register_with_groups instead of
> the old-style manual attributes and hwmon device registration.
>
> Also, unroll the attribute group macros for better code
> readability.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---

Applied. Looks like I'll send a second pull request to Linus after all.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
