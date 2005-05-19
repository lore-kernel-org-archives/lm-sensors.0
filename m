From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: checksum in (i2c) eeprom driver
Message-Id: <20041215005741.GB5489@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B8ED64.9020805@verizon.net> <SFhEWFpz.1102668141.6379450.khali@localhost>
In-Reply-To: <SFhEWFpz.1102668141.6379450.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: sensors@Stimpy.netroedge.com, Deepak Saxena <dsaxena@plexity.net>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>

Hello:

(summary of some IRC discussions...)

> On 2004-12-10, Mark Studebaker wrote:
> > IMHO the eeprom driver is more of a demonstration driver than one of
> > great and obvious value, so achieving consensus on the value of
> > sub-features (checksum, Vaio) is difficult, and performace concerns are
> > secondary.

In as much as eeprom is a demonstration driver, with very little actual
usefulness except as a test device for us sensors people... I think it
could probably be removed from the kernel altogether if we create a user-
space (w/ i2c-dev interface) replacement for it.

* Jean Delvare <khali@linux-fr.org> [2004-12-10 09:42:21 +0100]:
> This has certainly been true when the driver was first written and then
> maintained as a driver of the lm_sensors project, and was only used for
> memory module EEPROMs. However, we now start seeing more different
> natures of EEPROMs (proprietary on laptops, ethernet devices to name
> only two of them) for which the eeprom driver can be useful. Remember
> that a number of people even asked for write support in the driver (and
> this might as well happen in the future).

If read/write support is needed, IMHO it should be implemented as a proper
char device.  The sysfs interface of the current driver makes little sense.

OTOH, note that it would be possible to break RAM modules *permanently* by
misusing such a device.  The eeprom itself would still work, but the SIMM
or DIMM that it sits on would be effectively broken.  I don't personally
consider that a good argument against an eeprom char device, but some do.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
