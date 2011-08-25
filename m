From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 25 Aug 2011 15:56:11 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <1314287771.2796.40.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
	 <CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	 <20110825140630.GB8684@ericsson.com>
In-Reply-To: <20110825140630.GB8684@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, 2011-08-25 at 10:06 -0400, Guenter Roeck wrote:
> On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
> > On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
> > <guenter.roeck@ericsson.com> wrote:
> > > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
> > >> On chip temperature sensor driver. The driver monitors the temperature of
> > >> the MPU subsystem of the OMAP4. It sends notifications to the user space if
> > >> the temperature crosses user defined thresholds via kobject_uevent interface.
> > >> The user is allowed to configure the temperature thresholds vis sysfs nodes
> > >> exposed using hwmon interface.
> > >>
> > >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> > >> Cc: Jean Delvare <khali@linux-fr.org>
> > >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > >> Cc: lm-sensors@lm-sensors.org
> > >

[ ... ]


> >
> > >
> > >> +       }
> > >> +
> > >> +       mutex_lock(&temp_sensor->sensor_mutex);
> > >> +       /* obtain the T cold value */
> > >> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> > >> +                       temp_sensor->registers->bgap_threshold);
> > >> +       t_cold = (t_cold & temp_sensor->registers->threshold_tcold_mask) >>
> > >> +                       __ffs(temp_sensor->registers->threshold_tcold_mask);
> > >> +
> > >> +       if (t_hot < t_cold) {
> > >> +               count = -EINVAL;
> > >> +               goto out;
> > >
> > > Context specific limitations like this one are not a good idea, since it assumes an order of changing max
> > > and max_hysteresis which is not necessarily guaranteed by the application making the change, nor is a
> > > change order order well defined or even possible. Applications should not have to bother about this.
> >
> > The hardware behavior is like this. As long as the temperature is below
> > t_hot no interrupts are fired. Once the temperature increases above
> > t_hot we get an
> > interrupt. In order to avoid repeated interrupts we mask the t_hot interrupt
> > in the interrupt handler and enable the t_cold interrupts. So we get a t_cold
> > interrupt only when the temperature drops below the t_cold value. Hence
> > setting the t_cold higher than t_hot will mess up the state machine.
> >
> > t_hot value should be greater than t_cold value.
> >
> One option would be to update t_cold (max_hyst) automatically in that case.
> 
> Problem here is that you expect the application to know, depending on the current
> values of (max, max_hyst), how to update both limits in order. That is not a reasonable
> expectation.
> 
One possible solution would be to have a single function to set both
t_cold and t_hot, and call it from both initialization code and from the
set functions. That would unify all the register setting and interrupt
enable code.

Regarding the actual values to set, you can (as an example) use the
following approach:

- If max is set, and t_hot < t_cold, adjust t_cold to the new value of
t_hot.

- if max_hyst is set, and t_cold > t_hot, set t_cold to the new value of
t_hot.

So, in other words, your new unified function would only need the
following simple validation:

	if (t_cold > t_hot)
		t_cold = t_hot;

[ ... ]

> > >> +
> > >> +static int __devinit omap_temp_sensor_probe(struct platform_device *pdev)
> > >> +{
> > >> +       struct omap_temp_sensor_pdata   *pdata  = pdev->dev.platform_data;
> > >> +       struct omap_temp_sensor         *temp_sensor;
> > >> +       struct resource                 *mem;
> > >> +       int                             ret = 0;
> > >> +       int                             val, clk_rate;
> > >> +       u32                             max_freq, min_freq;
> > >> +
> > >> +       if (!pdata) {
> > >> +               dev_err(&pdev->dev, "platform data missing\n");
> > >> +               return -EINVAL;
> > >> +       }
> > >> +
> > >> +       temp_sensor = kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
> > >> +       if (!temp_sensor)
> > >> +               return -ENOMEM;
> > >> +
> > >
> > > You have error messages all over the place, Why not here ?
> >
> > Ok. I will add an error message here.
> >
> > >
> > >> +       mutex_init(&temp_sensor->sensor_mutex);
> > >> +
> > >> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >> +       if (!mem) {
> > >> +               dev_err(&pdev->dev, "no mem resource\n");
> > >> +               ret = -ENOMEM;
> > >> +               goto plat_res_err;
> > >> +       }
> > >> +
> > >
> > > If you try to get the resource before allocating the memory, you don't have to release
> > > the memory if the platform resource is missing.
> >
> > Ok. Here if i fail i am releasing temp_sensor memory which
> > has been allocated.
> >
> > >
> > >> +       temp_sensor->irq = platform_get_irq_byname(pdev, "thermal_alert");
> > >> +       if (temp_sensor->irq < 0) {
> > >> +               dev_err(&pdev->dev, "get_irq_byname failed\n");
> > >> +               ret = temp_sensor->irq;
> > >> +               goto plat_res_err;
> > >> +       }
> > >> +
> > >> +       temp_sensor->phy_base = ioremap(mem->start, resource_size(mem));
> > >> +       temp_sensor->clock = NULL;
> > >> +       temp_sensor->registers = pdata->registers;
> > >> +       temp_sensor->hwmon_dev = &pdev->dev;
> > >> +
> > >> +       if (pdata->max_freq && pdata->min_freq) {
> > >> +               max_freq = pdata->max_freq;
> > >> +               min_freq = pdata->min_freq;
> > >> +       } else {
> > >> +               max_freq = MAX_FREQ;
> > >> +               min_freq = MIN_FREQ;
> > >> +       }
> > >> +
> > >> +       pm_runtime_enable(&pdev->dev);
> > >> +       pm_runtime_irq_safe(&pdev->dev);
> > >> +
> > >> +       /*
> > >> +        * check if the efuse has a non-zero value if not
> > >> +        * it is an untrimmed sample and the temperatures
> > >> +        * may not be accurate
> > >> +        */
> > >> +
> > >> +       if (omap_temp_sensor_readl(temp_sensor,
> > >> +                       temp_sensor->registers->bgap_efuse)) {
> > >> +               temp_sensor->is_efuse_valid = 1;
> > >
> > > is_efuse_valid is not used anywhere. Might as well drop it.
> >
> > Ok
> >
> > >
> > >> +               dev_dbg(temp_sensor->hwmon_dev,
> > >> +                       "Invalid EFUSE, Non-trimmed BGAP, Temp not accurate\n");
> > >
> > > dev_info might be better here.
> >
> > Ok.
> >
> > >
> > >> +       }
> > >> +
> > >> +       dev_set_drvdata(&pdev->dev, temp_sensor);
> > >> +       temp_sensor->clock = clk_get(temp_sensor->hwmon_dev, "fck");
> > >> +       if (IS_ERR(temp_sensor->clock)) {
> > >> +               ret = PTR_ERR(temp_sensor->clock);
> > >> +               dev_err(temp_sensor->hwmon_dev,
> > >> +                       "unable to get fclk: %d\n", ret);
> > >> +               goto plat_res_err;
> > >> +       }
> > >> +
> > >> +       ret = omap_temp_sensor_clk_enable(temp_sensor);
> > >> +       if (ret) {
> > >> +               dev_err(&pdev->dev, "Cannot enable temp sensor\n");
> > >
> > > omap_temp_sensor_clk_enable() already generates error messages.
> >
> > Ok. I will remove this.
> >
> > >
> > >> +               goto clken_err;
> > >> +       }
> > >> +
> > >> +       clk_rate = clk_round_rate(temp_sensor->clock, max_freq);
> > >> +       if (clk_rate < min_freq || clk_rate = 0xffffffff) {
> > >> +               dev_err(&pdev->dev, "Error round rate\n");
> > >> +               ret = -EDOM;
> > >
> > > EDOM is wrong. Please use ENODEV.
> >
> > Ok
> >
> > >
> > > The error log doesn't really provide anything useful to the administrator.
> > > Either add parameters, or drop it.
> >
> > Ok
> >
> > >
> > >> +               goto clken_err;
> > >> +       }
> > >> +
> > >> +       ret = clk_set_rate(temp_sensor->clock, clk_rate);
> > >> +       if (ret) {
> > >> +               dev_err(&pdev->dev, "Cannot set clock rate\n");
> > >> +               goto clken_err;
> > >> +       }
> > >> +
> > >> +       temp_sensor->clk_rate = clk_rate;
> > >> +       omap_enable_continuous_mode(temp_sensor, 1);
> > >> +       omap_configure_temp_sensor_thresholds(temp_sensor);
> > >> +       /* 1 ms */
> > >> +       omap_configure_temp_sensor_counter(temp_sensor, 1);
> > >
> > > If temp_sensor->clk_rate * 2 is two seconds, as suggested below, 1 is not 1ms.
> > > 1ms would be temp_sensor->clk_rate / 1000.
> >
> > Yes! Wrong comment. It is configured to start the temperature conversion.
> > It represents 1 clock cycle of the temperature sensor fclk. I will correct this.
> >
> > >
> > >> +
> > >> +       /* Wait till the first conversion is done wait for at least 1ms */
> > >> +       usleep_range(1000, 2000);
> > >> +
> > >> +       /* Read the temperature once due to hw issue*/
> > >> +       omap_temp_sensor_readl(temp_sensor,
> > >> +                       temp_sensor->registers->temp_sensor_ctrl);
> > >> +
> > >> +       /* Set 2 seconds time as default counter */
> > >> +       omap_configure_temp_sensor_counter(temp_sensor,
> > >> +                                               temp_sensor->clk_rate * 2);
> > >> +
> > >> +       temp_sensor->hwmon_dev = hwmon_device_register(&pdev->dev);
> > >> +       if (IS_ERR(temp_sensor->hwmon_dev)) {
> > >> +               dev_err(&pdev->dev, "hwmon_device_register failed.\n");
> > >> +               ret = PTR_ERR(temp_sensor->hwmon_dev);
> > >> +               goto hwmon_reg_err;
> > >> +       }
> > >> +
> > >> +       ret = sysfs_create_group(&pdev->dev.kobj,
> > >> +                              &omap_temp_sensor_group);
> > >
> > > one line is sufficient here.
> >
> > Ok.
> >
> > >
> > >> +       if (ret) {
> > >> +               dev_err(&pdev->dev, "could not create sysfs files\n");
> > >> +               goto sysfs_create_err;
> > >> +       }
> > >> +
> > >> +       kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
> > >> +
> > >
> > > No other hwmon driver needs this. Doesn't the sysfs code take care of this ?
> >
> > Yes i will remove this.
> >
> > >
> > >> +       ret = request_threaded_irq(temp_sensor->irq, NULL,
> > >> +               omap_talert_irq_handler, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > >> +                       "temp_sensor", temp_sensor);
> > >> +       if (ret) {
> > >> +               dev_err(&pdev->dev, "Request threaded irq failed.\n");
> > >> +               goto req_irq_err;
> > >> +       }
> > >> +
> > >> +       /* unmask the T_COLD and unmask T_HOT at init */
> > >> +       val = omap_temp_sensor_readl(temp_sensor,
> > >> +               temp_sensor->registers->bgap_mask_ctrl);
> > >> +       val |= temp_sensor->registers->mask_cold_mask
> > >> +               | temp_sensor->registers->mask_hot_mask;
> > >> +
> > >> +       omap_temp_sensor_writel(temp_sensor, val,
> > >> +               temp_sensor->registers->bgap_mask_ctrl);
> > >> +
> > > This is racy. From Documentation/hwmon/submitting-patches:
> >
> > I read it. If i enable the interrupts before i have the sysfs
> > infrastructure ready.
> > I am likely to miss out on the uevent notification if the interrupt
> > occurs as soon as
> > i unmask. Correct me if my understanding is wrong.
> >
> See other email on sequence subject. I'll have to look into it in more detail.
> later - no time right now ...

Concerns:

- create sysfs entries first, then register with hwmon.
hwmon_device_register is usually the last call, made only after
everything is known to work.
- You can definitely request the interrupt before registering sysfs
entries
- temp_sensor->hwmon_dev is initially set to 
	temp_sensor->hwmon_dev = &pdev->dev;
  then overwritten with
	temp_sensor->hwmon_dev = hwmon_device_register(&pdev->dev);
  This is, at the very least, odd and doesn't seem to make sense.
- Interrupt enable code (setting bgap_mask_ctrl) in probe function
occurs after sysfs files have been enabled, and the access is not mutex
protected. Thus, sysfs access can already happen, causing the main race
I was concerned about.

My suggestion is 
- request interrupt prior to sysfs creation and hwmon registration.
- swap sysfs file creation and hwmon registration.
- Use the unified function I suggested above to set t_cold, t_hot, and
to enable interrupts as needed. Since that function will be mutex
protected, you can call it after hwmon registration, and avoid the race.

Also look into use of temp_sensor->hwmon_dev vs. &pdev->dev. That code
just doesn't look right.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
