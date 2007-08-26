From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 26 Aug 2007 18:50:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm70: Add a name attribute
Message-Id: <20070826185032.GG3679@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817173135.5eaffc0e@hyperion.delvare>
In-Reply-To: <20070817173135.5eaffc0e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-08-17 18:17:52 +0200]:
> Jean Delvare wrote:
> > Add a name attribute to the lm70 devices. This is required for
> > libsensors to recognize them.
> > 
> > Also drop the "+" before the temperature value, even though it did
> > not cause problems to libsensors, other hardware monitoring drivers
> > don't print it, so it's more consistent that way.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Looks good to me.
> 
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
