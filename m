From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Feb 2012 13:25:04 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <20120208142504.46ef264e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 8 Feb 2012 14:18:57 +0100, Jean Delvare wrote:
> > > [  237.889708]  [<ffffffffa0c7c2e4>] ? w83627ehf_probe+0x59e/0x22ba [w83627ehf]
> 
> Can you please ask gdb which line of the function this is? You'll
> probably have to install some kernel debugging package for this, don't
> know how this works on Ubuntu.
> 
> $ gdb
> (gdb) file drivers/hwmon/w83627ehf.ko
> (gdb) list *(w83627ehf_probe+0x59e)

Oops, obviously the driver isn't from your kernel but the one you got
from Guenter. So no need to install the kernel debugging package, only
gdb, and then modify the Makefile to include the debugging symbols:

EXTRA_CFLAGS	+= -DDEBUG

And then rebuild the w83627ehf driver. That should be enough for gdb to
show us where the failure occurred.

Also note: if you update your kernel, you have to rebuild the w83627ehf
driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
