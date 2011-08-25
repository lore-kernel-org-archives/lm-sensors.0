From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 25 Aug 2011 16:19:31 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <1314289171.2796.50.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
	 <CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	 <20110825140630.GB8684@ericsson.com>
	 <CAJ6a13Y0BERGmxSZR=H5h0+8z-UDUp0ZoUwdE+nH2KX7Li0c-Q@mail.gmail.com>
In-Reply-To: <CAJ6a13Y0BERGmxSZR=H5h0+8z-UDUp0ZoUwdE+nH2KX7Li0c-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, 2011-08-25 at 12:04 -0400, J, KEERTHY wrote:
> On Thu, Aug 25, 2011 at 7:36 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
> >> On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
> >> <guenter.roeck@ericsson.com> wrote:
> >> > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
> >> >> On chip temperature sensor driver. The driver monitors the temperature of
> >> >> the MPU subsystem of the OMAP4. It sends notifications to the user space if
> >> >> the temperature crosses user defined thresholds via kobject_uevent interface.
> >> >> The user is allowed to configure the temperature thresholds vis sysfs nodes
> >> >> exposed using hwmon interface.
> >> >>
> >> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> >> Cc: Jean Delvare <khali@linux-fr.org>
> >> >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> >> >> Cc: lm-sensors@lm-sensors.org
> >> >
> >> > Partial review only. Too many concerns, and after a while I tend to loose track.
> >> >
> >> >> ---
> >> >>  Documentation/hwmon/omap_temp_sensor |   27 +
> >> >>  drivers/hwmon/Kconfig                |   11 +
> >> >>  drivers/hwmon/Makefile               |    1 +
> >> >>  drivers/hwmon/omap_temp_sensor.c     |  933 ++++++++++++++++++++++++++++++++++
> >> >>  4 files changed, 972 insertions(+), 0 deletions(-)
> >> >>  create mode 100644 Documentation/hwmon/omap_temp_sensor
> >> >>  create mode 100644 drivers/hwmon/omap_temp_sensor.c
> >> >>
> >
> > [ ... ]
> >
> >> >> +/* Sysfs hook functions */
> >> >> +
> >> >> +static ssize_t show_temp_max(struct device *dev,
> >> >> +                       struct device_attribute *devattr, char *buf)
> >> >> +{
> >> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> >> +       int temp;
> >> >> +
> >> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> >> +                       temp_sensor->registers->bgap_threshold);
> >> >> +       temp = (temp & temp_sensor->registers->threshold_thot_mask)
> >> >> +                       >> __ffs(temp_sensor->registers->threshold_thot_mask);
> >> >> +
> >> >> +       if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE) {
> >> >> +               dev_err(dev, "invalid value\n");
> >> >> +               return -EDOM;
> >> >
> >> > Please don't use EDOM, and drop the error message.
> >>
> >> The temperature is out of range. Should i use EIO?
> >>
> > It is out of range, but not due to a math error, but due to a bad reading from the chip
> > or due to a chip failure. EIO is ok.
> 
> Ok
> 
> >
> >> >
> >> >> +       }
> >> >> +
> >> >> +       temp = adc_to_temp_conversion(temp);
> >> >> +
> >> >> +       return snprintf(buf, 16, "%d\n", temp);
> >> >> +}
> >> >> +
> >> >> +static ssize_t set_temp_max(struct device *dev,
> >> >> +                           struct device_attribute *devattr,
> >> >> +                           const char *buf, size_t count)
> >> >> +{
> >> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> >> +       long                    val;
> >> >> +       u32                     reg_val, t_cold, t_hot, temp;
> >> >> +
> >> >> +       if (strict_strtol(buf, 10, &val)) {
> >> >> +               count = -EINVAL;
> >> >> +               goto out;
> >> >
> >> > This will try to release the not-acquired lock.
> >>
> >> I will correct this.
> >>
> >> >
> >> >> +       }
> >> >> +
> >> >> +       t_hot = temp_to_adc_conversion(val);
> >> >
> >> > Bad error return check. Negative on error. Should be
> >> >        if (t_hot < 0)
> >> >                return t_hot;
> >>
> >> Ok.
> >>
> >> >
> >> >> +       if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_END_VALUE)) {
> >> >
> >> > Unnecessary (( ))
> >>
> >> This check is unnecessary with the negative check. I will remove.
> >>
> >> >
> >> >> +               count = -EINVAL;
> >> >> +               goto out;
> >> >
> >> > This will try to release the not-acquired lock.
> >>
> >> I will correct this.
> >>
> >> >
> >> >> +       }
> >> >> +
> >> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> >> +       /* obtain the T cold value */
> >> >> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> >> >> +                       temp_sensor->registers->bgap_threshold);
> >> >> +       t_cold = (t_cold & temp_sensor->registers->threshold_tcold_mask) >>
> >> >> +                       __ffs(temp_sensor->registers->threshold_tcold_mask);
> >> >> +
> >> >> +       if (t_hot < t_cold) {
> >> >> +               count = -EINVAL;
> >> >> +               goto out;
> >> >
> >> > Context specific limitations like this one are not a good idea, since it assumes an order of changing max
> >> > and max_hysteresis which is not necessarily guaranteed by the application making the change, nor is a
> >> > change order order well defined or even possible. Applications should not have to bother about this.
> >>
> >> The hardware behavior is like this. As long as the temperature is below
> >> t_hot no interrupts are fired. Once the temperature increases above
> >> t_hot we get an
> >> interrupt. In order to avoid repeated interrupts we mask the t_hot interrupt
> >> in the interrupt handler and enable the t_cold interrupts. So we get a t_cold
> >> interrupt only when the temperature drops below the t_cold value. Hence
> >> setting the t_cold higher than t_hot will mess up the state machine.
> >>
> >> t_hot value should be greater than t_cold value.
> >>
> > One option would be to update t_cold (max_hyst) automatically in that case.
> 
> updating the t_cold without application's knowledge?
> 
Why not ? Other drivers do the same. Happens all the time. Better than
returning an error and leaving the application wondering what is wrong.

> >
> > Problem here is that you expect the aplication to know, depending on the current
> > values of (max, max_hyst), how to update both limits in order. That is not a reasonable
> > expectation.
> 
> The thermal application which is configuring the thresholds must be
> intelligent enough to configure the thresholds in the right order. Configuring
> the thresholds wrongly and missing the interrupt may even result in burning
> the chip.
> 

Applications are generic, and _can not_ be expected to know chip
specific requirements such as order of initialization. What is needed
for your chip may be completely different for another chip, so you have
to make sure that _your driver_ prevents critical situations from
happening. You can not blame applications for not knowing the oddities
of your chips.

> >
> >> >
> >> >> +       }
> >> >> +
> >> >> +       /* write the new t_hot value */
> >> >> +       reg_val = omap_temp_sensor_readl(temp_sensor,
> >> >> +                       temp_sensor->registers->bgap_threshold);
> >> >> +       reg_val &= ~temp_sensor->registers->threshold_thot_mask;
> >> >> +       reg_val |= (t_hot <<
> >> >> +                       __ffs(temp_sensor->registers->threshold_thot_mask));
> >> >> +       omap_temp_sensor_writel(temp_sensor, reg_val,
> >> >> +                       temp_sensor->registers->bgap_threshold);
> >> >> +
> >> >> +       /* Read the current temperature */
> >> >> +       temp = omap_temp_sensor_readl(temp_sensor,
> >> >> +                       temp_sensor->registers->temp_sensor_ctrl);
> >> >> +       temp &= temp_sensor->registers->bgap_dtemp_mask;
> >> >> +
> >> >> +       /*
> >> >> +        * If user sets the HIGH threshold(t_hot) greater than the current
> >> >> +        * temperature(temp) unmask the HOT interrupts
> >> >> +        */
> >> >> +       if (t_hot > temp) {
> >> >> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> >> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> >> +               reg_val &= ~temp_sensor->registers->mask_cold_mask;
> >> >> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> >> >> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> >> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> >> +       }
> >> >> +
> >> >> +       /*
> >> >> +        * If current temperature is in-between the hot and cold thresholds,
> >> >> +        * Enable both masks.
> >> >> +        */
> >> >> +       if (temp > t_cold && temp < t_hot) {
> >> >> +               reg_val = omap_temp_sensor_readl(temp_sensor,
> >> >> +                               temp_sensor->registers->bgap_mask_ctrl);
> >> >> +               reg_val |= temp_sensor->registers->mask_cold_mask;
> >> >> +               reg_val |= temp_sensor->registers->mask_hot_mask;
> >> >> +               omap_temp_sensor_writel(temp_sensor, reg_val,
> >> >> +                               OMAP4460_BGAP_CTRL_OFFSET);
> >> >
> >> > Why use OMAP4460_BGAP_CTRL_OFFSET here but bgap_mask_ctrl elsewhere ?
> >>
> >> Ok. I will change this.
> >>
> >> >
> >> >> +       }
> >> >> +       /*
> >> >> +        * else no need to do anything since HW will immediately compare
> >> >> +        * the new threshold and generate interrupt accordingly
> >> >> +        */
> >> >> +out:
> >> >> +       mutex_unlock(&temp_sensor->sensor_mutex);
> >> >> +
> >> >> +       return count;
> >> >> +}
> >> >> +
> >> >> +static ssize_t show_temp_max_hyst(struct device *dev,
> >> >> +               struct device_attribute *devattr, char *buf)
> >> >> +{
> >> >> +       struct omap_temp_sensor *temp_sensor = dev_get_drvdata(dev);
> >> >> +       u32                     temp;
> >> >> +
> >> >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> >
> >> > This lock would only make sense if threshold_tcold_mask can change, and if that change
> >> > would be protected by the mutex. I don't see that to be the case, thus the lock is unnecessary.
> >> > Besides, the code in show_temp_max() is almost the same and does not use the lock.
> >>
> >> The masks are getting changed in show_temp_max() show_temp_max_hyst() and the
> >> ISR function. It is better to protect with mutex. I will add that in
> >> required places.
> >>
> > Reeally ? I seem to be blind. I searched for threshold_tcold_mask in the patch but
> > did not see where it is changed. Can you point me to the code ?
> 
> I misread it. Yes threshold_tcold_mask is used only in show_temp_max_hyst(),
> set_temp_max(), set_temp_max_hyst() functions. It is set only in the
> set_temp_max_hyst()
> function.
> 
I am still lost. Where exactly ? I don't see it being changed in
set_temp_max_hyst() either. Outside initialization code, I only see
writes to
	bgap_threshold
	bgap_counter
	bgap_mask_ctrl
but not to any of the masks.
	
Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
