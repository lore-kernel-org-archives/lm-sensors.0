From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 18 Feb 2014 16:59:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4215) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140218175944.1c7768c1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392686969-26703-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392686969-26703-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 17 Feb 2014 17:29:29 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach sysfs attributes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/ltc4215.c |   51 ++++++++++++-----------------------------------
>  1 file changed, 13 insertions(+), 38 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
