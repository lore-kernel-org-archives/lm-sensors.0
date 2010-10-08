From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 08 Oct 2010 08:26:31 +0000
Subject: Re: [lm-sensors] [PATCH v2] x86/therm_throt.c: Fix error handling
Message-Id: <20101008082631.GE13754@elte.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283905550-18571-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1283905550-18571-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Jin Dongming <jin.dongming@np.css.fujitsu.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


* Fenghua Yu <fenghua.yu@intel.com> wrote:

>  #ifdef CONFIG_HOTPLUG_CPU
>  	mutex_unlock(&therm_cpu_lock);
>  #endif

> +#ifdef CONFIG_HOTPLUG_CPU
> +	mutex_unlock(&therm_cpu_lock);
> +#endif

That's all very ugly.

Thanks,

	Ingo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
