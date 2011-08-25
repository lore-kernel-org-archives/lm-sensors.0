From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Thu, 25 Aug 2011 16:51:45 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13a-++PMin_-XfVXwwQP5WCXuBQ-dXt_07r8Wv13iVFgCw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
	<CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	<20110825140630.GB8684@ericsson.com>
	<CAJ6a13Y0BERGmxSZR=H5h0+8z-UDUp0ZoUwdE+nH2KX7Li0c-Q@mail.gmail.com>
	<1314289171.2796.50.camel@groeck-laptop>
In-Reply-To: <1314289171.2796.50.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Aug 25, 2011 at 9:49 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, 2011-08-25 at 12:04 -0400, J, KEERTHY wrote:
>> On Thu, Aug 25, 2011 at 7:36 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
>> >> On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
>> >> <guenter.roeck@ericsson.com> wrote:
>> >> > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
>> >> >> On chip temperature sensor driver. The driver monitors the tempera=
ture of
>> >> >> the MPU subsystem of the OMAP4. It sends notifications to the user=
 space if
>> >> >> the temperature crosses user defined thresholds via kobject_uevent=
 interface.
>> >> >> The user is allowed to configure the temperature thresholds vis sy=
sfs nodes
>> >> >> exposed using hwmon interface.
>> >> >>
>> >> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> >> >> Cc: Jean Delvare <khali@linux-fr.org>
>> >> >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> >> >> Cc: lm-sensors@lm-sensors.org
>> >> >
>> >> > Partial review only. Too many concerns, and after a while I tend to=
 loose track.
>> >> >
>> >> >> ---
>> >> >> =A0Documentation/hwmon/omap_temp_sensor | =A0 27 +
>> >> >> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> >> >> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> >> >> =A0drivers/hwmon/omap_temp_sensor.c =A0 =A0 | =A0933 +++++++++++++=
+++++++++++++++++++++
>> >> >> =A04 files changed, 972 insertions(+), 0 deletions(-)
>> >> >> =A0create mode 100644 Documentation/hwmon/omap_temp_sensor
>> >> >> =A0create mode 100644 drivers/hwmon/omap_temp_sensor.c
>> >> >>
>> >
>> > [ ... ]
>> >
>> >> >> +/* Sysfs hook functions */
>> >> >> +
>> >> >> +static ssize_t show_temp_max(struct device *dev,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attrib=
ute *devattr, char *buf)
>> >> >> +{
>> >> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drv=
data(dev);
>> >> >> + =A0 =A0 =A0 int temp;
>> >> >> +
>> >> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registe=
rs->bgap_threshold);
>> >> >> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_t=
hot_mask)
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor=
->registers->threshold_thot_mask);
>> >> >> +
>> >> >> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_E=
ND_VALUE) {
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;
>> >> >
>> >> > Please don't use EDOM, and drop the error message.
>> >>
>> >> The temperature is out of range. Should i use EIO?
>> >>
>> > It is out of range, but not due to a math error, but due to a bad read=
ing from the chip
>> > or due to a chip failure. EIO is ok.
>>
>> Ok
>>
>> >
>> >> >
>> >> >> + =A0 =A0 =A0 }
>> >> >> +
>> >> >> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> >> >> +
>> >> >> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> >> >> +}
>> >> >> +
>> >> >> +static ssize_t set_temp_max(struct device *dev,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devic=
e_attribute *devattr,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *=
buf, size_t count)
>> >> >> +{
>> >> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drv=
data(dev);
>> >> >> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> >> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val,=
 t_cold, t_hot, temp;
>> >> >> +
>> >> >> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> >
>> >> > This will try to release the not-acquired lock.
>> >>
>> >> I will correct this.
>> >>
>> >> >
>> >> >> + =A0 =A0 =A0 }
>> >> >> +
>> >> >> + =A0 =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>> >> >
>> >> > Bad error return check. Negative on error. Should be
>> >> > =A0 =A0 =A0 =A0if (t_hot < 0)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return t_hot;
>> >>
>> >> Ok.
>> >>
>> >> >
>> >> >> + =A0 =A0 =A0 if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_AD=
C_END_VALUE)) {
>> >> >
>> >> > Unnecessary (( ))
>> >>
>> >> This check is unnecessary with the negative check. I will remove.
>> >>
>> >> >
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> >
>> >> > This will try to release the not-acquired lock.
>> >>
>> >> I will correct this.
>> >>
>> >> >
>> >> >> + =A0 =A0 =A0 }
>> >> >> +
>> >> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> >> + =A0 =A0 =A0 /* obtain the T cold value */
>> >> >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registe=
rs->bgap_threshold);
>> >> >> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->thresho=
ld_tcold_mask) >>
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->r=
egisters->threshold_tcold_mask);
>> >> >> +
>> >> >> + =A0 =A0 =A0 if (t_hot < t_cold) {
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> >
>> >> > Context specific limitations like this one are not a good idea, sin=
ce it assumes an order of changing max
>> >> > and max_hysteresis which is not necessarily guaranteed by the appli=
cation making the change, nor is a
>> >> > change order order well defined or even possible. Applications shou=
ld not have to bother about this.
>> >>
>> >> The hardware behavior is like this. As long as the temperature is bel=
ow
>> >> t_hot no interrupts are fired. Once the temperature increases above
>> >> t_hot we get an
>> >> interrupt. In order to avoid repeated interrupts we mask the t_hot in=
terrupt
>> >> in the interrupt handler and enable the t_cold interrupts. So we get =
a t_cold
>> >> interrupt only when the temperature drops below the t_cold value. Hen=
ce
>> >> setting the t_cold higher than t_hot will mess up the state machine.
>> >>
>> >> t_hot value should be greater than t_cold value.
>> >>
>> > One option would be to update t_cold (max_hyst) automatically in that =
case.
>>
>> updating the t_cold without application's knowledge?
>>
> Why not ? Other drivers do the same. Happens all the time. Better than
> returning an error and leaving the application wondering what is wrong.
>
>> >
>> > Problem here is that you expect the aplication to know, depending on t=
he current
>> > values of (max, max_hyst), how to update both limits in order. That is=
 not a reasonable
>> > expectation.
>>
>> The thermal application which is configuring the thresholds must be
>> intelligent enough to configure the thresholds in the right order. Confi=
guring
>> the thresholds wrongly and missing the interrupt may even result in burn=
ing
>> the chip.
>>
>
> Applications are generic, and _can not_ be expected to know chip
> specific requirements such as order of initialization. What is needed
> for your chip may be completely different for another chip, so you have
> to make sure that _your driver_ prevents critical situations from
> happening. You can not blame applications for not knowing the oddities
> of your chips.
>
>> >
>> >> >
>> >> >> + =A0 =A0 =A0 }
>> >> >> +
>> >> >> + =A0 =A0 =A0 /* write the new t_hot value */
>> >> >> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registe=
rs->bgap_threshold);
>> >> >> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshold_thot=
_mask;
>> >> >> + =A0 =A0 =A0 reg_val |=3D (t_hot <<
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->r=
egisters->threshold_thot_mask));
>> >> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registe=
rs->bgap_threshold);
>> >> >> +
>> >> >> + =A0 =A0 =A0 /* Read the current temperature */
>> >> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registe=
rs->temp_sensor_ctrl);
>> >> >> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> >> >> +
>> >> >> + =A0 =A0 =A0 /*
>> >> >> + =A0 =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater =
than the current
>> >> >> + =A0 =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
>> >> >> + =A0 =A0 =A0 =A0*/
>> >> >> + =A0 =A0 =A0 if (t_hot > temp) {
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(t=
emp_sensor,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp=
_sensor->registers->bgap_mask_ctrl);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers=
->mask_cold_mask;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers-=
>mask_hot_mask;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,=
 reg_val,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp=
_sensor->registers->bgap_mask_ctrl);
>> >> >> + =A0 =A0 =A0 }
>> >> >> +
>> >> >> + =A0 =A0 =A0 /*
>> >> >> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot an=
d cold thresholds,
>> >> >> + =A0 =A0 =A0 =A0* Enable both masks.
>> >> >> + =A0 =A0 =A0 =A0*/
>> >> >> + =A0 =A0 =A0 if (temp > t_cold && temp < t_hot) {
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(t=
emp_sensor,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp=
_sensor->registers->bgap_mask_ctrl);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers-=
>mask_cold_mask;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers-=
>mask_hot_mask;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,=
 reg_val,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP=
4460_BGAP_CTRL_OFFSET);
>> >> >
>> >> > Why use OMAP4460_BGAP_CTRL_OFFSET here but bgap_mask_ctrl elsewhere=
 ?
