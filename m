From: Alex Riesen <raa.lkml@gmail.com>
Date: Thu, 13 Aug 2009 19:14:12 +0000
Subject: Re: [lm-sensors] Intel Moorestown Analog Accelerometer driver
Message-Id: <20090813191412.GA13354@blimp.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <c632a690908130147j55df80fbmc96b5bec6f9927b4@mail.gmail.com>
In-Reply-To: <c632a690908130147j55df80fbmc96b5bec6f9927b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ramesh Agarwal says:
> +The accelerometer operates in the polling mode. This is to say that sampling
> +by the driver will be done only if a user application has requested for the
> +values.  The driver does not  register as an input device, and hence input
> +calibration and fixing the sampling rate is left to the user level
> +framework/application. The sysfs interface only provides the decimal values
> +of the voltage read from the ADC where each bit is equivalent to 2mV.
...
> +/* PMIC ADC INTERRUPT REGISTERS */
> +#define PMIC_ADC_ACC_REG_ADCINT		0x5F	/*ADC interrupt register */

Does the accelerometer itself actually provide an interrupt for the
data? Can the interrupt be used?

The "ADC interrupt register" seem to hint at that.

Forcing people to poll for interactive data (and that seems to be a
very common use for accelerometers these days) is not very nice.

> +static unsigned int analog_accel_read(int offset)
> +{
> +	unsigned int ret_val;
> +	struct mrst_pmic_reg_data ipc_data;
> +
> +	ipc_data.ioc = 0;	/* No need to generate MSI */
> +	ipc_data.num_entries = 2;
> +	ipc_data.pmic_reg_data[0].register_address > +		PMIC_ADC_REG_HIGH(mrst_analog_reg_idx,
> +				offset); /* Higher 8 bits */
> +	ipc_data.pmic_reg_data[1].register_address > +		PMIC_ADC_REG_LOW(mrst_analog_reg_idx,
> +				offset); /* Lower 3 bits */
> +	if (mrst_pmic_ioread(&ipc_data) != 0) {
> +		printk(KERN_ERR
> +		"mrst_analog_accel:PMIC reg read using IPC failed\n");
> +		return -1;

You return -1 in a function returning unsigned?
And you don't handle the -1 anyway, so maybe a more useful value can
be returned (like one you'd return when there is no acceleration).
Or you can handle the error more sensibly, and return error (if it's
possible) from sysfs' _show().



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
