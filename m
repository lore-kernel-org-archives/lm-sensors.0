From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Sep 2011 19:59:33 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110918215933.385bcb29@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 17 Sep 2011 03:12:12 -0700, Guenter Roeck wrote:
> Hi Durgadoss,
> 
> On Sat, Sep 17, 2011 at 01:40:25AM -0400, R, Durgadoss wrote:
> > If we look at the file therm_throt.c, inside arch/x86/kernel/
> > cpu/mcheck/ I think we will get some idea.
> > 
> > There is some code which registers for thermal related interrupts
> > 
> > asmlinkage void smp_thermal_interrupt(struct pt_regs *regs)
> > {
> >         exit_idle();
> >         irq_enter();
> >         inc_irq_stat(irq_thermal_count);
> >         smp_thermal_vector();
> >         irq_exit();
> >         /* Ack only at the end to avoid potential reentry */
> >         ack_APIC_irq();
> > }
> > 
> > When our threshold interrupt occurs, the control comes here.
> > (We should enable the interrupt for this..)
> > And as of now, there is no code inside therm_throt that can
> > handle our threshold interrupts. For the past two days, I had
> > been working on a patch, to add this functionality, to therm_throt.
> > 
> > But the patch has to go to linux-x86_64 mailing list. I will copy
> > Jean & Guenter, while submitting this patch.
> > 
> Maybe I misunderstand something, but I don't think that will work.
> We can not have one module set parameters for interrupts to be handled
> by another. If the thermal throttling module is going to use
> the interrupts, the thresholds should be set there, not in the
> hwmon driver.

Actually it can be done using notification chains (coretemp registers a
callback function when loaded.) As I recall the mechanism is already in
place but unused at the moment. But that doesn't mean we want to do
this. I see no reason to make things more complex that they need to be,
if therm_throt registers the interrupt then it should deal with them by
itself. After all, we are discussing a brand new interface to deal with
this case, so it doesn't have to be in hwmon, it can be anywhere else.

But anyway, this discussion is pointless if we're talking about SMIs,
which is my impression so far (at least on my Thinkpad laptop - I need
to experiment further on the other machines.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
