From: akpm@osdl.org (Andrew Morton)
Date: Thu, 03 Aug 2006 07:36:55 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060803003655.e79ee54f.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2 Aug 2006 21:15:20 +0200
Michael Hanselmann <linux-kernel at hansmi.ch> wrote:

> This driver adds support for the Apple Motion Sensor (AMS) as found in
> 2005 revisions of Apple PowerBooks and iBooks. It implements both the
> PMU and I?C variants. The I?C driver and mouse emulation is based on
> code by Stelian Pop <stelian at popies.net>, while the PMU driver has been
> developped by myself. HD parking support will be added later.
> 
> ...
>
> +/* There is only one motion sensor per machine */
> +struct ams ams;

That's a somewhat risky name for a global variable.

Then again, nobody else is likely to be so bold as to add another
three-character global ;)

> +/* Call with lock held! */
> +int ams_sensor_attach(void)

Which lock?

> +static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
> +{
> +	s32 result;
> +	int i;
> +
> +	ams_i2c_write(AMS_COMMAND, cmd);
> +	for (i = 0; i < 10; i++) {
> +		mdelay(5);
> +		result = ams_i2c_read(AMS_COMMAND);
> +		if (result = 0 || result & 0x80)
> +			return 0;
> +	}
> +	return -1;
> +}

That's a potentially very long busy wait.

> +static void ams_i2c_set_irq(enum ams_irq reg, char enable)
> +{
> +	if (reg & AMS_IRQ_FREEFALL) {
> +		u8 val = ams_i2c_read(AMS_CTRLX);
> +		if (enable)     val |= 0x80;
> +		else            val &= ~0x80;
> +		ams_i2c_write(AMS_CTRLX, val);
> +	}
> +
> +	if (reg & AMS_IRQ_SHOCK) {
> +		u8 val = ams_i2c_read(AMS_CTRLY);
> +		if (enable)     val |= 0x80;
> +		else            val &= ~0x80;
> +		ams_i2c_write(AMS_CTRLY, val);
> +	}
> +
> +	if (reg & AMS_IRQ_GLOBAL) {
> +		u8 val = ams_i2c_read(AMS_CTRLZ);
> +		if (enable)     val |= 0x80;
> +		else            val &= ~0x80;
> +		ams_i2c_write(AMS_CTRLZ, val);
> +	}
> +}

Please, let's use

	if (a)
		b;
	else
		c;

> +/* Call with lock held! */
> +static void ams_mouse_enable(void)

Which lock?

> +{
> +	s8 x, y, z;
> +
> +	if (ams.idev)
> +		return;
> +
> +	ams_sensors(&x, &y, &z);
> +	ams.xcalib = x;
> +	ams.ycalib = y;
> +	ams.zcalib = z;
> +
> +	ams.idev = input_allocate_device();
> +	if (!ams.idev)
> +		return;
> +
> +	ams.idev->name = "Apple Motion Sensor";
> +	ams.idev->id.bustype = ams.bustype;
> +	ams.idev->id.vendor = 0;
> +	ams.idev->cdev.dev = &ams.of_dev->dev;
> +
> +	input_set_abs_params(ams.idev, ABS_X, -50, 50, 3, 0);
> +	input_set_abs_params(ams.idev, ABS_Y, -50, 50, 3, 0);
> +	input_set_abs_params(ams.idev, ABS_Z, -50, 50, 3, 0);
> +
> +	set_bit(EV_ABS, ams.idev->evbit);
> +	set_bit(EV_KEY, ams.idev->evbit);
> +
> +	if (input_register_device(ams.idev)) {
> +		input_free_device(ams.idev);
> +		ams.idev = NULL;
> +		return;
> +	}
> +
> +	ams.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
> +	if (IS_ERR(ams.kthread)) {
> +		input_unregister_device(ams.idev);
> +		ams.idev = NULL;
> +		return;

Didn't we just leak ams.idev?  Or does the disconnect handler handle that?

<goes to input_unregister_device() for the API description, comes away
discouraged>

> +		ams.idev = NULL;
> +	}
> +}
> +
> +static ssize_t ams_mouse_show_mouse(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", mouse);
> +}
> +
> +static ssize_t ams_mouse_store_mouse(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	if (sscanf(buf, "%d\n", &mouse) != 1)
> +		return -EINVAL;
> +
> +	mouse = !!mouse;

That statement isn't needed.

> +	mutex_lock(&ams.lock);
> +
> +	if (mouse)
> +		ams_mouse_enable();
> +	else
> +		ams_mouse_disable();
> +
> +	mutex_unlock(&ams.lock);
> +
> +	return count;
> +}
>
> ...
>
> +/* Enables or disables the specified interrupts */
> +static void ams_pmu_set_irq(enum ams_irq reg, char enable)
> +{
> +	if (reg & AMS_IRQ_FREEFALL) {
> +		u8 val = ams_pmu_get_register(AMS_FF_ENABLE);
> +		if (enable)	val |= 0x80;
> +		else		val &= ~0x80;
> +		ams_pmu_set_register(AMS_FF_ENABLE, val);
> +	}
> +
> +	if (reg & AMS_IRQ_SHOCK) {
> +		u8 val = ams_pmu_get_register(AMS_SHOCK_ENABLE);
> +		if (enable)	val |= 0x80;
> +		else		val &= ~0x80;
> +		ams_pmu_set_register(AMS_SHOCK_ENABLE, val);
> +	}
> +
> +	if (reg & AMS_IRQ_GLOBAL) {
> +		u8 val = ams_pmu_get_register(AMS_CONTROL);
> +		if (enable)	val |= 0x80;
> +		else		val &= ~0x80;
> +		ams_pmu_set_register(AMS_CONTROL, val);
> +	}
> +}

Again - coding style is wrong.

> +/* Call with lock held! */
> +int __init ams_pmu_init(struct device_node *np)

Which lock??

> +{
> +	u32 *prop;
> +	int result;
> +
> +	mutex_lock(&ams.lock);

Obviously not that one...



