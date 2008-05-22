From: David Brownell <david-b@pacbell.net>
Date: Thu, 22 May 2008 00:52:15 +0000
Subject: Re: [lm-sensors] Accelerometer,
Message-Id: <200805211752.15670.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <20080520132817.03fb74ea@hyperion.delvare>
In-Reply-To: <20080520132817.03fb74ea@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: spi-devel-general@lists.sourceforge.net, Jonathan Cameron <Jonathan.Cameron@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On Tuesday 20 May 2008, Jean Delvare wrote:
> This all sounds quite different from our hwmon drivers. Our hwmon
> drivers read all the sensor values at once and cache the readings for a
> couple seconds, so you can't get an instant reading at any time, and
> they also don't support interrupts in general.

That's something of an issue when the hardware monitor
triggers alarms though, right?  I couldn't figure out
how to get a TMP75 alert out to any userspace code that
would care, to pick one example, even after teaching
the i2c core how to handle SMBus alerts.  ;)

I suppose this just emphasizes the point made by Hans
that we kind of need (industrial) "control" components
(or "data acquisition"?) not just "monitoring" ones.

Such alarms are of course different from the "data
ready" signals of an accelerometer.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
