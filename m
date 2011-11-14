From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Nov 2011 08:01:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Fix two issues
Message-Id: <20111114090133.0c063dd2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tang,

On Mon, 14 Nov 2011 13:41:06 +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <B29983@freescale.com>
> 
> 1. Not all platforms support i2c_smbus_read_block_data function.
> Use i2c_smbus_read_i2c_block_data instead.

You can't do that. These are two different transfer formats, they are
not interchangeable. If the device wants the SMBus block format, then
you have to use this in the driver. If the bus driver doesn't support
that, it has to be fixed. In general it is only a matter of adding
support for I2C_M_RECV_LEN to the bus driver. You can check in
i2c-core:i2c_smbus_xfer_emulated() for a reference implementation.

> 2. Not all zlxx chips's id start with zlxx. zl6100's id starts
> with 0x10. Take this situation into account.

No, this is incorrect. 0x10 is the first byte returned because SMBus
block reads receive the block length as the first byte. 0x10 = 16,
which is the length of the ID for these chips, this is no coincidence.
This is a bug introduced by your above change of SMBus block read for
I2C block read.

So, nack.

> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> branch: master
> test platform: P1022DS
> 
>  drivers/hwmon/pmbus/zl6100.c |   21 ++++++++++++++-------
>  1 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
> index 2bc9800..8e2fd52 100644
> --- a/drivers/hwmon/pmbus/zl6100.c
> +++ b/drivers/hwmon/pmbus/zl6100.c
> @@ -26,6 +26,7 @@
>  #include <linux/i2c.h>
>  #include <linux/ktime.h>
>  #include <linux/delay.h>
> +#include <linux/ctype.h>
>  #include "pmbus.h"
>  
>  enum chips { zl2004, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105 };
> @@ -42,6 +43,8 @@ struct zl6100_data {
>  
>  #define ZL6100_WAIT_TIME		1000	/* uS	*/
>  
> +#define ZL6100_ID_LEN			16		/* device id length */
> +
>  static ushort delay = ZL6100_WAIT_TIME;
>  module_param(delay, ushort, 0644);
>  MODULE_PARM_DESC(delay, "Delay between chip accesses in uS");
> @@ -136,19 +139,20 @@ MODULE_DEVICE_TABLE(i2c, zl6100_id);
>  static int zl6100_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	int ret;
> +	int i, ret;
>  	struct zl6100_data *data;
>  	struct pmbus_driver_info *info;
> -	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
> +	u8 device_id[ZL6100_ID_LEN + 1];
>  	const struct i2c_device_id *mid;
>  
>  	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> -				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
>  		return -ENODEV;
>  
> -	ret = i2c_smbus_read_block_data(client, ZL6100_DEVICE_ID,
> -					device_id);
> +	ret = i2c_smbus_read_i2c_block_data(client, ZL6100_DEVICE_ID,
> +					ZL6100_ID_LEN, device_id);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to read device ID\n");
>  		return ret;
> @@ -156,9 +160,12 @@ static int zl6100_probe(struct i2c_client *client,
>  	device_id[ret] = '\0';
>  	dev_info(&client->dev, "Device ID %s\n", device_id);
>  
> +	for (i = 0; i < ret; i++)
> +		device_id[i] = tolower(device_id[i]);
> +
>  	mid = NULL;
>  	for (mid = zl6100_id; mid->name[0]; mid++) {
> -		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
> +		if (strstr(device_id, mid->name))
>  			break;
>  	}
>  	if (!mid->name[0]) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
