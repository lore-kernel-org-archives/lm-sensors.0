From: Natarajan Gurumoorthy <natg@google.com>
Date: Wed, 27 Apr 2011 17:49:01 +0000
Subject: Re: [lm-sensors] [PATCH v7 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTikGGO76ToGaRJ0foSc-Yp6Fe4C97g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303153127-11717-1-git-send-email-natg@google.com>
	<1303153204-11784-1-git-send-email-natg@google.com>
	<20110422044451.GB524@ericsson.com>
In-Reply-To: <20110422044451.GB524@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

Guenter,

On Thu, Apr 21, 2011 at 9:44 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> > =A0/**
> > @@ -303,8 +308,6 @@ static void wdt_stop(void)
> >
> > =A0static int wdt_set_timeout(int t)
> > =A0{
> > - =A0 =A0 =A0 unsigned long flags;
> > -
> > =A0 =A0 =A0 =A0 if (t < 1 || t > max_units * 60)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >
> > @@ -313,14 +316,14 @@ static int wdt_set_timeout(int t)
> > =A0 =A0 =A0 =A0 else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D t;
> >
> > - =A0 =A0 =A0 spin_lock_irqsave(&spinlock, flags);
> > =A0 =A0 =A0 =A0 if (test_bit(WDTS_TIMER_RUN, &wdt_status)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_enter();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > +
> I don't think you can do that here. You are moving the lock,
> meaning test_bit is no longer protected by the lock.
>
I am not sure I am in agreement with your here. If you look at other
places in the original driver I see sections of code in "wdt_ioctl"
that look as follows:
	case WDIOC_SETOPTIONS:
		if (get_user(new_options, uarg.i))
			return -EFAULT;

		switch (new_options) {
		case WDIOS_DISABLECARD:
			if (test_bit(WDTS_TIMER_RUN, &wdt_status))
				wdt_stop();
			clear_bit(WDTS_TIMER_RUN, &wdt_status);
			return 0;

		case WDIOS_ENABLECARD:
			if (!test_and_set_bit(WDTS_TIMER_RUN, &wdt_status))
				wdt_start();
			return 0;

		default:
			return -EFAULT;
		}

They have run through manipulating the "WDTS_TIMER_RUN" bit in
wdt_status without touching the spinlock. "wdt_stop" does acquire the
spinlock before touching the hardware through superio_enter. It seems
to me that the original writers of this driver were using the spinlock
to isolate access to the hardware and we will be achieving the same by
the use of "request_muxed_region" call from superio_enter.

I am fixing the rest of the issues pointed out by you and am hoping to
ship out a patch by the end of the week.

Regards
Nat

> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_select(GPIO);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_update_timeout();
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_exit();
> > =A0 =A0 =A0 =A0 }
> > - =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> > =A0 =A0 =A0 =A0 return 0;
> > =A0}
> >
> > @@ -339,12 +342,10 @@ static int wdt_set_timeout(int t)
> >
> > =A0static int wdt_get_status(int *status)
> > =A0{
> > - =A0 =A0 =A0 unsigned long flags;
> > -
> > =A0 =A0 =A0 =A0 *status =3D 0;
> > =A0 =A0 =A0 =A0 if (testmode) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&spinlock, flags);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_enter();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_select(GPIO);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (superio_inb(WDTCTRL) & WDT_ZERO) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_outb(0x00, WDTC=
TRL);
> > @@ -353,7 +354,6 @@ static int wdt_get_status(int *status)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> > =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 if (test_and_clear_bit(WDTS_KEEPALIVE, &wdt_status))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *status |=3D WDIOF_KEEPALIVEPING;
> > @@ -381,7 +381,12 @@ static int wdt_open(struct inode *inode, struct fi=
le *file)
> > =A0 =A0 =A0 =A0 if (!test_and_set_bit(WDTS_TIMER_RUN, &wdt_status)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nowayout && !test_and_set_bit(WDTS_=
LOCKED, &wdt_status))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __module_get(THIS_MODUL=
E);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_start();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wdt_start()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(WDTS_LOCKED, &w=
dt_status);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(WDTS_TIMER_RUN,=
 &wdt_status);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(WDTS_DEV_OPEN, =
&wdt_status);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 return nonseekable_open(inode, file);
> > =A0}
> > @@ -403,7 +408,15 @@ static int wdt_release(struct inode *inode, struct=
 file *file)
> > =A0{
> > =A0 =A0 =A0 =A0 if (test_bit(WDTS_TIMER_RUN, &wdt_status)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_and_clear_bit(WDTS_EXPECTED, &=
wdt_status)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_stop();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wdt_stop()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Stop=
 failed. Just keep the watchdog alive
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and =
hope nothing bad happens.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(W=
DTS_EXPECTED, &wdt_status);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_keepa=
live();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -E=
BUSY;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(WDTS_TIMER_RU=
N, &wdt_status);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_keepalive();
> > @@ -484,7 +497,8 @@ static long wdt_ioctl(struct file *file, unsigned i=
nt cmd, unsigned long arg)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &ident, sizeof(ident)) ? -EFAULT : 0;
> >
> > =A0 =A0 =A0 =A0 case WDIOC_GETSTATUS:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_get_status(&status);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wdt_get_status(&status))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return put_user(status, uarg.i);
> >
> > =A0 =A0 =A0 =A0 case WDIOC_GETBOOTSTATUS:
> > @@ -501,13 +515,19 @@ static long wdt_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (new_options) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WDIOS_DISABLECARD:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(WDTS_TIMER=
_RUN, &wdt_status))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_stop(=
);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wdt_s=
top())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 return -EBUSY;
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(WDTS_TIMER_RU=
N, &wdt_status);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WDIOS_ENABLECARD:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_set_bit(WDT=
S_TIMER_RUN, &wdt_status))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_start=
();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_set_bit(WDT=
S_TIMER_RUN, &wdt_status)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wdt_s=
tart()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 clear_bit(WDTS_TIMER_RUN, &wdt_status);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 return -EBUSY;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> > @@ -532,7 +552,8 @@ static int wdt_notify_sys(struct notifier_block *th=
is, unsigned long code,
> > =A0 =A0 =A0 =A0 void *unused)
> > =A0{
> > =A0 =A0 =A0 =A0 if (code =3D SYS_DOWN || code =3D SYS_HALT)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdt_stop();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wdt_stop())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>
> -EBUSY is not a valid return code here.
>
> > =A0 =A0 =A0 =A0 return NOTIFY_DONE;
> > =A0}
> >
> > @@ -560,16 +581,15 @@ static int __init it87_wdt_init(void)
> > =A0 =A0 =A0 =A0 int rc =3D 0;
> > =A0 =A0 =A0 =A0 int try_gameport =3D !nogameport;
> > =A0 =A0 =A0 =A0 u8 =A0chip_rev;
> > - =A0 =A0 =A0 unsigned long flags;
> >
> > =A0 =A0 =A0 =A0 wdt_status =3D 0;
> >
> > - =A0 =A0 =A0 spin_lock_irqsave(&spinlock, flags);
> > - =A0 =A0 =A0 superio_enter();
> > + =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > +
> > =A0 =A0 =A0 =A0 chip_type =3D superio_inw(CHIPID);
> > =A0 =A0 =A0 =A0 chip_rev =A0=3D superio_inb(CHIPREV) & 0x0f;
> > =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> >
> > =A0 =A0 =A0 =A0 switch (chip_type) {
> > =A0 =A0 =A0 =A0 case IT8702_ID:
> > @@ -603,8 +623,8 @@ static int __init it87_wdt_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > =A0 =A0 =A0 =A0 }
> >
> > - =A0 =A0 =A0 spin_lock_irqsave(&spinlock, flags);
> > - =A0 =A0 =A0 superio_enter();
> > + =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> >
> > =A0 =A0 =A0 =A0 superio_select(GPIO);
> > =A0 =A0 =A0 =A0 superio_outb(WDT_TOV1, WDTCFG);
> > @@ -621,14 +641,12 @@ static int __init it87_wdt_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpact =3D superio_inb(ACTREG);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_outb(0x01, ACTREG);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (request_region(base, 1, WATCHDOG_NA=
ME))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(WDTS_USE_GP, &w=
dt_status);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -EIO;
> > =A0 =A0 =A0 =A0 } else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> > =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 /* If we haven't Gameport support, try to get CIR suppo=
rt */
> > @@ -646,8 +664,8 @@ static int __init it87_wdt_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D CIR_BASE;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&spinlock, flags);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_enter();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_select(CIR);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_outw(base, BASEREG);
> > @@ -660,7 +678,6 @@ static int __init it87_wdt_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> > =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 if (timeout < 1 || timeout > max_units * 60) {
> > @@ -711,21 +728,19 @@ err_out_reboot:
> > =A0err_out_region:
> > =A0 =A0 =A0 =A0 release_region(base, test_bit(WDTS_USE_GP, &wdt_status)=
 ? 1 : 8);
> > =A0 =A0 =A0 =A0 if (!test_bit(WDTS_USE_GP, &wdt_status)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&spinlock, flags);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_enter();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_select(CIR);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_outb(ciract, ACTREG);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> > =A0 =A0 =A0 =A0 }
> > =A0err_out:
> > =A0 =A0 =A0 =A0 if (try_gameport) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&spinlock, flags);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_enter();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_select(GAMEPORT);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_outb(gpact, ACTREG);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> > =A0 =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0 return rc;
> > @@ -733,11 +748,9 @@ err_out:
> >
> > =A0static void __exit it87_wdt_exit(void)
> > =A0{
> > - =A0 =A0 =A0 unsigned long flags;
> > - =A0 =A0 =A0 int nolock;
> > + =A0 =A0 =A0 if (superio_enter())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> Assumption is that you unregister the device. So even if superio_select f=
ails,
> you still have to execute the rest of the code.
>
> >
> > - =A0 =A0 =A0 nolock =3D !spin_trylock_irqsave(&spinlock, flags);
> > - =A0 =A0 =A0 superio_enter();
> > =A0 =A0 =A0 =A0 superio_select(GPIO);
> > =A0 =A0 =A0 =A0 superio_outb(0x00, WDTCTRL);
> > =A0 =A0 =A0 =A0 superio_outb(0x00, WDTCFG);
> > @@ -752,8 +765,6 @@ static void __exit it87_wdt_exit(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_outb(ciract, ACTREG);
> > =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 superio_exit();
> > - =A0 =A0 =A0 if (!nolock)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&spinlock, flags);
> >
> > =A0 =A0 =A0 =A0 misc_deregister(&wdt_miscdev);
> > =A0 =A0 =A0 =A0 unregister_reboot_notifier(&wdt_notifier);
> > --
> > 1.7.3.1
> >
>
> --
> Guenter Roeck
> Distinguished Engineer
> PDU IP Systems



--
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
