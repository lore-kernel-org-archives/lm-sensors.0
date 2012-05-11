From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 11 May 2012 11:32:02 +0000
Subject: Re: [lm-sensors] Coretemp: Fix threshold attributes patch
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB5912334F@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
I have tried to answer some of your questions here.
Kindly let me know your opinion.

[snip.]
 
> IIRC my main concern was that nobody was ever able to explain what
> semantics the thresholds were supposed to have, i.e. whether they were
> low or high limits, what was supposed to happen when they were crossed
> and who was responsible for acting upon alarm and clearing these alarms.

Semantics:
There are two thresholds. One is supposed to be lower than the input temperature,
and other one higher (Initially they are both zero). When the input temperature
crosses any of these thresholds in either (high to low, low to high) the HW generates
an interrupt.

What can be done:
There is an MSR where we can configure whether this interrupt should be
handled by the BIOS or by the OS. If we configure it to OS mode,
then the 'therm_throt.c' receives this interrupt.

Coretemp receives notification from therm_throt,
and clears the status bits (like a standard interrupt
handler) and forwards the notification, in either of the two ways:

1. The user space (through an UEvent) may receive this notification and
throttle appropriate components.
2. Or coretemp can notify the Thermal framework inside kernel
(through an EXPORT_SYMBOL API)

If we configure it to the BIOS mode, this interrupt takes the system to the
SMM mode. (and OS will not receive this interrupt)
More details in this SDM:
http://www.scs.stanford.edu/~reddy/links/ia32/ia32_3.pdf
Chapter 8 on APIC's. Page: 331

> 
> As long as these questions are unanswered I don't feel safe applying
> your patch, because I suspect it could conflict with the BIOS, and I
> also don't see any value for the users.

We can enable this whole threshold thing in our driver, only after
checking that the interrupt is not configured for BIOS mode.
That way it will not conflict with the BIOS.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
