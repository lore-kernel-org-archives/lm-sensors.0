From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 06 Aug 2012 14:33:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sch56xx-common) Fix build warnings
Message-Id: <501FD5D4.5010509@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1344262986-26950-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1344262986-26950-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 08/06/2012 04:23 PM, Guenter Roeck wrote:
> Fix:
> warning: 'address' may be used uninitialized in this function
> warning: 'name' may be used uninitialized in this function
>
> While those are false warnings, the patch reduces module size on x86_64 by
> approximately 110 bytes, so it is still worth the effort.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks good:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/hwmon/sch56xx-common.c |   22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index 4380f5d..69abbf7 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -503,10 +503,10 @@ EXPORT_SYMBOL(sch56xx_watchdog_unregister);
>    * platform dev find, add and remove functions
>    */
>
> -static int __init sch56xx_find(int sioaddr, unsigned short *address,
> -			       const char **name)
> +static int __init sch56xx_find(int sioaddr, const char **name)
>   {
>   	u8 devid;
> +	unsigned short address;
>   	int err;
>
>   	err = superio_enter(sioaddr);
> @@ -540,13 +540,14 @@ static int __init sch56xx_find(int sioaddr, unsigned short *address,
>   	 * Warning the order of the low / high byte is the other way around
>   	 * as on most other superio devices!!
>   	 */
> -	*address = superio_inb(sioaddr, SIO_REG_ADDR) |
> +	address = superio_inb(sioaddr, SIO_REG_ADDR) |
>   		   superio_inb(sioaddr, SIO_REG_ADDR + 1) << 8;
> -	if (*address = 0) {
> +	if (address = 0) {
>   		pr_warn("Base address not set\n");
>   		err = -ENODEV;
>   		goto exit;
>   	}
> +	err = address;
>
>   exit:
>   	superio_exit(sioaddr);
> @@ -593,15 +594,14 @@ exit_device_put:
>
>   static int __init sch56xx_init(void)
>   {
> -	int err;
>   	unsigned short address;
> -	const char *name;
> +	const char *name = NULL;
>
> -	err = sch56xx_find(0x4e, &address, &name);
> -	if (err)
> -		err = sch56xx_find(0x2e, &address, &name);
> -	if (err)
> -		return err;
> +	address = sch56xx_find(0x4e, &name);
> +	if (address < 0)
> +		address = sch56xx_find(0x2e, &name);
> +	if (address < 0)
> +		return address;
>
>   	return sch56xx_device_add(address, name);
>   }
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
