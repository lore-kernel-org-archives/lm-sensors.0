From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 02:05:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (w83627ehf) The W83627DHG has 8 VID
Message-Id: <20080201020518.GM8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 21:22:44 +0100]:
> While the W83627EHF/EHG has only 6 VID pins, the W83627DHG has 8 VID
> pins, to support VRD 11.0. Add support for this.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/w83627ehf |    5 +++--
>  drivers/hwmon/w83627ehf.c     |   18 ++++++++----------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
