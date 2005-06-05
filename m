From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Jun 2005 22:48:40 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <20050605224910.17da8ee8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

> thanks for the comments, here's the next one. Patch against
> 2.6.12-rc5-mm2.

Thanks for taking Rudolf's comment into account, and for your work on
the it87 driver in general. Several users have been asking for the Smart
Guardian feature already.

However, there are a few problems with your patch.

First, there is a big pending patch for it87 which updates the driver to
make use of the new sysfs callbacks. I wouldn't want your patch to
collide with this one, so I'd like you to build your patch on top of
this one.

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012597.html

This will also have the advantage that you'll see how the new sysfs
callbacks can be written, and this should hopefully make your code much
more simple.

Second, your interface doesn't quite comply with the standard automatic
PWM interface as defined in Documentation/i2c/sysfs-interface. Please
take a look. The interface basically defines trip points (PWM,
temperature "coordinates"). You should come to something similar to what
you have already by just renaming a few files, except for the slope/step
concept which won't fit directly in, so I think you'll have to add some
arithmetics (compute the slope from the requested trip point
"coordinates", and vice-versa).

Third, the old datasheets for the IT8712F and IT8705F suggest that the
first revisions of both chips had a different SmartGuardian
implementation, trip-point based. If this is confirmed, then you will
have to check the revision of the chip before enabling your interface.
Which revision to you have yourself? I'll try to experiment on my
IT8705F rev.2.

Can you provide a dump of your chip at startup (before loading the it87
driver)?

Thanks,
-- 
Jean Delvare
