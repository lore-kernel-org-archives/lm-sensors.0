From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Thu, 25 Aug 2011 16:16:21 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13Y0BERGmxSZR=H5h0+8z-UDUp0ZoUwdE+nH2KX7Li0c-Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
	<CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	<20110825140630.GB8684@ericsson.com>
In-Reply-To: <20110825140630.GB8684@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Aug 25, 2011 at 7:36 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
>> On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
>> >> On chip temperature sensor driver. The driver monitors the temperatur=
e of
>> >> the MPU subsystem of the OMAP4. It sends notifications to the user sp=
ace if
>> >> the temperature crosses user defined thresholds via kobject_uevent in=
terface.
>> >> The user is allowed to configure the temperature thresholds vis sysfs=
 nodes
>> >> exposed using hwmon interface.
>> >>
>> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> >> Cc: Jean Delvare <khali@linux-fr.org>
>> >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> >> Cc: lm-sensors@lm-sensors.org
>> >
>> > Partial review only. Too many concerns, and after a while I tend to lo=
ose track.
>> >
>> >> ---
>> >> =A0Documentation/hwmon/omap_temp_sensor | =A0 27 +
>> >> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> >> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> >> =A0drivers/hwmon/omap_temp_sensor.c =A0 =A0 | =A0933 ++++++++++++++++=
++++++++++++++++++
>> >> =A04 files changed, 972 insertions(+), 0 deletions(-)
>> >> =A0create mode 100644 Documentation/hwmon/omap_temp_sensor
>> >> =A0create mode 100644 drivers/hwmon/omap_temp_sensor.c
>> >>
>
> [ ... ]
>
>> >> +/* Sysfs hook functions */
>> >> +
>> >> +static ssize_t show_temp_max(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute=
 *devattr, char *buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdat=
a(dev);
>> >> + =A0 =A0 =A0 int temp;
>> >> +
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_threshold);
>> >> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_thot=
_mask)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor->r=
egisters->threshold_thot_mask);
>> >> +
>> >> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_=
VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;
>> >
>> > Please don't use EDOM, and drop the error message.
>>
>> The temperature is out of range. Should i use EIO?
>>
> It is out of range, but not due to a math error, but due to a bad reading=
 from the chip
> or due to a chip failure. EIO is ok.

Ok

>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> >> +
>> >> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> >> +}
>> >> +
>> >> +static ssize_t set_temp_max(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_a=
ttribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf=
, size_t count)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdat=
a(dev);
>> >> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val, t_=
cold, t_hot, temp;
>> >> +
>> >> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > This will try to release the not-acquired lock.
>>
>> I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>> >
>> > Bad error return check. Negative on error. Should be
>> > =A0 =A0 =A0 =A0if (t_hot < 0)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return t_hot;
>>
>> Ok.
>>
>> >
>> >> + =A0 =A0 =A0 if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC_E=
ND_VALUE)) {
>> >
>> > Unnecessary (( ))
>>
>> This check is unnecessary with the negative check. I will remove.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > This will try to release the not-acquired lock.
>>
>> I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 /* obtain the T cold value */
>> >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_threshold);
>> >> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->threshold_=
tcold_mask) >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->regi=
sters->threshold_tcold_mask);
>> >> +
>> >> + =A0 =A0 =A0 if (t_hot < t_cold) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > Context specific limitations like this one are not a good idea, since =
it assumes an order of changing max
>> > and max_hysteresis which is not necessarily guaranteed by the applicat=
ion making the change, nor is a
>> > change order order well defined or even possible. Applications should =
not have to bother about this.
>>
>> The hardware behavior is like this. As long as the temperature is below
>> t_hot no interrupts are fired. Once the temperature increases above
>> t_hot we get an
>> interrupt. In order to avoid repeated interrupts we mask the t_hot inter=
rupt
>> in the interrupt handler and enable the t_cold interrupts. So we get a t=
_cold
>> interrupt only when the temperature drops below the t_cold value. Hence
>> setting the t_cold higher than t_hot will mess up the state machine.
>>
>> t_hot value should be greater than t_cold value.
>>
> One option would be to update t_cold (max_hyst) automatically in that cas=
e.

updating the t_cold without application's knowledge?

>
> Problem here is that you expect the aplication to know, depending on the =
current
> values of (max, max_hyst), how to update both limits in order. That is no=
t a reasonable
> expectation.

