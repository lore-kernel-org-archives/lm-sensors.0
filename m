From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 28 Aug 2015 08:04:18 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <20150828080418.GB13309@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-10-git-send-email-ray.huang@amd.com>
 <20150828064814.GB20153@nazgul.tnic>
In-Reply-To: <20150828064814.GB20153@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@alien8.de>
Cc: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>


* Borislav Petkov <bp@alien8.de> wrote:

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
> 
> Btw, this needs an ACK from a tip person if it goes through the hwmon
> tree.

Looks good to me in theory.

I suspect we might want to factor the 'compute unit' logic out a bit more if usage 
becomes more widespread - but right now it's hwmon drivers only,right?

Thanks,

	Ingo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
