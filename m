From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Nov 2009 13:16:29 +0000
Subject: Re: [lm-sensors] [patch 1/1] s3c-hwmon: fix build error
Message-Id: <20091124141629.5af88bf7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091124095009.441485821@fluff.org.uk>
In-Reply-To: <20091124095009.441485821@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 Nov 2009 09:49:02 +0000, Ben Dooks wrote:
> The previous patch, commit be4c23c93c4828d36ac9e1a88410618a61676426 was
> from the wrong tree and thus broke the current build which had the
> channel configuration name changed.
> 
> Fix the following build errors:
> 
> drivers/hwmon/s3c-hwmon.c: In function 's3c_hwmon_probe':
> drivers/hwmon/s3c-hwmon.c:326: warning: initialization from incompatible pointer type
> drivers/hwmon/s3c-hwmon.c:331: error: dereferencing pointer to incomplete type
> drivers/hwmon/s3c-hwmon.c:336: error: dereferencing pointer to incomplete type
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/hwmon/s3c-hwmon.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: b/drivers/hwmon/s3c-hwmon.c
> =================================> --- a/drivers/hwmon/s3c-hwmon.c	2009-11-22 17:44:39.000000000 +0000
> +++ b/drivers/hwmon/s3c-hwmon.c	2009-11-22 17:48:35.000000000 +0000
> @@ -323,7 +323,7 @@ static int __devinit s3c_hwmon_probe(str
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(pdata->in); i++) {
> -		struct s3c24xx_adc_hwmon_incfg *cfg = pdata->in[i];
> +		struct s3c_hwmon_chcfg *cfg = pdata->in[i];
>  
>  		if (!cfg)
>  			continue;
> @@ -333,7 +333,7 @@ static int __devinit s3c_hwmon_probe(str
>  				 "channel %d multiplier too large\n",
>  				 i);
>  
> -		if (cfg->divider = 0) {
> +		if (cfg->div = 0) {
>  			dev_err(&dev->dev, "channel %d divider zero\n", i);
>  			continue;
>  		}
> 

Grmbl. Please pay attention next time :(

I have queued this new patch now, hopefully I will manage to send it in
time to Linus before 2.6.32-final is released.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
