From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Sat, 10 Dec 2011 19:50:21 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (f75375s) Fix value range for
Message-Id: <FF215E78-FB29-4717-AA24-4A1FEE27BA1E@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323369069-26203-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1323369069-26203-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2011/12/8 Guenter Roeck <guenter.roeck@ericsson.com>:
> Accepted value range for PWM modes was 0..4, even though only 0..3 is
> subsequently used. Limit permitted value range to 0..3 to avoid unpredictable
> behavior.
> 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Reviewed-by: Bjoern Gerhart <oss@extracloud.de>
> ---
> drivers/hwmon/f75375s.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 316c29a..777a665 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -309,7 +309,7 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
> 	struct f75375_data *data = i2c_get_clientdata(client);
> 	u8 fanmode;
> 
> -	if (val < 0 || val > 4)
> +	if (val < 0 || val > 3)
> 		return -EINVAL;
> 
> 	fanmode = f75375_read8(client, F75375_REG_FAN_TIMER);
> -- 
> 1.7.3.1
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
