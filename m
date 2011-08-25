From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 25 Aug 2011 14:06:30 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <20110825140630.GB8684@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
 <CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
In-Reply-To: <CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
> On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
> >> On chip temperature sensor driver. The driver monitors the temperature of
> >> the MPU subsystem of the OMAP4. It sends notifications to the user space if
> >> the temperature crosses user defined thresholds via kobject_uevent interface.
> >> The user is allowed to configure the temperature thresholds vis sysfs nodes
> >> exposed using hwmon interface.
> >>
> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> Cc: Jean Delvare <khali@linux-fr.org>
> >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> >> Cc: lm-sensors@lm-sensors.org
> >
> > Partial review only. Too many concerns, and after a while I tend to loose track.
> >
> >> ---
> >>  Documentation/hwmon/omap_temp_sensor |   27 +
> >>  drivers/hwmon/Kconfig                |   11 +
> >>  drivers/hwmon/Makefile               |    1 +
> >>  drivers/hwmon/omap_temp_sensor.c     |  933 ++++++++++++++++++++++++++++++++++
> >>  4 files changed, 972 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/hwmon/omap_temp_sensor
> >>  create mode 100644 drivers/hwmon/omap_temp_sensor.c
> >>

[ ... ]

> >> +/* Sysfs hook functions */
> >> +
> >> +static ssize_t show_temp_max(struct device *dev,
> >> +                       struct device_attribute *devattr, char *buf)
> >> +{
> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> +       int temp;
> >> +
> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_threshold);
> >> +       temp = (temp & temp_sensor->registers->threshold_thot_mask)
> >> +                       >> __ffs(temp_sensor->registers->threshold_thot_mask);
> >> +
> >> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> >> +               dev_err(dev, "invalid value\n");
> >> +               return -EDOM;
> >
> > Please don't use EDOM, and drop the error message.
> 
> The temperature is out of range. Should i use EIO?
> 
It is out of range, but not due to a math error, but due to a bad reading from the chip
or due to a chip failure. EIO is ok.

