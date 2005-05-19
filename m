From: dirk.meul@epost.de (Dirk Meul)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: [Fwd: Re: i2c & lm_sensors2 patch for kernel 2.5]
Message-Id: <1015515764.2586.4.camel@aragorn>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

The same.

-----Weitergeleitete Nachricht-----
> From: Dirk Meul <dirk.meul@epost.de>
> To: linux-i2c@pelican.tk.uni-linz.ac.at
> Subject: Re: i2c & lm_sensors2 patch for kernel 2.5
> Date: 05 Mar 2002 19:36:42 +0100
> 
> Hello, again!
> 
> [i2c/i2c-algo-bit.c]
> This patch didn't work with linux-2.4.19-pre2 + preempt, so i think this
> will be part of scehd-O(1).
> 
> Everything else works fine, even the kdev_t patches without ?#define
> minor MINOR?!
> 
> Am Die, 2002-03-05 um 19.02 schrieb Dirk Meul:
> > Hello!
> > 
> > I did a checkout at Tue Mar 5 17:32:03 CET 2002 and patched my kernel
> > (2.5.6-pre2) with it. Everything but the file
> > linux-2.5.6-pre2/Documentation/Configure.help went fine. But i've to
> > apply attached patch for compiling.
> > 
> > [i2c/i2c-algo-bit.c]
> > I didn't know if it is correct, but i think so.
> > 
> > [i2c/i2c-dev.c]
> > The kdev_t fixes. Maybe a ?#define minor MINOR? will be good.
> > 
> > [sensors/*.c]
> > Add ?#include <linux/sched.h>? for missing jiffies.
> > 
> > Some days ago a kernel 2.5.5 with these patches works fine.
> > 
> > PS: I'm not subscribed to this list, so please CC to me.
> > 
> > Regards,
> > -- 
> > Dirk Meul <dirk.meul@epost.de>
> 
> Regards,
> -- 
> Dirk Meul <dirk.meul@epost.de>
