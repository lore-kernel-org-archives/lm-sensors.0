From: atull <atull@opensource.altera.com>
Date: Fri, 22 Aug 2014 15:30:58 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] pmbus: ltc2978: add regulator gating
Message-Id: <alpine.DEB.2.02.1408221026340.30084@atx-linux-37>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408659686-29106-1-git-send-email-atull@opensource.altera.com> <1408659686-29106-3-git-send-email-atull@opensource.altera.com> <20140822003650.GQ24407@sirena.org.uk>
In-Reply-To: <20140822003650.GQ24407@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: linux@roeck-us.net, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Fri, 22 Aug 2014, Mark Brown wrote:

> On Thu, Aug 21, 2014 at 05:21:26PM -0500, atull@opensource.altera.com wrote:
> 
> > +config SENSORS_LTC2978_REGULATOR
> > +	boolean "Regulator support for LTC2974, LTC2978, LTC3880, and LTC3883"
> > +	default n
> 
> No need to say default n here, it's the default default.
> 
> > +	depends on SENSORS_LTC2978
> > +	select REGULATOR
> 
> I'd expect a depends here.

Hi Mark,

Thanks for the review.  I'll fix these two Kconfig issues.

> 
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/machine.h>
> 
> If you need machine.h that's suspicious...  why do you need it?

It was to define 'struct regulator_init_data' which I had hardwired here 
as you noted below.  Will fix.

> 
> > +static int ltc2978_write_pmbus_operation(struct regulator_dev *rdev, u8 value)
> > +{
> > +	struct device *dev = rdev_get_dev(rdev);
> > +	struct i2c_client *client = to_i2c_client(dev->parent);
> > +	int ret;
> > +
> > +	ret = pmbus_set_page(client, 0xff);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return i2c_smbus_write_byte_data(client, PMBUS_OPERATION, value);
> > +}
> 
> This all looks very much like pmbus could use regmap and then the regmap
> helpers.  I'd not insist on it though.  What I would however suggest is
> that these functions should all be helpers which read the specific
> page, addresses and bits to write from the driver structure - I bet the
> code is going to be identical for most pmbus using regulators and so it
> makes sense to share it like we do with the generic regmap functions.
> 
> That means that any good practice can be deployed more easily and any
> API updates only need to update the helpers.
> 
> > +static struct regulator_init_data ltc2978_regulator_init = {
> > +	.constraints = {
> > +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > +	},
> > +};
> 
> You should not be forcing this on, you don't know what's safe on any
> given board.  Allow the board to specify constraints then it has
> control.
> 

Yes, this info should be from board info or device tree.  I'll fix this.

Thanks!

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
