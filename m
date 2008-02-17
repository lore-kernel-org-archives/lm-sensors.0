From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 17 Feb 2008 20:02:50 +0000
Subject: Re: [lm-sensors] [PATCH] adt7473: New driver for Analog
Message-Id: <20080217200250.GD2916@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071219034116.GM6870@tree.beaverton.ibm.com> <20071219154759.7be5025c@hyperion.delvare> <20071219231437.GR6870@tree.beaverton.ibm.com>
In-Reply-To: <20071219231437.GR6870@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Darrick:

Sorry this took forever for me to review.  Just a few little things...

* Darrick J. Wong <djwong@us.ibm.com> [2007-12-19 15:14:38 -0800]:
> This driver also had that funny alarm1/alarm2 thing; here's a revision
> of yesterday's patch with that straightened out.
> ---
> This driver reports voltage, temperature and fan sensor readings
> on an ADT7473 chip.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/hwmon/Kconfig   |   10 
>  drivers/hwmon/Makefile  |    1 
>  drivers/hwmon/adt7473.c | 1161 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1172 insertions(+), 0 deletions(-)
> 

Documentation/hwmon/adt7473 would be nice.

> new file mode 100644
> index 0000000..5528d5c
> --- /dev/null
> +++ b/drivers/hwmon/adt7473.c
> @@ -0,0 +1,1161 @@

(snip)

> +/*
> + * On this chip, voltages are given as a count of steps between a minimum
> + * and maximum voltage, not a direct voltage.
> + */
> +static int volt_convert_table[][2] = {
> +	{2997, 3},
> +	{4395, 4},
> +};

That should be const.

(snip)

> +static ssize_t show_pwm_auto_temp(struct device *dev,
> +				  struct device_attribute *devattr,
> +				  char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7473_data *data = adt7473_update_device(dev);
> +	int bhvr = data->pwm_behavior[attr->index] >> ADT7473_PWM_BHVR_SHIFT;
> +
> +	switch (bhvr) {
> +	case 3:
> +	case 4:
> +	case 7:
> +		return sprintf(buf, "0\n");
> +	case 0:
> +	case 1:
> +	case 5:
> +	case 6:
> +		return sprintf(buf, "%d\n", bhvr + 1);
> +	case 2:
> +		return sprintf(buf, "4\n");
> +	}
> +	BUG();

Given ADT7473_PWM_BHVR_SHIFT is 5, this BUG() is obviously impossible.
But I guess it's not obvious to GCC.

(snip)

> +static int adt7473_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	/*
> +	 * Some NVIDIA cards have an adt7473 attached to the on-board
> +	 * i2c controller, but the i2c adapter driver in the binary
> +	 * nvidia superblob driver sets class to 0.
> +	 */
> +	if (!(adapter->class & I2C_CLASS_HWMON) && adapter->class)
> +		return 0;

NACK on that comment and associated code:  Jean Delvare submitted a
patch to NVIDIA over two years ago to fix their bug.  Apparently some
distros even carry his patch.  So, I don't want to encourage such a
hack to persist.  Please just do the standard check here.

> +	return i2c_probe(adapter, &addr_data, adt7473_detect);
> +}

(snip)

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
