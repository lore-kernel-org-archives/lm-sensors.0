From: Huang Rui <ray.huang@amd.com>
Date: Fri, 28 Aug 2015 10:42:02 +0000
Subject: Re: [lm-sensors] [PATCH 10/15] hwmon, fam15h_power: add compute unit accumulated power
Message-Id: <20150828104202.GC4191@hr-slim.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-11-git-send-email-ray.huang@amd.com>
 <20150828080335.GA13309@gmail.com>
In-Reply-To: <20150828080335.GA13309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Fri, Aug 28, 2015 at 10:03:35AM +0200, Ingo Molnar wrote:
> 
> * Huang Rui <ray.huang@amd.com> wrote:
> 
> > @@ -249,6 +254,21 @@ static int fam15h_power_init_data(struct pci_dev *f4,
> >  
> >  	data->max_cu_acc_power = tmp;
> >  
> > +	cores_per_cu = amd_get_cores_per_cu();
> > +	cu_num = boot_cpu_data.x86_max_cores / cores_per_cu;
> > +
> > +	WARN_ON_ONCE(cu_num > MAX_CUS);
> > +
> > +	for (cpu = 0; cpu < cu_num * cores_per_cu; cpu += cores_per_cu) {
> 
> so 'cu_num * cores_per_cu' is really a roundabout way to say 
> boot_cpu_data.x86_max_cores?
> 

Oh, yes. :)
I will update it at v2.

> > +		cu = cpu / cores_per_cu;
> > +		if (rdmsrl_safe_on_cpu(cpu, MSR_F15H_CU_PWR_ACCUMULATOR,
> > +				       &data->cu_acc_power[cu])) {
> > +			pr_err("Failed to read compute unit power accumulator MSR on core%d\n",
> > +			       cpu);
> 
> Please don't break printk lines mid-line - ignore checkpatch in this case.
> 

OK, I got it.

> Also, the message talks about 'core', while a CPU ID is printed.
> 

Yes, but actually this value is for the compute unit which the core
belongs to.
E.X. the MSR_F15H_CU_PWR_ACCUMULATOR value is the same between core 0
and core 1. Because they belong to the same compute unit.

Thanks,
Rui

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
