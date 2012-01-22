From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jan 2012 19:10:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83795) Unconditionally support manual fan speed control
Message-Id: <20120122201031.456633ad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120122183613.4ba050f6@endymion.delvare>
In-Reply-To: <20120122183613.4ba050f6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Jan 2012 09:52:10 -0800, Guenter Roeck wrote:
> Hi Jean,
> 
> On Sun, Jan 22, 2012 at 12:36:13PM -0500, Jean Delvare wrote:
> > Manual fan speed control uses a standard interface and has received
> > sufficient testing and review by now, it can be enabled
> > unconditionally. This includes attributes pwm[1-8], pwm[1-8]_enable,
> > pwm[1-8]_mode and pwm[1-8]_freq.
> > 
> > We only let the user switch from automatic mode to manual mode, but
> > not the other way around, as automatic control settings may not have
> > been set properly by the BIOS.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  drivers/hwmon/Kconfig  |    9 +++++----
> >  drivers/hwmon/w83795.c |   26 ++++++++++++++++++--------
> >  2 files changed, 23 insertions(+), 12 deletions(-)
> > (...)
> > @@ -2006,15 +2014,17 @@ static int w83795_handle_files(struct de
> >  		}
> >  	}
> >  
> > -#ifdef CONFIG_SENSORS_W83795_FANCTRL
> >  	for (i = 0; i < data->has_pwm; i++) {
> > +#ifdef CONFIG_SENSORS_W83795_FANCTRL
> >  		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
> > +#else
> > +		for (j = 0; j < 4; j++) {
> > +#endif
> 
> In situations like this I came to prefer something like
> 
> #ifdef CONFIG_SENSORS_W83795_FANCTRL
> #define NUM_PWM_ATTRIBUTES	ARRAY_SIZE(w83795_pwm[0])
> #else
> #define NUM_PWM_ATTRIBUTES	4
> #endif
> ...
> 		for (j = 0; j < NUM_PWM_ATTRIBUTES; j++)
> 
> to avoid the ifdef in the code, especially in situations like this where opening
> and closing brackets no longer match due to the ifdef.

Agreed, I'll update the patch that way and resend.

> Other than that,
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> I guess this should be independent of the multiline comment patch I sent out earlier.
> Would be good, though, if both are in the same tree. Do you want me to take both patches,
> or do you want to take them ? Let me know.

They are independent indeed, but I agree with your reasoning still. As
I maintain the w83795 driver I propose that I pick both patches in my
tree.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
