From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Nov 2010 02:23:48 +0000
Subject: Re: [lm-sensors] [PATCH 3/8] hwmon: applesmc: Dynamic creation of
Message-Id: <20101105022348.GA28308@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
 <1288511434-5662-4-git-send-email-rydberg@euromail.se>
In-Reply-To: <1288511434-5662-4-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sun, Oct 31, 2010 at 03:50:29AM -0400, Henrik Rydberg wrote:
> The current driver creates temperature files based on a list
> of temperature keys given per device. Apart from slow adaption
> to new machine models, the number of sensors also depends on
> the number of processors. This patch looks up the temperature
> keys dynamically, thereby supporting all models.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Hi Henrik,

Nice cleanup. Just a coule of minor comments.

> ---
>  drivers/hwmon/applesmc.c |  498 +++++++++++-----------------------------------
>  1 files changed, 113 insertions(+), 385 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 7f030f0..0207618 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
[ ...]
> 
> -       pr_info("key=%d\n", s->key_count);
> +       pr_info("key=%d temp=%d\n", s->key_count, s->temp_count);

Is this useful or just noisy ? How about pr_debug instead ?

> 
>         return 0;
>  }

[ ... ] 

> @@ -1429,13 +1122,66 @@ static int applesmc_dmi_match(const struct dmi_system_id *id)
>         pr_info(" - Model %s light sensors and backlight\n",
>                 applesmc_light ? "with" : "without");
> 
> -       applesmc_temperature_set =  dmi_data->temperature_set;
> -       while (temperature_sensors_sets[applesmc_temperature_set][i] != NULL)
> -               i++;
> -       pr_info(" - Model with %d temperature sensors\n", i);
> +

This results in another double empty line.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
