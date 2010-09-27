From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Sep 2010 23:27:16 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (coretemp): Fix build breakage if
Message-Id: <20100927232716.GB4744@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
 <20100927125946.GB2862@elte.hu>
 <AANLkTinPHP8WhoAZQqcmhotEfFa6=mG_Acy+xCBQ0_5+@mail.gmail.com>
In-Reply-To: <AANLkTinPHP8WhoAZQqcmhotEfFa6=mG_Acy+xCBQ0_5+@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pekka Enberg <penberg@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

On Mon, Sep 27, 2010 at 09:02:57AM -0400, Pekka Enberg wrote:
> On Mon, Sep 27, 2010 at 3:59 PM, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> >
> >> +#ifdef CONFIG_SMP
> >> +#endif
> >> +#ifdef CONFIG_SMP
> >> +#endif
> >
> > Hm, this tickles my uglo-meter. Is there no cleaner way, preferably one
> > that doesnt involve preprocessor directives?
> 
> Implement cpu_sibling_mask() on UP so that the loop goes away?

So what is the take ? Looks like Linus won't accept my patch without someone 
else signing off on it. If the uglo-meter prevents it from being accepted,
I'll be happy to submit the SMP cleanup patch instead. As I mentioned
before, I would prefer that to go into -next.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
