From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 16:11:36 +0000
Subject: Re: [lm-sensors] [PATCH 67/95] hwmon: (pc87427) Convert to use devm_ functions
Message-Id: <20120616181136.3a26e9ec@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-68-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-68-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 15 Jun 2012 08:23:48 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/pc87427.c |   41 +++++++----------------------------------
>  1 file changed, 7 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
> index 37059a3..75f67a8 100644
> --- a/drivers/hwmon/pc87427.c
> +++ b/drivers/hwmon/pc87427.c
> (...)
> @@ -980,7 +969,8 @@ static int __devinit pc87427_request_regions(struct platform_device *pdev,
>  			dev_err(&pdev->dev, "Missing resource #%d\n", i);
>  			break;
>  		}
> -		if (!request_region(res->start, resource_size(res), DRVNAME)) {
> +		if (!devm_request_region(&pdev->dev, res->start,
> +					 resource_size(res), DRVNAME)) {
>  			err = -EBUSY;
>  			dev_err(&pdev->dev,
>  				"Failed to request region 0x%lx-0x%lx\n",
> @@ -989,10 +979,6 @@ static int __devinit pc87427_request_regions(struct platform_device *pdev,
>  			break;
>  		}
>  	}
> -
> -	if (err && i)
> -		pc87427_release_regions(pdev, i);
> -
>  	return err;
>  }

Looks to me like you could simplify function pc87427_request_regions()
further, by replacing breaks with returns?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
