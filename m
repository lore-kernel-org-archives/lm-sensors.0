From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 08 Apr 2011 00:37:42 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/3] Make all it87 drivers SMP safe.
Message-Id: <20110408003742.GD3942@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302211560-8052-1-git-send-email-natg@google.com>
In-Reply-To: <1302211560-8052-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Thu, Apr 07, 2011 at 05:26:00PM -0400, Nat Gurumoorthy wrote:
> There are 3 different drivers that touch the it87 hardware registers.
> The 3 drivers have been written independently and access the it87 hardware
> registers assuming they are the only driver accessing it. This change
> attempts to serialize access to the hardware by defining a global spinlock
> it87_io_lock in a file it87_lock.c. This lock has to be acquired by each
> of the it87 drivers before it can access the hardware. We have defined
> a new Kconfig option IT87_LOCK. When it is selected it87_lock.c is compiled
> into the kernel thereby making the lock global and accessable to the it87
> drivers which are typically built as loadable modules. All the it87 drivers
> select IT87_LOCK to compile the lock into the kernel.
> The routines accessing the hardware are being called from module init,
> open, ioctl and module exit routines and hence it is sufficient to use
> calls to spin_lock and spin_unlock to acquire and release the locks. For
> the same reasons it87_wdt.c has extensive changes to remove calls to
> spin_lock_irqsave and spin_unlock_irqrestore. The lock is now acquired
> in superio_enter and released in superio_exit. This is now identical
> to the code in drivers/hwmon/it87.c and drivers/watchdog/it8712f_wdt.c.
> Added __acquire and __release annotations wherever needed.
> 
> 01 - Adds the relevant lock files.
>  drivers/watchdog/Kconfig
>  drivers/watchdog/Makefile
>  drivers/watchdog/it87_lock.c
>  include/linux/it87_lock.h
> 
Did you consider naming this file include/linux/it87.h as suggested ?
I thought that was a goodd idea.

When you send out new versions of your patch set, it would be prudent
to list the patch version, as well as the changes made compared to previous
versions of your patch. See Documents/SubmittingPatches, rule #2.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