The thermal application which is configuring the thresholds must be
intelligent enough to configure the thresholds in the right order. Configur=
ing
the thresholds wrongly and missing the interrupt may even result in burning
the chip.

>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* write the new t_hot value */
>> >> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_threshold);
>> >> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshold_thot_ma=
sk;
>> >> + =A0 =A0 =A0 reg_val |=3D (t_hot <<
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->regi=
sters->threshold_thot_mask));
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_threshold);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the current temperature */
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>temp_sensor_ctrl);
>> >> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater tha=
n the current
>> >> + =A0 =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (t_hot > temp) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp=
_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_se=
nsor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->m=
ask_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->ma=
sk_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, re=
g_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_se=
nsor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot and c=
old thresholds,
>> >> + =A0 =A0 =A0 =A0* Enable both masks.
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (temp > t_cold && temp < t_hot) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp=
_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_se=
nsor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->ma=
sk_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->ma=
sk_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, re=
g_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP446=
0_BGAP_CTRL_OFFSET);
>> >
>> > Why use OMAP4460_BGAP_CTRL_OFFSET here but bgap_mask_ctrl elsewhere ?
>>
>> Ok. I will change this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* else no need to do anything since HW will immediat=
ely compare
>> >> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt according=
ly
>> >> + =A0 =A0 =A0 =A0*/
>> >> +out:
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 return count;
>> >> +}
>> >> +
>> >> +static ssize_t show_temp_max_hyst(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, char =
*buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdat=
a(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >
>> > This lock would only make sense if threshold_tcold_mask can change, an=
d if that change
>> > would be protected by the mutex. I don't see that to be the case, thus=
 the lock is unnecessary.
>> > Besides, the code in show_temp_max() is almost the same and does not u=
se the lock.
>>
>> The masks are getting changed in show_temp_max() show_temp_max_hyst() an=
d the
>> ISR function. It is better to protect with mutex. I will add that in
>> required places.
>>
> Reeally ? I seem to be blind. I searched for threshold_tcold_mask in the =
patch but
> did not see where it is changed. Can you point me to the code ?

I misread it. Yes threshold_tcold_mask is used only in show_temp_max_hyst(),
set_temp_max(), set_temp_max_hyst() functions. It is set only in the
set_temp_max_hyst()
function.

>
> If it is changed outside the driver, you have a real problem, since there=
 is no guarantee
> that the mask is not changed from outside the driver, by code not protect=
ed by the mutex.
> And if read functions have the side effect of changing such values, there=
 should really
> be a note somewhere to make people aware of it. I'd call that side effect=
 programming,
> and would argue it is a really bad idea.

It is not changed anywhere outside the driver.

>
>> >
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshold);
>> >> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_tcol=
d_mask) >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->threshold=
_tcold_mask);
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_=
VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EDOM;
>> >
>> > "Math argument out of domain of func" does not make sense.
>> > Unless you don't know anything better, use EIO (I/O Error). Not very s=
pecific,
>> > but at least not misleading.
>>
>> Out of range i assumed this was the closest error value. I will use EIO.
>>
> It is not a math error, though.

Ok

>
>> >
>> > Besides, the log message is unnecessary. The user is informed with -EI=
O, and the admin
>> > won't be able to do anything useful with "invalid value".
>>
>> Ok. I will return -EIO and eliminate the log message.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> >> +
>> >> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>> >> +}
>> >> +
>> >> +static ssize_t set_temp_max_hyst(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct device_attribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cons=
t char *buf, size_t count)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor =
=3D dev_get_drvdata(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 reg_val, t_hot, t_cold, temp;
>> >> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0val;
>> >> +
>> >> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > This will try to release the not acquired lock.
>>
>> I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
>> >
>> > Bad error return check; same as above.
>>
>> Ok. I will correct this.
>>
>> >
>> >> + =A0 =A0 =A0 if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_ADC_=
END_VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 /* obtain the T HOT value */
>> >> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_threshold);
>> >> + =A0 =A0 =A0 t_hot =3D (t_hot & temp_sensor->registers->threshold_th=
ot_mask) >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->regi=
sters->threshold_thot_mask);
>> >> +
>> >> + =A0 =A0 =A0 if (t_cold > t_hot) {
>> >
>> > Same concern as above. Change order is left to application which shoul=
d not be bothered.
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* write the new t_cold value */
>> >> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_threshold);
>> >> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->threshold_tcold_m=
ask;
>> >> + =A0 =A0 =A0 reg_val |=3D t_cold <<
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->regi=
sters->threshold_tcold_mask);
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_threshold);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the current temperature */
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctr=
l);
>> >> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower than =
the current
>> >> + =A0 =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (t_cold < temp) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp=
_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_se=
nsor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->m=
ask_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->ma=
sk_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, re=
g_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot and c=
old thresholds,
>> >> + =A0 =A0 =A0 =A0* Enable both masks.
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (temp < t_hot && temp > t_cold) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp=
_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_se=
nsor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->ma=
sk_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->ma=
sk_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, re=
g_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_se=
nsor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* else no need to do anything since HW will immediat=
ely compare
>> >> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt according=
ly
>> >> + =A0 =A0 =A0 =A0*/
>> >
>> > Would be nice if you could unify the interrupt enable code in a single=
 function.
