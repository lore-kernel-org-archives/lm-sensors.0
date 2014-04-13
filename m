From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 13 Apr 2014 07:52:48 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (tmp102) Convert to use hwmon_device_register_with_groups
Message-Id: <20140413095248.75155c30@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397277376-27502-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397277376-27502-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 Apr 2014 21:36:16 -0700, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach sysfs attributes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp102.c |   46 ++++++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
