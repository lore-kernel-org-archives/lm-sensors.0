From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Regarding standardized auto-fan control
Message-Id: <20040630024326.GH3064@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

This latest round of discussion convinces me: I think that a standard
interface (at the chip driver level) for automatic fan control just
isn't feasible, for these reasons:

1a) No two of these chips are alike, and

1b) some of them are vastly different.

(And from the department of broken records...)

2) A hardware driver should do and perform exactly as it is told.  I.e.
we should not be afraid to expose an interface for each auto-fan capable
chip which is suited to just that chip.

* Jean Delvare <khali@linux-fr.org> [2004-06-24 13:41:02 +0200]:
> * Interface reflects the physical reality. It doesn't mean we lose
> chip-independancy, but scripts will be twice as big.

What scripts?  Automatic fan control is, um, *automatic* ;-)

OK seriously... if a standard interface is desirable for these controls
then let's present one in userspace via libsensors.  I personally think
that will be difficult, if not impossible... but then again not any
harder than forcing it in the drivers themselves.

One side-benefit of doing it in libsensors, is that we may be able to
implement a "virtual" auto control in userspace for chips that have only
manual PWM control.

In the meantime, we can upgrade the drivers to make use of these features
instead of searching for an interface that might never exist.

Of course, it is still important to carefully design the interface for
each driver.  I just don't think we can usefully nail them to a single
design.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
