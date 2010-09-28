From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Sep 2010 11:24:29 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon (coretemp): Fix build breakage if
Message-Id: <20100928112429.GB7033@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285637552-1058-1-git-send-email-guenter.roeck@ericsson.com>
 <20100928082729.GA20898@elte.hu>
In-Reply-To: <20100928082729.GA20898@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Pekka Enberg <penberg@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

On Tue, Sep 28, 2010 at 04:27:29AM -0400, Ingo Molnar wrote:
> 
> * Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> 
> > Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f introduced
> > a build breakage if CONFIG_SMP is undefined. This commit
> > fixes the problem.
> 
> This commit works around the problem in a hacky but not-so-ugly way.
> 
> ( You might also want to include Linus's suggestion about how to fix it 
>   for real in the future - so that we have at least some kind of record 
>   of it. )
> 
Done.

> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> 
> FYI, while i dont care about my Reported-by's but you lost a Reported-by 
> tag here - you should be as careful about them as about your own 
> signoffs.
> 
Added it back in.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
