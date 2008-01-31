From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:04:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm77) Add individual alarm files
Message-Id: <20080131130420.GB8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103233533.08ff4c07@hyperion.delvare>
In-Reply-To: <20080103233533.08ff4c07@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 23:35:33 +0100]:
> The new libsensors needs this. As the old library never had support for
> the lm77 driver, I even dropped the legacy "alarms" file.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Michael, could you please test and/or review this patch? Either test
> the sysfs files directly or use lm-sensors 3.0.0 and the alarms should
> be displayed as needed. Thanks.
> 
>  drivers/hwmon/lm77.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
