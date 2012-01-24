From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jan 2012 08:14:15 +0000
Subject: Re: [lm-sensors] [PATCH 78/79] hwmon: (it87) Constify fixed string arrays
Message-Id: <20120124091415.6da95dd3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-79-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-79-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jan 2012 18:49:57 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Make checkpatch happy by constifying fixed string arrays.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 93a197b..0b204e4 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -1341,12 +1341,12 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
>  static ssize_t show_label(struct device *dev, struct device_attribute *attr,
>  		char *buf)
>  {
> -	static const char *labels[] = {
> +	static const char * const labels[] = {
>  		"+5V",
>  		"5VSB",
>  		"Vbat",
>  	};
> -	static const char *labels_it8721[] = {
> +	static const char * const labels_it8721[] = {
>  		"+3.3V",
>  		"3VSB",
>  		"Vbat",
> @@ -1815,7 +1815,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  	int err = 0, i;
>  	int enable_pwm_interface;
>  	int fan_beep_need_rw;
> -	static const char *names[] = {
> +	static const char * const names[] = {
>  		"it87",
>  		"it8712",
>  		"it8716",

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
