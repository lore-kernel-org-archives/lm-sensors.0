From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Sep 2010 11:23:10 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon (coretemp): Fix build breakage if
Message-Id: <20100928112310.GA7033@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285637552-1058-1-git-send-email-guenter.roeck@ericsson.com>
 <20100928082729.GA20898@elte.hu>
 <20100928101408.GA29525@elte.hu>
In-Reply-To: <20100928101408.GA29525@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Pekka Enberg <penberg@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

On Tue, Sep 28, 2010 at 06:14:08AM -0400, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > v2: Fix compile warning due to unused variable i if SMP is undefined 
> > > v3: include asm/smp.h instead of using ifdef CONFIG_SMP
> > 
> > I've started testing this fix [...]
> 
> Works fine here.
> 
> Tested-by: Ingo Molnar <mingo@elte.hu>
> 
Great - thanks for your time!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
