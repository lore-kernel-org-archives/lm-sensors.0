From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jul 2011 14:50:59 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm95241) Fix chip detection
Message-Id: <20110707165059.6784cea6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310047864-22691-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310047864-22691-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Jul 2011 07:11:02 -0700, Guenter Roeck wrote:
> The LM95241 driver accepts every chip ID equal to or larger than 0xA4 as its
> own, and other chips such as LM95245 use chip IDs in the accepted ID range.
> This results in false chip detection.
> 
> Fix problem by accepting only the known LM95241 chip ID.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
> Candidate for -stable.

Definitely.

> 
>  drivers/hwmon/lm95241.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> index 1a6dfb6..01c638e 100644
> --- a/drivers/hwmon/lm95241.c
> +++ b/drivers/hwmon/lm95241.c
> @@ -339,7 +339,7 @@ static int lm95241_detect(struct i2c_client *new_client,
>  	if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
>  	     = MANUFACTURER_ID)
>  	    && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
> -		>= DEFAULT_REVISION)) {
> +		= DEFAULT_REVISION)) {
>  		name = DEVNAME;
>  	} else {
>  		dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
