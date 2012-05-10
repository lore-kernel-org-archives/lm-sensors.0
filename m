From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 May 2012 20:32:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (it87) Create voltage attributes only if voltage is enabled
Message-Id: <20120510223233.41aee3a0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue,  8 May 2012 19:31:52 -0700, Guenter Roeck wrote:
> On IT8782F and IT8783F, some voltage input pins may be disabled. Don't create
> sysfs attribute files if that is the case.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |  146 ++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 113 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index aebac13..baf4173 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> (...)
> @@ -1725,18 +1761,31 @@ static int __init it87_find(unsigned short *address,
>  
>  		/* VIN5 */
>  		if ((reg27 & (1 << 0)) || uart6)
> -			; /* No VIN5 */
> +			sio_data->skip_in |= (1 << 5); /* No VIN5 */
>  
>  		/* VIN6 */
>  		if ((reg27 & (1 << 1)) || uart6)
> -			; /* No VIN6 */
> +			sio_data->skip_in |= (1 << 6); /* No VIN6 */
>  
>  		/*
>  		 * VIN7
>  		 * Does not depend on bit 2 of Reg2C, contrary to datasheet.
>  		 */
> -		if (reg27 & (1 << 2))
> -			; /* No VIN7 (unless internal) */
> +		if (reg27 & (1 << 2)) {
> +			/*
> +			 * The data sheet is a bit uncear regarding the internal

Typo: "unclear".

> +			 * voltage divider for VCCH5V. It says
> +			 * "This bit enables and switches VIN7 (pin91) to the

Missing space between "pin" and "91".

> +			 * internal voltage divider for VCCH5V".
> +			 * This is different to other chips, where the internal
> +			 * voltage divider would connect VIN7 to an internal
> +			 * voltage source. Maybe that is the case here as well,
> +			 * but at least for now follow the data sheet and assume
> +			 * that there is no VIN7 if pin 91 is not configured as
> +			 * VIN7 input.
> +			 */

I think this is the unfortunate result of a copy / paste / edit from
another datasheet. If you look at the IT8716F datasheet, it said:

"Enables PCIRSTIN# (pin 91), and switches VIN7 function to internal
voltage divider for VCCH5V"

So my take is that the editor dropped the reference to PCIRSTIN#
because pin 91 can't be that on the IT8783E/F, but forgot to mention
the other alternative functions (which the IT8716F didn't have.) The
wording was pretty confusing in the first place, and the many
configuration options of the IT8783F only make things worse. I just
can't get how manufacturers can't come up with less confusing designs.

So my personal guess is that this bit switches VIN7 to the internal
source just as with the other chips.

> +			sio_data->skip_in |= (1 << 7);
> +		}
>  
>  		if (reg2C & (1 << 0))
>  			sio_data->internal |= (1 << 0);
> (...)
> @@ -1847,6 +1907,12 @@ static void it87_remove_files(struct device *dev)
>  	int i;
>  
>  	sysfs_remove_group(&dev->kobj, &it87_group);
> +	for (i = 0; i < 9; i++) {

For consistency, you could check sio_data->skip_in. I know no harm is
done if you don't, but the driver does it for fan inputs and PWM
outputs already.

> +		sysfs_remove_group(&dev->kobj, &it87_group_in[i]);
> +		if (it87_attributes_in_beep[i])
> +			sysfs_remove_file(&dev->kobj,
> +					  it87_attributes_in_beep[i]);
> +	}
>  	if (sio_data->beep_pin)
>  		sysfs_remove_group(&dev->kobj, &it87_group_beep);
>  	for (i = 0; i < 5; i++) {
> @@ -1945,9 +2011,23 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  	it87_init_device(pdev);
>  
>  	/* Register sysfs hooks */
> +	for (i = 0; i < 9; i++) {
> +		if (sio_data->skip_in & (1 << i))
> +			continue;
> +		err = sysfs_create_group(&dev->kobj, &it87_group_in[i]);
> +		if (err)
> +			goto ERROR4;
> +		if (sio_data->beep_pin && it87_attributes_in_beep[i]) {
> +			err = sysfs_create_file(&dev->kobj,
> +						it87_attributes_in_beep[i]);
> +			if (err)
> +				goto ERROR4;
> +		}
> +	}
> +
>  	err = sysfs_create_group(&dev->kobj, &it87_group);
>  	if (err)
> -		goto ERROR2;
> +		goto ERROR4;

Why didn't you leave this call first? This would avoid having to change
this label -> smaller patch.

>  
>  	if (sio_data->beep_pin) {
>  		err = sysfs_create_group(&dev->kobj, &it87_group_beep);

These are all minor things, overall the patch looks very good, so you
can add:

Acked-by: Jean Delvare <khali@linux-fr.org>

after addressing the points I made that you find relevant. And sorry
again for the late review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
