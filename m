From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: checksum in (i2c) eeprom driver
Message-Id: <vojkqBdx.1102603548.0379010.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <41B85D43.8070409@verizon.net>
References: <lNsWdTVB.1102596784.6279250.khali@localhost>
In-Reply-To: <lNsWdTVB.1102596784.6279250.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@Stimpy.netroedge.com
Cc: Deepak Saxena <dsaxena@plexity.net>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>


On 2004-12-09, Mark Studebaker wrote:

> I think the checksum code is useful because checksum=1 prevents the module
> from claiming ddc monitor eeproms and other devices in its address space
> 50-57.

DDC monitor EEPROMs *are* EEPROMs so there is no reason to exclude them
from this driver. We used to have a specific (ddcmon) driver for these
but this too is an error IMHO. Developping different eeprom drivers for
different natures of eeproms is silly (how many more?). What the ddcmon
driver was doing really belongs to user-space, not kernel-space.

There are not that many non-EEPROMs chips in the 0x50-0x57 range, only
the Maxim MAX6900 RTC according to sensors-detect (quite a rare chip at
that, we don't even have a driver for it yet).

> Since detection for eeproms is otherwise poor, it's the only way we have
> for robust detection.

Except that it only works with memory module EEPROMs.

If the checksumming was that important, I guess it would have been the
default, which it was not. If it is there for the sole purpose of
allowing the user to prevent the eeprom driver from taking over
non-eeprom chips, then the "ignore" module parameter can be used to
achieve the same effect, faster, plus it is configurable on a
per-address basis, while the checksum parameter isn't.

Thanks,
--
Jean Delvare
