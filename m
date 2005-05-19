From: dirk.meul@epost.de (Dirk Meul)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: [Fwd: i2c & lm_sensors2 patch for kernel 2.5]
Message-Id: <1015515732.2586.2.camel@aragorn>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

That was a wrong mail address.

-----Weitergeleitete Nachricht-----
> From: Dirk Meul <dirk.meul@epost.de>
> To: linux-i2c@pelican.tk.uni-linz.ac.at
> Subject: i2c & lm_sensors2 patch for kernel 2.5
> Date: 05 Mar 2002 19:02:19 +0100
> 
> Hello!
> 
> I did a checkout at Tue Mar 5 17:32:03 CET 2002 and patched my kernel
> (2.5.6-pre2) with it. Everything but the file
> linux-2.5.6-pre2/Documentation/Configure.help went fine. But i've to
> apply attached patch for compiling.
> 
> [i2c/i2c-algo-bit.c]
> I didn't know if it is correct, but i think so.
> 
> [i2c/i2c-dev.c]
> The kdev_t fixes. Maybe a ?#define minor MINOR? will be good.
> 
> [sensors/*.c]
> Add ?#include <linux/sched.h>? for missing jiffies.
> 
> Some days ago a kernel 2.5.5 with these patches works fine.
> 
> PS: I'm not subscribed to this list, so please CC to me.
> 
> Regards,
> -- 
> Dirk Meul <dirk.meul@epost.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors2.diff.gz
Type: application/x-gzip
Size: 1633 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020307/1b718d75/lm_sensors2.diff.gz
