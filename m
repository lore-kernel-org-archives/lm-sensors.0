From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Feb 2011 20:54:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc1403) Fix I2C address range
Message-Id: <20110209215403.39be701f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297284858-27842-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297284858-27842-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Feb 2011 12:54:18 -0800, Guenter Roeck wrote:
> I2C address range included 0x2a, which the chips do not support.
> Replace with 0x29 which is supported but was missing.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
>  drivers/hwmon/emc1403.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index 5dea9fa..cd2a6e4 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -344,7 +344,7 @@ static int emc1403_remove(struct i2c_client *client)
>  }
>  
>  static const unsigned short emc1403_address_list[] = {
> -	0x18, 0x2a, 0x4c, 0x4d, I2C_CLIENT_END
> +	0x18, 0x29, 0x4c, 0x4d, I2C_CLIENT_END
>  };
>  
>  static const struct i2c_device_id emc1403_idtable[] = {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
