From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Nov 2006 18:30:30 +0000
Subject: [lm-sensors] sensord and missing alarms
Message-Id: <20061117193030.07cc622c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061110190557.GA25801@dbz.icequake.net>
In-Reply-To: <20061110190557.GA25801@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ryan,

On Fri, 17 Nov 2006 12:18:27 -0600, Ryan Underwood wrote:
> On Fri, Nov 17, 2006 at 01:45:43PM +0100, Jean Delvare wrote:
> > 
> > Not really, sorry. How can you be that interested in possible alarms
> > that happened in the past, but you don't care about what value
> > triggered it?
> 
> We want to catch the alarm so we can then check if the condition that
> triggered it is still true, and if so, take action according to the
> magnitude of the condition.

For the vast majority of chips, if the condition is still true, then
the alarm is reasserted immediately after it has been cleared by a read.

> > This is a completely different need, and one which is already covered
> > by the drivers. If there is an out-of-range condition, then the alarm
> > _is_ asserted. That's the other way around which may not be true for
> > most chips.
> 
> It's asserted, but is cleared on read with some chips.  Then the
> condition remains out of range, but the alarm is cleared.

Most chips don't work that way. Of all (relatively popular) chips I
know of, only the W83781D chip does behave the way you describe, and
only for voltages and fans, not for temperatures, if I remember
correctly. It is due to the fact that this chip doesn't have real-time
alarm registers, so we are (ab)using the interrupt registers instead.
In fact we shouldn't have exported these alarm values at all for this
chip, as they don't match our own standard.

> So in general, the alarms are useless and the application should simply
> check the current value against the ranges always?

In general, alarm flags work as intended and applications can use them.
Only the W83781D causes trouble, and it's just bad luck that this is
the chip you are using. So for the W83781D, yes, comparing the readings
with the limit values is better.

-- 
Jean Delvare

