From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Sep 2011 19:54:19 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110918215419.28d2a7d3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 17 Sep 2011 11:10:25 +0530, R, Durgadoss wrote:
> That said, I do not know the behaviour on a different kernel version,
> (especially older kernels) with a different BIOS. I do not see any
> mention of 'BIOS configuring (or can configure) these thresholds' in
> the SDM. For a double check, I am referring to IA Manual Vol-3A.Chapter-14:
> Download Link: 
> http://download.intel.com/design/processor/manuals/253668.pdf

Yes, I'm reading the same...

> In Section 14.5 it says:
> "On-die digital thermal sensor and interrupt mechanisms permit the OS to
> manage thermal conditions natively without relying on BIOS or other system
> board components."
> This is also one more reason why I believe BIOS is not changing
> these thresholds. But it might be wrong too.

Maybe the BIOS shouldn't do it if you stick to the SDM wording, by I
have a real world case on my desk where it does. As I said, this is a
popular series of machines, so we will have to deal with it.

> In older kernels (before Linux 3.0), the temp1_max sysfs interface
> reads the value from IA32_TEMPERATURE_TARGET register.
> But in recent machines, I don't think this register is supported.

I thought it was the other way around and it was not supported on older
CPUs, but it was on newer ones. Pretty hard to say though, given that
it's still undocumented.

> This is the reason, I wanted the sysfs interface names to be
> tempX_threshold[0/1] (or something but not interfere with temp1_max).
> Due to ABI considerations, we had to make it 'temp1_max'.
> May be we should leave temp1_max as such, and add temp1_threshold[0/1] ?
> 
> So, Jean, if your kernel's temp1_max interface is being read from
> IA32_TEMPERATURE_TARGET, I can imagine the change in values you
> reported.

No, my report was with the latest coretemp driver (backported to my
older kernel), so tempX_max not read from IA32_TEMPERATURE_TARGET, and
thresholds mapping to tempX_max and tempX_max_hyst.

> Could you please tell us, whether the change in values are seen
> in a newer kernel(Linux 3.0+) also ? Hope you find some time..

I can try, but I doubt it will change anything, as I'm testing with the
latest version of the coretemp driver anyway.

> Moreover, I do not see a mention of IA32_TEMPERATURE_TARGET in the SDM
> I am referring to. May be all of us don't see :-(

Not sure what you mean here, but if you mean bits 14-8 of MSR
IA32_TEMPERATURE_TARGET, then yes, as I said these are undocumented.
You can argue that we shouldn't use undocumented registers in our
driver, but Rudolf thought it was useful, and honestly, if we only used
documented information, the coretemp driver would not have existed in
the first place.

> > * The driver assumes that threshold0 is higher than threshold1. Looking
> >   at the SDM, there is no such asymmetry, both thresholds are
> >   equivalent. So my laptop's BIOS is in its own right when deciding that
> >   threshold1 is high and threshold0 is low. Given that 0 < 1, their
> >   decision makes even more sense than ours. It's an IBM/Lenovo Thinkpad
> >   T60p, a pretty popular series, so we can't just ignore this problem.
> >   A lot of users will be affected.
> 
> I feel the driver thinks the other way only. The store_ttarget function
> corresponding to temp1_max interface, reads values for Threshold1
> and store_tmin corresponding to temp1_max_hyst interface reads values
> for Threshold0. Kindly correct me if I am wrong here.

I know what the driver does, I was simply saying that it shouldn't do
it. This is pointless now anyway, as we agreed to rework the whole
interface.

> (...)
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

I doubt it. On my Thinkpad, the threshold interrupts are enabled, I see
the threshold values change under heavy load, but the TRM counters
in /proc/interrupts do not change. So at least in my case it really
seems that the interrupts are SMIs and not thermal event interrupts.

I find it really odd that the SDM doesn't seem to explain this. Or
maybe I am just not looking at the right place. 1874 pages is a lot.

> And as of now, there is no code inside therm_throt that can
> handle our threshold interrupts. For the past two days, I had
> been working on a patch, to add this functionality, to therm_throt.
> 
> But the patch has to go to linux-x86_64 mailing list. I will copy
> Jean & Guenter, while submitting this patch.
> 
> This is what I am planning to try out:
> 1. Catch the threshold interrupts in therm_throt

If we can at all...

> 2. Notify coretemp from therm_throt
>    (There is a function pointer exported for this)
> 3. Send UEvent from coretemp to the user space
> 4. Let the user space deal with the UEvent
>    (i.e let it take appropriate actions)

As Guenter wrote, it's questionable then why coretemp would be
responsible for this.

> > I admit I am not sure how to deal with all this. Suggestions are
> > welcome. What I'm sure of is that we don't want to let the coretemp
> > driver in the state it currently is... We will get a flood of user
> > complaints or at least questions if we do.
> 
> I agree. I plan to do the 4 steps that I mentioned above.
> Kindly correct/suggest alternatives.
> 
> And Sorry Jean, I think we are in different time zones.

Me being very busy is worse than the time zone difference, I'm afraid.

> That's why could not respond to this mail early.
> I woke up this morning reading this email..and replying now.

Take it easy :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
