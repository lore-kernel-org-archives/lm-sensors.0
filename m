From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Jul 2008 11:16:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080706131605.163fc962@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Tue, 24 Jun 2008 09:16:30 -0400, Andrew Paprocki wrote:
> On Sun, Feb 24, 2008 at 11:43 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Which register are you talking about please?
> 
> If you compare the PDF documents here:
> http://www.ite.com.tw/product_info/PC/Brief-IT8712_2.asp
> 
> v0.8.2 shows 9.6.2.2.12 Fan Tachometer Divisor Register (Indexh,
> Default	h) using bits 0-6 for the divisors. This version corresponds
> to revisions of the chip < 0x8.
> 
> v0.9.1 & v0.9.3 show the same register having bits 0-5 reserved and
> 6-7 are the PWM Smoothing Step Frequency Selection. This version
> corresponds to revisions of the chip >= 0x8.

Correct.

> Since those bit ranges overlap, I don't see how they could be
> preserving the "old" behavior. They could have done that if bits 0-6
> were reserved, but the new meaning of bits 6-7 overlaps the old FAN3
> divisor. Strangely, both revisions say they have a default value of
> 09h. (Documentation error?)

I agree it's all strange. I don't have a revision J or later chip so I
can't test. Someone with such a chip (you?) could attempt to reset it
(write 1 to bit 7 of register 00h) and check what the default value
of register 0Bh actually is.

If the default value is really 09h, one possibility is that bits 0-5 of
register 0Bh still control fan clock dividers for fan1 and fan2, even
though they are no longer needed and this is not documented. Again,
only someone with such a chip could test that. Or maybe value 09h is
read only and just meant to express the fact that the fan clock divider
is always 2 in 16-bit mode. But OTOH we don't really care, what really
matters is to add 16-bit fan speed support for the chips that need
this, just as your patch does.

> > This is a BIOS bug, which should be fixed in the BIOS. Please report to
> > your motherboard manufacturer and get them to fix the bug. What
> > motherboard is this, BTW? Usually motherboard BIOS enable all fans, or
> > none; I don't remember seeing a BIOS (improperly) enabling a subset
> > only.
> 
> I've reported this to the motherboard manufacturer and I'm waiting to
> hear back if they confirm that it is a BIOS setup issue on their side.
> The board in question is the Albatron KI 690-AM2 motherboard. This
> board has a 4-pin & a 3-pin fan header. The main fan control register
> has a value of 0x11 which indicates that only FAN1 is active (in
> SmartGuardian mode). If I manually hack the driver to always set bit 5
> of the register (9.6.2.2.16 Fan Controller Main Control Register
> (Indexh, Defaulth) in the docs), then I get a valid fan reading
> from my CPU fan on "fan2" plugged into the 3-pin header. Short of a
> BIOS update to fix this, I'd have to hack it to allow me to force
> enable the second fan to get a valid reading.
> 
> I've reworked the code to just add a revision field as you noted and
> to only contain the 16-bit tach change. Please review and let me know
> what you think re: force enabling the fans via a module parameter
> bitmask or something similar.

Maybe I have been too optimistic when assuming that we could always
trust the BIOS on either leaving the fans alone (in which case the
driver enables all inputs) or enabling all the ones the board uses.
After all, they have no reason to enable fan inputs for which they don't
display a value themselves. I noticed that this happens for my own
motherboard, which has an IT8705F chip. The board has 3 fans headers,
but only fan1 and fan2 are enabled (and displayed) by the BIOS. Maybe a
BIOS upgrade would help, but my attempt at this, failed.

So maybe we should simply always enable all of fan1, fan2 and fan3,
regardless of what the BIOS did. That's a one-line change as far as I
can see, fairly simple.

Review of your patch:

> Subject: [PATCH] hwmon: it87 support for 16-bit fan reading in it8712 >= rev 8
> 
> The it8712 chip does not use fan divisors in revisions >= 8.
> The newer version of the chip uses 16-bit fan tachometers just
> like the it8716 and it8718 chips.

Overall it looks fine, with minor comments:

> Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
> ---
>  drivers/hwmon/it87.c |   29 +++++++++++++++++++----------
>  1 files changed, 19 insertions(+), 10 deletions(-)

You also need to update Documentation/hwmon/it87, which currently
claims that "the driver only uses the 16-bit mode on the IT8716F and
IT8718F". Likewise, the documentation says that fan4 and fan5 are not
supported for the IT8712F, while your patch enables this for
revisions >= J as far as I can see. This makes me wonder why your patch
doesn't also cover revision I, as it already had 16-bit fan speed
registers and the 2 extra fans as well.

> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index e12c132..4017fee 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -151,9 +151,9 @@ static int fix_pwm_polarity;
>  /* The IT8718F has the VID value in a different register, in Super-I/O
>     configuration space. */
>  #define IT87_REG_VID           0x0a
> -/* Warning: register 0x0b is used for something completely different in
> -   new chips/revisions. I suspect only 16-bit tachometer mode will work
> -   for these. */
> +/* The IT8705F and IT8712F earlier than revision 0x08 use register 0x0b
> +   for fan divisors. Later IT8712F revisions ust use 16-bit tachometer

Typo: must.

> +   mode. */
>  #define IT87_REG_FAN_DIV       0x0b
>  #define IT87_REG_FAN_16BIT     0x0c
>  
> @@ -234,6 +234,7 @@ static const unsigned int pwm_freq[8] = {
>  struct it87_sio_data {
>  	enum chips type;
>  	/* Values read from Super-I/O config space */
> +	u8 revision;
>  	u8 vid_value;
>  };
>  
> @@ -242,6 +243,7 @@ struct it87_sio_data {
>  struct it87_data {
>  	struct device *hwmon_dev;
>  	enum chips type;
> +	u8 revision;
>  
>  	unsigned short addr;
>  	const char *name;
> @@ -991,8 +993,9 @@ static int __init it87_find(unsigned short *address,
>  	}
>  
>  	err = 0;
> +	sio_data->revision = superio_inb(DEVREV) & 0x0f;
>  	pr_info("it87: Found IT%04xF chip at 0x%x, revision %d\n",
> -		chip_type, *address, superio_inb(DEVREV) & 0x0f);
> +		chip_type, *address, sio_data->revision);
>  
>  	/* Read GPIO config and VID value from LDN 7 (GPIO) */
>  	if (chip_type != IT8705F_DEVID) {
> @@ -1045,6 +1048,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  
>  	data->addr = res->start;
>  	data->type = sio_data->type;
> +	data->revision = sio_data->revision;
>  	data->name = names[sio_data->type];
>  
>  	/* Now, we do the remaining detection. */
> @@ -1069,7 +1073,8 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  		goto ERROR2;
>  
>  	/* Do not create fan files for disabled fans */
> -	if (data->type = it8716 || data->type = it8718) {
> +	if ((data->type = it8712 && data->revision >= 0x08)
> +	 || data->type = it8716 || data->type = it8718) {

It might be convenient to introduce the following inline helper
function:

static inline int has_16bit_fans(const struct *it87_data)
{
	return (data->type = it8712 && data->revision >= 0x08)
	     || data->type = it8716
	     || data->type = it8718;
}

So you can call it each time you need to differenciate between chips
that have 16-bit fans and chips that do not.

>  		/* 16-bit tachometers */
>  		if (data->has_fan & (1 << 0)) {
>  			if ((err = device_create_file(dev,
> @@ -1350,7 +1355,8 @@ static void __devinit it87_init_device(struct platform_device *pdev)
>  	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
>  
>  	/* Set tachometers to 16-bit mode if needed */
> -	if (data->type = it8716 || data->type = it8718) {
> +	if ((data->type = it8712 && data->revision >= 0x08)
> +	 || data->type = it8716 || data->type = it8718) {
>  		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
>  		if (~tmp & 0x07 & data->has_fan) {
>  			dev_dbg(&pdev->dev,
> @@ -1426,7 +1432,8 @@ static struct it87_data *it87_update_device(struct device *dev)
>  			data->fan[i] = it87_read_value(data,
>  				       IT87_REG_FAN[i]);
>  			/* Add high byte if in 16-bit mode */
> -			if (data->type = it8716 || data->type = it8718) {
> +			if ((data->type = it8712 && data->revision >= 0x08)
> +			 || data->type = it8716 || data->type = it8718) {
>  				data->fan[i] |= it87_read_value(data,
>  						IT87_REG_FANX[i]) << 8;
>  				data->fan_min[i] |= it87_read_value(data,
> @@ -1443,8 +1450,9 @@ static struct it87_data *it87_update_device(struct device *dev)
>  		}
>  
>  		/* Newer chips don't have clock dividers */
> -		if ((data->has_fan & 0x07) && data->type != it8716
> -		 && data->type != it8718) {
> +		if ((data->has_fan & 0x07)
> +		 && (data->type = it87
> +		  || (data->type = it8712 && data->revision < 0x08))) {
>  			i = it87_read_value(data, IT87_REG_FAN_DIV);
>  			data->fan_div[0] = i & 0x07;
>  			data->fan_div[1] = (i >> 3) & 0x07;
> @@ -1460,7 +1468,8 @@ static struct it87_data *it87_update_device(struct device *dev)
>  		data->fan_ctl = it87_read_value(data, IT87_REG_FAN_CTL);
>  
>  		data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
> -		/* The 8705 does not have VID capability */
> +		/* The 8705 does not have VID capability.
> +		   The 8718 does not use IT87_REG_VID for the same purpose. */
>  		if (data->type = it8712 || data->type = it8716) {
>  			data->vid = it87_read_value(data, IT87_REG_VID);
>  			/* The older IT8712F revisions had only 5 VID pins,

Other than that it looks simple and nice. Please update according to my
comments and resubmit as a new post, so that it gets a better summary
line and doesn't get lost in the list.

I've tested your patch on my IT8705F revision F, and didn't experience
any regression. I have an IT8712F somewhere, I'll test on it later
today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
