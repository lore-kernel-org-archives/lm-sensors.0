From: David Brownell <david-b@pacbell.net>
Date: Fri, 17 Oct 2008 19:04:54 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <200810171204.54448.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809251902.00201.david-b@pacbell.net>
	<Pine.LNX.4.64.0809261652040.7680@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0809261652040.7680-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

... just to recap this before I scrub old mail from my mbox:

On Friday 26 September 2008, Trent Piepho wrote:
> > It's not a question of the I2C adapter supporting it. =A0It's a
> > question of whether there's an SMBALERT# signal on your board,
> > which can generate an interrupt. =A0If it can, this patch has an
> > IRQ handler which implements the SMBus alert protocol. =A0Think
> > of it as sideband signaling ... unknown to that adapter.
>=20
> If nothing is alerting, then the read from the ARA address won't get an a=
ck.=20

This is indeed how the SMBALERT# protocol handling code must
detect that all pending alerts have been handled:  each read
of ARA clears one pending alert, until none responds any more.
(And the active-low open drain SMBALERT# signal went high.)


> Some i2c adapters don't handle this so well.

If your system can't implement the SMBALERT# protocol, then
there's no problem at all.  Just handle the IRQ using whatever
non-standard hackery is necessary to cope with that hardware,
and DO NOT tell Linux that it's really SMBALERT#.  Simple.


The SMBALERT# protocol is very specific about how it acts and
what it does.  It's also very specific to SMBus.  The $SUBJECT
patch never claimed to be an attempt to work with arbitrary
collections of I2C device interrupts that weren't designed to
cooperate at all, much less to follow the SMBALERT# rules.

Absolutely nothing you've said makes a real argument against
providing support for SMBALERT#.

At best, you've made an argument that some drivers may need
to support less-efficient IRQ dispatching schemes as well as
SMBALERT#, in order to handle board-specific design quirks.

- Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
