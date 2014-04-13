From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 13 Apr 2014 09:45:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp421) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140413114503.23cc1c67@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397277596-27648-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397277596-27648-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 Apr 2014 21:39:56 -0700, Guenter Roeck wrote:
> Use devm_hwmon_device_register_with_groups API to attach attributes
> to hwmon device, simplify code, and reduce code size.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp421.c |   47 +++++++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 32 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
