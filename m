From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 26 Aug 2007 18:50:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/smsc47m1: No confusing debugging
Message-Id: <20070826185037.GH3679@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070816143337.5f3486d1@hyperion.delvare>
In-Reply-To: <20070816143337.5f3486d1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2007-08-16 14:33:37 +0200]:
> It's confusing to display debugging messages for fan3 and pwm3 for
> chips which don't have them.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
