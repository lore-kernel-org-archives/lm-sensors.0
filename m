From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 26 Feb 2008 13:06:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83l785ts) Don't ask the user
Message-Id: <20080226130618.GA2947@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080212111726.23db114f@hyperion.delvare>
In-Reply-To: <20080212111726.23db114f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-02-12 11:17:26 +0100]:
> There's nothing we can do about read errors on the W83L785TS-S, so
> don't ask the user to report them.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/w83l785ts |    3 ++-
>  drivers/hwmon/w83l785ts.c     |    4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
