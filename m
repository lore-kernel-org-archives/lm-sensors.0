From: Trent Piepho <tpiepho@freescale.com>
Date: Fri, 26 Sep 2008 01:42:03 +0000
Subject: Re: [lm-sensors] Sensor chip interrupt
Message-Id: <Pine.LNX.4.64.0809251809080.7680@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Sep 2008, David Brownell wrote:
> Being unable to use the existing framework for quicker feedback
> loops (milliseconds not seconds), even when the hardware support for
> them is available, seems like such a gap to me.  I've just resent
> my SMBALERT# support patch, which helps address part of that little

Another problem with polling, besides milliseconds vs seconds, is that it's
done from userspace.  Now certainly policy belongs in usespace and all that,
but... userspace is a lot easier to break.

If the heatsink fell off one of my CPUs (and multi-pound heat sinks attached
via little plastic tabs really do fall off sometimes), it would stand a very
good chance of knocking the flimsy non-latching SATA cable below it out of its
socket.  With the system block device off-line, any userspace hardware monitor
is virtually certain to hang before it's able to power the system off.

Probably why most PCs now days have hardware based thermal safeguards.  On the
new version of our device, we'll use LM96163s which have an additional CRIT#
signal that we will use for a hardware based shutdown.  Without that, I
wouldn't consider something based in userspace as safe enough to protect the
hardware.

If anyone hasn't seen it, the famous Tom's Hardware video of removing
heatsinks from running computers, before hardware thermal shutdown became
standard: http://www.youtube.com/watch?v=NxNUK3U73SI

The AMD cpus take about 3 seconds to crash.  So one extra second of latency
for polling is a very significant amount of the time available to prevent
hardware damage.  Something that polled every five seconds would be completely
useless.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
