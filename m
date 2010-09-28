From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 28 Sep 2010 10:14:08 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon (coretemp): Fix build breakage if
Message-Id: <20100928101408.GA29525@elte.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285637552-1058-1-git-send-email-guenter.roeck@ericsson.com>
 <20100928082729.GA20898@elte.hu>
In-Reply-To: <20100928082729.GA20898@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Pekka Enberg <penberg@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> > v2: Fix compile warning due to unused variable i if SMP is undefined 
> > v3: include asm/smp.h instead of using ifdef CONFIG_SMP
> 
> I've started testing this fix [...]

Works fine here.

Tested-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
