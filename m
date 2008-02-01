From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 02:35:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (w83627hf) Enable VBAT
Message-Id: <20080201023532.GN8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 22:54:13 +0100]:
> If VBAT monitoring is disabled, enable it. Bug reported on the
> lm-sensors trac system:
> http://lm-sensors.org/ticket/2282
> This is the exact same patch that was applied to the w83627ehf driver
> 6 months ago.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Carlos, could you please test and/or review this patch?
> 
>  drivers/hwmon/w83627hf.c |    5 +++++
>  1 file changed, 5 insertions(+)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
