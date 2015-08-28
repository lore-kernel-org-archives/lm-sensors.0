From: Borislav Petkov <bp@alien8.de>
Date: Fri, 28 Aug 2015 08:56:51 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <20150828085651.GA21769@nazgul.tnic>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-10-git-send-email-ray.huang@amd.com>
 <20150828064814.GB20153@nazgul.tnic>
 <20150828080418.GB13309@gmail.com>
In-Reply-To: <20150828080418.GB13309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>
Cc: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Fri, Aug 28, 2015 at 10:04:18AM +0200, Ingo Molnar wrote:
> Looks good to me in theory.

Thanks.

> I suspect we might want to factor the 'compute unit' logic out a bit
> more if usage becomes more widespread - but right now it's hwmon
> drivers only,right?

Yeah.

My angle is to extend stuff as we go and only when we need it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
