From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Sat, 17 Sep 2011 05:52:25 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E8D6D182@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Some clarifications from my side.
I am testing the coretemp driver code on Linux-3.0-rc6
Kernel on a Core i5 machine running Fedora 12.
All my observations are w.r.t this configuration.

> 
> Worse than this. Reloading the driver changes the values.
> 
> I think I finally understood what is going on. The threshold values are
> adjusted dynamically based on the measured temperature. This is on
> kernel 2.6.32 where the kernel has no clue about these thresholds, so
> the only possibility I can think of is that the BIOS is doing it. And
> "hyst" is consistently higher than "high", which means that the BIOS has
> decided on an opposite convention to what the coretemp driver is doing.
> 

I do not think the BIOS is changing the threshold values (temp1_max
and temp1_max_hyst) in my case. They are both 0 when I insmod the 
driver, and remain 0 until I 'echo' some values into it.
As you rightly pointed out below, the SDM does not restrict the
values for _max or max_hyst. I can very well make max_hyst higher than _max.

> So our driver makes many assumptions which aren't verified in my case:
> 
> * The driver shouldn't assume that the threshold values are under his
>   sole control. Reading the values once at initialization time and
>   never again after that is not correct.
> 

In My BIOS it is not changing anything. So, unless the driver changes it
the values remain the same.

That said, I do not know the behaviour on a different kernel version,
(especially older kernels) with a different BIOS. I do not see any
mention of 'BIOS configuring (or can configure) these thresholds' in
the SDM. For a double check, I am referring to IA Manual Vol-3A.Chapter-14:
Download Link: 
http://download.intel.com/design/processor/manuals/253668.pdf

In Section 14.5 it says:
"On-die digital thermal sensor and interrupt mechanisms permit the OS to
manage thermal conditions natively without relying on BIOS or other system
board components."
This is also one more reason why I believe BIOS is not changing
these thresholds. But it might be wrong too.

In older kernels (before Linux 3.0), the temp1_max sysfs interface
reads the value from IA32_TEMPERATURE_TARGET register.
But in recent machines, I don't think this register is supported.
This is the reason, I wanted the sysfs interface names to be
tempX_threshold[0/1] (or something but not interfere with temp1_max).
Due to ABI considerations, we had to make it 'temp1_max'.
May be we should leave temp1_max as such, and add temp1_threshold[0/1] ?

So, Jean, if your kernel's temp1_max interface is being read from
IA32_TEMPERATURE_TARGET, I can imagine the change in values you
reported.

Could you please tell us, whether the change in values are seen
in a newer kernel(Linux 3.0+) also ? Hope you find some time..

Moreover, I do not see a mention of IA32_TEMPERATURE_TARGET in the SDM
I am referring to. May be all of us don't see :-(

> * The driver assumes that threshold0 is higher than threshold1. Looking
>   at the SDM, there is no such asymmetry, both thresholds are
>   equivalent. So my laptop's BIOS is in its own right when deciding that
>   threshold1 is high and threshold0 is low. Given that 0 < 1, their
>   decision makes even more sense than ours. It's an IBM/Lenovo Thinkpad
>   T60p, a pretty popular series, so we can't just ignore this problem.
>   A lot of users will be affected.
> 

I feel the driver thinks the other way only. The store_ttarget function
corresponding to temp1_max interface, reads values for Threshold1
and store_tmin corresponding to temp1_max_hyst interface reads values
for Threshold0. Kindly correct me if I am wrong here.

> * The driver artificially binds the two thresholds by making one the
>   _hyst of the other. I see no such relation in the datasheet though,

I completely agree with you that the thresholds are independent.
So, we might have to remove the _hyst from the interface name.
More than that, changing the interface names would be clean I believe.

>   both thresholds appear to be completely independent. I know that this
>   wasn't Durgadoss' original implementation and we had him change to
>   that, but retrospectively this seems to have been a mistake.
> 

I also feel the same. But I am all for fixing this.

> I presume that my BIOS leverages the interrupts associated with the
> thresholds to do dynamic thermal management, either by fan speed control
> or by CPU throttling, or anything else, or a mix of all these.
> 
> Durgadoss, please speak up if anything I wrote above isn't correct.
> 
> This brings up a question I asked before but never got an answer to,
> and it seems I can't find the answer in the SDM either: where are the
> interrupts going? Are these by any chance SMIs which the kernel has no
> way to deal with?
> 

Alright, here comes the million dollar question:
where are the interrupts going?

Honestly I do not have a complete answer. I am writing
Whatever I know, from the kernel code base.

If we look at the file therm_throt.c, inside arch/x86/kernel/
cpu/mcheck/ I think we will get some idea.

There is some code which registers for thermal related interrupts

asmlinkage void smp_thermal_interrupt(struct pt_regs *regs)
{
        exit_idle();
        irq_enter();
        inc_irq_stat(irq_thermal_count);
        smp_thermal_vector();
        irq_exit();
        /* Ack only at the end to avoid potential reentry */
        ack_APIC_irq();
}

When our threshold interrupt occurs, the control comes here.
(We should enable the interrupt for this..)
And as of now, there is no code inside therm_throt that can
handle our threshold interrupts. For the past two days, I had
been working on a patch, to add this functionality, to therm_throt.

But the patch has to go to linux-x86_64 mailing list. I will copy
Jean & Guenter, while submitting this patch.

This is what I am planning to try out:
1. Catch the threshold interrupts in therm_throt
2. Notify coretemp from therm_throt
   (There is a function pointer exported for this)
3. Send UEvent from coretemp to the user space
4. Let the user space deal with the UEvent
   (i.e let it take appropriate actions)

> I admit I am not sure how to deal with all this. Suggestions are
> welcome. What I'm sure of is that we don't want to let the coretemp
> driver in the state it currently is... We will get a flood of user
> complaints or at least questions if we do.

I agree. I plan to do the 4 steps that I mentioned above.
Kindly correct/suggest alternatives.

And Sorry Jean, I think we are in different time zones.
That's why could not respond to this mail early.
I woke up this morning reading this email..and replying now.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
