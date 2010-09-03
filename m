From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 03 Sep 2010 09:35:53 +0000
Subject: Re: [lm-sensors] [PATCH] therm_throt.c: Fix error handling in
Message-Id: <20100903093553.GA6821@elte.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283474726-20109-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1283474726-20109-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Jin Dongming <jin.dongming@np.css.fujitsu.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


* Fenghua Yu <fenghua.yu@intel.com> wrote:

> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Warn when sysfs_add_file_to_group fails.
> 
> Also add missing curly braces.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/x86/kernel/cpu/mcheck/therm_throt.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)

> +               WARN_ON(err);

Hm, we tend to use WARN_ON_ONCE(), to avoid repeat spamming of the 
syslog. Also, and perhaps more importantly, WARN_ON() is not a 
particularly smart way to handle errors. How do other drivers handle 
sysfs registration failures?

Also, that's not the only thing the patch does:

> @@ -211,20 +211,26 @@ static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev)

> -	return err;
> +	return 0;

How is the ignoring of an error and turning it into a WARN_ON() a fix? 
Either it makes no sense to return errors - in which case the whole 
add_dev method needs to be fixed in all drivers - or it makes sense, in 
which case the behavior here is inconsistent.

At minimum more explanation is needed in the changelog.

Thanks,

	Ingo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
