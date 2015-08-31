From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 31 Aug 2015 14:57:07 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <20150831145707.GG16853@twins.programming.kicks-ass.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-10-git-send-email-ray.huang@amd.com>
 <20150828064814.GB20153@nazgul.tnic>
 <20150828080418.GB13309@gmail.com>
 <20150829091914.GA8878@gmail.com>
 <20150830155322.GA26370@nazgul.tnic>
 <20150831083821.GE16853@twins.programming.kicks-ass.net>
 <55E455E8.1060208@roeck-us.net>
 <20150831133809.GM19282@twins.programming.kicks-ass.net>
 <55E45C76.3070704@roeck-us.net>
In-Reply-To: <55E45C76.3070704@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Mon, Aug 31, 2015 at 06:53:58AM -0700, Guenter Roeck wrote:

> What does that have to do with 'hwmon' ? The current implementation in the
> driver may not be a good idea, and maybe for good reasons; I can not
> comment on that. However, you concluded from that implementation that
> hwmon, the subsystem, would not be able to support 'much finer grained
> measurements than system wide'. I would like to understand how you reached
> that conclusion.

Purely going on what this driver does here. I assumed it was
representative of things, if not then good.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
