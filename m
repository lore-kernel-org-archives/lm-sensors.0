From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 06 Oct 2007 19:52:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm90: Export temperature offset
Message-Id: <20071006195253.GB3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070905141537.58990ad4@hyperion.delvare>
In-Reply-To: <20070905141537.58990ad4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-05 09:42:33 +0200]:
> Hi All,
> 
> In this post:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021154.html
> 
> Jean Delvare wrote:
> --------------------------------------------
> Now that we have standard sysfs names to export temperature offset
> values, add this feature to the lm90 driver. All supported chips
> except the MAX6657, MAX6658 and MAX6659 support it.
> 
> Signed-off-by: Jean Delvare <khali at linux-fr.org>

(...)

> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

I made a *tiny* whitespace change because git complains about space-before-tab.

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
