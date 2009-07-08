From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 08 Jul 2009 21:25:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: k8temp.c Add support for AMD 11h
Message-Id: <4A550ED6.8050908@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1246959006.3001.7.camel@hpdv5.satnam>
In-Reply-To: <1246959006.3001.7.camel@hpdv5.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I think Jean will have some comments too. Here is quick review.


> 
> Added AMD 11h support in k8temp. Thanks to Rudolf Marek for help.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> ---
>  drivers/hwmon/Kconfig  |    4 +-
>  drivers/hwmon/k8temp.c |   75 ++++++++++++++++++++++++++++++-----------------
>  2 files changed, 50 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2d50166..e7b4941 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -200,11 +200,11 @@ config SENSORS_ADT7475
>  	  will be called adt7475.
>  
>  config SENSORS_K8TEMP
> -	tristate "AMD Athlon64/FX or Opteron temperature sensor"
> +	tristate "AMD Athlon64/FX or Opteron or 11h temperature sensor"


maybe something else? like fam11h All it sounds too technical. Maybe we can
leave it and fix the help. Also the documentation/hwmon/k8temp should be updated.

>  	depends on X86 && PCI && EXPERIMENTAL
>  	help
>  	  If you say yes here you get support for the temperature
> -	  sensor(s) inside your CPU. Supported is whole AMD K8
> +	  sensor(s) inside your CPU. Supported is whole AMD K8 and 11h
>  	  microarchitecture. Please note that you will need at least
>  	  lm-sensors 2.10.1 for proper userspace support.

Maybe we can add note why fam10h is not supported, and also to a readme. Best it
would be with another patch.

>  
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index 1fe9951..f91da26 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -1,5 +1,6 @@
>  /*
>   * k8temp.c - Linux kernel module for hardware monitoring
> + *	      for AMD K8 and 11h
>   *
>   * Copyright (C) 2006 Rudolf Marek <r.marek@assembler.cz>
>   *
> @@ -33,7 +34,7 @@
>  #include <linux/mutex.h>
>  #include <asm/processor.h>
>  
> -#define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
> +#define REG_TCTL	0xa4
>  #define REG_TEMP	0xe4
>  #define SEL_PLACE	0x40
>  #define SEL_CORE	0x04
> @@ -52,42 +53,61 @@ struct k8temp_data {
>  	u32 temp_offset;
>  };
>  
> -static struct k8temp_data *k8temp_update_device(struct device *dev)

> +static inline unsigned long temp_from_reg(unsigned long val)

maybe the unsigned long val should be u32 so it is fixed - regs is also fixed size.

> +{
> +	if (boot_cpu_data.x86 > 0xf)
> +		return (val >> 21) * 125;
> +	else
> +		return (((val >> 16) & 0xff) - 49) * 1000;
> +}
> +
> +static void update_11h_temp(struct pci_dev *pdev, struct k8temp_data *data)
> +{
> +	pci_read_config_dword(pdev, REG_TCTL, &data->temp[0][0]);
> +}
> +
> +static void update_k8_temp(struct pci_dev *pdev, struct k8temp_data *data)
>  {
> -	struct k8temp_data *data = dev_get_drvdata(dev);
> -	struct pci_dev *pdev = to_pci_dev(dev);
>  	u8 tmp;
>  
> -	mutex_lock(&data->update_lock);
> +	pci_read_config_byte(pdev, REG_TEMP, &tmp);
> +	tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
> +	pci_write_config_byte(pdev, REG_TEMP, tmp);
> +	pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
>  
> -	if (!data->valid
> -	    || time_after(jiffies, data->last_updated + HZ)) {
> -		pci_read_config_byte(pdev, REG_TEMP, &tmp);
> -		tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
> +	if (data->sensorsp & SEL_PLACE) {
> +		tmp |= SEL_PLACE;		/* Select sensor 1, core0 */
>  		pci_write_config_byte(pdev, REG_TEMP, tmp);
> -		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
> +		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][1]);
> +	}
> +
> +	if (data->sensorsp & SEL_CORE) {
> +		tmp &= ~SEL_PLACE;		/* Select sensor 0, core1 */
> +		tmp |= SEL_CORE;
> +		pci_write_config_byte(pdev, REG_TEMP, tmp);
> +		pci_read_config_dword(pdev, REG_TEMP, &data->temp[1][0]);
>  
>  		if (data->sensorsp & SEL_PLACE) {
> -			tmp |= SEL_PLACE;	/* Select sensor 1, core0 */
> +			tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
>  			pci_write_config_byte(pdev, REG_TEMP, tmp);
>  			pci_read_config_dword(pdev, REG_TEMP,
> -					      &data->temp[0][1]);
> +					      &data->temp[1][1]);
>  		}
> +	}
> +}
>  
> -		if (data->sensorsp & SEL_CORE) {
> -			tmp &= ~SEL_PLACE;	/* Select sensor 0, core1 */
> -			tmp |= SEL_CORE;
> -			pci_write_config_byte(pdev, REG_TEMP, tmp);
> -			pci_read_config_dword(pdev, REG_TEMP,
> -					      &data->temp[1][0]);
> -
> -			if (data->sensorsp & SEL_PLACE) {
> -				tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
> -				pci_write_config_byte(pdev, REG_TEMP, tmp);
> -				pci_read_config_dword(pdev, REG_TEMP,
> -						      &data->temp[1][1]);
> -			}
> -		}
> +static struct k8temp_data *k8temp_update_device(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct k8temp_data *data = dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
> +		if (boot_cpu_data.x86 > 0xf)
> +			update_11h_temp(pdev, data);
> +		else
> +			update_k8_temp(pdev, data);
>  
>  		data->last_updated = jiffies;
>  		data->valid = 1;


Rest looks ok. Anyone else can test?

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpVDpgACgkQ3J9wPJqZRNUo9ACgnsmlkNYiCXnqmW18stl2T8Vb
GAgAoJHlrO9BtGSEprPrAUMyZd/F/9Z3
=xlSR
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
