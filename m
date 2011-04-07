From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Apr 2011 16:48:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Fix update interval
Message-Id: <20110407184839.6cae440f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302192955-27311-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1302192955-27311-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Apr 2011 09:15:55 -0700, Guenter Roeck wrote:
> The lm90 driver's attribute update interval is configurable.
> Reflect this information in the driver documentation.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/lm90 |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
> index ed58f17..a94d593 100644
> --- a/Documentation/hwmon/lm90
> +++ b/Documentation/hwmon/lm90
> @@ -205,9 +205,9 @@ are exported, one for each channel, but these values are of course linked.
>  Only the local hysteresis can be set from user-space, and the same delta
>  applies to the remote hysteresis.
>  
> -The lm90 driver will not update its values more frequently than every
> -other second; reading them more often will do no harm, but will return
> -'old' values.
> +The lm90 driver will not update its values more frequently than configured with
> +the update_interval attribute; reading them more often will do no harm, but will
> +return 'old' values.
>  
>  SMBus Alert Support
>  -------------------

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
