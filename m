From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 18 Feb 2014 21:52:15 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (max1668) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140218225215.1d1b85a0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392516481-16548-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392516481-16548-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 15 Feb 2014 18:08:01 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach hwmon attributes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max1668.c |   67 +++++++++++++----------------------------------
>  1 file changed, 18 insertions(+), 49 deletions(-)
> (...)

Looks good to me.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
