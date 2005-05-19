From: adobriyan@mail.ru (Alexey Dobriyan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <200502020315.14281.adobriyan@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <41F6F1D5.90601@mvista.com>
In-Reply-To: <41F6F1D5.90601@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 01 Feb 2005 10:54:32 -0700, Mark A. Greer wrote:

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c

> +struct mv64xxx_i2c_data {
> +	void			*reg_base;

ioremap() returns "void __iomem *".

> +static void __devexit
> +mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_data)
> +{
> +	if (!drv_data->reg_base) {
> +		iounmap(drv_data->reg_base);

A typo? You're unmapping known to be invalid address.

> +	drv_data->reg_base = 0;

Use NULL because drv_data->reg_base is a pointer.

> +};

> +static int __devinit
> +mv64xxx_i2c_probe(struct device *dev)
> +{

> +	if ((pd->id = 0) && pdata) {

Rewrite this as:

	if ((pd->id != 0) || !pdata)
		return -ENODEV;

and save one level of indentation below.

> +		drv_data = kmalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> +		if (!drv_data)
> +			return -ENOMEM;
> +		memset(drv_data, 0, sizeof(struct mv64xxx_i2c_data));
> +
> +		if (mv64xxx_i2c_map_regs(pd, drv_data)) {
> +			kfree(drv_data);
> +			return -ENODEV;
> +		}

		[snip non-branching stuff]

> +		if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
> +			MV64XXX_I2C_CTLR_NAME, drv_data)) {
> +
> +			dev_err(dev, "mv64xxx: Can't register intr handler "
> +				"irq: %d\\n", drv_data->irq);

"\n".

> +
> +			mv64xxx_i2c_unmap_regs(drv_data);
> +			kfree(drv_data);
> +			return -EINVAL;
> +		}
> +		else if ((rc = i2c_add_adapter(&drv_data->adapter)) != 0) {
> +			dev_err(dev, "mv64xxx: Can't add i2c adapter, rc: %d\n",
> +				-rc);
> +			free_irq(drv_data->irq, drv_data);
> +			mv64xxx_i2c_unmap_regs(drv_data);
> +			kfree(drv_data);
> +			return rc;
> +		}
		[snip]
> +	}

> +}

Use centralized exiting and goto's. Something like:

	if (mv64xxx_i2c_map_regs(pd, drv_data)) {
		rc = -ENODEV;
		goto exit_free;
	}
	if (request_irq) {
		rc = -EINVAL;
		dev_err
		goto exit_unmap_regs
	}
	if (rc = i2c_add_adapter) {
		dev_err
		goto exit_free_irq
	}
	mv64xxx_i2c_hw_init

	return 0;

	exit_free_irq:
		free_irq
	exit_unmap_regs:
		mv64xxx_i2c_unmap_regs
	exit_free:
		kfree
	return rc;

					Alexey

P. S.: struct mv64xxx_i2c_data revisited...

> +	uint			state;
> +	ulong			reg_base_p;

Silly request, but... Maybe this should be changed to plain old "unsigned int"
and "unsigned long". Please. I just don't understand why people use "uint",
"u_int", "uInt", "UINT", "uINT", "uint_t" which are always typedef'ed to
"unsigned int".
