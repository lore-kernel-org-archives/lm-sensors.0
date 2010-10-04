From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 04 Oct 2010 11:41:34 +0000
Subject: Re: [lm-sensors] [RFC PATCH 8/9] hwmon: lis3: use block read to
Message-Id: <4CA9BD6E.6040002@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com> <1285933616-16044-9-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1285933616-16044-9-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On 10/01/10 12:46, Samu Onkalo wrote:
> Add optional blockread function to interface driver. If available
> the chip driver uses it for data register access. For 12 bit device
> it reads 6 bytes to get 3*16bit data. For 8 bit device it reads out
> 5 bytes since every second byte is dummy.
> This optimizes bus usage and reduces number of operations and
> interrupts needed for one data update.

Do we need to query if the i2c bus supports block reading or are they
all guaranteed to do so?

I'm guessing not seeing as i2c.h has a functionality bit for it...
I2C_FUNC_SMBUS_READ_BLOCK_DATA

Otherwise looks good.  Either justify that all i2c buses will work
or add the functionality check and you can add.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

> 
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> ---
>  drivers/hwmon/lis3lv02d.c     |   21 ++++++++++++++++++---
>  drivers/hwmon/lis3lv02d.h     |    1 +
>  drivers/hwmon/lis3lv02d_i2c.c |    9 +++++++++
>  3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
> index b740024..469f251 100644
> --- a/drivers/hwmon/lis3lv02d.c
> +++ b/drivers/hwmon/lis3lv02d.c
> @@ -129,9 +129,24 @@ static void lis3lv02d_get_xyz(struct lis3lv02d *lis3, int *x, int *y, int *z)
>  	int position[3];
>  	int i;
>  
> -	position[0] = lis3->read_data(lis3, OUTX);
> -	position[1] = lis3->read_data(lis3, OUTY);
> -	position[2] = lis3->read_data(lis3, OUTZ);
> +	if (lis3->blkread) {
> +		if (lis3_dev.whoami = WAI_12B) {
> +			u16 data[3];
> +			lis3->blkread(lis3, OUTX_L, 6, (u8 *)data);
> +			for (i = 0; i < 3; i++)
> +				position[i] = (s16)le16_to_cpu(data[i]);
> +		} else {
> +			u8 data[5];
> +			/* Data: x, dummy, y, dummy, z */
> +			lis3->blkread(lis3, OUTX, 5, data);
> +			for (i = 0; i < 3; i++)
> +				position[i] = (s8)data[i * 2];
> +		}
> +	} else {
> +		position[0] = lis3->read_data(lis3, OUTX);
> +		position[1] = lis3->read_data(lis3, OUTY);
> +		position[2] = lis3->read_data(lis3, OUTZ);
> +	}
>  
>  	for (i = 0; i < 3; i++)
>  		position[i] = (position[i] * lis3->scale) / LIS3_ACCURACY;
> diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
> index 1522855..cfff63c 100644
> --- a/drivers/hwmon/lis3lv02d.h
> +++ b/drivers/hwmon/lis3lv02d.h
> @@ -232,6 +232,7 @@ struct lis3lv02d {
>  	int (*init) (struct lis3lv02d *lis3);
>  	int (*write) (struct lis3lv02d *lis3, int reg, u8 val);
>  	int (*read) (struct lis3lv02d *lis3, int reg, u8 *ret);
> +	int (*blkread) (struct lis3lv02d *lis3, int reg, int len, u8 *ret);
>  	int (*reg_ctrl) (struct lis3lv02d *lis3, bool state);
>  
>  	int                     *odrs;     /* Supported output data rates */
> diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> index c5a60e4..1e0673b 100644
> --- a/drivers/hwmon/lis3lv02d_i2c.c
> +++ b/drivers/hwmon/lis3lv02d_i2c.c
> @@ -66,6 +66,14 @@ static inline s32 lis3_i2c_read(struct lis3lv02d *lis3, int reg, u8 *v)
>  	return 0;
>  }
>  
> +static inline s32 lis3_i2c_blockread(struct lis3lv02d *lis3, int reg, int len,
> +				u8 *v)
> +{
> +	struct i2c_client *c = lis3->bus_priv;
> +	reg |= (1 << 7); /* 7th bit enables address auto incrementation */
> +	return i2c_smbus_read_i2c_block_data(c, reg, len, v);
> +}
> +
>  static int lis3_i2c_init(struct lis3lv02d *lis3)
>  {
>  	u8 reg;
> @@ -125,6 +133,7 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
>  	lis3_dev.bus_priv = client;
>  	lis3_dev.init	  = lis3_i2c_init;
>  	lis3_dev.read	  = lis3_i2c_read;
> +	lis3_dev.blkread  = lis3_i2c_blockread;
>  	lis3_dev.write	  = lis3_i2c_write;
>  	lis3_dev.reg_ctrl = lis3_reg_ctrl;
>  	lis3_dev.irq	  = client->irq;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
