From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 31 Jul 2010 00:57:56 +0000
Subject: Re: [lm-sensors] [PATCH V3 2/5] Package Level Thermal Control and
Message-Id: <4C537514.9090109@zytor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1280448826-12004-1-git-send-email-fenghua.yu@intel.com> <1280448826-12004-3-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1280448826-12004-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, Huaxu Wan <huaxu.wan@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On 07/29/2010 05:13 PM, Fenghua Yu wrote:
> +
> +enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL, SHOW_NAME } SHOW;
> +

This conflicts with an equally poorly named global variable in
drivers/hwmon/via-cputemp.c, and the conflict is causing a build failure.

I think both these drivers have the same bug: a missing "typedef" before
the enum keyword, as present in coretemp.c.  Of course, one can question
if it should be given a typename at all since in none of these drivers
they are actually referenced by type, and instead the enumeration is
just used as a source of constants, which can perfectly well be handled
with an unnamed enum:

enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL, SHOW_NAME };

	-hpa

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
