From: Fenghua Yu <fenghua.yu@intel.com>
Date: Wed, 28 Jul 2010 23:15:08 +0000
Subject: Re: [lm-sensors] [PATH V2 4/5] Package Level Thermal Control and
Message-Id: <20100728231508.GB13469@fenghua-desk.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1280343653-26380-1-git-send-email-fenghua.yu@intel.com> <1280343653-26380-5-git-send-email-fenghua.yu@intel.com> <1280351860.17322.1.camel@groeck-laptop>
In-Reply-To: <1280351860.17322.1.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Chen Gong <gong.chen@linux.jf.intel.com>, Jean Delvare <khali@linux-fr.org>, "Wan, Huaxu" <huaxu.wan@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Wed, Jul 28, 2010 at 02:17:40PM -0700, Guenter Roeck wrote:
> On Wed, 2010-07-28 at 15:00 -0400, Fenghua Yu wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> >
> > -static int therm_throt_process(bool is_throttled, int level)
> > +static int therm_throt_process(bool new_event, int event, int level)
> >  {
> >         struct _thermal_state *state;
> > -       unsigned int this_cpu;
> > -       bool was_throttled;
> > +       unsigned int this_cpu = smp_processor_id();
> > +       bool old_event;
> >         u64 now;
> > +       struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
> > +
> > +       if (!new_event)
> > +               return 0;
> >
> As a result of this check and return, events will never be reset.

With the check, throttling returning to normal will not be reflected (i.e. only
throttling event is shown). I'll remove this check.
> 
> > -       this_cpu = smp_processor_id();
> >         now = get_jiffies_64();
> > -       if (level = CORE_LEVEL)
> > -               state = &per_cpu(thermal_state, this_cpu).core;
> > -       else
> > -               state = &per_cpu(thermal_state, this_cpu).package;
> > +       if (level = CORE_LEVEL) {
> > +               if (event = THERMAL_THROTTLING_EVENT)
> > +                       state = &pstate->core_throttle;
> > +               else if (event = POWER_LIMIT_EVENT)
> > +                       state = &pstate->core_power_limit;
> > +               else
> > +                        return 0;
> > +       } else if (level = PACKAGE_LEVEL) {
> > +               if (event = THERMAL_THROTTLING_EVENT)
> > +                       state = &pstate->package_throttle;
> > +               else if (event = POWER_LIMIT_EVENT)
> > +                       state = &pstate->package_power_limit;
> > +               else
> > +                       return 0;
> > +       } else
> > +               return 0;
> >
> > -       was_throttled = state->is_throttled;
> > -       state->is_throttled = is_throttled;
> > +       old_event = state->new_event;
> > +       state->new_event = new_event;
> >
> > -       if (is_throttled)
> > -               state->throttle_count++;
> > +       if (new_event)
> > +               state->count++;
> >
> >         if (time_before64(now, state->next_check) &&
> > -                       state->throttle_count != state->last_throttle_count)
> > +                       state->count != state->last_count)
> >                 return 0;
> >
> >         state->next_check = now + CHECK_INTERVAL;
> > -       state->last_throttle_count = state->throttle_count;
> > +       state->last_count = state->count;
> >
> >         /* if we just entered the thermal event */
> > -       if (is_throttled) {
> > -               printk(KERN_CRIT "CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> > -                     this_cpu,
> > -                     level = CORE_LEVEL ? "Core" : "Package",
> > -                     state->throttle_count);
> > +       if (new_event) {
> > +               if (event = THERMAL_THROTTLING_EVENT)
> > +                       printk(KERN_CRIT "CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> > +                               this_cpu,
> > +                               level = CORE_LEVEL ? "Core" : "Package",
> > +                               state->count);
> > +               else
> > +                       printk(KERN_CRIT "CPU%d: %s power limit notification (total events = %lu)\n",
> > +                               this_cpu,
> > +                               level = CORE_LEVEL ? "Core" : "Package",
> > +                               state->count);
> >
> >                 add_taint(TAINT_MACHINE_CHECK);
> >                 return 1;
> >         }
> 
> Since new_event is always true, code below will never be executed.
> That doesn't make sense to me.
After removing the previous new_event check, this code should be fine.

Thanks.

-Fenghua

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
