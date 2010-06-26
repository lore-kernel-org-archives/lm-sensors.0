From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Jun 2010 06:52:38 +0000
Subject: Re: [lm-sensors] [PATCH/RFC 3/3] hwmon: Update current alarm
Message-Id: <20100626085238.603933d0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1277520011-29782-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1277520011-29782-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 25 Jun 2010 19:40:11 -0700, Guenter Roeck wrote:
> This patch adds currX_alarm, currX_min_alarm, and currX_max_alarm attributes
> to the hwmon sysfs API.
> 
> currX_min_alarm and currX_max_alarm are already supported by the LTC4215 and
> LTC4245 drivers. currX_alarm is supported by the LTC4261 driver.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/sysfs-interface |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index d4e2917..520fa7a 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -471,6 +471,7 @@ limit-related alarms, not both. The driver should just reflect the hardware
>  implementation.
>  
>  in[0-*]_alarm
> +curr[1-*]_alarm
>  fan[1-*]_alarm
>  temp[1-*]_alarm
>  		Channel alarm
> @@ -482,6 +483,8 @@ OR
>  
>  in[0-*]_min_alarm
>  in[0-*]_max_alarm
> +curr[1-*]_min_alarm
> +curr[1-*]_max_alarm
>  fan[1-*]_min_alarm
>  fan[1-*]_max_alarm
>  temp[1-*]_min_alarm

Applied, thanks. I also added curr[1-*]_beep, as libsensors supports it
already. And I've removed the comment that says that current attributes
are not implemented by any driver yet, as this comment was obviously
obsolete.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
