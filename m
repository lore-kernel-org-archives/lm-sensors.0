From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Apr 2007 05:43:42 +0000
Subject: Re: [lm-sensors] possible error in ams-i2c.c
Message-Id: <20070402074342.feb78af0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 30 Mar 2007 21:41:37 +0200, Stelian Pop wrote:
> Fix sleep and retry logic in ams-i2c.
> 
> Signed-off-by: Stelian Pop <stelian@popies.net>
> ---
>  drivers/hwmon/ams/ams-i2c.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ams/ams-i2c.c b/drivers/hwmon/ams/ams-i2c.c
> index 0d24bdf..6f5b423 100644
> --- a/drivers/hwmon/ams/ams-i2c.c
> +++ b/drivers/hwmon/ams/ams-i2c.c
> @@ -85,17 +85,17 @@ static int ams_i2c_write(u8 reg, u8 value)
>  static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
>  {
>  	s32 result;
> -	int remaining = HZ / 20;
> +	int count = 3;
>  
>  	ams_i2c_write(AMS_COMMAND, cmd);
> -	mdelay(5);
> +	msleep(5);
>  
> -	while (remaining) {
> +	while (count--) {
>  		result = ams_i2c_read(AMS_COMMAND);
>  		if (result = 0 || result & 0x80)
>  			return 0;
>  
> -		remaining = schedule_timeout(remaining);
> +		schedule_timeout_uninterruptible(HZ / 20);
>  	}
>  
>  	return -1;

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
