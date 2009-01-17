From: Roel Kluin <roel.kluin@gmail.com>
Date: Sat, 17 Jan 2009 14:02:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/?] &&/|| confusion
Message-Id: <4971E4F2.5000408@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4971E2CB.6080307@gmail.com>
In-Reply-To: <4971E2CB.6080307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I wrote:
> diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
> index 034b2c5..4a1c9fb 100644
> --- a/drivers/hwmon/ltc4245.c
> +++ b/drivers/hwmon/ltc4245.c
> @@ -456,7 +456,7 @@ static int ltc4245_check_control_reg(struct i2c_client *client, u8 reg, u8 bits)
>  		voff1 &= bits;
>  		voff2 &= bits;
>  
> -		if (v != voff1 || v != voff2)
> +		if (v != voff1 && v != voff2)
>  			return -ENODEV;
>  	}


On second hand I am not so certain this is wrong. If so, sorry for the noise.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
