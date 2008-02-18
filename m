From: Matt Roberds <mattroberds@cox.net>
Date: Mon, 18 Feb 2008 14:30:09 +0000
Subject: Re: [lm-sensors] does lm-sensors pick up sensors that don't exist?
Message-Id: <Pine.LNX.4.64.0802180822310.20487@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <fpc320$q83$1@saturn.local.net>
In-Reply-To: <fpc320$q83$1@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Feb 2008, Per Jessen wrote:
> I've been suspecting temp3 of being the Northbridge temperature, but
> I've just been told by Gigabyte support that there is no sensor for
> temp3 ...

Many monitoring chips have multiple inputs and the motherboard
manufacturer does not always connect all of them.  I have an Asus
M2N-SLI motherboard with an it8716 monitoring chip with three inputs,
but only two of them are connected.

Another possibility is that temp3 is connected to *something* in your
system, but the values that lm-sensors uses to scale the raw reading
are incorrect.  Have you looked in the /etc/sensors.conf or
/etc/sensors3.conf for any information on your particular monitoring
chip or motherboard?

> I've been particularly interested in this temp3 as it has been
> hovering in the 80-86 degrees range, which I thought might be the
> cause of severe system instability (whilst under load).

On my system, temp3 on the it8716 always reports the maximum possible
value, +127 C.  I can guarantee (by putting my hand inside the case)
that nothing in my computer is that hot, so I have always just ignored
that reading.  I suspect that either the chip is designed to report the
maximum possible reading if there is no sensor connected, or that Asus
wired the unused sensor input to ground, +3.3 V, or some other voltage
that makes it read at the maximum possible.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
