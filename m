From: Huang Rui <ray.huang@amd.com>
Date: Fri, 28 Aug 2015 10:28:30 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <20150828102830.GB4191@hr-slim.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-10-git-send-email-ray.huang@amd.com>
 <20150827172746.GA27452@roeck-us.net>
In-Reply-To: <20150827172746.GA27452@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Thu, Aug 27, 2015 at 10:27:46AM -0700, Guenter Roeck wrote:
> On Thu, Aug 27, 2015 at 04:07:40PM +0800, Huang Rui wrote:
> > Add an accessor function amd_get_cores_per_cu() which returns the
> > number of cores per compute unit.
> > 
> > In a subsequent patch, we will use this function in fam15h_power
> > driver.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  arch/x86/include/asm/processor.h |  1 +
> >  arch/x86/kernel/cpu/amd.c        | 19 +++++++++++++++++--
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 19577dd..831ad682 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -810,6 +810,7 @@ static inline int mpx_disable_management(void)
> >  
> >  extern u16 amd_get_nb_id(int cpu);
> >  extern u32 amd_get_nodes_per_socket(void);
> > +extern u32 amd_get_cores_per_cu(void);
> >  
> >  static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
> >  {
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index 51ad2af..8ab939a 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -26,6 +26,9 @@
> >   */
> >  static u32 nodes_per_socket = 1;
> >  
> > +/* cores_per_cu: stores the number of cores per compute unit */
> > +static u32 cores_per_cu = 1;
> > +
> Is this value going to be constant even if there are multiple CPUs
> in the system ? In other words, if there are multiple CPUs, do
> they always have to have the same number of cores per CU ?
> 

Yes, the same type of processors have the fixed number of cores per
compute unit. Currently, the number is 2, but it might be more in
future.

Thanks,
Rui

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
