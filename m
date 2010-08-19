From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 19 Aug 2010 17:07:17 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/coretemp: Fix incorrect
Message-Id: <20100819170717.GA4312@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282172027-640-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1282172027-640-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, Huaxu Wan <huaxu.wan@intel.com>, H Peter Anvin <hpa@zytor.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Wed, Aug 18, 2010 at 06:53:45PM -0400, Fenghua Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> In current coretemp driver, when a CPU in dev_list is hot-removed, although its
> HT sibling is still running, its core sensor is gone and not available to user
> level application any more.
> 
> When a CPU is hot-removed, its core sensor should be still available to upper
> level application as long as the hot-removed CPU's HT sibling is still running.
> A core sensor is invisible to user level only when all of siblings in a core are
> hot-removed.
>
Isn't that just a short term (ie a couple of ms or even us) race condition
until the sibling is removed as well ? If so, why bother ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
