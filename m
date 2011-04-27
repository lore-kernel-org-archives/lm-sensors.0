From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 27 Apr 2011 19:49:56 +0000
Subject: Re: [lm-sensors] [PATCH v7 1/2] Use "request_muxed_region" in it87
Message-Id: <20110427194956.GA24382@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303153127-11717-1-git-send-email-natg@google.com>
 <1303153204-11784-1-git-send-email-natg@google.com>
 <20110422044451.GB524@ericsson.com>
 <BANLkTikGGO76ToGaRJ0foSc-Yp6Fe4C97g@mail.gmail.com>
In-Reply-To: <BANLkTikGGO76ToGaRJ0foSc-Yp6Fe4C97g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Natarajan Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Wed, Apr 27, 2011 at 01:49:01PM -0400, Natarajan Gurumoorthy wrote:
> Guenter,
> 
> On Thu, Apr 21, 2011 at 9:44 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > >  /**
> > > @@ -303,8 +308,6 @@ static void wdt_stop(void)
> > >
> > >  static int wdt_set_timeout(int t)
> > >  {
> > > -       unsigned long flags;
> > > -
> > >         if (t < 1 || t > max_units * 60)
> > >                 return -EINVAL;
> > >
> > > @@ -313,14 +316,14 @@ static int wdt_set_timeout(int t)
> > >         else
> > >                 timeout = t;
> > >
> > > -       spin_lock_irqsave(&spinlock, flags);
> > >         if (test_bit(WDTS_TIMER_RUN, &wdt_status)) {
> > > -               superio_enter();
> > > +               if (superio_enter())
> > > +                       return -EBUSY;
> > > +
> > I don't think you can do that here. You are moving the lock,
> > meaning test_bit is no longer protected by the lock.
> >
> I am not sure I am in agreement with your here. If you look at other
> places in the original driver I see sections of code in "wdt_ioctl"
> that look as follows:
>         case WDIOC_SETOPTIONS:
>                 if (get_user(new_options, uarg.i))
>                         return -EFAULT;
> 
>                 switch (new_options) {
>                 case WDIOS_DISABLECARD:
>                         if (test_bit(WDTS_TIMER_RUN, &wdt_status))
>                                 wdt_stop();
>                         clear_bit(WDTS_TIMER_RUN, &wdt_status);
>                         return 0;
> 
>                 case WDIOS_ENABLECARD:
>                         if (!test_and_set_bit(WDTS_TIMER_RUN, &wdt_status))
>                                 wdt_start();
>                         return 0;
> 
>                 default:
>                         return -EFAULT;
>                 }
> 
> They have run through manipulating the "WDTS_TIMER_RUN" bit in
> wdt_status without touching the spinlock. "wdt_stop" does acquire the
> spinlock before touching the hardware through superio_enter. It seems
> to me that the original writers of this driver were using the spinlock
> to isolate access to the hardware and we will be achieving the same by
> the use of "request_muxed_region" call from superio_enter.
> 
Agreed. Thanks for the clarification.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
