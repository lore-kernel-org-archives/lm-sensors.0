From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Apr 2011 20:35:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (smm665) Fix spelling error in
Message-Id: <20110418223544.591b20d0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Apr 2011 13:42:23 -0700, Guenter Roeck wrote:
> tempererature may sound interesting, but temperature is still preferred.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/smm665 |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/smm665 b/Documentation/hwmon/smm665
> index 3820fc9..59e3161 100644
> --- a/Documentation/hwmon/smm665
> +++ b/Documentation/hwmon/smm665
> @@ -150,8 +150,8 @@ in8_crit_alarm		Channel F critical alarm
>  in9_crit_alarm		AIN1 critical alarm
>  in10_crit_alarm		AIN2 critical alarm
>  
> -temp1_input		Chip tempererature
> -temp1_min		Mimimum chip tempererature
> -temp1_max		Maximum chip tempererature
> -temp1_crit		Critical chip tempererature
> +temp1_input		Chip temperature
> +temp1_min		Mimimum chip temperature
> +temp1_max		Maximum chip temperature
> +temp1_crit		Critical chip temperature
>  temp1_crit_alarm	Temperature critical alarm

Nice :D

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
