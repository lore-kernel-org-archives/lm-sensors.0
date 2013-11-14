From: Laszlo Papp <lpapp@kde.org>
Date: Thu, 14 Nov 2013 20:26:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Add support for gpiodef
Message-Id: <CAOMwXhPvPnprrJx-1dfJnO+E12sxAE9M_sYg7tyzp4dsDa8vyg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384440661-3769-1-git-send-email-lpapp@kde.org>
	<20131114172427.GA11062@roeck-us.net>
	<CAOMwXhNdo8aRGH9AL+JxYnDg2zAN4+-TeHJU=Kc1kDKmyYuYmA@mail.gmail.com>
	<20131114181845.GA13727@roeck-us.net>
	<CAOMwXhNaZ=oqp5mjnCrOSkdax5U6ffsZf_p4mzd3W2jF+=xWqg@mail.gmail.com>
	<20131114190044.GE13727@roeck-us.net>
In-Reply-To: <20131114190044.GE13727@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: hjk@hansjkoch.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Nov 14, 2013 at 7:00 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> What are those pins used for ?

I would like to drive them dynamically like the rest of the features
exposed to the sysfs in a similar way.

For instance, one may need to output a logic-low level on the pin 0 to
get an operation working. One use case could be (and is) enabling or
disabling the fans dynamically based on the temperature, etc
condition. Imagine that if you have a 12 V fan with 5 V board power
supply, and such a pin would be useful to establish the bridge between
them with diodes.

This is just one use case of those, you could also use it for
non-generic gpio functionality, like alarm, "full-on", internal clock,
external clock, etc. I believe it is always a bit tricky with MFD. I
personally prefer to put it into the chip driver because this is not
clearly a generic gpio interface here, and I need to drive it
dynamically.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