>>
>> Ok. I will have a function for this.
>>
>> >
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 return count;
>> >> +}
>> >> +
>> >> +static ssize_t show_update_rate(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute=
 *devattr, char *buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdat=
a(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D 0,=
 ret =3D 0;
>> >> +
>> > No need to initialize temp.
>> > ret is u32, which doesn't seem to be a good type to use for negative v=
alues.
>>
>> Oops yes. I will correct this.
>>
>> >
>> >> +
>> >> + =A0 =A0 =A0 if (!temp_sensor->clk_rate) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "clk_rate is NULL\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> >
>> > Same comment as above (this is not a math error). And you don't have t=
o check clk_rate anyway,
>> > since it is set in probe, and probe bails out if it is not set.
>>
>> Ok
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >
>> > As with other show locks, this one would only make sense if counter_ma=
sk can change during runtime,
>> > and if that change would be protected by the mutex. This is not the ca=
se, thus the lock is unnecessary.
>>
>> Counter value can be altered runtime. A lock is needed in both the cases.
>> I will add it.
>>
> clk_rate does not change, counter_mask does not change, and reading a sin=
gle value
> doesn't need a mutex. Am I missing something ?

Ok. I will remove the lock from show function.

>
>> >
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_counter);
>> >> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->counter_mask) =
>>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->regi=
sters->counter_mask);
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 temp =3D temp * 1000 / temp_sensor->clk_rate;
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 if (!ret)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> >> +
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static ssize_t set_update_rate(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct d=
evice_attribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const ch=
ar *buf, size_t count)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdat=
a(dev);
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val;
>> >> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>> >> +
>> >> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 val *=3D temp_sensor->clk_rate / 1000;
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_counter);
>> >> +
>> >> + =A0 =A0 =A0 reg_val &=3D ~temp_sensor->registers->counter_mask;
>> >> + =A0 =A0 =A0 reg_val |=3D val;
>> >
>> > Sure you want to accept any value (including negative ones) here ?
>> > val is not shifted, and not masked against counter_mask, meaning it ca=
n write
>> > all bits of the register. That doesn't sound right.
>>
>> I will have a check.
>>
>> >
>> > It would make sense to call omap_configure_temp_sensor_counter() inste=
ad of duplicating
>> > the set functionality.
>>
>> Yes I will make use of that.
>>
>> >
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_counter);
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 return count;
>> >> +}
>> >> +
>> >> +static int omap_temp_sensor_read_temp(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct device_attribute *devattr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 char *buf)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvdat=
a(dev);
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp, ret =
=3D 0;
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >
>> > Unless bgap_dtemp_mask can change during runtime, and that change is p=
rotected by the mutex,
>> > this lock is unnecessary.
>>
>> It is read only and is updated by hardware. Change cannot be protected b=
y mutex.
>>
>> >
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_ctr=
l);
>> >> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>> >> +
>> >> + =A0 =A0 =A0 /* look up for temperature in the table and return the =
temperature */
>> >> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_=
VALUE) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid adc code reported=
 %d", temp);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> >
