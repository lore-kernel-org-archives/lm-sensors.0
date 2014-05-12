From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 13:08:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc1403) Fix resource leak on module unload
Message-Id: <5370C7BE.4030300@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140512114451.3cb890c6@endymion.delvare>
In-Reply-To: <20140512114451.3cb890c6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/12/2014 02:44 AM, Jean Delvare wrote:
> Commit 454aee17f claims to convert driver emc1403 to use
> devm_hwmon_device_register_with_groups, however the patch itself makes
> use of hwmon_device_register_with_groups instead. As the driver remove
> function was still dropped, the hwmon device is no longer unregistered
> on driver removal, leading to a resource leak.
>
Oops ....

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 454aee17f hwmon: (emc1403) Convert to use devm_hwmon_device_register_with_groups
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: stable@vger.kernel.org [3.13+]

Thanks, I'll apply and send to Linus.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
