From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Dec 2010 12:05:29 +0000
Subject: Re: [lm-sensors] [PATCH] emc1403: added emc1423 support
Message-Id: <20101210130529.01c31fa5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101210101036.12174.79352.stgit@bob.linux.org.uk>
In-Reply-To: <20101210101036.12174.79352.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

On Fri, 10 Dec 2010 10:10:50 +0000, Alan Cox wrote:
> From: Jekyll Lai <jekyll_lai@wistron.com>
> 
> emc1423 uses the similar register and adds a hardware shutdown pin to
> protect exceed temperature. This function is set by resistor; it's not
> necessary to do anything in the driver except add the emc1423 pid of 0x23.
> 
> Signed-off-by: Jekyll Lai <jekyll_lai@wistron.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/hwmon/emc1403.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index 8dee3f3..9141e22 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -278,7 +278,7 @@ static int emc1403_detect(struct i2c_client *client,
>  	/* Note: 0x25 is the 1404 which is very similar and this
>  	   driver could be extended */
>  	id = i2c_smbus_read_byte_data(client, THERMAL_PID_REG);
> -	if (id != 0x21)
> +	if (id != 0x21 && id != 0x23)	/* 0x21:emc1403 0x23:emc1423*/
>  		return -ENODEV;
>  
>  	id = i2c_smbus_read_byte_data(client, THERMAL_REVISION_REG);

I like small patches, but this time it seems kind of extreme ;)

We need:
* An update to the Kconfig entry, mentioning the new device being
  supported.
* A new entry in emc1403_idtable.
* That emc1403_detect() writes the right device name to info->type. And
  an update to the top comment in this function.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
