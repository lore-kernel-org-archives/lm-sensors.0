From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Sep 2015 16:06:52 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <55E5CD1C.4070502@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-10-git-send-email-ray.huang@amd.com> <20150828064814.GB20153@nazgul.tnic> <20150828080418.GB13309@gmail.com> <20150829091914.GA8878@gmail.com> <20150830155322.GA26370@nazgul.tnic> <20150831083821.GE16853@twins.programming.kicks-ass.net> <20150831160622.GA29830@nazgul.tnic> <55E47E88.7080202@roeck-us.net> <20150831204426.GI16853@twins.programming.kicks-ass.net> <55E4C5F8.6050303@roeck-us.net> <20150901155600.GA8497@nazgul.tnic>
In-Reply-To: <20150901155600.GA8497@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On 09/01/2015 08:56 AM, Borislav Petkov wrote:
> On Mon, Aug 31, 2015 at 02:24:08PM -0700, Guenter Roeck wrote:
>> That is a matter of driver implementation. Very commonly hwmon drivers
>> implement value caching, where data from the device is only read at
>> minimum intervals, and the cached values are reported if the information
>> is polled too rapidly.
>
> I don't see how we can use cached values in that case as they'd be
> basically a lie as to how much power the CU/processor has consumed. I
> guess it would be fairer to the user to warn instead and not issue any
> values or to simply delay the read to a min timeout...
>

This is all a matter of ABI description. I personally don't see the
harm in caching values for up to <n> milliseconds and documenting that
readings may reflect power consumption from <n> milliseconds ago.
However, I don't mind any other solution either if that is considered
unacceptable, as long as that solution doesn't break the ABI.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
