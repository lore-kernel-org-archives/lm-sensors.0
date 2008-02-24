From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Feb 2008 15:43:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080224164335.6ccfdc23@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Mon, 11 Feb 2008 01:32:59 -0500, Andrew Paprocki wrote:
> This splits the it8712 chip type into two chip types to distinguish the
> changes made in rev 8 of the chip. A new type it8712old represents all
> revs prior to rev 8. The it8712 chip type now represents rev 8 and
> greater.

I am not fond of the "it8712old" name, because "old" doesn't tell the
reader in which way it is different from the (new) it8712 type. It also
doesn't "scale" well... What will you do if the next IT8712F revision
differs from rev. K in a new way?

I would prefer a separate field in struct it87_sio_data and struct
it87_data, recording the revision value. This is reusable for future
differences between the various revisions of all supported chips. This
approach is also less likely to break the current code.

As a side note, I think it's rather weird that the IT8712F rev. J (and
later) do default to 8-bit fan speed values while they no longer
support fan clock dividers. As these revisions of the chip are not
backward compatible with the older revisions, ITE should really have
switched to a saner default.

> For clarity, the it87 chip type is now named it8705.

Bad idea. Renaming it87 chips to it8705 will break compatibility with
libsensors 2.x. Even for libsensors 3.x, the configuration file
mentions specific chip names, and this change would cause the "it87-*"
section to be ignored.

So, please revert this part of your patch.

> The it8712 chip type now enables 16-bit fan tachometer reading to get
> proper readings. The register used in the it8712old chip type no longer
> has the same meaning in rev 8 of the chip.

Which register are you talking about please?

> Also, a new module param array enable_fans is added. This was needed to
> get fan2 to show up on an it8712 rev 8 chip which was not enabled at
> boot time by the BIOS. The module param is checked and if a fan index
> value is 1, the fan is forced on even if it is not configured that way
> from the BIOS.

This is a BIOS bug, which should be fixed in the BIOS. Please report to
your motherboard manufacturer and get them to fix the bug. What
motherboard is this, BTW? Usually motherboard BIOS enable all fans, or
none; I don't remember seeing a BIOS (improperly) enabling a subset
only.

It would have had to be a separate patch anyway.

Review:

> Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
> ---
>   drivers/hwmon/it87.c |   84
> +++++++++++++++++++++++++++++++++++++-------------

Your e-mail client wraps long lines, so I can't apply your patch.
Please fix your e-mail client configuration. If you can't get it to
work, include the patch as a text attachment.

>   1 files changed, 62 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index ad6c8a3..3c23726 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -50,7 +50,7 @@
> 
>   #define DRVNAME "it87"
> 
> -enum chips { it87, it8712, it8716, it8718 };
> +enum chips { it8705, it8712old, it8712, it8716, it8718 };
> 
>   static struct platform_device *pdev;
> 
> @@ -121,6 +121,9 @@ static int update_vbat;
>   /* Not all BIOSes properly configure the PWM registers */
>   static int fix_pwm_polarity;
> 
> +/* Not all BIOSes properly enable all available fans */
> +static int enable_fans[5];
> +
>   /* Many IT87 constants specified below */
> 
>   /* Length of ISA address segment */
> @@ -145,11 +148,11 @@ static int fix_pwm_polarity;
>   #define IT87_REG_ALARM3        0x03
> 
>   /* The IT8718F has the VID value in a different register, in Super-I/O
> -   configuration space. */
> + * configuration space. */

Please revert. If anything, your comments should match the style of the
file, not the other way around!

