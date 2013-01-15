From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 15 Jan 2013 10:54:02 +0000
Subject: Re: [lm-sensors] [patch] hwmon/max6697: fix memset size in max6697_init_chip()
Message-Id: <20130115105402.GA21765@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130115065308.GA899@elgon.mountain>
In-Reply-To: <20130115065308.GA899-mgFCXtclrQlZLf2FXnZxJA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

On Tue, Jan 15, 2013 at 09:53:08AM +0300, Dan Carpenter wrote:
> sizeof(p) was intended instead of sizeof(data).  data is a pointer and
> p is a 7 character struct.  It probably doesn't make a difference most
> of the time, but it could result in using uninitialized data.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Hi Dan,

Thanks a lot!

Guenter

> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index a1c8c0a..d229cc7 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -474,7 +474,7 @@ static int max6697_init_chip(struct i2c_client *client)
>  		return 0;
>  
>  	if (!pdata || client->dev.of_node) {
> -		memset(&p, 0, sizeof(data));
> +		memset(&p, 0, sizeof(p));
>  		max6697_get_config_of(client->dev.of_node, &p);
>  		pdata = &p;
>  	}
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
