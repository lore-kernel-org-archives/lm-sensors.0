From: adobriyan@mail.ru (Alexey Dobriyan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <200502031556.59319.adobriyan@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <41F6F1D5.90601@mvista.com>
In-Reply-To: <41F6F1D5.90601@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 02 February 2005 19:26, Mark A. Greer wrote:

> How's this (a complete replacement for previous patch)?

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig

> +	  If you say yes to this option, support will be included for the
> +	  built-in I2C interface on the Marvell 64xxx line of host bridges

Dot at the end. Should have noticed it earlier...

> +	  This driver can also be built as a module.  If so, the module

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c

> +static void
> +mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)

> +	if (drv_data->state = MV64XXX_I2C_STATE_IDLE) {
> +		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
> +		drv_data->state = MV64XXX_I2C_STATE_IDLE;

drv_data->state is already MV64XXX_I2C_STATE_IDLE. Gcc will probably optimize
this line away, but...

> +		}
> +		else {

It should be "} else {" according to CodingStyle.

> +static int
> +mv64xxx_i2c_intr(int irq, void *dev_id, struct pt_regs *regs)

> +	while (readl(drv_data->reg_base + MV64XXX_I2C_REG_CONTROL) &
> +						MV64XXX_I2C_REG_CONTROL_IFLG) {
> +		status = readl(drv_data->reg_base + MV64XXX_I2C_REG_STATUS);
> +		mv64xxx_i2c_fsm(drv_data, status);

It can set drv_data->rc to -ENODEV or -EIO. In both cases ->action goes to
MV64XXX_I2C_ACTION_SEND_STOP and mv64xxx_i2c_do_action() will writel()
something. Is it correct to _not_ check ->rc here? If it isn't then would it be
better to make all functions that set it return -E___ instead and drop
struct mv64xxx_i2c_data.rc altogether?

> +		mv64xxx_i2c_do_action(drv_data);

> +static void
> +mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)

> +		time_left = wait_event_timeout(drv_data->waitq,
> +			!drv_data->block,
> +			msecs_to_jiffies(drv_data->adapter.timeout));
> +
> +		if (!time_left <= 0) {

Confusing. You meant "if (time_left)" or "if (time_left > 0)"?

> +			drv_data->state = MV64XXX_I2C_STATE_IDLE;
> +			dev_err(&drv_data->adapter.dev,
> +				"mv64xxx: I2C bus locked\n");
> +		}

> +static struct i2c_algorithm mv64xxx_i2c_algo = {
> +	.name = MV64XXX_I2C_CTLR_NAME "algorithm",

MV64XXX_I2C_CTLR_NAME doesn't end with space. " algorithm" here.

> +static int __devinit
> +mv64xxx_i2c_probe(struct device *dev)

> +	strncpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME "adapter",
> +		I2C_NAME_SIZE);

And " adapter" there.

> +		dev_err(dev, "mv64xxx: Can't register intr handler "
> +			"irq: %d\\n", drv_data->irq);

You snipped s# \\n # \n # suggestion in my previous email. ;-)

> --- a/include/linux/mv643xx.h
> +++ b/include/linux/mv643xx.h

> +#define MV64XXX_I2C_CTLR_NAME				"mv64xxx i2c"

	Alexey
