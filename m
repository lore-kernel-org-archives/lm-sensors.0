From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: update_lock
Message-Id: <20040331013048.GA29782@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-03-30 11:22:39 +0200]:

(snipped a lot of other stuff, so I can comment here first...)

> BTW I reiterate my agreement with Phil Pokorny's registers split between
> input values and limits. Having two different caching periods for these
> groups makes much much sense and is likely to speed chip updates up. I
> also agree that not updating limits at all wouldn't be clever, since
> sometimes motherboards write to them in our backs and it's something we
> have to be informed of.

In my opinion, the "cached update" scheme serves only one purpose, and
it's not speed.  Internally, some of these sensor chips actually pause
the sampling and conversion in order to answer an i2c/smbus request. If
we didn't have this scheme in place and some user did this:

	while [ true ]; do
		cat /sys/bus/i2c/devices/xyz/temp1_in > /dev/null
	done

.. the value would in fact never change.  But worse, it could also halt
the alarms, QFAN, smartfan, or whatever - i.e. a DOS attack against the
hardware.  Keep in mind that the proc/sysfs files are world readable.

All that said, I think that any further optimization of the update routine
for speed is just added complexity for little or no gain.  The data being
reported by these drivers are not real-time critical w.r.t. their present
application as PC hardware monitors. And in my experience, the precision of
PC hardware sensors is questionable at best anyway.

Bottom line: I don't think these drivers should be any more complex than
necessary.  Furthermore, I think that any tradeoff of simplicity for update
speed is bad for this class of drivers.  K.I.S.S.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
