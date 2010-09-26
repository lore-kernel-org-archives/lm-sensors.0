From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 26 Sep 2010 19:05:31 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.36
Message-Id: <20100926190531.GA29089@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285378081-7902-1-git-send-email-guenter.roeck@ericsson.com>
 <20100926121314.GA20023@elte.hu>
In-Reply-To: <20100926121314.GA20023@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sun, Sep 26, 2010 at 08:13:14AM -0400, Ingo Molnar wrote:
> 
> * Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> 
> > Hi Linus,
> > 
> > Please pull hwmon subsystem fixes for Linux 2.6.36 from:
> > 
> >     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus
> > 
> > Thanks,
> > Guenter Roeck
> > 
> > ------
> > 
> > Guenter Roeck (1):
> >       MAINTAINERS: Update hwmon entry
> > 
> > Jan Beulich (7):
> >       x86/hwmon: fix module init for hotplug-but-no-device-found case
> >       x86/hwmon: avoid deadlock on CPU removal in pkgtemp
> >       x86/hwmon: don't leak device attribute file from pkgtemp_probe() and pkgtemp_remove()
> >       x86/hwmon: fix initialization of coretemp
> >       x86/hwmon: fix initialization of pkgtemp
> >       x86/hwmon: register alternate sibling upon CPU removal
> >       x86/hwmon: pkgtemp has no dependency on PCI
> > 
> > Takashi Iwai (1):
> >       hwmon: (lis3) Fix Oops with NULL platform data
> > 
> >  MAINTAINERS                       |    2 +
> >  arch/x86/include/asm/cpufeature.h |    1 +
> >  arch/x86/kernel/cpu/scattered.c   |    1 +
> 
> Please at minimum get acks for arch/x86 changes from the maintainers.
> 
Ok, I assume that is a hard rule, and keep that in mind for the future. 

> >  drivers/hwmon/Kconfig             |    2 +-
> >  drivers/hwmon/coretemp.c          |   56 +++++++++++++++++++++----------------
> >  drivers/hwmon/lis3lv02d.c         |    4 +-
> >  drivers/hwmon/pkgtemp.c           |   23 +++++++--------
> >  7 files changed, 50 insertions(+), 39 deletions(-)
> 
> This fails to build with an about 10% likelyhood in randconfig builds:
> 
>   drivers/hwmon/coretemp.c:506: error: implicit declaration of function 'cpu_sibling_mask'
> 
Sorry, didn't catch that. 

Still learning, though that is not an excuse.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
