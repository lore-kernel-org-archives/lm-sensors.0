From: Jan Engelhardt <jengelh@medozas.de>
Date: Thu, 24 Jul 2008 22:25:49 +0000
Subject: Re: [lm-sensors] [Patch 0/4] IndustrialIO subsystem (ADCs,
Message-Id: <alpine.LNX.1.10.0807250025080.11551@fbirervta.pbzchgretzou.qr>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>
In-Reply-To: <488763AD.4050400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Dmitry Torokhov <dtor@mail.ru>, "Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br, David Brownell <david-b@pacbell.net>, mgross@linux.intel.com, Ben Nizette <bn@niasdigital.com>, Anton Vorontsov <avorontsov@ru.mvista.com>


On Wednesday 2008-07-23 19:00, Jonathan Cameron wrote:

>Dear All,
>
>The need for an industrialio subsystem was discussed in
>http://lkml.org/lkml/2008/5/20/135
>
>Firstly thanks to all the people who have contributed to the discussion
>of this in the past.
>
>In brief the intention is provide a kernel subsystem directed towards the
>handling on sensors (and later related output devices) such as ADC's,
>accelerometers and many others.

Could this be done using UIO instead?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
