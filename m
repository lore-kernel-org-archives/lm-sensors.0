From: Fenghua Yu <fenghua.yu@intel.com>
Date: Fri, 20 Aug 2010 16:58:47 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] Package Level Thermal Control and
Message-Id: <20100820165847.GB22602@linux-os.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C485DF1.5050407@linux.intel.com> <20100722162222.GA22450@linux-os.sc.intel.com> <20100722172726.GA4914@ericsson.com> <20100722175225.GB22450@linux-os.sc.intel.com> <20100722185814.GA5235@ericsson.com> <20100722212111.GC22450@linux-os.sc.intel.com> <20100819174632.239aed93@hyperion.delvare> <20100819162719.GB4160@ericsson.com> <20100819205120.GA22602@linux-os.sc.intel.com> <20100820103356.01c9907f@hyperion.delvare>
In-Reply-To: <20100820103356.01c9907f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "Wan, Huaxu" <huaxu.wan@intel.com>, lkml <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 20, 2010 at 01:33:56AM -0700, Jean Delvare wrote:
> Fenghua,
> 
> On Thu, 19 Aug 2010 13:51:20 -0700, Fenghua Yu wrote:
> > On Thu, Aug 19, 2010 at 09:27:19AM -0700, Guenter Roeck wrote:
> > > I might spend some time rewriting the coretemp driver as described above,
> > > unless someone else picks it up, and unless there is opposition. 
> > > Obviously, that won't include the package sensor since there is now
> > > a separate driver for it.
> >
> > I agree with this method too. On a multiple socket system, the current coretemp
> > output will cause confusion since it only outputs core# without package#.
> 
> Good point.
> 
> > If it's ok for you, I can rewrite this part to have hwmon device per CPU with
> > both core and package thermal info and send out RFC patch soon.
> 
> Yes, please! If you have time to work on this, it would be very great.
> I am really curious to see how the driver would look like if we go with
> this approach. I can test the code, too (although I understand you
> won't have any difficulties getting your hands on recent Intel
> systems ;)
> 
> Also see my reply in the other thread about the handling of removed
> siblings. I suspect it will be very easy to add to the new design.
> 
> Side question: is it safe to assume a maximum of 2 siblings per core on
> Intel x86 CPUs?
I think architecturally it's not safe to assume 2 siblings per core on x86
although so far HT implementations have been having 2 siblings per core.

Linux kernel doesn't assume 2 siblings per core during initialization (please
check arch/x86/kernel/smpboot.c). This is right way to handle potential non 2
sibling case in the future.

Thanks.

-Fenghua

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
