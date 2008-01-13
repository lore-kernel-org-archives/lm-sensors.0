From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sun, 13 Jan 2008 22:43:42 +0000
Subject: Re: [lm-sensors] lmsensors and gkrellm
Message-Id: <4dfa50520801131443h1bfc6569p8eb8314f58c91f88@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200801131658.26068.kiwionabike@xnet.co.nz>
In-Reply-To: <200801131658.26068.kiwionabike@xnet.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Carren,

> > Note: while this is true of AMD CPUs (k8temp is a PCI driver) this
> > isn't how Intel CPUs work. The coretemp driver reads the temperature
> > values from MSRs (model-specific registers) i.e. from the CPU directly.
>
> So does that make the coretemp values more accurate/reliable than the
> thermal_zone temps?

I stand corrected. Yes, I misunderstood how Intel CPUs report the
digital temp sensor. But Carren, whether the CPU reports the data
through PCI or through MSRs, it is just a digital temp sensor. (So,
what does that mean for temp control? It just means another input.)

In response to your other question -- why would your digital temp
sensors be lower? I can't claim any knowledge about how the chip is
actually engineered. But my SWAG (Scientifically Wildly in-Accurate
Guess) would be that the digital sensors are measuring the temperature
much closer to the execution core, while the analog thermal_zone
sensors are measuring the whole-chip average temperature. Intel Core
Duo chips had the very first releases of the Merom design, and
probably are more prone to overheat in the "misc" circuitry. That is,
the execution unit just got a huge overhaul and is incredibly
efficient. So if the digital temp sensor is close to it, it gives
Intel some nice benchmarks, but isn't the main suspect of overheating
on this particular design.

Or I could be completely wrong.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
