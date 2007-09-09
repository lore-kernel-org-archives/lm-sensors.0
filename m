From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 09 Sep 2007 14:39:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: End of I/O region off-by-one
Message-Id: <20070909143944.GB31992@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-08-29 10:39:57 +0200]:
> Fix an off-by-one error in the I/O region declaration of two
> hardware monitoring drivers (lm78 and w83781d.) We were requesting
> one extra port at the end of the region.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

> ---
> Mark, can you please apply this fix quickly? It should probably go to
> 2.6.22-stable as well, as in theory it could prevent drivers from
> loading.
> 
> Personal note: having different conventions for declaring resources and
> requesting them really sucks :(

True that, and btw good catch.  I'll pull this one into my release tree and
submit it now.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
