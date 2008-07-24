From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 24 Jul 2008 09:19:57 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <20080724101957.75bf03e0@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>
	<20080723191918.GC26938@trinity.fluff.org>
	<20080724074124.GB2254@local>
In-Reply-To: <20080724074124.GB2254@local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Hans J. Koch" <hjk@linutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>, Jonathan Cameron <Jonathan.Cameron@gmail.com>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, David Brownell <david-b@pacbell.net>, hmh@hmh.eng.br, Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>

> hwmon is designed for slow I/O. It won't handle an ADC that does a few
> megasamples/sec.

At that rate I would assume you want a memory mapped ring buffer or
similar not a sysfs style interface ?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
