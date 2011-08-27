From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Sat, 27 Aug 2011 16:49:30 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13ZGhzj4N63YGfFTG37LBaQrEQMmcjTssi5azcFYKLqaHA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
	<CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	<20110825140630.GB8684@ericsson.com>
	<1314287771.2796.40.camel@groeck-laptop>
	<CAJ6a13YcmJCHPOVvgUfV6-LB3+MCGjgbGv=9Ks3Rv5gRvr=r1A@mail.gmail.com>
	<1314375395.2796.82.camel@groeck-laptop>
In-Reply-To: <1314375395.2796.82.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 26, 2011 at 9:46 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, 2011-08-26 at 07:17 -0400, J, KEERTHY wrote:
>> On Thu, Aug 25, 2011 at 9:26 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Thu, 2011-08-25 at 10:06 -0400, Guenter Roeck wrote:
>> >> On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
>> >> > On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
>> >> > <guenter.roeck@ericsson.com> wrote:
>> >> > > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
>> >> > >> On chip temperature sensor driver. The driver monitors the tempe=
rature of
>> >> > >> the MPU subsystem of the OMAP4. It sends notifications to the us=
er space if
>> >> > >> the temperature crosses user defined thresholds via kobject_ueve=
nt interface.
>> >> > >> The user is allowed to configure the temperature thresholds vis =
sysfs nodes
>> >> > >> exposed using hwmon interface.
>> >> > >>
>> >> > >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> >> > >> Cc: Jean Delvare <khali@linux-fr.org>
>> >> > >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> >> > >> Cc: lm-sensors@lm-sensors.org
>> >> > >
>> >
>> > [ ... ]
>> >
>> >
>> >> >
>> >> > >
>> >> > >> + =A0 =A0 =A0 }
>> >> > >> +
>> >> > >> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>> >> > >> + =A0 =A0 =A0 /* obtain the T cold value */
>> >> > >> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->regis=
ters->bgap_threshold);
>> >> > >> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->thres=
hold_tcold_mask) >>
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor-=
>registers->threshold_tcold_mask);
>> >> > >> +
>> >> > >> + =A0 =A0 =A0 if (t_hot < t_cold) {
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> > >
>> >> > > Context specific limitations like this one are not a good idea, s=
ince it assumes an order of changing max
>> >> > > and max_hysteresis which is not necessarily guaranteed by the app=
lication making the change, nor is a
>> >> > > change order order well defined or even possible. Applications sh=
ould not have to bother about this.
>> >> >
>> >> > The hardware behavior is like this. As long as the temperature is b=
elow
>> >> > t_hot no interrupts are fired. Once the temperature increases above
>> >> > t_hot we get an
>> >> > interrupt. In order to avoid repeated interrupts we mask the t_hot =
interrupt
>> >> > in the interrupt handler and enable the t_cold interrupts. So we ge=
t a t_cold
>> >> > interrupt only when the temperature drops below the t_cold value. H=
ence
>> >> > setting the t_cold higher than t_hot will mess up the state machine.
>> >> >
>> >> > t_hot value should be greater than t_cold value.
>> >> >
>> >> One option would be to update t_cold (max_hyst) automatically in that=
 case.
>> >>
>> >> Problem here is that you expect the application to know, depending on=
 the current
>> >> values of (max, max_hyst), how to update both limits in order. That i=
s not a reasonable
>> >> expectation.
>> >>
>> > One possible solution would be to have a single function to set both
>> > t_cold and t_hot, and call it from both initialization code and from t=
he
>> > set functions. That would unify all the register setting and interrupt
>> > enable code.
>> >
>> > Regarding the actual values to set, you can (as an example) use the
>> > following approach:
>> >
>> > - If max is set, and t_hot < t_cold, adjust t_cold to the new value of
>> > t_hot.
>> >
>> > - if max_hyst is set, and t_cold > t_hot, set t_cold to the new value =
of
>> > t_hot.
>> >
>> > So, in other words, your new unified function would only need the
>> > following simple validation:
>> >
>> > =A0 =A0 =A0 =A0if (t_cold > t_hot)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t_cold =3D t_hot;
>>
>> One concern here. There should be a hysteresis
>> difference between the two and can not be equal.
>> I need to add a hysteresis value to t_hot so as
>> to maintain t_hot > t_cold condition.
>>
> Sure, makes sense. Was that in your original patch ? Just wondering.

Original patch never let the user set thresholds which failed to
satisfy the condition t_hot > t_cold. The original patch threw up
error if this condition was violated.

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