> >
> >> +       }
> >> +
> >> +       temp = adc_to_temp_conversion(temp);
> >> +
> >> +       return snprintf(buf, 16, "%d\n", temp);
> >> +}
> >> +
> >> +static ssize_t set_temp_max(struct device *dev,
> >> +                           struct device_attribute *devattr,
> >> +                           const char *buf, size_t count)
> >> +{
> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> +       long                    val;
> >> +       u32                     reg_val, t_cold, t_hot, temp;
> >> +
> >> +       if (strict_strtol(buf, 10, &val)) {
> >> +               count = -EINVAL;
> >> +               goto out;
> >
> > This will try to release the not-acquired lock.
> 
> I will correct this.
> 
> >
> >> +       }
> >> +
> >> +       t_hot = temp_to_adc_conversion(val);
> >
> > Bad error return check. Negative on error. Should be
> >        if (t_hot < 0)
> >                return t_hot;
> 
> Ok.
> 
> >
> >> +       if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_VALUE)) {
> >
> > Unnecessary (( ))
> 
> This check is unnecessary with the negative check. I will remove.
> 
> >
> >> +               count = -EINVAL;
> >> +               goto out;
> >
> > This will try to release the not-acquired lock.
> 
> I will correct this.
> 
> >
> >> +       }
> >> +
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> +       /* obtain the T cold value */
> >> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_threshold);
> >> +       t_cold = (t_cold & temp_sensor->registers->threshold_tcold_mask) >>
> >> +                       __ffs(temp_sensor->registers->threshold_tcold_mask);
> >> +
> >> +       if (t_hot < t_cold) {
> >> +               count = -EINVAL;
> >> +               goto out;
> >
> > Context specific limitations like this one are not a good idea, since it assumes an order of changing max
> > and max_hysteresis which is not necessarily guaranteed by the application making the change, nor is a
> > change order order well defined or even possible. Applications should not have to bother about this.
> 
> The hardware behavior is like this. As long as the temperature is below
> t_hot no interrupts are fired. Once the temperature increases above
> t_hot we get an
> interrupt. In order to avoid repeated interrupts we mask the t_hot interrupt
> in the interrupt handler and enable the t_cold interrupts. So we get a t_cold
> interrupt only when the temperature drops below the t_cold value. Hence
> setting the t_cold higher than t_hot will mess up the state machine.
> 
> t_hot value should be greater than t_cold value.
> 
One option would be to update t_cold (max_hyst) automatically in that case.

Problem here is that you expect the aplication to know, depending on the current 
values of (max, max_hyst), how to update both limits in order. That is not a reasonable
expectation.

> >
> >> +       }
> >> +
> >> +       /* write the new t_hot value */
> >> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_threshold);
> >> +       reg_val &= ~temp_sensor->registers->threshold_thot_mask;
> >> +       reg_val |= (t_hot <<
> >> +                       __ffs(temp_sensor->registers->threshold_thot_mask));
> >> +       omap_temp_sensor_writel(temp_sensor, reg_val,
> >> +                       temp_sensor->registers->bgap_threshold);
> >> +
> >> +       /* Read the current temperature */
> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->temp_sensor_ctrl);
> >> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> >> +
> >> +       /*
> >> +        * If user sets the HIGH threshold(t_hot) greater than the current
> >> +        * temperature(temp) unmask the HOT interrupts
> >> +        */
> >> +       if (t_hot > temp) {
> >> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> +               reg_val &= ~temp_sensor->registers->mask_cold_mask;
> >> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> >> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> +       }
> >> +
> >> +       /*
> >> +        * If current temperature is in-between the hot and cold thresholds,
> >> +        * Enable both masks.
> >> +        */
> >> +       if (temp > t_cold && temp < t_hot) {
> >> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> >> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> >> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> >> +                               OMAP4460_BGAP_CTRL_OFFSET);
> >
> > Why use OMAP4460_BGAP_CTRL_OFFSET here but bgap_mask_ctrl elsewhere ?
> 
> Ok. I will change this.
> 
> >
> >> +       }
> >> +       /*
> >> +        * else no need to do anything since HW will immediately compare
> >> +        * the new threshold and generate interrupt accordingly
> >> +        */
> >> +out:
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >> +       return count;
> >> +}
> >> +
> >> +static ssize_t show_temp_max_hyst(struct device *dev,
> >> +               struct device_attribute *devattr, char *buf)
> >> +{
> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> +       u32                     temp;
> >> +
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >
> > This lock would only make sense if threshold_tcold_mask can change, and if that change
> > would be protected by the mutex. I don't see that to be the case, thus the lock is unnecessary.
> > Besides, the code in show_temp_max() is almost the same and does not use the lock.
> 
> The masks are getting changed in show_temp_max() show_temp_max_hyst() and the
> ISR function. It is better to protect with mutex. I will add that in
> required places.
> 
Reeally ? I seem to be blind. I searched for threshold_tcold_mask in the patch but
did not see where it is changed. Can you point me to the code ?

If it is changed outside the driver, you have a real problem, since there is no guarantee
that the mask is not changed from outside the driver, by code not protected by the mutex.
And if read functions have the side effect of changing such values, there should really
be a note somewhere to make people aware of it. I'd call that side effect programming,
and would argue it is a really bad idea.

> >
> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> +               temp_sensor->registers->bgap_threshold);
> >> +       temp = (temp & temp_sensor->registers->threshold_tcold_mask) >>
> >> +               __ffs(temp_sensor->registers->threshold_tcold_mask);
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> >> +               dev_err(dev, "invalid value\n");
> >> +               return -EDOM;
> >
> > "Math argument out of domain of func" does not make sense.
> > Unless you don't know anything better, use EIO (I/O Error). Not very specific,
> > but at least not misleading.
> 
> Out of range i assumed this was the closest error value. I will use EIO.
> 
It is not a math error, though.

