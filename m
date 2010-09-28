From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 28 Sep 2010 08:27:29 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon (coretemp): Fix build breakage if
Message-Id: <20100928082729.GA20898@elte.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285637552-1058-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1285637552-1058-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Pekka Enberg <penberg@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>


* Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f introduced
> a build breakage if CONFIG_SMP is undefined. This commit
> fixes the problem.

This commit works around the problem in a hacky but not-so-ugly way.

( You might also want to include Linus's suggestion about how to fix it 
  for real in the future - so that we have at least some kind of record 
  of it. )

> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>

FYI, while i dont care about my Reported-by's but you lost a Reported-by 
tag here - you should be as careful about them as about your own 
signoffs.

> v2: Fix compile warning due to unused variable i if SMP is undefined 
> v3: include asm/smp.h instead of using ifdef CONFIG_SMP

I've started testing this fix - but i'd expect it to fix the problem - 
so consider it fixed unless i report back within a few hours that 
there's some breakage left.

Thanks,

	Ingo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
