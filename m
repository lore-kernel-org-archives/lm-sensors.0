From: Natarajan Gurumoorthy <natg@google.com>
Date: Tue, 05 Apr 2011 23:03:35 +0000
Subject: Re: [lm-sensors] [PATCH] Make all it87 drivers SMP safe.
Message-Id: <BANLkTimQDVYe53K-M173iQtmkHzKg6Djyg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6428152577457814085=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1302038697-28985-1-git-send-email-natg@google.com>
In-Reply-To: <1302038697-28985-1-git-send-email-natg@google.com>
To: lm-sensors@vger.kernel.org

--===============6428152577457814085==
Content-Type: multipart/alternative; boundary=0016369fa253c9523b04a033e205

--0016369fa253c9523b04a033e205
Content-Type: text/plain; charset=ISO-8859-1

Guenter,
       This patch patch applies a common fix to all IT87 driver. Separating
it into 2 patches (one for drivers/hwmon and one for drivers/watchdog) does
not seem to be the right thing to do. I think having all the patches in one
file makes it easier to understand the rationale behind the patch. The
it87_io_lock.c and it87_io_lock.h files are in drivers/watchdog directory
and the lock defined in it is needed by the changes in drivers/hwmon/it87.c

Regards
Nat


On Tue, Apr 5, 2011 at 3:38 PM, Guenter Roeck <guenter.roeck@ericsson.com>wrote:

> On Tue, Apr 05, 2011 at 05:24:57PM -0400, Nat Gurumoorthy wrote:
> > There are 3 different drivers that touch the it87 hardware registers.
> > The 3 drivers have been written independently and access the it87
> hardware
> > registers assuming they are the only driver accessing it. This change
> > attempts to serialize access to the hardware by defining a global
> spinlock
> > it87_io_lock in a file it87_lock.c. This lock has to be acquired by each
> > of the it87 drivers before it can access the hardware. We have defined
> > a new Kconfig option IT87_LOCK. When it is selected it87_lock.c is
> compiled
> > into the kernel thereby making the lock global and accessable to the it87
> > drivers which are typically built as loadable modules. All the it87
> drivers
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
> >  drivers/hwmon/Kconfig          |    1 +
> >  drivers/hwmon/it87.c           |   14 ++++++++++++-
> >  drivers/watchdog/Kconfig       |   12 +++++++++++
> >  drivers/watchdog/Makefile      |    1 +
> >  drivers/watchdog/it8712f_wdt.c |   10 ++++----
> >  drivers/watchdog/it87_lock.c   |   27 +++++++++++++++++++++++++
> >  drivers/watchdog/it87_wdt.c    |   42
> ++++++---------------------------------
> >  include/linux/it87_lock.h      |   28 ++++++++++++++++++++++++++
> >  8 files changed, 94 insertions(+), 41 deletions(-)
> >  create mode 100644 drivers/watchdog/it87_lock.c
> >  create mode 100644 include/linux/it87_lock.h
> >
> > Signed-off-by: Nat Gurumoorthy <natg@google.com>
> >
> Seems to me those should be separate patches, one per affected subsystem.
>
> Guenter
>



-- 
Regards
Nat Gurumoorthy AB6SJ

--0016369fa253c9523b04a033e205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Guenter,<div>=A0 =A0 =A0 =A0This patch patch applies a common fix to all IT=
87 driver. Separating it into 2 patches (one for drivers/hwmon and one for =
drivers/watchdog) does not seem to be the right thing to do. I think having=
 all the patches in one file makes it easier to understand the rationale be=
hind the patch. The it87_io_lock.c and it87_io_lock.h files are in drivers/=
watchdog directory and the lock defined in it is needed by the changes in d=
rivers/hwmon/it87.c</div>
<div><br></div><div>Regards</div><div>Nat</div><div><br><br><div class=3D"g=
mail_quote">On Tue, Apr 5, 2011 at 3:38 PM, Guenter Roeck <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.c=
om</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Tue, A=
pr 05, 2011 at 05:24:57PM -0400, Nat Gurumoorthy wrote:<br>
&gt; There are 3 different drivers that touch the it87 hardware registers.<=
br>
&gt; The 3 drivers have been written independently and access the it87 hard=
ware<br>
&gt; registers assuming they are the only driver accessing it. This change<=
br>
&gt; attempts to serialize access to the hardware by defining a global spin=
lock<br>
&gt; it87_io_lock in a file it87_lock.c. This lock has to be acquired by ea=
ch<br>
&gt; of the it87 drivers before it can access the hardware. We have defined=
<br>
&gt; a new Kconfig option IT87_LOCK. When it is selected it87_lock.c is com=
piled<br>
&gt; into the kernel thereby making the lock global and accessable to the i=
t87<br>
&gt; drivers which are typically built as loadable modules. All the it87 dr=
ivers<br>
&gt; select IT87_LOCK to compile the lock into the kernel.<br>
&gt; The routines accessing the hardware are being called from module init,=
<br>
&gt; open, ioctl and module exit routines and hence it is sufficient to use=
<br>
&gt; calls to spin_lock and spin_unlock to acquire and release the locks. F=
or<br>
&gt; the same reasons it87_wdt.c has extensive changes to remove calls to<b=
r>
&gt; spin_lock_irqsave and spin_unlock_irqrestore. The lock is now acquired=
<br>
&gt; in superio_enter and released in superio_exit. This is now identical<b=
r>
&gt; to the code in drivers/hwmon/it87.c and drivers/watchdog/it8712f_wdt.c=
.<br>
&gt; Added __acquire and __release annotations wherever needed.<br>
&gt; ---<br>
&gt; =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +<br>
&gt; =A0drivers/hwmon/it87.c =A0 =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++-<br>
&gt; =A0drivers/watchdog/Kconfig =A0 =A0 =A0 | =A0 12 +++++++++++<br>
&gt; =A0drivers/watchdog/Makefile =A0 =A0 =A0| =A0 =A01 +<br>
&gt; =A0drivers/watchdog/it8712f_wdt.c | =A0 10 ++++----<br>
&gt; =A0drivers/watchdog/it87_lock.c =A0 | =A0 27 +++++++++++++++++++++++++=
<br>
&gt; =A0drivers/watchdog/it87_wdt.c =A0 =A0| =A0 42 ++++++-----------------=
----------------<br>
&gt; =A0include/linux/it87_lock.h =A0 =A0 =A0| =A0 28 +++++++++++++++++++++=
+++++<br>
&gt; =A08 files changed, 94 insertions(+), 41 deletions(-)<br>
&gt; =A0create mode 100644 drivers/watchdog/it87_lock.c<br>
&gt; =A0create mode 100644 include/linux/it87_lock.h<br>
&gt;<br>
&gt; Signed-off-by: Nat Gurumoorthy &lt;<a href=3D"mailto:natg@google.com">=
natg@google.com</a>&gt;<br>
&gt;<br>
</div></div>Seems to me those should be separate patches, one per affected =
subsystem.<br>
<font color=3D"#888888"><br>
Guenter<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards<br>Nat G=
urumoorthy AB6SJ<div><br></div><br>
</div>

--0016369fa253c9523b04a033e205--


--===============6428152577457814085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6428152577457814085==--
