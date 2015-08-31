From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 31 Aug 2015 20:44:26 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <20150831204426.GI16853@twins.programming.kicks-ass.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-10-git-send-email-ray.huang@amd.com>
 <20150828064814.GB20153@nazgul.tnic>
 <20150828080418.GB13309@gmail.com>
 <20150829091914.GA8878@gmail.com>
 <20150830155322.GA26370@nazgul.tnic>
 <20150831083821.GE16853@twins.programming.kicks-ass.net>
 <20150831160622.GA29830@nazgul.tnic>
 <55E47E88.7080202@roeck-us.net>
In-Reply-To: <55E47E88.7080202@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Mon, Aug 31, 2015 at 09:19:20AM -0700, Guenter Roeck wrote:
> On 08/31/2015 09:06 AM, Borislav Petkov wrote:

> >That's a good point - I missed that during previous review. Rui, please
> >put the rdmsrl_safe_on_cpu() accesses in a separate function which you
> >run on a particular CPU, for your next version.
> >
> ... and maybe work with Peter to address the other hotplug related issues.
> 
> It might also be worthwhile thinking about per-CU attributes, if that
> provides any value (Peter's comments suggested that this might be the case).

Yeah, so it would allow measuring the power of a subset of compute
units. Typically only useful if you've partitioned your workload. But
since the hardware trivially supports it, its a waste to not expose it.

(Note that its not per-cpu, its per compute unit. What we do with perf
is export a cpumask)

My biggest problem is that all this is user readable and unthrottled. It
basically allows DoS (perf does not typically allow user access to CPU
wide resources).

Imagine joe user doing:

	for ((i=0; i<1000; i++)); do
		(while :; do cat /sys/foo/file > /dev/null ; done) &
	done

Even when contained to a subset of CPUs, that will cause an IPI storm on
all (/2) CPUs, even if you've tried really hard to keep users away from
some of them (see the above partitioning) because you're running some
important RT workload or whatnot.


As to hotplug, if you unplug any of the even numbered CPUs the whole
thing bails and returns 0, even if the corresponding odd CPU of the
compute unit it still online and perfectly capable of accessing the MSR.


As to relying on CPU numbering, maybe I should go write an APICID -> cpu
number randomizer, just for kicks to see what else fails.

We have topology information and cpumasks aplenty for things like this.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
