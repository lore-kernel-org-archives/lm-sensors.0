From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Oct 2010 13:54:34 +0000
Subject: Re: [lm-sensors] [PATCH] adt7411: set reserved bit
Message-Id: <20101021155434.1642eb6c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101021134441.GA10439@arv-002>
In-Reply-To: <20101021134441.GA10439@arv-002>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Oct 2010 15:44:41 +0200, Rini wrote:
> This patch set the reserved bit in cfg1 register.
> This bit should be 1 at startup but it's not.

And what is the problem with this? And what's your hardware?

> 
> Signed-off-by: Rini <rini@arvoo.nl>

We need a full name for kernel contributions, sorry.

> ---
>  drivers/hwmon/adt7411.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> index f13c843..c516876 100644
> --- a/drivers/hwmon/adt7411.c
> +++ b/drivers/hwmon/adt7411.c
> @@ -31,6 +31,7 @@
>  
>  #define ADT7411_REG_CFG1			0x18
>  #define ADT7411_CFG1_START_MONITOR		(1 << 0)
> +#define ADT7411_CFG1_RESERVED			(1 << 3)
>  
>  #define ADT7411_REG_CFG2			0x19
>  #define ADT7411_CFG2_DISABLE_AVG		(1 << 5)
> @@ -291,6 +292,15 @@ static int __devinit adt7411_probe(struct i2c_client *client,
>  	mutex_init(&data->device_lock);
>  	mutex_init(&data->update_lock);
>  
> +	/*
> +	 * reserved bit should be 1, despite document say it's 1 at powerup
> +	 * it's not. Gives bad values at input3 when 0
> +	 */
> +	ret = adt7411_modify_bit(client, ADT7411_REG_CFG1,
> +				ADT7411_CFG1_RESERVED, 1);
> +	if (ret < 0)
> +		goto exit_free;
> +
>  	ret = adt7411_modify_bit(client, ADT7411_REG_CFG1,
>  				 ADT7411_CFG1_START_MONITOR, 1);
>  	if (ret < 0)

This is inefficient: you read and write the same register twice in a
row. It would be much better to read it once, modify all bits and write
it once.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
