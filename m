From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Nov 2007 18:37:45 +0000
Subject: Re: [lm-sensors] [PATCH 15/59] drivers/hwmon: Add missing "space"
Message-Id: <20071121193745.00f31f21@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1195523331-15303-1-git-send-email-joe@perches.com>
	<1195523331-15303-2-git-send-email-joe@perches.com>
	<1195523331-15303-3-git-send-email-joe@perches.com>
	<1195523331-15303-4-git-send-email-joe@perches.com>
	<1195523331-15303-5-git-send-email-joe@perches.com>
	<1195523331-15303-6-git-send-email-joe@perches.com>
	<1195523331-15303-7-git-send-email-joe@perches.com>
	<1195523331-15303-8-git-send-email-joe@perches.com>
	<1195523331-15303-9-git-send-email-joe@perches.com>
	<1195523331-15303-10-git-send-email-joe@perches.com>
	<1195523331-15303-11-git-send-email-joe@perches.com>
	<1195523331-15303-12-git-send-email-joe@perches.com>
	<1195523331-15303-13-git-send-email-joe@perches.com>
	<1195523331-15303-14-git-send-email-joe@perches.com>
	<1195523331-15303-15-git-send-email-joe@perches.com>
	<1195523331-15303-16-git-send-email-joe@perches.com>
In-Reply-To: <1195523331-15303-16-git-send-email-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org

Hi Joe,

On Mon, 19 Nov 2007 17:48:07 -0800, Joe Perches wrote:
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/hwmon/vt8231.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
> index 2196a84..f876617 100644
> --- a/drivers/hwmon/vt8231.c
> +++ b/drivers/hwmon/vt8231.c
> @@ -504,7 +504,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
>  	case 4: data->fan_div[nr] = 2; break;
>  	case 8: data->fan_div[nr] = 3; break;
>  	default:
> -		dev_err(dev, "fan_div value %ld not supported."
> +		dev_err(dev, "fan_div value %ld not supported. "
>  		        "Choose one of 1, 2, 4 or 8!\n", val);
>  		mutex_unlock(&data->update_lock);
>  		return -EINVAL;

Obviously correct, thanks.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
