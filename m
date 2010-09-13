From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Sep 2010 16:17:18 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/7] hwmon: Add tempX_emergency_alarm
Message-Id: <20100913181718.56ba6054@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
	<1284038750-8833-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284038750-8833-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 9 Sep 2010 06:25:44 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/sysfs-interface |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index 101300b..22843cb 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -513,6 +513,7 @@ fan[1-*]_max_alarm
>  temp[1-*]_min_alarm
>  temp[1-*]_max_alarm
>  temp[1-*]_crit_alarm
> +temp[1-*]_emergency_alarm
>  		Limit alarm
>  		0: no alarm
>  		1: alarm

Looks good, I'll merge this into the following patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-add-tempx_emergency-attribute-to-sysfs-abi.patch

as they make more sense together than separated.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
