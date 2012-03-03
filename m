From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Mar 2012 09:27:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max34440) Add support for 'lowest' output voltage attribute
Message-Id: <20120303102757.11a63315@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 28 Feb 2012 17:18:25 -0800, Guenter Roeck wrote:
> MAX34440 and compatibles support reporting the lowest measured output voltage.
> Add support for it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/pmbus/max34440.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
> index 7d830c1..95ee9e1 100644
> --- a/drivers/hwmon/pmbus/max34440.c
> +++ b/drivers/hwmon/pmbus/max34440.c
> @@ -30,6 +30,7 @@ enum chips { max34440, max34441 };
>  #define MAX34440_MFR_VOUT_PEAK		0xd4
>  #define MAX34440_MFR_IOUT_PEAK		0xd5
>  #define MAX34440_MFR_TEMPERATURE_PEAK	0xd6
> +#define MAX34440_MFR_VOUT_MIN		0xd7
>  
>  #define MAX34440_STATUS_OC_WARN		(1 << 0)
>  #define MAX34440_STATUS_OC_FAULT	(1 << 1)
> @@ -41,6 +42,10 @@ static int max34440_read_word_data(struct i2c_client *client, int page, int reg)
>  	int ret;
>  
>  	switch (reg) {
> +	case PMBUS_VIRT_READ_VOUT_MIN:
> +		ret = pmbus_read_word_data(client, page,
> +					   MAX34440_MFR_VOUT_MIN);
> +		break;
>  	case PMBUS_VIRT_READ_VOUT_MAX:
>  		ret = pmbus_read_word_data(client, page,
>  					   MAX34440_MFR_VOUT_PEAK);
> @@ -73,6 +78,10 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
>  	switch (reg) {
>  	case PMBUS_VIRT_RESET_VOUT_HISTORY:
>  		ret = pmbus_write_word_data(client, page,
> +					    MAX34440_MFR_VOUT_MIN, 0x7fff);
> +		if (ret)
> +			break;
> +		ret = pmbus_write_word_data(client, page,
>  					    MAX34440_MFR_VOUT_PEAK, 0);
>  		break;
>  	case PMBUS_VIRT_RESET_IOUT_HISTORY:

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
