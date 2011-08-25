From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Thu, 25 Aug 2011 16:18:08 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13Y1s4AwNftGhQ0Qv8E-zCCepK5ATFJdXNOpwKHhF377TA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
	<CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	<20110825140630.GB8684@ericsson.com>
	<1314287771.2796.40.camel@groeck-laptop>
In-Reply-To: <1314287771.2796.40.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Aug 25, 2011 at 9:26 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, 2011-08-25 at 10:06 -0400, Guenter Roeck wrote:
>> On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
>> > On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
>> > <guenter.roeck@ericsson.com> wrote:
>> > > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
>> > >> On chip temperature sensor driver. The driver monitors the temperat=
ure of
>> > >> the MPU subsystem of the OMAP4. It sends notifications to the user =
space if
>> > >> the temperature crosses user defined thresholds via kobject_uevent =
interface.
>> > >> The user is allowed to configure the temperature thresholds vis sys=
fs nodes
>> > >> exposed using hwmon interface.
>> > >>
>> > >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> > >> Cc: Jean Delvare <khali@linux-fr.org>
>> > >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> > >> Cc: lm-sensors@lm-sensors.org
>> > >
>
> [ ... ]
>
>
>> >
>> > >
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> > >> + =A0 =A0 =A0 /* obtain the T cold value */
>> > >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>> > >> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->threshol=
d_tcold_mask) >>
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->re=
gisters->threshold_tcold_mask);
>> > >> +
>> > >> + =A0 =A0 =A0 if (t_hot < t_cold) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > >
>> > > Context specific limitations like this one are not a good idea, sinc=
e it assumes an order of changing max
>> > > and max_hysteresis which is not necessarily guaranteed by the applic=
ation making the change, nor is a
>> > > change order order well defined or even possible. Applications shoul=
d not have to bother about this.
>> >
>> > The hardware behavior is like this. As long as the temperature is below
>> > t_hot no interrupts are fired. Once the temperature increases above
>> > t_hot we get an
>> > interrupt. In order to avoid repeated interrupts we mask the t_hot int=
errupt
>> > in the interrupt handler and enable the t_cold interrupts. So we get a=
 t_cold
>> > interrupt only when the temperature drops below the t_cold value. Hence
>> > setting the t_cold higher than t_hot will mess up the state machine.
>> >
>> > t_hot value should be greater than t_cold value.
>> >
>> One option would be to update t_cold (max_hyst) automatically in that ca=
se.
>>
>> Problem here is that you expect the application to know, depending on th=
e current
>> values of (max, max_hyst), how to update both limits in order. That is n=
ot a reasonable
>> expectation.
>>
> One possible solution would be to have a single function to set both
> t_cold and t_hot, and call it from both initialization code and from the
> set functions. That would unify all the register setting and interrupt
> enable code.
>
> Regarding the actual values to set, you can (as an example) use the
> following approach:
>
> - If max is set, and t_hot < t_cold, adjust t_cold to the new value of
> t_hot.
>
> - if max_hyst is set, and t_cold > t_hot, set t_cold to the new value of
> t_hot.
>
> So, in other words, your new unified function would only need the
> following simple validation:
>
> =A0 =A0 =A0 =A0if (t_cold > t_hot)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t_cold =3D t_hot;
>
> [ ... ]
>
>> > >> +
>> > >> +static int __devinit omap_temp_sensor_probe(struct platform_device=
 *pdev)
>> > >> +{
>> > >> + =A0 =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev-=
>dev.platform_data;
>> > >> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> > >> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;
>> > >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 ret =3D 0;
>> > >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 val, clk_rate;
>> > >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 max_freq, min_freq;
>> > >> +
>> > >> + =A0 =A0 =A0 if (!pdata) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data mi=
ssing\n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KER=
NEL);
>> > >> + =A0 =A0 =A0 if (!temp_sensor)
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> > >> +
>> > >
>> > > You have error messages all over the place, Why not here ?
>> >
>> > Ok. I will add an error message here.
>> >
>> > >
>> > >> + =A0 =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>> > >> +
>> > >> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
);
>> > >> + =A0 =A0 =A0 if (!mem) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\=
n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >
>> > > If you try to get the resource before allocating the memory, you don=
't have to release
>> > > the memory if the platform resource is missing.
>> >
>> > Ok. Here if i fail i am releasing temp_sensor memory which
>> > has been allocated.
>> >
>> > >
>> > >> + =A0 =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, "t=
hermal_alert");
>> > >> + =A0 =A0 =A0 if (temp_sensor->irq < 0) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname f=
ailed\n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resourc=
e_size(mem));
>> > >> + =A0 =A0 =A0 temp_sensor->clock =3D NULL;
>> > >> + =A0 =A0 =A0 temp_sensor->registers =3D pdata->registers;
>> > >> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D &pdev->dev;
>> > >> +
>> > >> + =A0 =A0 =A0 if (pdata->max_freq && pdata->min_freq) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D pdata->max_freq;
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D pdata->min_freq;
>> > >> + =A0 =A0 =A0 } else {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D MAX_FREQ;
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D MIN_FREQ;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> > >> + =A0 =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> > >> +
>> > >> + =A0 =A0 =A0 /*
>> > >> + =A0 =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> > >> + =A0 =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> > >> + =A0 =A0 =A0 =A0* may not be accurate
>> > >> + =A0 =A0 =A0 =A0*/
>> > >> +
>> > >> + =A0 =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_efuse)) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->is_efuse_valid =3D 1;
>> > >
>> > > is_efuse_valid is not used anywhere. Might as well drop it.
>> >
>> > Ok
>> >
>> > >
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(temp_sensor->hwmon_dev,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invalid EFUSE, Non-t=
rimmed BGAP, Temp not accurate\n");
>> > >
>> > > dev_info might be better here.
>> >
>> > Ok.
>> >
>> > >
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>> > >> + =A0 =A0 =A0 temp_sensor->clock =3D clk_get(temp_sensor->hwmon_dev=
, "fck");
>> > >> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock);
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk: =
%d\n", ret);
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>> > >> + =A0 =A0 =A0 if (ret) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable te=
mp sensor\n");
>> > >
>> > > omap_temp_sensor_clk_enable() already generates error messages.
>> >
>> > Ok. I will remove this.
>> >
>> > >
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, max_f=
req);
>> > >> + =A0 =A0 =A0 if (clk_rate < min_freq || clk_rate =3D 0xffffffff) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Error round rate=
\n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> > >
>> > > EDOM is wrong. Please use ENODEV.
>> >
>> > Ok
>> >
>> > >
>> > > The error log doesn't really provide anything useful to the administ=
rator.
>> > > Either add parameters, or drop it.
>> >
>> > Ok
>> >
>> > >
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>> > >> + =A0 =A0 =A0 if (ret) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock=
 rate\n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>> > >> + =A0 =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);
