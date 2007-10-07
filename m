From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 20:45:20 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75: new-style i2c binding,
Message-Id: <20071007224520.124ef77d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 7 Oct 2007 14:57:48 -0400, Mark M. Hoffman wrote:
> Hi Jean, David:
> 
> > On Mon, 24 Sep 2007 13:18:39 -0700, David Brownell wrote:
> > > The location of that tree seems to be hidden.  I did find a GIT
> > > tree of Mark's, but it didn't have any lm75 changes.
> 
> * Jean Delvare <khali@linux-fr.org> [2007-09-25 11:24:53 +0200]:
> > MAINTAINERS says:
> > 
> > T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git
> > 
> > It indeed doesn't mention the testing branch, while this is the
> > interesting one. Mark, is there something that can be done to improve
> > the situation?
> 
> This helps?  No other "T:" line specifies a branch this way, but it seems
> natural enough.

Yes, I think you should apply something like this.

Thanks.

> From f115afe21e8399473d166d2fb5652446e748bc16 Mon Sep 17 00:00:00 2001
> From: Mark M. Hoffman <mhoffman@lightlink.com>
> Date: Sun, 7 Oct 2007 14:45:26 -0400
> Subject: [PATCH] MAINTAINERS: update hwmon subsystem git trees
> 
> Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> ---
>  MAINTAINERS |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 62931db..9f50955 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1661,7 +1661,8 @@ P:	Mark M. Hoffman
>  M:	mhoffman@lightlink.com
>  L:	lm-sensors@lm-sensors.org
>  W:	http://www.lm-sensors.org/
> -T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git
> +T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git testing
> +T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git release
>  S:	Maintained
>  
>  HARDWARE RANDOM NUMBER GENERATOR CORE


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
