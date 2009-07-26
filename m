From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 26 Jul 2009 19:12:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (smsc47m1) Differentiate between
Message-Id: <4A6CAA80.8000909@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090720211436.1dfb676c@hyperion.delvare>
In-Reply-To: <20090720211436.1dfb676c@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks good to me,

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


On 07/20/2009 09:14 PM, Jean Delvare wrote:
> The SMSC LPC47M233 and LPC47M292 chips have the same device ID but
> are not compatible.
>
> Signed-off-by: Jean Delvare<khali@linux-fr.org>
> Cc: Juerg Haefliger<juergh@gmail.com>
> ---
>   drivers/hwmon/smsc47m1.c |   11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> --- linux-2.6.31-rc3.orig/drivers/hwmon/smsc47m1.c	2009-06-10 05:05:27.000000000 +0200
> +++ linux-2.6.31-rc3/drivers/hwmon/smsc47m1.c	2009-07-20 20:19:09.000000000 +0200
> @@ -86,6 +86,7 @@ superio_exit(void)
>   #define SUPERIO_REG_ACT		0x30
>   #define SUPERIO_REG_BASE	0x60
>   #define SUPERIO_REG_DEVID	0x20
> +#define SUPERIO_REG_DEVREV	0x21
>
>   /* Logical device registers */
>
> @@ -429,6 +430,9 @@ static int __init smsc47m1_find(unsigned
>   	 * The LPC47M292 (device id 0x6B) is somewhat compatible, but it
>   	 * supports a 3rd fan, and the pin configuration registers are
>   	 * unfortunately different.
> +	 * The LPC47M233 has the same device id (0x6B) but is not compatible.
> +	 * We check the high bit of the device revision register to
> +	 * differentiate them.
>   	 */
>   	switch (val) {
>   	case 0x51:
> @@ -448,6 +452,13 @@ static int __init smsc47m1_find(unsigned
>   		sio_data->type = smsc47m1;
>   		break;
>   	case 0x6B:
> +		if (superio_inb(SUPERIO_REG_DEVREV)&  0x80) {
> +			pr_debug(DRVNAME ": "
> +				 "Found SMSC LPC47M233, unsupported\n");
> +			superio_exit();
> +			return -ENODEV;
> +		}
> +
>   		pr_info(DRVNAME ": Found SMSC LPC47M292\n");
>   		sio_data->type = smsc47m2;
>   		break;
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