>> > >> + =A0 =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);
>> > >> + =A0 =A0 =A0 /* 1 ms */
>> > >> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>> > >
>> > > If temp_sensor->clk_rate * 2 is two seconds, as suggested below, 1 i=
s not 1ms.
>> > > 1ms would be temp_sensor->clk_rate / 1000.
>> >
>> > Yes! Wrong comment. It is configured to start the temperature conversi=
on.
>> > It represents 1 clock cycle of the temperature sensor fclk. I will cor=
rect this.
>> >
>> > >
>> > >> +
>> > >> + =A0 =A0 =A0 /* Wait till the first conversion is done wait for at=
 least 1ms */
>> > >> + =A0 =A0 =A0 usleep_range(1000, 2000);
>> > >> +
>> > >> + =A0 =A0 =A0 /* Read the temperature once due to hw issue*/
>> > >> + =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->temp_sensor_ctrl);
>> > >> +
>> > >> + =A0 =A0 =A0 /* Set 2 seconds time as default counter */
>> > >> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate * 2);
>> > >> +
>> > >> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&pde=
v->dev);
>> > >> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_reg=
ister failed.\n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_de=
v);
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&omap_=
temp_sensor_group);
>> > >
>> > > one line is sufficient here.
>> >
>> > Ok.
>> >
>> > >
>> > >> + =A0 =A0 =A0 if (ret) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not create=
 sysfs files\n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_AD=
D);
>> > >> +
>> > >
>> > > No other hwmon driver needs this. Doesn't the sysfs code take care o=
f this ?
>> >
>> > Yes i will remove this.
>> >
>> > >
>> > >> + =A0 =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER=
_RISING | IRQF_ONESHOT,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp_s=
ensor);
>> > >> + =A0 =A0 =A0 if (ret) {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded=
 irq failed.\n");
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> > >> + =A0 =A0 =A0 }
>> > >> +
>> > >> + =A0 =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */
>> > >> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctr=
l);
>> > >> + =A0 =A0 =A0 val |=3D temp_sensor->registers->mask_cold_mask
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor->registers->mask_hot_ma=
sk;
>> > >> +
>> > >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctr=
l);
>> > >> +
>> > > This is racy. From Documentation/hwmon/submitting-patches:
>> >
>> > I read it. If i enable the interrupts before i have the sysfs
>> > infrastructure ready.
>> > I am likely to miss out on the uevent notification if the interrupt
>> > occurs as soon as
>> > i unmask. Correct me if my understanding is wrong.
>> >
>> See other email on sequence subject. I'll have to look into it in more d=
etail.
>> later - no time right now ...
>
> Concerns:
>
> - create sysfs entries first, then register with hwmon.
> hwmon_device_register is usually the last call, made only after
> everything is known to work.
> - You can definitely request the interrupt before registering sysfs
> entries
> - temp_sensor->hwmon_dev is initially set to
> =A0 =A0 =A0 =A0temp_sensor->hwmon_dev =3D &pdev->dev;
> =A0then overwritten with
> =A0 =A0 =A0 =A0temp_sensor->hwmon_dev =3D hwmon_device_register(&pdev->de=
v);
> =A0This is, at the very least, odd and doesn't seem to make sense.
> - Interrupt enable code (setting bgap_mask_ctrl) in probe function
> occurs after sysfs files have been enabled, and the access is not mutex
> protected. Thus, sysfs access can already happen, causing the main race
> I was concerned about.
>
> My suggestion is
> - request interrupt prior to sysfs creation and hwmon registration.
> - swap sysfs file creation and hwmon registration.
> - Use the unified function I suggested above to set t_cold, t_hot, and
> to enable interrupts as needed. Since that function will be mutex
> protected, you can call it after hwmon registration, and avoid the race.
>
> Also look into use of temp_sensor->hwmon_dev vs. &pdev->dev. That code
> just doesn't look right.

Thanks for the inputs. I will work on them and get back.

>
> Thanks,
> Guenter
>
>
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
