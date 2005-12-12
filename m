From: hidden@paradise.net.nz (Volker Kuhlmann)
Date: Mon, 12 Dec 2005 23:37:54 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card	temperature
Message-Id: <20051212233754.GD6589@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051212191628.14d6ea0c.khali@linux-fr.org>
In-Reply-To: <20051212191628.14d6ea0c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i2c-nvidia2 doesn't exist as far as I know. You must refer to
> i2c-nforce2, I presume?

Yes, sorry.

> Search for rivatv instead - see my other post.

Yes, very informative, thanks!

The 0.86 release doesn't compile, but the cvs one does. The module loads
fine, syslog:

 kernel: Linux video capture interface: v1.00
 kernel: rivatv: module not supported by Novell, setting U taint flag.
 kernel: rivatv: Video4Linux driver for NVIDIA cards
 kernel: rivatv: MMX processor extension enabled

> Rudolf's w83785 driver is meant for the Winbond W83L785R chips, which
> is a full-featured hardware monitoring chip. My w83l785ts driver, OTOH,
> is meant for the Winbond W83L785TS-S, which is a very simple
> single-temperature sensor.

Thanks for the clarification. I can't get modprobe w83l785ts with
various probe= and force= options to do anything useful. Loading
i2c-nforce2 makes two i2c busesses avilable, numbered 0 and 1.
Presumably something similar would have to happen if the graphics card
has an i2c bus too? Dunno how though. :(
I've insmoded all /lib/modules/2.6.13-15.7-default/kernel/drivers/i2c/busses/*
ignoring the errors, and rivafb and rivatv, sensors-detect finds a lot
more but it's all bogus. sensors -s (with the original sensors.conf),
then sensors outputs only zeros for anything that wasn't there before.
Might have to give up. :((

Thanks again for all your insights.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

