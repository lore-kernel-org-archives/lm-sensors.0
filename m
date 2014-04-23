From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 08:18:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Convert to use hwmon_device_register_with_groups
Message-Id: <20140423101854.08cd7cf6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398124016-30079-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1398124016-30079-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Apr 2014 16:46:56 -0700, Guenter Roeck wrote:
> Simplify code and attach hwmon attributes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm75.c |   51 ++++++++++++++++++++------------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
