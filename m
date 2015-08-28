From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 28 Aug 2015 08:00:23 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <55E01517.2000104@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com> <1440662866-28716-10-git-send-email-ray.huang@amd.com> <20150828064814.GB20153@nazgul.tnic>
In-Reply-To: <20150828064814.GB20153@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On 08/27/2015 11:48 PM, Borislav Petkov wrote:
> On Thu, Aug 27, 2015 at 04:07:40PM +0800, Huang Rui wrote:
>> Add an accessor function amd_get_cores_per_cu() which returns the
>> number of cores per compute unit.
>>
>> In a subsequent patch, we will use this function in fam15h_power
>> driver.
>>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> ---
>>   arch/x86/include/asm/processor.h |  1 +
>>   arch/x86/kernel/cpu/amd.c        | 19 +++++++++++++++++--
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>
> Btw, this needs an ACK from a tip person if it goes through the hwmon
> tree.
>
Yes, most definitely.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