>> > Another wrong use of EDOM, and another value-free error message.
>>
>> Ok. I will use -EIO and drop the error message.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];
>> >> +
>> >> +out:
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 if (!ret)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>> >> +
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_rea=
d_temp,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);
>> >> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_ma=
x,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);
>> >> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_te=
mp_max_hyst,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst, =
0);
>> >> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_updat=
e_rate,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_update_rate, 0);
>> >> +
>> >
>> > ABI is update_interval. Please use it.
>>
>> Ok.
>>
>> >
>> >> +static struct attribute *omap_temp_sensor_attributes[] =3D {
>> >> + =A0 =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
>> >> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
>> >> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> >> + =A0 =A0 =A0 &sensor_dev_attr_update_rate.dev_attr.attr,
>> >> + =A0 =A0 =A0 NULL
>> >> +};
>> >> +
>> >> +static const struct attribute_group omap_temp_sensor_group =3D {
>> >> + =A0 =A0 =A0 .attrs =3D omap_temp_sensor_attributes,
>> >> +};
>> >> +
>> >> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp=
_sensor)
>> >> +{
>> >> + =A0 =A0 =A0 u32 ret =3D 0;
>> >> +
>> >> + =A0 =A0 =A0 if (temp_sensor->clk_on) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock =
already on\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->hwmon_dev);
>> >> + =A0 =A0 =A0 if (ret < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "get sy=
nc failed\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 temp_sensor->clk_on =3D 1;
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >
>> > Completely unnecessary lock.
>>
>> Ok
>>
>> >
>> >> +out:
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *tem=
p_sensor)
>> >
>> > Return code is not used anywhere, why bother providing one ?
>>
>> It is not checked in the error path. I can make it void.
>>
>> >
>> >> +{
>> >> + =A0 =A0 =A0 u32 ret =3D 0;
>> >> +
>> >> + =A0 =A0 =A0 if (!temp_sensor->clk_on) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "clock =
already off\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >
>> > ... and since you ignore the error anyway, why log it ?
>>
>> Ok. I will remove the log message.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* Gate the clock */
>> >> + =A0 =A0 =A0 ret =3D pm_runtime_put_sync(temp_sensor->hwmon_dev);
>> >> + =A0 =A0 =A0 if (ret < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "put sy=
nc failed\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> + =A0 =A0 =A0 temp_sensor->clk_on =3D 0;
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >
>> > Completely unnecessary lock.
>>
>> Ok
>>
>> >
>> >> +out:
>> >> + =A0 =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 t_hot, t_cold, temp;
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor =3D data;
>> >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the status of t_hot */
>> >> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_status)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->register=
s->status_hot_mask;
>> >> +
>> >> + =A0 =A0 =A0 /* Read the status of t_cold */
>> >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_status)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->register=
s->status_cold_mask;
>> >> +
>> >> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* One TALERT interrupt: Two sources
>> >> + =A0 =A0 =A0 =A0* If the interrupt is due to t_hot then mask t_hot a=
nd
>> >> + =A0 =A0 =A0 =A0* and unmask t_cold else mask t_cold and unmask t_hot
>> >> + =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 if (t_hot) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->mask=
_hot_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_=
cold_mask;
>> >> + =A0 =A0 =A0 } else if (t_cold) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~temp_sensor->registers->mask=
_cold_mask;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mask_=
hot_mask;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> >> +
>> >> + =A0 =A0 =A0 /* kobject_uvent to user space telling thermal threshol=
d crossed */
>> >> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_CHAN=
GE);
>> >> +
>> >> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 return IRQ_HANDLED;
>> >> +}
>> >> +
>> >> +static int __devinit omap_temp_sensor_probe(struct platform_device *=
pdev)
>> >> +{
>> >> + =A0 =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev->d=
ev.platform_data;
>> >> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>> >> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D 0;
>> >> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 val, clk_rate;
>> >> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 max_freq, min_freq;
>> >> +
>> >> + =A0 =A0 =A0 if (!pdata) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data miss=
ing\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KERNE=
L);
>> >> + =A0 =A0 =A0 if (!temp_sensor)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> >> +
>> >
>> > You have error messages all over the place, Why not here ?
>>
>> Ok. I will add an error message here.
>>
>> >
>> >> + =A0 =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>> >> +
>> >> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >> + =A0 =A0 =A0 if (!mem) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\n"=
);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >
>> > If you try to get the resource before allocating the memory, you don't=
 have to release
