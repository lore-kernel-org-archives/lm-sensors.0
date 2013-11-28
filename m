From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Nov 2013 02:51:33 +0000
Subject: Re: [lm-sensors] [PATCH] sfc: Convert to use hwmon_device_register_with_groups
Message-Id: <5296AFB5.6080104@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385523187-31996-1-git-send-email-linux@roeck-us.net> <1385604693.1586.76.camel@bwh-desktop.uk.level5networks.com>
In-Reply-To: <1385604693.1586.76.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@solarflare.com, lm-sensors@lm-sensors.org

On 11/27/2013 06:11 PM, Ben Hutchings wrote:
> On Tue, 2013-11-26 at 19:33 -0800, Guenter Roeck wrote:
>> Simplify the code. Avoid race conditions caused by attributes
>> being created after hwmon device registration. Implicitly
>> (through hwmon API) add mandatory 'name' sysfs attribute.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Compile tested only.
> [...]
>
> Very close, but you missed this bit:
>
> --- a/drivers/net/ethernet/sfc/mcdi_mon.c
> +++ b/drivers/net/ethernet/sfc/mcdi_mon.c
> @@ -142,7 +142,7 @@ static int efx_mcdi_mon_update(struct efx_nic *efx)
>   static int efx_mcdi_mon_get_entry(struct device *dev, unsigned int index,
>   				  efx_dword_t *entry)
>   {
> -	struct efx_nic *efx = dev_get_drvdata(dev);
> +	struct efx_nic *efx = dev_get_drvdata(dev->parent);
>   	struct efx_mcdi_mon *hwmon = efx_mcdi_mon(efx);
>   	int rc;
>
> ---
>
> With that addition, it works for me, and you can add my Reviewed-by.
>

Thanks a lot!

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