> >
> > Besides, the log message is unnecessary. The user is informed with -EIO, and the admin
> > won't be able to do anything useful with "invalid value".
> 
> Ok. I will return -EIO and eliminate the log message.
> 
> >
> >> +       }
> >> +
> >> +       temp = adc_to_temp_conversion(temp);
> >> +
> >> +       return snprintf(buf, 16, "%d\n", temp);
> >> +}
> >> +
> >> +static ssize_t set_temp_max_hyst(struct device *dev,
> >> +                                struct device_attribute *devattr,
> >> +                                const char *buf, size_t count)
> >> +{
> >> +       struct omap_temp_sensor         *temp_sensor = dev_get_drvdata(dev);
> >> +       u32                             reg_val, t_hot, t_cold, temp;
> >> +       long                            val;
> >> +
> >> +       if (strict_strtol(buf, 10, &val)) {
> >> +               count = -EINVAL;
> >> +               goto out;
> >
> > This will try to release the not acquired lock.
> 
> I will correct this.
> 
> >
> >> +       }
> >> +
> >> +       t_cold = temp_to_adc_conversion(val);
> >
> > Bad error return check; same as above.
> 
> Ok. I will correct this.
> 
> >
> >> +       if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_ADC_END_VALUE) {
> >> +               count = -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> +       /* obtain the T HOT value */
> >> +       t_hot = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_threshold);
> >> +       t_hot = (t_hot & temp_sensor->registers->threshold_thot_mask) >>
> >> +                       __ffs(temp_sensor->registers->threshold_thot_mask);
> >> +
> >> +       if (t_cold > t_hot) {
> >
> > Same concern as above. Change order is left to application which should not be bothered.
> >
> >> +               count = -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       /* write the new t_cold value */
> >> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_threshold);
> >> +       reg_val &= ~temp_sensor->registers->threshold_tcold_mask;
> >> +       reg_val |= t_cold <<
> >> +                       __ffs(temp_sensor->registers->threshold_tcold_mask);
> >> +       omap_temp_sensor_writel(temp_sensor, reg_val,
> >> +                       temp_sensor->registers->bgap_threshold);
> >> +
> >> +       /* Read the current temperature */
> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> +               temp_sensor->registers->temp_sensor_ctrl);
> >> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> >> +
> >> +       /*
> >> +        * If user sets the LOW threshold(t_cold) lower than the current
> >> +        * temperature(temp) unmask the COLD interrupts
> >> +        */
> >> +       if (t_cold < temp) {
> >> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> +               reg_val &= ~temp_sensor->registers->mask_hot_mask;
> >> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> >> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> >> +                       temp_sensor->registers->bgap_mask_ctrl);
> >> +       }
> >> +
> >> +       /*
> >> +        * If current temperature is in-between the hot and cold thresholds,
> >> +        * Enable both masks.
> >> +        */
> >> +       if (temp < t_hot && temp > t_cold) {
> >> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> >> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> >> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> +       }
> >> +
> >> +       /*
> >> +        * else no need to do anything since HW will immediately compare
> >> +        * the new threshold and generate interrupt accordingly
> >> +        */
> >
> > Would be nice if you could unify the interrupt enable code in a single function.
> 
> Ok. I will have a function for this.
> 
> >
> >> +
> >> +out:
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >> +       return count;
> >> +}
> >> +
> >> +static ssize_t show_update_rate(struct device *dev,
> >> +                       struct device_attribute *devattr, char *buf)
> >> +{
> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> +       u32                     temp = 0, ret = 0;
> >> +
> > No need to initialize temp.
> > ret is u32, which doesn't seem to be a good type to use for negative values.
> 
> Oops yes. I will correct this.
> 
> >
> >> +
> >> +       if (!temp_sensor->clk_rate) {
> >> +               dev_err(dev, "clk_rate is NULL\n");
> >> +               ret = -EDOM;
> >
> > Same comment as above (this is not a math error). And you don't have to check clk_rate anyway,
> > since it is set in probe, and probe bails out if it is not set.
> 
> Ok
> 
> >
> >> +               goto out;
> >> +       }
> >> +
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >
> > As with other show locks, this one would only make sense if counter_mask can change during runtime,
> > and if that change would be protected by the mutex. This is not the case, thus the lock is unnecessary.
> 
> Counter value can be altered runtime. A lock is needed in both the cases.
> I will add it.
> 
clk_rate does not change, counter_mask does not change, and reading a single value
doesn't need a mutex. Am I missing something ?

> >
> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_counter);
> >> +       temp = (temp & temp_sensor->registers->counter_mask) >>
> >> +                       __ffs(temp_sensor->registers->counter_mask);
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +       temp = temp * 1000 / temp_sensor->clk_rate;
> >> +
> >> +out:
> >> +       if (!ret)
> >> +               return sprintf(buf, "%d\n", temp);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static ssize_t set_update_rate(struct device *dev,
> >> +                              struct device_attribute *devattr,
> >> +                              const char *buf, size_t count)
> >> +{
> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> +       u32                     reg_val;
> >> +       long                    val;
> >> +
> >> +       if (strict_strtol(buf, 10, &val)) {
> >> +               count = -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       val *= temp_sensor->clk_rate / 1000;
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_counter);
> >> +
> >> +       reg_val &= ~temp_sensor->registers->counter_mask;
> >> +       reg_val |= val;
> >
> > Sure you want to accept any value (including negative ones) here ?
> > val is not shifted, and not masked against counter_mask, meaning it can write
> > all bits of the register. That doesn't sound right.
> 
> I will have a check.
> 
> >
> > It would make sense to call omap_configure_temp_sensor_counter() instead of duplicating
> > the set functionality.
> 
> Yes I will make use of that.
> 
> >
> >> +       omap_temp_sensor_writel(temp_sensor, reg_val,
> >> +                       temp_sensor->registers->bgap_counter);
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >> +out:
> >> +       return count;
> >> +}
> >> +
> >> +static int omap_temp_sensor_read_temp(struct device *dev,
> >> +                                     struct device_attribute *devattr,
> >> +                                     char *buf)
> >> +{
> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> +       int                     temp, ret = 0;
> >> +
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >
> > Unless bgap_dtemp_mask can change during runtime, and that change is protected by the mutex,
> > this lock is unnecessary.
> 
> It is read only and is updated by hardware. Change cannot be protected by mutex.
> 
> >
> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> +               temp_sensor->registers->temp_sensor_ctrl);
> >> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> >> +
> >> +       /* look up for temperature in the table and return the temperature */
> >> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> >> +               dev_err(dev, "invalid adc code reported %d", temp);
> >> +               ret = -EDOM;
> >
> > Another wrong use of EDOM, and another value-free error message.
> 
> Ok. I will use -EIO and drop the error message.
> 
> >
> >> +               goto out;
> >> +       }
> >> +
> >> +       temp = adc_to_temp[temp - OMAP_ADC_START_VALUE];
> >> +
> >> +out:
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +       if (!ret)
> >> +               return sprintf(buf, "%d\n", temp);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_read_temp,
> >> +                         NULL, 0);
> >> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> >> +                         set_temp_max, 0);
> >> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_max_hyst,
> >> +                         set_temp_max_hyst, 0);
> >> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_update_rate,
> >> +                         set_update_rate, 0);
> >> +
> >
> > ABI is update_interval. Please use it.
> 
> Ok.
> 
> >
> >> +static struct attribute *omap_temp_sensor_attributes[] = {
> >> +       &sensor_dev_attr_temp1_input.dev_attr.attr,
> >> +       &sensor_dev_attr_temp1_max.dev_attr.attr,
> >> +       &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> >> +       &sensor_dev_attr_update_rate.dev_attr.attr,
> >> +       NULL
> >> +};
> >> +
> >> +static const struct attribute_group omap_temp_sensor_group = {
> >> +       .attrs = omap_temp_sensor_attributes,
> >> +};
> >> +
> >> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_sensor)
> >> +{
> >> +       u32 ret = 0;
> >> +
> >> +       if (temp_sensor->clk_on) {
> >> +               dev_err(temp_sensor->hwmon_dev, "clock already on\n");
> >> +               goto out;
> >> +       }
> >> +
> >> +       ret = pm_runtime_get_sync(temp_sensor->hwmon_dev);
> >> +       if (ret < 0) {
> >> +               dev_err(temp_sensor->hwmon_dev, "get sync failed\n");
> >> +               goto out;
> >> +       }
> >> +
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> +       temp_sensor->clk_on = 1;
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >
> > Completely unnecessary lock.
> 
> Ok
> 
> >
> >> +out:
> >> +       return ret;
> >> +}
> >> +
> >> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *temp_sensor)
> >
> > Return code is not used anywhere, why bother providing one ?
> 
> It is not checked in the error path. I can make it void.
> 
> >
> >> +{
> >> +       u32 ret = 0;
> >> +
> >> +       if (!temp_sensor->clk_on) {
> >> +               dev_err(temp_sensor->hwmon_dev, "clock already off\n");
> >> +               goto out;
> >
> > ... and since you ignore the error anyway, why log it ?
> 
> Ok. I will remove the log message.
> 
> >
> >> +       }
> >> +
> >> +       /* Gate the clock */
> >> +       ret = pm_runtime_put_sync(temp_sensor->hwmon_dev);
> >> +       if (ret < 0) {
> >> +               dev_err(temp_sensor->hwmon_dev, "put sync failed\n");
> >> +               goto out;
> >> +       }
> >> +
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> +       temp_sensor->clk_on = 0;
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >
> > Completely unnecessary lock.
> 
> Ok
> 
> >
> >> +out:
> >> +       return ret;
> >> +}
> >> +
> >> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
> >> +{
> >> +       struct omap_temp_sensor         *temp_sensor;
> >> +       int                             t_hot, t_cold, temp;
> >> +
> >> +       temp_sensor = data;
> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> +
> >> +       /* Read the status of t_hot */
> >> +       t_hot = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_status)
> >> +                       & temp_sensor->registers->status_hot_mask;
> >> +
> >> +       /* Read the status of t_cold */
> >> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_status)
> >> +                       & temp_sensor->registers->status_cold_mask;
> >> +
> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_mask_ctrl);
> >> +       /*
> >> +        * One TALERT interrupt: Two sources
> >> +        * If the interrupt is due to t_hot then mask t_hot and
> >> +        * and unmask t_cold else mask t_cold and unmask t_hot
> >> +        */
> >> +       if (t_hot) {
> >> +               temp &= ~temp_sensor->registers->mask_hot_mask;
> >> +               temp |= temp_sensor->registers->mask_cold_mask;
> >> +       } else if (t_cold) {
> >> +               temp &= ~temp_sensor->registers->mask_cold_mask;
> >> +               temp |= temp_sensor->registers->mask_hot_mask;
> >> +       }
> >> +
> >> +       omap_temp_sensor_writel(temp_sensor, temp,
> >> +               temp_sensor->registers->bgap_mask_ctrl);
> >> +
> >> +       /* kobject_uvent to user space telling thermal threshold crossed */
> >> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_CHANGE);
> >> +
> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> +
> >> +       return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int __devinit omap_temp_sensor_probe(struct platform_device *pdev)
> >> +{
> >> +       struct omap_temp_sensor_pdata   *pdata  = pdev->dev.platform_data;
> >> +       struct omap_temp_sensor         *temp_sensor;
> >> +       struct resource                 *mem;
> >> +       int                             ret = 0;
> >> +       int                             val, clk_rate;
> >> +       u32                             max_freq, min_freq;
> >> +
> >> +       if (!pdata) {
> >> +               dev_err(&pdev->dev, "platform data missing\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       temp_sensor = kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
> >> +       if (!temp_sensor)
> >> +               return -ENOMEM;
> >> +
> >
> > You have error messages all over the place, Why not here ?
> 
> Ok. I will add an error message here.
> 
> >
> >> +       mutex_init(&temp_sensor->sensor_mutex);
> >> +
> >> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +       if (!mem) {
> >> +               dev_err(&pdev->dev, "no mem resource\n");
> >> +               ret = -ENOMEM;
> >> +               goto plat_res_err;
> >> +       }
> >> +
> >
> > If you try to get the resource before allocating the memory, you don't have to release
> > the memory if the platform resource is missing.
> 
> Ok. Here if i fail i am releasing temp_sensor memory which
> has been allocated.
> 
> >
> >> +       temp_sensor->irq = platform_get_irq_byname(pdev, "thermal_alert");
> >> +       if (temp_sensor->irq < 0) {
> >> +               dev_err(&pdev->dev, "get_irq_byname failed\n");
> >> +               ret = temp_sensor->irq;
> >> +               goto plat_res_err;
> >> +       }
> >> +
> >> +       temp_sensor->phy_base = ioremap(mem->start, resource_size(mem));
> >> +       temp_sensor->clock = NULL;
> >> +       temp_sensor->registers = pdata->registers;
> >> +       temp_sensor->hwmon_dev = &pdev->dev;
> >> +
> >> +       if (pdata->max_freq && pdata->min_freq) {
> >> +               max_freq = pdata->max_freq;
> >> +               min_freq = pdata->min_freq;
> >> +       } else {
> >> +               max_freq = MAX_FREQ;
> >> +               min_freq = MIN_FREQ;
> >> +       }
> >> +
> >> +       pm_runtime_enable(&pdev->dev);
> >> +       pm_runtime_irq_safe(&pdev->dev);
> >> +
> >> +       /*
> >> +        * check if the efuse has a non-zero value if not
> >> +        * it is an untrimmed sample and the temperatures
> >> +        * may not be accurate
> >> +        */
> >> +
> >> +       if (omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->bgap_efuse)) {
> >> +               temp_sensor->is_efuse_valid = 1;
> >
> > is_efuse_valid is not used anywhere. Might as well drop it.
> 
> Ok
> 
> >
> >> +               dev_dbg(temp_sensor->hwmon_dev,
> >> +                       "Invalid EFUSE, Non-trimmed BGAP, Temp not accurate\n");
> >
> > dev_info might be better here.
> 
> Ok.
> 
> >
> >> +       }
> >> +
> >> +       dev_set_drvdata(&pdev->dev, temp_sensor);
> >> +       temp_sensor->clock = clk_get(temp_sensor->hwmon_dev, "fck");
> >> +       if (IS_ERR(temp_sensor->clock)) {
> >> +               ret = PTR_ERR(temp_sensor->clock);
> >> +               dev_err(temp_sensor->hwmon_dev,
> >> +                       "unable to get fclk: %d\n", ret);
> >> +               goto plat_res_err;
> >> +       }
> >> +
> >> +       ret = omap_temp_sensor_clk_enable(temp_sensor);
> >> +       if (ret) {
> >> +               dev_err(&pdev->dev, "Cannot enable temp sensor\n");
> >
> > omap_temp_sensor_clk_enable() already generates error messages.
> 
> Ok. I will remove this.
> 
> >
> >> +               goto clken_err;
> >> +       }
> >> +
> >> +       clk_rate = clk_round_rate(temp_sensor->clock, max_freq);
> >> +       if (clk_rate < min_freq || clk_rate = 0xffffffff) {
> >> +               dev_err(&pdev->dev, "Error round rate\n");
> >> +               ret = -EDOM;
> >
> > EDOM is wrong. Please use ENODEV.
> 
> Ok
> 
> >
> > The error log doesn't really provide anything useful to the administrator.
> > Either add parameters, or drop it.
> 
> Ok
> 
> >
> >> +               goto clken_err;
> >> +       }
> >> +
> >> +       ret = clk_set_rate(temp_sensor->clock, clk_rate);
> >> +       if (ret) {
> >> +               dev_err(&pdev->dev, "Cannot set clock rate\n");
> >> +               goto clken_err;
> >> +       }
> >> +
> >> +       temp_sensor->clk_rate = clk_rate;
> >> +       omap_enable_continuous_mode(temp_sensor, 1);
> >> +       omap_configure_temp_sensor_thresholds(temp_sensor);
> >> +       /* 1 ms */
> >> +       omap_configure_temp_sensor_counter(temp_sensor, 1);
> >
> > If temp_sensor->clk_rate * 2 is two seconds, as suggested below, 1 is not 1ms.
> > 1ms would be temp_sensor->clk_rate / 1000.
> 
> Yes! Wrong comment. It is configured to start the temperature conversion.
> It represents 1 clock cycle of the temperature sensor fclk. I will correct this.
> 
> >
> >> +
> >> +       /* Wait till the first conversion is done wait for at least 1ms */
> >> +       usleep_range(1000, 2000);
> >> +
> >> +       /* Read the temperature once due to hw issue*/
> >> +       omap_temp_sensor_readl(temp_sensor,
> >> +                       temp_sensor->registers->temp_sensor_ctrl);
> >> +
> >> +       /* Set 2 seconds time as default counter */
> >> +       omap_configure_temp_sensor_counter(temp_sensor,
> >> +                                               temp_sensor->clk_rate * 2);
> >> +
> >> +       temp_sensor->hwmon_dev = hwmon_device_register(&pdev->dev);
> >> +       if (IS_ERR(temp_sensor->hwmon_dev)) {
> >> +               dev_err(&pdev->dev, "hwmon_device_register failed.\n");
> >> +               ret = PTR_ERR(temp_sensor->hwmon_dev);
> >> +               goto hwmon_reg_err;
> >> +       }
> >> +
> >> +       ret = sysfs_create_group(&pdev->dev.kobj,
> >> +                              &omap_temp_sensor_group);
> >
> > one line is sufficient here.
> 
> Ok.
> 
> >
> >> +       if (ret) {
> >> +               dev_err(&pdev->dev, "could not create sysfs files\n");
> >> +               goto sysfs_create_err;
> >> +       }
> >> +
> >> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
> >> +
> >
> > No other hwmon driver needs this. Doesn't the sysfs code take care of this ?
> 
> Yes i will remove this.
> 
> >
> >> +       ret = request_threaded_irq(temp_sensor->irq, NULL,
> >> +               omap_talert_irq_handler, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> >> +                       "temp_sensor", temp_sensor);
> >> +       if (ret) {
> >> +               dev_err(&pdev->dev, "Request threaded irq failed.\n");
> >> +               goto req_irq_err;
> >> +       }
> >> +
> >> +       /* unmask the T_COLD and unmask T_HOT at init */
> >> +       val = omap_temp_sensor_readl(temp_sensor,
> >> +               temp_sensor->registers->bgap_mask_ctrl);
> >> +       val |= temp_sensor->registers->mask_cold_mask
> >> +               | temp_sensor->registers->mask_hot_mask;
> >> +
> >> +       omap_temp_sensor_writel(temp_sensor, val,
> >> +               temp_sensor->registers->bgap_mask_ctrl);
> >> +
> > This is racy. From Documentation/hwmon/submitting-patches:
> 
> I read it. If i enable the interrupts before i have the sysfs
> infrastructure ready.
> I am likely to miss out on the uevent notification if the interrupt
> occurs as soon as
> i unmask. Correct me if my understanding is wrong.
> 
See other email on sequence subject. I'll have to look into it in more detail.
later - no time right now ...

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
