From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 17 Sep 2011 10:12:12 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110917101212.GA18903@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durgadoss,

On Sat, Sep 17, 2011 at 01:40:25AM -0400, R, Durgadoss wrote:
> Hi Jean,
> 
> Some clarifications from my side.
> I am testing the coretemp driver code on Linux-3.0-rc6
> Kernel on a Core i5 machine running Fedora 12.
> All my observations are w.r.t this configuration.
> 
[ ... ]

> Alright, here comes the million dollar question:
> where are the interrupts going?
> 
> Honestly I do not have a complete answer. I am writing
> Whatever I know, from the kernel code base.
> 
> If we look at the file therm_throt.c, inside arch/x86/kernel/
> cpu/mcheck/ I think we will get some idea.
> 
> There is some code which registers for thermal related interrupts
> 
> asmlinkage void smp_thermal_interrupt(struct pt_regs *regs)
> {
>         exit_idle();
>         irq_enter();
>         inc_irq_stat(irq_thermal_count);
>         smp_thermal_vector();
>         irq_exit();
>         /* Ack only at the end to avoid potential reentry */
>         ack_APIC_irq();
> }
> 
> When our threshold interrupt occurs, the control comes here.
> (We should enable the interrupt for this..)
> And as of now, there is no code inside therm_throt that can
> handle our threshold interrupts. For the past two days, I had
> been working on a patch, to add this functionality, to therm_throt.
> 
> But the patch has to go to linux-x86_64 mailing list. I will copy
> Jean & Guenter, while submitting this patch.
> 
Maybe I misunderstand something, but I don't think that will work.
We can not have one module set parameters for interrupts to be handled
by another. If the thermal throttling module is going to use
the interrupts, the thresholds should be set there, not in the
hwmon driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
