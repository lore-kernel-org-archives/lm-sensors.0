From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Feb 2009 09:22:46 +0000
Subject: Re: [lm-sensors] Next version of lm-sensors 3
Message-Id: <20090214102246.2902f55d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090212140842.42c28d88@hyperion.delvare>
In-Reply-To: <20090212140842.42c28d88@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Fri, 13 Feb 2009 00:11:11 -0600 (CST), Matt Roberds wrote:
> On Thu, 12 Feb 2009, Jean Delvare wrote:
> > The major changes in this release will be:
> > * Completely reworked sensors-detect.
> 
> This doesn't affect the sensors-detect code, but I think somewhere in
> the documentation, the stand-alone nature of sensors-detect should be
> emphasized.  Something like:
> 
> ---
> sensors-detect is a *stand-alone* tool to detect which hardware
> monitoring chips are present on your system.  It does not depend on any
> other part of the lm-sensors package to work.  (It is written in Perl,
> so you do need perl on your system.)

I've just updated our documentation to mention the stand-alone nature
of sensors-detect, thanks for the suggestion.

> 
> If you are not sure about installing a particular version of the
> lm-sensors package, you can download the source for that version from
> http://www.lm-sensors.org/FIXME, unpack it, and just run
> prog/detect/sensors-detect by yourself.
> 
> If you want to know if the latest version of lm-sensors has better
> support for your hardware, you can download the latest version of
> sensors-detect at http://www.lm-sensors.org/FIXME and run it.

lm-sensors 3 is hardware-agnostic. There is no such thing as "the
latest version of lm-sensors has better support for your hardware"
anymore [1]. This required enough time and work to get there that we
should not mislead the user into thinking this did not happen.

The typical scenario would rather be: sensors-detect from my
distribution didn't detect my hardware, try the latest version of
sensors-detect from lm-sensors.org and see if it finds more. Then
look at the wiki and see which kernel I need - because in most cases,
if the distribution's sensors-detect didn't find my chip, it also means
that the distribution's kernel won't support it. At this point there
are 3 options left: upgrade to a more recent distribution if possible
(easier for beginners), backport the driver I need (requires help from
developers), or install a newer kernel myself (for experts only.)

[1] An exception being brand new features such as power or current
sensors, but this is so specific that people who need this probably
don't need to be guided step by step.

> ---
> 
> This next piece may be out of scope a little, but maybe the
> documentation should say something about using a packaged (usually by
> the distro) version of lm-sensors.  I suspect a growing number of users
> are getting their lm-sensors this way.  Something like:
> 
> ---
> Many Linux distributions offer packages (dpkg on Debian and some others,
> rpm on Red Hat and some others) containing compiled versions of
> lm-sensors.  Some advantages to using these packages are that they
> are probably a bit simpler to install, they integrate well with the rest
> of the system, and that you can probably get patches and updates via
> your distribution's normal update mechanism.  A disadvantage is that the
> packaged versions tend to be a little older, and therefore may not
> support all of the hardware that is supported in the latest source
> release.

The above it true for every part of a Linux system, it is absolutely
not specific to lm-sensors.

> 
> Note that even if you have a distribution-provided package, you still
> have to configure lm-sensors for your particular motherboard (and other
> hardware) yourself.  See FIXME for how to do that.
> 
> If the Linux distribution you use offers an lm-sensors package,
> installing it is often a good place to start.  If it detects all your
> hardware and you can configure it to your liking, then use it.  But if
> the packaged version of lm-sensors doesn't detect all your hardware, or
> if you can't configure it exactly the way you like, it may be better to
> compile a more recent version of lm-sensors from source.  See FIXME for
> how to do that.

See above. If things don't work then the user will have to build a new
kernel, not a new lm-sensors (as already explained in the README file.)
And I don't want to guide people through this, that's way too complex
for most Linux users.

Rather than spending time documenting things most users won't be able
or willing to do, I think we're better spending it on pushing support
for new chips to the kernel faster, and release new versions of
lm-sensors more frequently, so that users can use what's in their
distribution and it just works.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
