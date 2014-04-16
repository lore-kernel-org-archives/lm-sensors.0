From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 16 Apr 2014 08:30:24 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (lm77) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140416103024.381032ad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397322118-4275-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397322118-4275-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 12 Apr 2014 10:01:58 -0700, Guenter Roeck wrote:
> Use devm_hwmon_device_register_with_groups API to attach attributes
> to hwmon device, simplify code, and reduce code size.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm77.c |   57 ++++++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 41 deletions(-)
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
