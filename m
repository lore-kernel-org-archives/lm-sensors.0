From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Mon, 22 Aug 2011 04:52:28 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6 V2] hwmon: OMAP4: On die
Message-Id: <CAJ6a13bTk9WJnk0qrGqbpuOu5MOyKcBe1uT5L3DR7msMnepv5w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
	<1313664735-8917-7-git-send-email-j-keerthy@ti.com>
	<20110819053438.GA2901@google.com>
In-Reply-To: <20110819053438.GA2901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Fri, Aug 19, 2011 at 11:04 AM, Todd Poynor <toddpoynor@google.com> wrote:
> On Thu, Aug 18, 2011 at 04:22:15PM +0530, Keerthy wrote:
> ...
>> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_se=
nsor)
>> +{
>> + =A0 =A0 u32 ret =3D 0;
>> +
>> + =A0 =A0 if (temp_sensor->clk_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock already=
 on\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->hwmon_dev);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "get sync fail=
ed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->clk_on =3D 1;
>
>
> Probably should hold the mutex around this to keep clk_on consistent
> with runtime PM state (and in disable method).

Ok

>
> ...
>> +static int __devinit omap_temp_sensor_probe(struct platform_device *pde=
v)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev->dev.plat=
form_data;
>> + =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> + =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
t =3D 0;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 va=
l, clk_rate;
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data missing\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
>> + =A0 =A0 if (!temp_sensor)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>> +
>> + =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, "thermal_al=
ert");
>> + =A0 =A0 if (temp_sensor->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resource_size(me=
m));
>> + =A0 =A0 temp_sensor->clock =3D NULL;
>> + =A0 =A0 temp_sensor->registers =3D pdata->registers;
>> + =A0 =A0 temp_sensor->hwmon_dev =3D &pdev->dev;
>> +
>> + =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> + =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> + =A0 =A0 =A0* may not be accurate
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_e=
fuse))
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->is_efuse_valid =3D 1;
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, temp_sensor);
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>> + =A0 =A0 temp_sensor->clock =3D clk_get(temp_sensor->hwmon_dev, "fck");
>> + =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk: %d\n", re=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable temp sensor=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, 2000000);
>> + =A0 =A0 if (clk_rate < 1000000 || clk_rate =3D 0xffffffff) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Error round rate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock rate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>> + =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);
>> + =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);
>> + =A0 =A0 /* 1 ms */
>> + =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>> +
>> + =A0 =A0 /* Wait till the first conversion is done wait for at least 1m=
s */
>> + =A0 =A0 usleep_range(1000, 2000);
>> +
>> + =A0 =A0 /* Read the temperature once due to hw issue*/
>> + =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_s=
ensor_ctrl);
>> +
>> + =A0 =A0 /* Set 2 seconds time as default counter */
>> + =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate * 2);
>> +
>> + =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&pdev->dev);
>> + =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_register fai=
led.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&omap_temp_=
sensor_group);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not create sysfs fi=
les\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
>> +
>> + =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER_RISING |=
 IRQF_ONESHOT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp_sensor);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded irq fail=
ed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */
>> + =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> + =A0 =A0 val |=3D temp_sensor->registers->mask_cold_mask
>> + =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor->registers->mask_hot_mask;
>> +
>> + =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> +
>> + =A0 =A0 return 0;
>> +
>> +req_irq_err:
>> + =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
>> + =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp_sen=
sor_group);
>> +sysfs_create_err:
>> + =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> +hwmon_reg_err:
>> + =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>> +clken_err:
>> + =A0 =A0 clk_put(temp_sensor->clock);
>> +plat_res_err:
>> + =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>> + =A0 =A0 kfree(temp_sensor);
>
> Should also:
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, NULL);
> =A0 =A0 =A0 =A0dev_set_drvdata(&pdev->dev, NULL);

Ok

>
>
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit omap_temp_sensor_remove(struct platform_device *pd=
ev)
>> +{
>> + =A0 =A0 struct omap_temp_sensor *temp_sensor =3D platform_get_drvdata(=
pdev);
>> +
>> + =A0 =A0 hwmon_device_unregister(&pdev->dev);
>> + =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
>> + =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp_sensor_group);
>> + =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>> + =A0 =A0 clk_put(temp_sensor->clock);
>> + =A0 =A0 platform_set_drvdata(pdev, NULL);
>
> And:
> =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);

Ok

>
>> + =A0 =A0 free_irq(temp_sensor->irq, temp_sensor);
>
> Need to free IRQ before clock is disabled (else ISR may access while
> clock stopped, possible L3 interconnect error and ARM imprecise
> external abort)?

Ok

>
>> + =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>> + =A0 =A0 kfree(temp_sensor);
>> +
>> + =A0 =A0 return 0;
>> +}
>
>
> Todd
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
