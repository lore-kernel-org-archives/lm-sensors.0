From: Natarajan Gurumoorthy <natg@google.com>
Date: Tue, 05 Apr 2011 23:05:47 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <BANLkTikX5fAkdrZAktQON=8DwuQL+5Ow-w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302038697-28985-1-git-send-email-natg@google.com>
	<20110405223814.GA21350@ericsson.com>
In-Reply-To: <20110405223814.GA21350@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

Guenter,
       This patch patch applies a common fix to all IT87 driver.
Separating it into 2 patches (one for drivers/hwmon and one for
drivers/watchdog) does not seem to be the right thing to do. I think
having all the patches in one file makes it easier to understand the
rationale behind the patch. The it87_io_lock.c and it87_io_lock.h
files are in drivers/watchdog directory and the lock defined in it is
needed by the changes in drivers/hwmon/it87.c

Regards
Nat


On Tue, Apr 5, 2011 at 3:38 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
>
> On Tue, Apr 05, 2011 at 05:24:57PM -0400, Nat Gurumoorthy wrote:
> > There are 3 different drivers that touch the it87 hardware registers.
> > The 3 drivers have been written independently and access the it87 hardw=
are
> > registers assuming they are the only driver accessing it. This change
> > attempts to serialize access to the hardware by defining a global spinl=
ock
> > it87_io_lock in a file it87_lock.c. This lock has to be acquired by each
> > of the it87 drivers before it can access the hardware. We have defined
> > a new Kconfig option IT87_LOCK. When it is selected it87_lock.c is comp=
iled
> > into the kernel thereby making the lock global and accessable to the it=
87
> > drivers which are typically built as loadable modules. All the it87 dri=
vers
> > select IT87_LOCK to compile the lock into the kernel.
> > The routines accessing the hardware are being called from module init,
> > open, ioctl and module exit routines and hence it is sufficient to use
> > calls to spin_lock and spin_unlock to acquire and release the locks. For
> > the same reasons it87_wdt.c has extensive changes to remove calls to
> > spin_lock_irqsave and spin_unlock_irqrestore. The lock is now acquired
> > in superio_enter and released in superio_exit. This is now identical
> > to the code in drivers/hwmon/it87.c and drivers/watchdog/it8712f_wdt.c.
> > Added __acquire and __release annotations wherever needed.
> > ---
> > =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> > =A0drivers/hwmon/it87.c =A0 =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++-
> > =A0drivers/watchdog/Kconfig =A0 =A0 =A0 | =A0 12 +++++++++++
> > =A0drivers/watchdog/Makefile =A0 =A0 =A0| =A0 =A01 +
> > =A0drivers/watchdog/it8712f_wdt.c | =A0 10 ++++----
> > =A0drivers/watchdog/it87_lock.c =A0 | =A0 27 +++++++++++++++++++++++++
> > =A0drivers/watchdog/it87_wdt.c =A0 =A0| =A0 42 ++++++------------------=
---------------
> > =A0include/linux/it87_lock.h =A0 =A0 =A0| =A0 28 ++++++++++++++++++++++=
++++
> > =A08 files changed, 94 insertions(+), 41 deletions(-)
> > =A0create mode 100644 drivers/watchdog/it87_lock.c
> > =A0create mode 100644 include/linux/it87_lock.h
> >
> > Signed-off-by: Nat Gurumoorthy <natg@google.com>
> >
> Seems to me those should be separate patches, one per affected subsystem.
>
> Guenter



--
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
