From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Aug 2015 13:53:58 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <55E45C76.3070704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com> <1440662866-28716-10-git-send-email-ray.huang@amd.com> <20150828064814.GB20153@nazgul.tnic> <20150828080418.GB13309@gmail.com> <20150829091914.GA8878@gmail.com> <20150830155322.GA26370@nazgul.tnic> <20150831083821.GE16853@twins.programming.kicks-ass.net> <55E455E8.1060208@roeck-us.net> <20150831133809.GM19282@twins.programming.kicks-ass.net>
In-Reply-To: <20150831133809.GM19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?windows-1252?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On 08/31/2015 06:38 AM, Peter Zijlstra wrote:
> On Mon, Aug 31, 2015 at 06:26:00AM -0700, Guenter Roeck wrote:
>> On 08/31/2015 01:38 AM, Peter Zijlstra wrote:
>>> On Sun, Aug 30, 2015 at 05:53:22PM +0200, Borislav Petkov wrote:
>>>> On Sat, Aug 29, 2015 at 11:19:14AM +0200, Ingo Molnar wrote:
>>>>> So let me withdraw my ack: the much more important question that I
>>>>> missed first time around, why is this reporting feature living in
>>>>> hwmon, not in perf? We have energy reporting facilities in perf that
>>>>> this should be synced to.
>>>>
>>>> Because there's already fam15h_power driver which is exactly for that.
>>>> Making it part of perf is then a question of cat-ting the same sysfs
>>>> file twice, at the beginning and at the end of the trace, which is
>>>> trivial.
>>>
>>> That don't make sense.
>>>
>>> Looking at the BKDG Fam 15h 60h-6Fh these MSRs are per compute unit.
>>> This means you can do much finer grained measurements than system wide
>>> -- which is all hwmon seems capable of.
>>>
>>
>> Is it ? Why ?
>
> Dunno, because there's that big old loop iterating all cpus?
>

What does that have to do with 'hwmon' ? The current implementation in the
driver may not be a good idea, and maybe for good reasons; I can not
comment on that. However, you concluded from that implementation that
hwmon, the subsystem, would not be able to support 'much finer grained
measurements than system wide'. I would like to understand how you reached
that conclusion.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
