From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 23 May 2011 18:03:37 +0000
Subject: Re: [lm-sensors] linux-next: Tree for May 23 (hwmon/coretemp.c)
Message-Id: <1306173817.2163.354.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
	 <20110523104958.98ef4d1a.randy.dunlap@oracle.com>
In-Reply-To: <20110523104958.98ef4d1a.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Rudolf Marek <r.marek@assembler.cz>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Sigh. And I was sure I tested that :(. I'll look into it immediately.

Guenter

On Mon, 2011-05-23 at 13:49 -0400, Randy Dunlap wrote:
> On Mon, 23 May 2011 15:45:18 +1000 Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > Changes since 20110520:
> 
> when CONFIG_SMP is not enabled:
> 
> drivers/hwmon/coretemp.c:765: error: implicit declaration of function 'cpu_sibling_mask'
> 
> 
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
