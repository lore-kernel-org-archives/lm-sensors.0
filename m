From: Borislav Petkov <bp@alien8.de>
Date: Mon, 31 Aug 2015 16:06:22 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <20150831160622.GA29830@nazgul.tnic>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-10-git-send-email-ray.huang@amd.com>
 <20150828064814.GB20153@nazgul.tnic>
 <20150828080418.GB13309@gmail.com>
 <20150829091914.GA8878@gmail.com>
 <20150830155322.GA26370@nazgul.tnic>
 <20150831083821.GE16853@twins.programming.kicks-ass.net>
In-Reply-To: <20150831083821.GE16853@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Mon, Aug 31, 2015 at 10:38:21AM +0200, Peter Zijlstra wrote:
> Looking at the BKDG Fam 15h 60h-6Fh these MSRs are per compute unit.
> This means you can do much finer grained measurements than system wide

Well, we can do finer-grained if needed. I'm all for everything which
has a good use case. The use case we had in mind here was the physical
processor power consumption for a time period.

> -- which is all hwmon seems capable of.

I guess we can do both - perf and hwmon. I don't see why not.

> Not to mention the proposed code is horrible, who in their right mind
> does two rdmsrl_safe_on_cpu() back to back.

That's a good point - I missed that during previous review. Rui, please
put the rdmsrl_safe_on_cpu() accesses in a separate function which you
run on a particular CPU, for your next version.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
