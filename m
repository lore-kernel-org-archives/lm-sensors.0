From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 10:03:19 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (max6650) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140213110319.01dcf98e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392226866-25968-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392226866-25968-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Feb 2014 09:41:04 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach sensor attributes
> to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max6650.c |   77 +++++++++++++++++------------------------------
>  1 file changed, 28 insertions(+), 49 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
