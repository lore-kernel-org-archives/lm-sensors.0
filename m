From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:53:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gl518sm) Fix the reported fan	speed
Message-Id: <20071125015353.GL13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071023140224.0f8ca055@hyperion.delvare>
In-Reply-To: <20071023140224.0f8ca055@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-23 14:02:24 +0200]:
> The fan speeds reported by the gl518sm driver are twice as much as they
> should. It's currently reporting the number of pulses per minute, not
> rotations per minute, while typical fans emit two pulses per rotation.
> This explains why all reports with this driver had very high speed
> values (between 9000 to 12000 RPM). Odd that nobody ever actually
> complained about this bug.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/gl518sm.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
