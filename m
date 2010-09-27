From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Sep 2010 13:15:10 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (coretemp): Fix build breakage if
Message-Id: <20100927131510.GB2277@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
 <20100927125946.GB2862@elte.hu>
In-Reply-To: <20100927125946.GB2862@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

On Mon, Sep 27, 2010 at 08:59:46AM -0400, Ingo Molnar wrote:
> 
> * Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> 
> > +#ifdef CONFIG_SMP
> > +#endif
> > +#ifdef CONFIG_SMP
> > +#endif
> 
> Hm, this tickles my uglo-meter. Is there no cleaner way, preferably one 
> that doesnt involve preprocessor directives?
> 
Mine too, but not at 6am in the morning (actually 5am when I wrote it),
and right now I thought it more important to fix the kernel breakage.

I'll think about it and see if I can find something better. But I would
still prefer to have this one applied and submit a cleaner solution later on
(if I find one). Preferrably, as you suggested, without any CONFIG_SMP
declarations.

Fwiw, there are several similar "#ifdef CONFIG_SMP" in this driver already,
so it would definitely be good to find a cleaner solution.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