>   #define IT87_REG_VID           0x0a
> -/* Warning: register 0x0b is used for something completely different in
> -   new chips/revisions. I suspect only 16-bit tachometer mode will work
> -   for these. */
> +/* The IT8705F and IT8712F earlier than revision 0x08 use register 0x0b
> + * for fan divisors. Later IT8712F revisions must use 16-bit tachometer
> + * mode. */
>   #define IT87_REG_FAN_DIV       0x0b
>   #define IT87_REG_FAN_16BIT     0x0c
> 
> @@ -904,16 +907,21 @@ static int __init it87_find(unsigned short *address,
>   {
>   	int err = -ENODEV;
>   	u16 chip_type;
> +        u8 revision;

Bad indentation. Please use tabs, not spaces, for indentation, as
documented in Documentation/CodingStyle.

> 
>   	superio_enter();
>   	chip_type = superio_inw(DEVID);
> +        revision = superio_inb(DEVREV);

The revision is only the low nibble of the register, so you should mask
the value with & 0x0f.

> 
>   	switch (chip_type) {
>   	case IT8705F_DEVID:
> -		sio_data->type = it87;
> +		sio_data->type = it8705;
>   		break;
>   	case IT8712F_DEVID:
> -		sio_data->type = it8712;
> +                if (revision < 0x08)
> +                        sio_data->type = it8712old;
> +                else
> +                        sio_data->type = it8712;
>   		break;
>   	case IT8716F_DEVID:
>   	case IT8726F_DEVID:

Later in this function, the revision is read from the chip. Now that
you have it in a variable you should use this variable instead.

> @@ -975,7 +983,8 @@ static int __devinit it87_probe(struct
> platform_device *pdev)
>   	int err = 0;
>   	int enable_pwm_interface;
>   	static const char *names[] = {
> -		"it87",
> +		"it8705",
> +		"it8712",
>   		"it8712",
>   		"it8716",
>   		"it8718",
> @@ -1021,7 +1030,7 @@ static int __devinit it87_probe(struct
> platform_device *pdev)
>   		goto ERROR2;
> 
>   	/* Do not create fan files for disabled fans */
> -	if (data->type = it8716 || data->type = it8718) {
> +        if (data->type != it8705 && data->type != it8712old) {
>   		/* 16-bit tachometers */
>   		if (data->has_fan & (1 << 0)) {
>   			if ((err = device_create_file(dev,
> @@ -1111,8 +1120,7 @@ static int __devinit it87_probe(struct
> platform_device *pdev)
>   			goto ERROR4;
>   	}
> 
> -	if (data->type = it8712 || data->type = it8716
> -	 || data->type = it8718) {
> +	if (data->type != it8705) {
>   		data->vrm = vid_which_vrm();
>   		/* VID reading from Super-I/O config space if available */
>   		data->vid = sio_data->vid_value;

> @@ -1362,7 +1395,8 @@ static struct it87_data *it87_update_device(struct
> device *dev)
>   			data->fan[i] = it87_read_value(data,
>   				       IT87_REG_FAN[i]);
>   			/* Add high byte if in 16-bit mode */
> -			if (data->type = it8716 || data->type = it8718) {
> +			if (data->type = it8712 || data->type = it8716
> +                         || data->type = it8718) {
>   				data->fan[i] |= it87_read_value(data,
>   						IT87_REG_FANX[i]) << 8;
>   				data->fan_min[i] |= it87_read_value(data,
> @@ -1378,9 +1412,11 @@ static struct it87_data
> *it87_update_device(struct device *dev)
>   			    it87_read_value(data, IT87_REG_TEMP_LOW(i));
>   		}
> 
> -		/* Newer chips don't have clock dividers */
> -		if ((data->has_fan & 0x07) && data->type != it8716
> -		 && data->type != it8718) {
> +                /* The 8705 uses fan divisors. The 8712 had fan divisors
> +                 * prior to revision 0x08.
> +                 */
> +		if ((data->has_fan & 0x07) &&
> +                    (data->type = it8705 || data->type = it8712old)) {
>   			i = it87_read_value(data, IT87_REG_FAN_DIV);
>   			data->fan_div[0] = i & 0x07;
>   			data->fan_div[1] = (i >> 3) & 0x07;
> @@ -1396,7 +1432,9 @@ static struct it87_data *it87_update_device(struct
> device *dev)
>   		data->fan_ctl = it87_read_value(data, IT87_REG_FAN_CTL);
> 
>   		data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
> -		/* The 8705 does not have VID capability */
> +                /* The 8705 does not have VID capability.
> +                 * The 8718 does not use IT87_REG_VID for the same purpose.
> +                 */
>   		if (data->type = it8712 || data->type = it8716) {
>   			data->vid = it87_read_value(data, IT87_REG_VID);
>   			/* The older IT8712F revisions had only 5 VID pins,
> @@ -1495,6 +1533,8 @@ module_param(update_vbat, bool, 0);
>   MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup
> value");
>   module_param(fix_pwm_polarity, bool, 0);
>   MODULE_PARM_DESC(fix_pwm_polarity, "Force PWM polarity to active high
> (DANGEROUS)");
> +module_param_array(enable_fans, bool, 0, 0444);
> +MODULE_PARM_DESC(enable_fans, "Force enable fans (up to 5 fans when
> supported)");
>   MODULE_LICENSE("GPL");
> 
>   module_init(sm_it87_init);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
