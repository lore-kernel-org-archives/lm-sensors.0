From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Makefile automagic for RedHat kernel sources
Message-Id: <20030121002409.A27422@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

There's been a lot of "I can't compile vs. RedHat" lately.
I found it's because the makefile automagic chokes on
version.h...

> #include <linux/rhconfig.h>
> #if defined(__module__smp)
> #define UTS_RELEASE "2.4.18-19.8.0smp"
> #elif defined(__module__BOOT)
> #define UTS_RELEASE "2.4.18-19.8.0BOOT"
> #elif defined(__module__bigmem)
> #define UTS_RELEASE "2.4.18-19.8.0bigmem"
> #elif defined(__module__debug)
> #define UTS_RELEASE "2.4.18-19.8.0debug"
> #else
> #define UTS_RELEASE "2.4.18-19.8.0"
> #endif
> #define LINUX_VERSION_CODE 132114
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

... because we're doing a simple grep for UTS_RELEASE.

What if we did this instead, e.g.

> MODPREF := /lib/modules/`$(CC) -I$(LINUX_HEADERS) -E config.c | \
> grep uts_release | cut -f 2 -d '"'`

Where config.c looked like this:

> #include <linux/version.h>
> char *uts_release=UTS_RELEASE;

Similar guck for SMP and MODVER.  Comments?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
