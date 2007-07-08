From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 14:49:09 +0000
Subject: Re: [lm-sensors] [PATCH 00/10] hwmon/w83627ehf: Fixes and new
Message-Id: <20070708144909.GC3591@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, David:

* Jean Delvare <khali@linux-fr.org> [2007-06-24 11:06:06 +0200]:
> Hi all,
> 
> Here comes a 10-piece patchset for the w83627ehf hardware monitoring
> driver. 3 of these patches were originally written by David Hubbard, I
> only made them ready for upstream submission; the rest was written by
> myself.
> 
> [PATCH 01/10] hwmon/w83627ehf: Preserve speed reading when changing fan min
> [PATCH 02/10] hwmon/w83627ehf: Update the Kconfig entry
> [PATCH 03/10] hwmon/w83627ehf: Convert to a platform driver
> [PATCH 04/10] hwmon/w83627ehf: Add error messages for two error cases
> [PATCH 05/10] hwmon/w83627ehf: Fix timing issues
> [PATCH 06/10] hwmon/w83627ehf: Add support for the VID inputs
> [PATCH 07/10] hwmon/w83627ehf: Enable VBAT monitoring
> [PATCH 08/10] hwmon/w83627ehf: Export the thermal sensor types
> [PATCH 09/10] hwmon/w83627ehf: No need to initialize fan_min
> [PATCH 10/10] hwmon/w83627ehf: Be quiet when no chip is found
> 
> I would like to again thank Bernardo Motta and Observit for donating a
> motherboard with a Winbond W83627EHG chip, which made it possible for
> me to write and test these patches.
> 
> Reviewers and testers are of course welcome. Note that you'll need
> lm-sensors SVN for patches 6 (VID) and 8 (thermal sensor types).

The (identical) first patch was already applied to testing; I've applied the
other nine.  Thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
