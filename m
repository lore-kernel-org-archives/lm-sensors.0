From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 16:16:35 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V3] hwmon: OMAP4: On die temperature
Message-Id: <1314375395.2796.82.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824171612.GA8160@ericsson.com>
	 <CAJ6a13b-0TPwqRku5_72B3Sa0gRyZOrYp-qAOuTvB5Q+G-x3Bg@mail.gmail.com>
	 <20110825140630.GB8684@ericsson.com>
	 <1314287771.2796.40.camel@groeck-laptop>
	 <CAJ6a13YcmJCHPOVvgUfV6-LB3+MCGjgbGv=9Ks3Rv5gRvr=r1A@mail.gmail.com>
In-Reply-To: <CAJ6a13YcmJCHPOVvgUfV6-LB3+MCGjgbGv=9Ks3Rv5gRvr=r1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, 2011-08-26 at 07:17 -0400, J, KEERTHY wrote:
> On Thu, Aug 25, 2011 at 9:26 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Thu, 2011-08-25 at 10:06 -0400, Guenter Roeck wrote:
> >> On Thu, Aug 25, 2011 at 06:30:07AM -0400, J, KEERTHY wrote:
> >> > On Wed, Aug 24, 2011 at 10:46 PM, Guenter Roeck
> >> > <guenter.roeck@ericsson.com> wrote:
> >> > > On Wed, Aug 24, 2011 at 10:37:12AM -0400, Keerthy wrote:
> >> > >> On chip temperature sensor driver. The driver monitors the temperature of
> >> > >> the MPU subsystem of the OMAP4. It sends notifications to the user space if
> >> > >> the temperature crosses user defined thresholds via kobject_uevent interface.
> >> > >> The user is allowed to configure the temperature thresholds vis sysfs nodes
> >> > >> exposed using hwmon interface.
> >> > >>
> >> > >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> > >> Cc: Jean Delvare <khali@linux-fr.org>
> >> > >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> >> > >> Cc: lm-sensors@lm-sensors.org
> >> > >
> >
> > [ ... ]
> >
> >
> >> >
> >> > >
> >> > >> +       }
> >> > >> +
> >> > >> +       mutex_lock(&temp_sensor->sensor_mutex);
> >> > >> +       /* obtain the T cold value */
> >> > >> +       t_cold = omap_temp_sensor_readl(temp_sensor,
> >> > >> +                       temp_sensor->registers->bgap_threshold);
> >> > >> +       t_cold = (t_cold & temp_sensor->registers->threshold_tcold_mask) >>
> >> > >> +                       __ffs(temp_sensor->registers->threshold_tcold_mask);
> >> > >> +
> >> > >> +       if (t_hot < t_cold) {
> >> > >> +               count = -EINVAL;
> >> > >> +               goto out;
> >> > >
> >> > > Context specific limitations like this one are not a good idea, since it assumes an order of changing max
> >> > > and max_hysteresis which is not necessarily guaranteed by the application making the change, nor is a
> >> > > change order order well defined or even possible. Applications should not have to bother about this.
> >> >
> >> > The hardware behavior is like this. As long as the temperature is below
> >> > t_hot no interrupts are fired. Once the temperature increases above
> >> > t_hot we get an
> >> > interrupt. In order to avoid repeated interrupts we mask the t_hot interrupt
> >> > in the interrupt handler and enable the t_cold interrupts. So we get a t_cold
> >> > interrupt only when the temperature drops below the t_cold value. Hence
> >> > setting the t_cold higher than t_hot will mess up the state machine.
> >> >
> >> > t_hot value should be greater than t_cold value.
> >> >
> >> One option would be to update t_cold (max_hyst) automatically in that case.
> >>
> >> Problem here is that you expect the application to know, depending on the current
> >> values of (max, max_hyst), how to update both limits in order. That is not a reasonable
> >> expectation.
> >>
> > One possible solution would be to have a single function to set both
> > t_cold and t_hot, and call it from both initialization code and from the
> > set functions. That would unify all the register setting and interrupt
> > enable code.
> >
> > Regarding the actual values to set, you can (as an example) use the
> > following approach:
> >
> > - If max is set, and t_hot < t_cold, adjust t_cold to the new value of
> > t_hot.
> >
> > - if max_hyst is set, and t_cold > t_hot, set t_cold to the new value of
> > t_hot.
> >
> > So, in other words, your new unified function would only need the
> > following simple validation:
> >
> >        if (t_cold > t_hot)
> >                t_cold = t_hot;
> 
> One concern here. There should be a hysteresis
> difference between the two and can not be equal.
> I need to add a hysteresis value to t_hot so as
> to maintain t_hot > t_cold condition.
> 
Sure, makes sense. Was that in your original patch ? Just wondering.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
