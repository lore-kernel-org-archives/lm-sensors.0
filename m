From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 15 Aug 2012 13:44:16 +0000
Subject: Re: [lm-sensors] [patch] hwmon: ADT7410: handle errors from adt7410_update_device()
Message-Id: <20120815134416.GA32584@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120815074943.GA16112@elgon.mountain>
In-Reply-To: <20120815074943.GA16112@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Wed, Aug 15, 2012 at 10:49:43AM +0300, Dan Carpenter wrote:
> Smatch complains that adt7410_update_device() can return error pointers.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Only needed in linux-next.
> 
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index f8606df..030c8d7 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -236,9 +236,14 @@ static ssize_t adt7410_show_t_hyst(struct device *dev,
>  				   char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct adt7410_data *data = adt7410_update_device(dev);
> +	struct adt7410_data *data;
>  	int nr = attr->index;
> -	int hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
> +	int hyst;
> +
> +	data = adt7410_update_device(dev);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +	hyst = (data->hyst & ADT7410_T_HYST_MASK) * 1000;
>  
Hi Dan,

That should teach me to run smatch on new code :).

Applied, thanks a lot!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
