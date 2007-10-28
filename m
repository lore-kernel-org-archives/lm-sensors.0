From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 28 Oct 2007 17:41:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83781d) Add missing curly braces
Message-Id: <20071028174145.GN30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071025131101.364e7c58@hyperion.delvare>
In-Reply-To: <20071025131101.364e7c58@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Voipio Riku <Riku.Voipio@movial.fi> [2007-10-27 01:28:08 +0300]:
> > Missing curly braces cause an if statement to be evaluated when it
> > shouldn't. It happens to be harmless, but that's still worth fixing.
> > Thanks to Riku Voipio for reporting.
> 
> This is clearly the correct fix:
> 
> Acked-By: Riku Voipio <riku.voipio@movial.fi>
> 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  drivers/hwmon/w83781d.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
