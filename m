From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 16:32:58 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (lm92) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140423183258.061459b6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397861485-31740-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397861485-31740-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Apr 2014 15:51:25 -0700, Guenter Roeck wrote:
> Use devm_hwmon_device_register_with_groups API to attach attributes
> to hwmon device, simplify code, and reduce code size.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm92.c |   56 ++++++++++++++------------------------------------
>  1 file changed, 15 insertions(+), 41 deletions(-)
> (...)

Nice cleanup as usual :)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
