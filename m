From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 29 Jan 2008 13:18:01 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm85) Return standard
Message-Id: <20080129131801.GK29892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-12-03 23:23:21 +0100]:
> The values returned by the lm85 driver in pwmN_enable sysfs files do
> not match the standard. Fix that.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
