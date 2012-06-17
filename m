From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 11:55:15 +0000
Subject: Re: [lm-sensors] [PATCH 82/95] hwmon: (w83627hf) Convert to use devm_ functions
Message-Id: <20120617135515.2650138d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-83-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-83-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:24:03 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/w83627hf.c |   46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> index 5ce54a2..2cb403c 100644
> --- a/drivers/hwmon/w83627hf.c
> +++ b/drivers/hwmon/w83627hf.c
> (...)
> -      ERROR4:
> +error:

One space before label please.

Other than this:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
