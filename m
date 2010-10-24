From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 24 Oct 2010 14:59:23 +0000
Subject: Re: [lm-sensors] [PATCH 12/12] hwmon: lis3: Release resources is
Message-Id: <4CC449CB.1040005@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com> <1287748654-2626-13-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1287748654-2626-13-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, jic23@cam.ac.uk, lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Op 22-10-10 13:57, Samu Onkalo schreef:
> If lis3lv02d_init_device fails, HW resources were not released
> properly. In case of failure call release_resources if available.
>
> Signed-off-by: Samu Onkalo<samu.p.onkalo@nokia.com>
Acked-by: Eric Piel <eric.piel@tremplin-utc.net>
> ---
>   drivers/hwmon/lis3lv02d_i2c.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> index 61c109b..94d5bde 100644
> --- a/drivers/hwmon/lis3lv02d_i2c.c
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -161,7 +161,12 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
>
>   	if (lis3_dev.reg_ctrl)
>   		lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
> +
> +	if (ret = 0)
> +		return 0;
>   fail:
> +	if (pdata&&  pdata->release_resources)
> +		pdata->release_resources();
>   	return ret;
>   }
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
