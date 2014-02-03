From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Feb 2014 09:11:13 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm80) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140203101113.206f4bfb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391390207-19144-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391390207-19144-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  2 Feb 2014 17:16:47 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach hwmon attributes to
> hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use PTR_ERR_OR_ZERO
>     Associate driver messages with hwmon device
> 
>  drivers/hwmon/lm80.c |   70 ++++++++++++++++----------------------------------
>  1 file changed, 22 insertions(+), 48 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
