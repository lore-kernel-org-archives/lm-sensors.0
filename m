From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 May 2008 13:20:09 +0000
Subject: Re: [lm-sensors] Accelerometer,
Message-Id: <20080521152009.0a227c3e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com>
	<20080520132817.03fb74ea@hyperion.delvare>
	<20080520214005.GH3220@local>
	<4833F3B6.6020806@gmail.com>
In-Reply-To: <4833F3B6.6020806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: "Hans J. Koch" <hjk@linutronix.de>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>, Dmitry Torokhov <dtor@mail.ru>

On Wed, 21 May 2008 11:04:38 +0100, Jonathan Cameron wrote:
> Definitely agreed that it makes sense to put DACs and ADCs in the same 
> general place and obviously there are plenty of devices out there that do
> both.

Note that hardware monitoring chips can include ADCs and DACs: the
former to monitor system voltages, and the later to control fans (most
chips use PWM for that but a few use DACs.) ADCs and DACs are, much
like GPIOs, usable for a variety of different purposes. I doubt that
there would be any benefit in abstracting DACs and ADCs the way we did
for GPIOs, but the important point here is that we really want to group
the drivers according to their functionality and not technical
implementation details.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
