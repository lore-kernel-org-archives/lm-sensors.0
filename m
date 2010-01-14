From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jan 2010 11:49:48 +0000
Subject: Re: [lm-sensors] [patch] hwmon/amc6821: double unlock bug
Message-Id: <20100114124948.79c9d4d3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100114103020.GA4939@bicker>
In-Reply-To: <20100114103020.GA4939@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <error27@gmail.com>
Cc: Tomaz Mertelj <tomaz.mertelj@guest.arnes.si>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 14 Jan 2010 13:30:20 +0300, Dan Carpenter wrote:
> The mutex gets unlocked after we goto EXIT.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> --- orig/drivers/hwmon/amc6821.c	2010-01-14 13:22:23.000000000 +0300
> +++ devel/drivers/hwmon/amc6821.c	2010-01-14 13:22:30.000000000 +0300
> @@ -686,7 +686,6 @@ static ssize_t set_fan1_div(
>  		data->fan1_div = 4;
>  		break;
>  	default:
> -		mutex_unlock(&data->update_lock);
>  		count = -EINVAL;
>  		goto EXIT;
>  	}

Good catch. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
