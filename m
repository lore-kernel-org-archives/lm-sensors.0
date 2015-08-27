From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Aug 2015 14:48:12 +0000
Subject: Re: [lm-sensors] [PATCH 04/15] hwmon, fam15h_power: update running_avg_capture bit field to 28
Message-Id: <55DF232C.6060906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com> <1440662866-28716-5-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-5-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?windows-1252?Q?Fr=E9d=E9ric_We?= =?windows-1252?Q?isbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On 08/27/2015 01:07 AM, Huang Rui wrote:
> On Carrizo and later platforms, running_avg_capture bit field is
> extended to 4:31 (28 bits) from 4:25.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Applied to hwmon-next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
