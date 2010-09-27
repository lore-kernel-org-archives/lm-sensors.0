From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 27 Sep 2010 12:59:46 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (coretemp): Fix build breakage if
Message-Id: <20100927125946.GB2862@elte.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, torvalds@linux-foundation.org, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>


* Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> +#ifdef CONFIG_SMP
> +#endif
> +#ifdef CONFIG_SMP
> +#endif

Hm, this tickles my uglo-meter. Is there no cleaner way, preferably one 
that doesnt involve preprocessor directives?

Thanks,

	Ingo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
