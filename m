From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 14 Aug 2007 01:59:45 +0000
Subject: Re: [lm-sensors] [PATCH] [210/2many] MAINTAINERS - HARDWARE
Message-Id: <20070814015945.GC7748@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <46bffa04.JW3S0ykNGAQACMv1%joe@perches.com>
In-Reply-To: <46bffa04.JW3S0ykNGAQACMv1%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Joe:

* joe@perches.com <joe@perches.com> [2007-08-12 23:28:20 -0700]:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e35e29c..f422277 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2015,6 +2015,7 @@ L:	lm-sensors@lm-sensors.org
>  W:	http://www.lm-sensors.org/
>  T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git
>  S:	Maintained
> +F:	drivers/hwmon/
>  
>  HARDWARE RANDOM NUMBER GENERATOR CORE
>  P:	Michael Buesch

I guess you know by now not to ever do that again.

If you collect the hwmon stuff into one (1) patch, I'll take it.

Now you'll excuse me while I drive a nail through my delete key.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
