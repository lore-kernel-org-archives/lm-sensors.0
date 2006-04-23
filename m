From: roger@planbit.co.uk (Roger Lucas)
Date: Sun, 23 Apr 2006 19:13:13 +0000
Subject: [lm-sensors] Kernel fault from ACPI when using W83627EHG on
Message-Id: <20060423191311.9A23512ED4@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060420235351.9D72212ED4@bluewhale.planbit.co.uk>
In-Reply-To: <20060420235351.9D72212ED4@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> -----Original Message-----
> From: Jean Delvare [mailto:khali at linux-fr.org]
> Sent: 23 April 2006 19:40
> To: Roger Lucas
> Cc: LM Sensors
> Subject: Re: [lm-sensors] Kernel fault from ACPI when using W83627EHG on
> 2.6.15
> 
> Hi Roger,
> 
> When starting a new thread, please do NOT use the "reply" function of
> your e-mail client on a random post. This confuses users of threading
> e-mail clients a lot.

I thought that I had started the thread with a new subject line.  Is there
something else that I am missing that happens behind-the-scenes?

> 
> > Although booting with "acpi=off" is a workaround, I would _really_ like
> to
> > have ACPI running as it means that the power button on the front of the
> box
> > does a controlled shutdown (rather than a hard power-off) if pressed
> briefly
> > as well as a few other nice features.
> 
> The various ACPI features can be built modular. You could try this, and
> only load the parts you need (e.g. ac, button) and not the ones which
> are probably responsible for the crash (e.g. thermal). This might help
> you survive for now, and isolate the problem within acpi.
> 
> And this definitely needs to be reported to the acpi people (bugzilla?)

I've raised the problem on the mailing list: 
http://permalink.gmane.org/gmane.linux.acpi.devel/17523

I still want to know what is really going on though.  This ACPI area is not
one I am familiar with, and although I have tried reading the documentation,
much of it is old and much more seems to indicate that a lot is
manufacturer-specific.

I have a few work-arounds for this problem, but I'm not comfortable using
them until I know what is actually going on.  Disabling ACPI completely
resolves the problem (but I lose ACPI).  Removing the "thermal" module in
ACPI stops the kernel dump, but the machine still runs very slowly until the
over-temperature situation clears.  This may be correct behaviour (e.g. the
processor is run at a much lower clock speed to help cool it down) but I
don't know for sure.   If I just set a very high cpu temperature limit (e.g.
95C) then this also "fixes" the problem, but it is really just a hack rather
than a real solution.

Hopefully, the guys on the ACPI mailing list can help.  This doesn't seem to
be a problem with lm-sensors (as far as I can see).

> 
> --
> Jean Delvare


