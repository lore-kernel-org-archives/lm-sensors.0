From: rutger@nospam.com (Rutger Nijlunsing)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <20040516213645.GA18906@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
In-Reply-To: <20040516222809.2c3d1ea2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

On Sun, May 16, 2004 at 10:28:09PM +0200, Jean Delvare wrote:
> Hi all,
> 
[snip]

Another implementation to add to the pool. Note I'm not convinced this
is the best solution, since I know little about the hardware
limitations...

Implementation #5

Since the divider can be programmed, it is possible to take two
measurements (all in the driver): first with the highest divider
allowed by the chipset to get an indication of the current speed, and
then a new measurement followed as close as possible to the first one
with a divider fitting the first measured speed.

Example: set divider to 64 (or highest possible divider); fan speed
gives 2500 +- 500. Not set divider to 2 or 1 and re-measure.

Advantages:
  - no 'low limit' has to be set magically
  - most accurate reading possible on the whole range
  - invisible to the user

Disadvantages:
  - no 'low limit' can be set in the hardware; low limit must be
    processed in software.
  - Update frequency of the fan speed will be halved.

Maybe-problem:
  - The 'as close as possible' must be in a small range or otherwise
    the fan speed may be dropping to fast to fall outside the
    measurable range. I do not know with which frequency the fan speed
    can be measured.

Processing the low limit in software will also solve the 'BIOS
triggering false alarms'.

> ### CONCLUSION
> 
> I think I'll stick to #2 for now. The extra code is reasonable, and I
> don't really see the low accuracy at high speed as a problem. What
> matters much to me is that the user shouldn't have to worry about
> selecting dividers himself, and #2 does this.

I agree with the stated 'I don't really see the low accuracy at high
speed as a problem', but this would suggest a simple
3-or-so-line-patch to solve the problems: just use the highest fan
divider by default. If a user really knows what he is doing, he can
change the divider himself.


-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