>> >>
>> >> Ok. I will change this.
>> >>
>> >> >
>> >> >> + =A0 =A0 =A0 }
>> >> >> + =A0 =A0 =A0 /*
>> >> >> + =A0 =A0 =A0 =A0* else no need to do anything since HW will immed=
iately compare
>> >> >> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt accord=
ingly
>> >> >> + =A0 =A0 =A0 =A0*/
>> >> >> +out:
>> >> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> >> +
>> >> >> + =A0 =A0 =A0 return count;
>> >> >> +}
>> >> >> +
>> >> >> +static ssize_t show_temp_max_hyst(struct device *dev,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, ch=
ar *buf)
>> >> >> +{
>> >> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drv=
data(dev);
>> >> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> >> >> +
>> >> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> >
>> >> > This lock would only make sense if threshold_tcold_mask can change,=
 and if that change
>> >> > would be protected by the mutex. I don't see that to be the case, t=
hus the lock is unnecessary.
>> >> > Besides, the code in show_temp_max() is almost the same and does no=
t use the lock.
>> >>
>> >> The masks are getting changed in show_temp_max() show_temp_max_hyst()=
 and the
>> >> ISR function. It is better to protect with mutex. I will add that in
>> >> required places.
>> >>
>> > Reeally ? I seem to be blind. I searched for threshold_tcold_mask in t=
he patch but
>> > did not see where it is changed. Can you point me to the code ?
>>
>> I misread it. Yes threshold_tcold_mask is used only in show_temp_max_hys=
t(),
>> set_temp_max(), set_temp_max_hyst() functions. It is set only in the
>> set_temp_max_hyst()
>> function.
>>
> I am still lost. Where exactly ? I don't see it being changed in
> set_temp_max_hyst() either. Outside initialization code, I only see
> writes to
> =A0 =A0 =A0 =A0bgap_threshold

bgap_threshold is the register and "threshold_tcold_mask" is a bit field
in that register which is written in the  set_temp_max_hyst() function to
configure temp_max_hyst.
Similarly "threshold_thot_mask"  is a bit field in the bgap_threshold
register which is written in the set_temp_max() function to configure
temp_max.

> =A0 =A0 =A0 =A0bgap_counter
> =A0 =A0 =A0 =A0bgap_mask_ctrl
> but not to any of the masks.
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
