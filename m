From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 13 Feb 2009 06:11:11 +0000
Subject: Re: [lm-sensors] Next version of lm-sensors 3
Message-Id: <Pine.LNX.4.64.0902122349220.32471@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090212140842.42c28d88@hyperion.delvare>
In-Reply-To: <20090212140842.42c28d88@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Feb 2009, Jean Delvare wrote:
> The major changes in this release will be:
> * Completely reworked sensors-detect.

This doesn't affect the sensors-detect code, but I think somewhere in
the documentation, the stand-alone nature of sensors-detect should be
emphasized.  Something like:

---
sensors-detect is a *stand-alone* tool to detect which hardware
monitoring chips are present on your system.  It does not depend on any
other part of the lm-sensors package to work.  (It is written in Perl,
so you do need perl on your system.)

If you are not sure about installing a particular version of the
lm-sensors package, you can download the source for that version from
http://www.lm-sensors.org/FIXME, unpack it, and just run
prog/detect/sensors-detect by yourself.

If you want to know if the latest version of lm-sensors has better
support for your hardware, you can download the latest version of
sensors-detect at http://www.lm-sensors.org/FIXME and run it.
---

This next piece may be out of scope a little, but maybe the
documentation should say something about using a packaged (usually by
the distro) version of lm-sensors.  I suspect a growing number of users
are getting their lm-sensors this way.  Something like:

---
Many Linux distributions offer packages (dpkg on Debian and some others,
rpm on Red Hat and some others) containing compiled versions of
lm-sensors.  Some advantages to using these packages are that they
are probably a bit simpler to install, they integrate well with the rest
of the system, and that you can probably get patches and updates via
your distribution's normal update mechanism.  A disadvantage is that the
packaged versions tend to be a little older, and therefore may not
support all of the hardware that is supported in the latest source
release.

Note that even if you have a distribution-provided package, you still
have to configure lm-sensors for your particular motherboard (and other
hardware) yourself.  See FIXME for how to do that.

If the Linux distribution you use offers an lm-sensors package,
installing it is often a good place to start.  If it detects all your
hardware and you can configure it to your liking, then use it.  But if
the packaged version of lm-sensors doesn't detect all your hardware, or
if you can't configure it exactly the way you like, it may be better to
compile a more recent version of lm-sensors from source.  See FIXME for
how to do that.
---

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
