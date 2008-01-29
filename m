From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 29 Jan 2008 13:18:22 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm85) Make the
Message-Id: <20080129131822.GL29892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-12-03 23:28:42 +0100]:
> Make the pwmN_enable files writable. This makes it possible to use
> standard fan speed control tools (pwmconfig, fancontrol) with the lm85
> driver.
> 
> I left the non-standard pwmN_auto_channels files in place, as they
> give additional control for the automatic mode, and some users might
> be used to them by now.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |   40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
