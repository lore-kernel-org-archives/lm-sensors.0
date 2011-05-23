From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Mon, 23 May 2011 17:49:58 +0000
Subject: Re: [lm-sensors] linux-next: Tree for May 23 (hwmon/coretemp.c)
Message-Id: <20110523104958.98ef4d1a.randy.dunlap@oracle.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
In-Reply-To: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, Rudolf Marek <r.marek@assembler.cz>, lm-sensors@lm-sensors.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>

On Mon, 23 May 2011 15:45:18 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20110520:

when CONFIG_SMP is not enabled:

drivers/hwmon/coretemp.c:765: error: implicit declaration of function 'cpu_sibling_mask'


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
