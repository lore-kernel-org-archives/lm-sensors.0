From: David Brownell <david-b@pacbell.net>
Date: Wed, 23 Jul 2008 18:36:25 +0000
Subject: Re: [lm-sensors] [Patch 0/4] IndustrialIO subsystem (ADCs,
Message-Id: <200807231136.26115.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>
In-Reply-To: <488763AD.4050400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Dmitry Torokhov <dtor@mail.ru>, "Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br, mgross@linux.intel.com, Ben Nizette <bn@niasdigital.com>, Anton Vorontsov <avorontsov@ru.mvista.com>

On Wednesday 23 July 2008, Jonathan Cameron wrote:
> * Software ring buffer support to allow semi regular capture of data form=
 the
> =A0 device. =A0Typically this will be driven from either datardy events, =
or from
> =A0 a periodic timer interrupt (to this end a very simple wrapper for per=
iodic
> =A0 RTC's is included. This will move to more generic timer interfaces as=
 and when
> =A0 they become available. =A0For now available rtc's must be registered =
with the
> =A0 subsystem via the industrialio_register_ptimer function form within a=
 board
> =A0 init.

Could you elaborate a bit on why you'd want hardware supported
periodic timers, rather than either an hrtimer or a timer?
Maybe provide some real-world scenarios where those software
abstractions are inappropriate.

I can imagine numerous reasons, but those might not be yours...

- Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
