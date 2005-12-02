From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Dec 2005 22:13:07 +0000
Subject: [lm-sensors] Re: [patch] ds2482: i2c to 1-wire bridge
Message-Id: <20051202221418.48c92c66.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512020734rb7d351bla98161d14c8cb70@mail.gmail.com>
In-Reply-To: <808c8e9d0512020734rb7d351bla98161d14c8cb70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> This patch adds support for the Maxim DS2482-100 and DS2482-800 chips,
> which are i2c devices that provide 1 or 8 1-wire masters.
> 
> I put the code under drivers/i2c/chips, but perhaps it should go under
> drivers/w1.

Yes, I think it should go under drivers/w1. SMBus masters which are PCI
devices go under drivers/i2c/busses rather than drivers/pci, and in
general it sounds saner to care about what the driver provides rather
than the technology it relies on. drivers/i2c/chips is an exception to
that rule, but drivers should only go there if there is really no other
place where they fit. Ideally this directory should be empty ;)

> + * The DS2482 is a sensor chip made by Dallis Semiconductor (Maxim).

Typo: Dallas.

> + * The complete datasheet can be obtained from MAXIM's website at:
> + *   http://www.maxim-ic.com

Can you please point to the device page? Maxim's site is well done and
each chip or family of chips has a page you can easily point to.

> +/**
> + * Address is selected using 2 pins, resulting in 4 possible addresses.
> + *  0x18, 0x19, 0x1a, 0x1b
> + * However, this chip is rare and should not be detected, so use the force
> + * module parameter.
> + */

I guess you mean "cannot be detected" rather than "should not be
detected"?

Hopefully, the upcoming new method to explicitely attach i2c drivers to
devices should make that case easier to deal with.

> +/**
> + * Configure Register bit definitions
> + * The top 4 bits always read 0.
> + * To write, the top nibble must be the 1's compl. of the low nibble.
> + */
> +#define DS2482_REG_CFG_1WS             0x08
> +#define DS2482_REG_CFG_SPU             0x04
> +#define DS2482_REG_CFG_PPM             0x02
> +#define DS2482_REG_CFG_APU             0x01
> +
> +/* Write and verify codes for the CHANNEL_SELECT command (DS2482-800 only) */
> +static u8 ds2482_chan_wr[8] = { 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87};
> +static u8 ds2482_chan_rd[8] = { 0xB8, 0xB1, 0xAA, 0xA3, 0x9C, 0x95, 0x8E, 0x87};

This second static array (ds2482_chan_rd) looks contradictory with the
above statement that the top 4 bits always read 0. Clarification needed?

BTW, please align all define values using tabs, not spaces. And spaces
are missing before closing curly braces.

> +static struct i2c_driver ds2482_driver = {
> +	.owner		= THIS_MODULE,
> +	.name		= "ds2482",
> +	.flags		= I2C_DF_NOTIFY,
> +	.attach_adapter	= ds2482_attach_adapter,
> +	.detach_client	= ds2482_detach_client,
> +};

Note that there are ongoing changes related to this structure which
will hit next -mm. This will need to look like this there:

static struct i2c_driver ds2482_driver = {
	.driver = {
		.owner	= THIS_MODULE,
		.name	= "ds2482",
	},
	.attach_adapter	= ds2482_attach_adapter,
	.detach_client	= ds2482_detach_client,
};

I guess Andrew will deal with this just fine anyway.

> +	if ( pdev->read_prt != read_ptr ) {

No spaces inside parentheses please! Ever!

> +			return(-1);

No parentheses on simple returns.

> +static inline int ds2482_set_channel(struct ds2482_data *pdev, u8 channel)
> +{
> +	if (channel >= 8)
> +		return -1;

As I understand it, this cannot happen unless you did a programming
error. Thus this should be made a DEBUG statement, if not plain dropped
once your driver is fully tested.

> +static u8 ds2482_w1_touch_bit(unsigned long data, u8 bit)
> +{
> +	struct ds2482_w1_chan *pchan = (struct ds2482_w1_chan *)data;

That's an ugly cast. Can't it be avoided?

> +static u8 ds2482_w1_read_byte(unsigned long data)
> +{
> (...)
> +	return((u8)result);
> +}

If this cast is ever useful, then your code is broken. Let alone the
fact that the cast is implicit anyway.

> +		retval = (err & DS2482_REG_STS_PPD) ? 0 : 1;

I suspect that:

		retval = !(err & DS2482_REG_STS_PPD);

would be more efficient. But the compiler might generate the same code
after all, I don't know for sure.

> +	if ( !i2c_check_functionality(adapter,
> +				      I2C_FUNC_SMBUS_BYTE_DATA |
> +				      I2C_FUNC_SMBUS_BYTE) ) {
> +		goto exit;
> +	}

You don't seem to use i2c_smbus_read_byte_data, so you should test for
I2C_FUNC_SMBUS_WRITE_BYTE_DATA instead of I2C_FUNC_SMBUS_BYTE_DATA.

> +	if ( !(data = kmalloc(sizeof(struct ds2482_data), GFP_KERNEL)) ) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +	memset(data, 0, sizeof(struct ds2482_data));

Please use kzalloc().

> +	new_client->flags = 0;

Not needed thanks to kzalloc (or memset).

> +	/* Read the status byte - expect reset bit and line to be set */
> +	temp1 = i2c_smbus_read_byte(new_client);
> +	if (temp1 != (DS2482_REG_STS_LL | DS2482_REG_STS_RST)) {

You test for more than the comment says (you test that all other bits
are *not* set).

> +	/* We can fill in the remaining client fields */
> +	sprintf(new_client->name, "ds2482-%d00", data->w1_count);

Unsafe, please use snprintf.

> +exit_w1_remove:
> +	for (idx = 0; idx < data->w1_count; idx++) {
> +		if (data->w1_ch[idx].pdev != NULL) {
> +			w1_remove_master_device(&data->w1_ch[idx].w1_bus_master);
> +		}
> +	}
> +exit_free:
> +	kfree(data);

Isn't there an i2c_detach_client(new_client) missing in this error path?

-- 
Jean Delvare