>> > the memory if the platform resource is missing.
>>
>> Ok. Here if i fail i am releasing temp_sensor memory which
>> has been allocated.
>>
>> >
>> >> + =A0 =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, "the=
rmal_alert");
>> >> + =A0 =A0 =A0 if (temp_sensor->irq < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname fai=
led\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resource_=
size(mem));
>> >> + =A0 =A0 =A0 temp_sensor->clock =3D NULL;
>> >> + =A0 =A0 =A0 temp_sensor->registers =3D pdata->registers;
>> >> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D &pdev->dev;
>> >> +
>> >> + =A0 =A0 =A0 if (pdata->max_freq && pdata->min_freq) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D pdata->max_freq;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D pdata->min_freq;
>> >> + =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D MAX_FREQ;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D MIN_FREQ;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> >> + =A0 =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> >> +
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> >> + =A0 =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> >> + =A0 =A0 =A0 =A0* may not be accurate
>> >> + =A0 =A0 =A0 =A0*/
>> >> +
>> >> + =A0 =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>bgap_efuse)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->is_efuse_valid =3D 1;
>> >
>> > is_efuse_valid is not used anywhere. Might as well drop it.
>>
>> Ok
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(temp_sensor->hwmon_dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invalid EFUSE, Non-tri=
mmed BGAP, Temp not accurate\n");
>> >
>> > dev_info might be better here.
>>
>> Ok.
>>
>> >
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>> >> + =A0 =A0 =A0 temp_sensor->clock =3D clk_get(temp_sensor->hwmon_dev, =
"fck");
>> >> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk: %d=
\n", ret);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable temp=
 sensor\n");
>> >
>> > omap_temp_sensor_clk_enable() already generates error messages.
>>
>> Ok. I will remove this.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, max_fre=
q);
>> >> + =A0 =A0 =A0 if (clk_rate < min_freq || clk_rate =3D 0xffffffff) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Error round rate\n=
");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EDOM;
>> >
>> > EDOM is wrong. Please use ENODEV.
>>
>> Ok
>>
>> >
>> > The error log doesn't really provide anything useful to the administra=
tor.
>> > Either add parameters, or drop it.
>>
>> Ok
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock r=
ate\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>> >> + =A0 =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);
>> >> + =A0 =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);
>> >> + =A0 =A0 =A0 /* 1 ms */
>> >> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>> >
>> > If temp_sensor->clk_rate * 2 is two seconds, as suggested below, 1 is =
not 1ms.
>> > 1ms would be temp_sensor->clk_rate / 1000.
>>
>> Yes! Wrong comment. It is configured to start the temperature conversion.
>> It represents 1 clock cycle of the temperature sensor fclk. I will corre=
ct this.
>>
>> >
>> >> +
>> >> + =A0 =A0 =A0 /* Wait till the first conversion is done wait for at l=
east 1ms */
>> >> + =A0 =A0 =A0 usleep_range(1000, 2000);
>> >> +
>> >> + =A0 =A0 =A0 /* Read the temperature once due to hw issue*/
>> >> + =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers-=
>temp_sensor_ctrl);
>> >> +
>> >> + =A0 =A0 =A0 /* Set 2 seconds time as default counter */
>> >> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate * 2);
>> >> +
>> >> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&pdev-=
>dev);
>> >> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_regis=
ter failed.\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_dev);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&omap_te=
mp_sensor_group);
>> >
>> > one line is sufficient here.
>>
>> Ok.
>>
>> >
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not create s=
ysfs files\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
>> >> +
>> >
>> > No other hwmon driver needs this. Doesn't the sysfs code take care of =
this ?
>>
>> Yes i will remove this.
>>
>> >
>> >> + =A0 =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER_R=
ISING | IRQF_ONESHOT,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp_sen=
sor);
>> >> + =A0 =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded i=
rq failed.\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> >> + =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */
>> >> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> >> + =A0 =A0 =A0 val |=3D temp_sensor->registers->mask_cold_mask
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor->registers->mask_hot_mask;
>> >> +
>> >> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctrl);
>> >> +
>> > This is racy. From Documentation/hwmon/submitting-patches:
>>
>> I read it. If i enable the interrupts before i have the sysfs
>> infrastructure ready.
>> I am likely to miss out on the uevent notification if the interrupt
>> occurs as soon as
>> i unmask. Correct me if my understanding is wrong.
>>
> See other email on sequence subject. I'll have to look into it in more de=
tail.
> later - no time right now ...

Ok

>
> Guenter
>
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
