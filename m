From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Sep 2010 08:03:03 +0000
Subject: Re: [lm-sensors] [PATCH] x86/hwmon: fix configuration and
Message-Id: <20100907100303.2f45f227@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C7FB8370200007800013F40@vpn.id2.novell.com>
	<20100902212505.GA31811@fenghua-desk.sc.intel.com>
In-Reply-To: <20100902212505.GA31811@fenghua-desk.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Beulich <JBeulich@novell.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>

On Thu, 2 Sep 2010 14:25:05 -0700, Fenghua Yu wrote:
> On Thu, Sep 02, 2010 at 05:44:07AM -0700, Jan Beulich wrote:
> > - using cpuid_eax() to determine feature availability on other than
> >   the current CPU is invalid
> > - feature availability shopuld also be check in the hotplug code path
> > - pkgtemp doesn't depend on PCI altogether (apparently just inherited
> >   from coretemp)
> > - coretemp really only needs PCI for Atom support
> > 
> 
> Could you split the patch into small patches since it handles a few different
> things?

I can only second this request. This should be split into per-driver
patches or per-bug patches, or even both.

Jan, can you please send updated patches? I can't apply that one as is.
Thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
