From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 12 Jul 2012 23:04:15 +0000
Subject: Re: [lm-sensors] [RESEND PATCH v4 1/5] thermal: add generic cpufreq cooling implementation
Message-Id: <20120712160415.473748fd.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342100468-19426-1-git-send-email-amit.kachhap@linaro.org>
	<1342100468-19426-2-git-send-email-amit.kachhap@linaro.org>
In-Reply-To: <1342100468-19426-2-git-send-email-amit.kachhap@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, linux-samsung-soc@vger.kernel.org, SangWook Ju <sw.ju@samsung.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org, Donggeun Kim <dg77.kim@samsung.com>

On Thu, 12 Jul 2012 19:11:04 +0530
Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:

> [akpm@linux-foundation.org: fix comment layout]
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Cc: Donggeun Kim <dg77.kim@samsung.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: SangWook Ju <sw.ju@samsung.com>
> Cc: Durgadoss <durgadoss.r@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Something strange appears to have happened here?  At a guess it seems
that the patches were in my tree, I sent them to someone (Len?), then
they were merged into linux-next by "someone" and then they fell
out of linux-next again?

If so, they will hopefully come back soon.  If not, something failed
fairly seriously.


I took a look at re-merging these patches into my tree, but there are
significant conflicts with other work which has gone into linux-next.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
